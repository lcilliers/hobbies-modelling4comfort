# FINAL VERSION - Dry Run CSV Generator with Proper UNC Path Handling
# Generates two CSVs showing all planned changes for validation

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "DRY RUN CSV GENERATOR (FINAL)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Plant code mapping
$plantCodes = @{
    'bluebells' = 'blu'
    'daffodil' = 'daf'
    'ranunculus' = 'ran'
    'snowdrops' = 'sno'
    'poinsettia' = 'poi'
    'protea' = 'pro'
    'strelitzia' = 'str'
}

# Base UNC path
$workspaceRoot = "\\ukwsdev07\e$\Models4Comfort"

# ==========================================
# PART 1: Generate File Rename Inventory
# ==========================================
Write-Host "`nPART 1: Generating file rename inventory..." -ForegroundColor Cyan

$basePath = "assets\images\projects\plant-displays"
$renameInventory = @()
$renameId = 1

# Track sequential numbering per folder
$folderCounters = @{}

foreach ($plant in $plantCodes.Keys | Sort-Object) {
    $plantFolder = Join-Path $workspaceRoot (Join-Path $basePath $plant)
    
    if (-not (Test-Path $plantFolder)) {
        Write-Host "  WARNING: $plant not found, skipping" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "  Processing: $plant" -ForegroundColor White
    
    # Get all JPG files recursively
    $files = Get-ChildItem $plantFolder -Filter "*.jpg" -Recurse -File | Sort-Object FullName
    $fileCount = 0
    
    foreach ($file in $files) {
        # Strip workspace root to get relative path
        $relPath = $file.FullName.Replace("$workspaceRoot\", '').Replace('\', '/')
        
        # Parse category from path structure
        # Path format: assets/images/projects/plant-displays/PLANT/CATEGORY/[SUBFOLDER/]filename.jpg
        $pathParts = $relPath.Split('/')
        $plantIndex = [array]::IndexOf($pathParts, $plant)
        
        if ($plantIndex -ge 0 -and $pathParts.Length > ($plantIndex + 1)) {
            $category = $pathParts[$plantIndex + 1]
            $subfolder = if ($pathParts.Length > ($plantIndex + 3)) {
                $pathParts[($plantIndex + 2)..($pathParts.Length - 2)] -join '/'
            } else {
                ''
            }
        }
        else {
            $category = 'unknown'
            $subfolder = ''
        }
        
        # Create folder key for sequential numbering
        $folderKey = "$plant|$category|$subfolder"
        if (-not $folderCounters.ContainsKey($folderKey)) {
            $folderCounters[$folderKey] = 1
        }
        
        # Get current (old) filename
        $oldName = $file.Name
        
        # Generate new name
        $code = $plantCodes[$plant]
        $newName = $null
        
        # Check if this is a combined/themed image
        if ($oldName -match "^(bluebells|daffodil)-planning-([a-z-]+)-\d+\.jpg$") {
            $themeName = $Matches[2]
            $number = $folderCounters[$folderKey].ToString('000')
            $newName = "$code-planning-$themeName-$number.jpg"
        }
        else {
            # Standard rename
            $number = $folderCounters[$folderKey].ToString('000')
            $newName = "$code-$category-$number.jpg"
        }
        
        $folderCounters[$folderKey]++
        
        # Build old and new relative paths
        $oldRelPath = $relPath
        $newRelPath = $relPath.Replace($oldName, $newName)
        
        $renameInventory += [PSCustomObject]@{
            RenameID = $renameId++
            Plant = $plant
            Category = $category
            Subfolder = $subfolder
            OldName = $oldName
            NewName = $newName
            OldRelPath = $oldRelPath
            NewRelPath = $newRelPath
            Operation = 'File Rename'
            Notes = if ($oldName -match "-planning-([a-z-]+)-") { "Combined/Themed" } else { "" }
        }
        
        $fileCount++
    }
    
    Write-Host "    $fileCount files" -ForegroundColor Gray
}

# Export
$renameInventory | Export-Csv "RENAME-INVENTORY.csv" -NoTypeInformation -Encoding UTF8
Write-Host "`n  Exported: RENAME-INVENTORY.csv ($($renameInventory.Count) entries)" -ForegroundColor Green

# ==========================================
# PART 2: Generate Markdown Update Inventory
# ==========================================
Write-Host "`nPART 2: Generating markdown update inventory..." -ForegroundColor Cyan

# Create path lookup
$pathLookup = @{}
foreach ($entry in $renameInventory) {
    $pathLookup[$entry.OldRelPath] = $entry.NewRelPath
}

$markdownUpdates = @()
$updateId = 1

# Markdown files to process
$markdownFiles = @(
    "_builds\plant-displays\bluebells-001-planning-build.md",
    "_builds\plant-displays\daffodil-001-planning-build.md",
    "_builds\plant-displays\ranunculus-001-planning-build.md",
    "_builds\plant-displays\snowdrops-001-planning-build.md",
    "_builds\plant-displays\protea-001-planning-build.md",
    "_builds\plant-displays\strelitzia-001-planning-build.md",
    "_builds\plant-displays\poinsettia-001-planning-build.md",
    "_projects\plant-displays.md"
)

foreach ($mdFile in $markdownFiles) {
    $fullMdPath = Join-Path $workspaceRoot $mdFile
    
    if (-not (Test-Path $fullMdPath)) {
        Write-Host "  WARNING: $mdFile not found" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "  Analyzing: $mdFile" -ForegroundColor White
    $lines = Get-Content $fullMdPath
    $foundCount = 0
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        $lineNum = $i + 1
        
        # Find image paths
        $pattern = 'assets/images/projects/plant-displays/[^"\s)}\]]+\.jpg'
        $matches = [regex]::Matches($line, $pattern)
        
        foreach ($match in $matches) {
            $oldPath = $match.Value
            
            # Look up new path
            $newPath = $pathLookup[$oldPath]
            
            if ($newPath) {
                $context = $line.Trim()
                if ($context.Length > 120) {
                    $context = $context.Substring(0, 117) + "..."
                }
                
                $markdownUpdates += [PSCustomObject]@{
                    UpdateID = $updateId++
                    MarkdownFile = $mdFile
                    LineNumber = $lineNum
                    OldPath = $oldPath
                    NewPath = $newPath
                    ChangeType = if ($mdFile -like "*poinsettia*") { "Path + Plant rename" } else { "Path update" }
                    Context = $context
                }
                
                $foundCount++
            }
        }
    }
    
    Write-Host "    $foundCount path updates" -ForegroundColor Gray
}

# Add special entries for poinsettia→hibiscus
if (Test-Path (Join-Path $workspaceRoot "_builds\plant-displays\poinsettia-001-planning-build.md")) {
    $markdownUpdates += [PSCustomObject]@{
        UpdateID = $updateId++
        MarkdownFile = "_builds\plant-displays\poinsettia-001-planning-build.md"
        LineNumber = 0
        OldPath = "[FILE RENAME]"
        NewPath = "_builds\plant-displays\hibiscus-001-planning-build.md"
        ChangeType = "File Rename"
        Context = "Rename build log file from poinsettia to hibiscus"
    }
    
    $markdownUpdates += [PSCustomObject]@{
        UpdateID = $updateId++
        MarkdownFile = "_builds\plant-displays\hibiscus-001-planning-build.md (after rename)"
        LineNumber = 0
        OldPath = "[TEXT: 'Poinsettia']"
        NewPath = "[TEXT: 'Hibiscus']"
        ChangeType = "Text Replace"
        Context = "Replace all 'Poinsettia' with 'Hibiscus' throughout file"
    }
}

if (Test-Path (Join-Path $workspaceRoot "_projects\plant-displays.md")) {
    $markdownUpdates += [PSCustomObject]@{
        UpdateID = $updateId++
        MarkdownFile = "_projects\plant-displays.md"
        LineNumber = 0
        OldPath = "[TEXT: 'Poinsettia']"
        NewPath = "[TEXT: 'Hibiscus']"
        ChangeType = "Text Replace"
        Context = "Replace 'Poinsettia' with 'Hibiscus' in plant descriptions"
    }
}

# Export
$markdownUpdates | Export-Csv "MARKDOWN-UPDATES.csv" -NoTypeInformation -Encoding UTF8
Write-Host "`n  Exported: MARKDOWN-UPDATES.csv ($($markdownUpdates.Count) entries)" -ForegroundColor Green

# ==========================================
# SUMMARY
# ==========================================
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SUMMARY" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nFILE RENAMES: $($renameInventory.Count) files" -ForegroundColor Yellow
$renameInventory | Group-Object Plant | Sort-Object Name | ForEach-Object {
    Write-Host "  $($_.Name): $($_.Count) files" -ForegroundColor White
}

Write-Host "`nMARKDOWN UPDATES: $($markdownUpdates.Count) updates" -ForegroundColor Yellow
$markdownUpdates | Group-Object MarkdownFile | Sort-Object Name | ForEach-Object {
    Write-Host "  $(Split-Path $_.Name -Leaf): $($_.Count) updates" -ForegroundColor White
}

Write-Host "`nGENERATED FILES:" -ForegroundColor Cyan
Write-Host "  RENAME-INVENTORY.csv - File rename operations"
Write-Host "  MARKDOWN-UPDATES.csv - Markdown path updates"

Write-Host "`nREVIEW CHECKLIST:" -ForegroundColor Yellow
Write-Host "  [ ] Open RENAME-INVENTORY.csv - verify OldName → NewName"
Write-Host "  [ ] Check OldRelPath and NewRelPath are correct"
Write-Host "  [ ] Verify Category column shows build/gallery/planning"
Write-Host "  [ ] Check themed images keep descriptive names"
Write-Host "  [ ] Open MARKDOWN-UPDATES.csv - verify OldPath → NewPath"
Write-Host "  [ ] Check LineNumber and Context are meaningful"
Write-Host "  [ ] Verify poinsettia→hibiscus entries included"

Write-Host "`n========================================" -ForegroundColor Cyan
