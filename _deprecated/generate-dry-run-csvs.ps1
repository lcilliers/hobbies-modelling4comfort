# Generate Comprehensive Dry Run CSVs
# Creates two CSVs for validation:
# 1. RENAME-INVENTORY.csv - File rename operations (site + source)
# 2. MARKDOWN-UPDATES.csv - Markdown path update operations

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "DRY RUN CSV GENERATOR" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Plant code mapping
$plantCodes = @{
    'bluebells' = 'blu'
    'daffodil' = 'daf'
    'ranunculus' = 'ran'
    'snowdrops' = 'sno'
    'poinsettia' = 'poi'  # Will be moved to hibiscus
    'hibiscus' = 'hib'
    'protea' = 'pro'
    'strelitzia' = 'str'
}

# ==========================================
# PART 1: Generate File Rename Inventory
# ==========================================
Write-Host "`nPART 1: Generating file rename inventory..." -ForegroundColor Cyan

$basePath = "assets\images\projects\plant-displays"
$renameInventory = @()
$renameId = 1

# Track sequential numbering per folder
$folderCounters = @{}

foreach ($plant in $plantCodes.Keys | Where-Object { $_ -ne 'hibiscus' }) {
    $plantFolder = Join-Path $basePath $plant
    
    if (-not (Test-Path $plantFolder)) {
        Write-Host "  WARNING: $plantFolder not found" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "  Processing: $plant" -ForegroundColor White
    
    # Get all JPG files recursively
    $files = Get-ChildItem $plantFolder -Filter "*.jpg" -Recurse -File
    
    foreach ($file in $files) {
        # Determine category from path
        $fullPlantFolderPath = (Resolve-Path $plantFolder).Path
        $relativePath = $file.DirectoryName.Replace($fullPlantFolderPath, '').TrimStart('\')
        $pathParts = if ($relativePath) { $relativePath.Split('\') } else { @() }
        $category = if ($pathParts.Length -gt 0 -and $pathParts[0] -ne '') { $pathParts[0] } else { 'root' }
        $subfolder = if ($pathParts.Length -gt 1) { $pathParts[1..($pathParts.Length-1)] -join '\' } else { '' }
        
        # Create folder key for sequential numbering
        $folderKey = "$plant|$category|$subfolder"
        if (-not $folderCounters.ContainsKey($folderKey)) {
            $folderCounters[$folderKey] = 1
        }
        
        # Generate new name
        $code = $plantCodes[$plant]
        $oldName = $file.Name
        
        # Check if this is a combined image (has theme name, not just numbers)
        if ($oldName -match "$plant-planning-([a-z-]+)-\d+\.jpg") {
            # Combined image - preserve theme name
            $themeName = $Matches[1]
            $number = $folderCounters[$folderKey].ToString('000')
            $newName = "$code-planning-$themeName-$number.jpg"
        }
        else {
            # Regular image - use sequential number
            $number = $folderCounters[$folderKey].ToString('000')
            $newName = "$code-$category-$number.jpg"
        }
        
        $folderCounters[$folderKey]++
        
        # Build paths
        $oldRelPath = $file.FullName.Replace('\\ukwsdev07\e$\Models4Comfort\', '').Replace('\', '/')
        
        $newRelDir = $file.DirectoryName.Replace($plant, $plant).Replace('\', '/')  # Keep same directory
        $newRelPath = "$newRelDir/$newName".Replace('\\ukwsdev07\e$\Models4Comfort\', '').Replace('\', '/')
        
        $renameInventory += [PSCustomObject]@{
            RenameID = $renameId++
            Plant = $plant
            Category = $category
            Subfolder = $subfolder
            OldName = $oldName
            NewName = $newName
            OldRelPath = $oldRelPath
            NewRelPath = $newRelPath
            Operation = 'Rename'
            Notes = ''
        }
    }
}

# Export rename inventory
$renameInventory | Export-Csv "RENAME-INVENTORY.csv" -NoTypeInformation -Encoding UTF8

Write-Host "  Generated $($renameInventory.Count) file rename entries" -ForegroundColor Green

# ==========================================
# PART 2: Generate Markdown Update Inventory
# ==========================================
Write-Host "`nPART 2: Generating markdown update inventory..." -ForegroundColor Cyan

# Create lookup: old path -> new path
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
    if (-not (Test-Path $mdFile)) {
        Write-Host "  WARNING: $mdFile not found" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "  Analyzing: $mdFile" -ForegroundColor White
    $lines = Get-Content $mdFile
    $foundCount = 0
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        $lineNum = $i + 1
        
        # Find all image paths in this line
        $pattern = 'assets/images/projects/plant-displays/[^"\s)}\]]+\.jpg'
        $matches = [regex]::Matches($line, $pattern)
        
        foreach ($match in $matches) {
            $oldPath = $match.Value
            
            # Look up new path
            $newPath = $pathLookup[$oldPath]
            
            if ($newPath) {
                # Get context (truncate if too long)
                $context = $line.Trim()
                if ($context.Length -gt 120) {
                    $context = $context.Substring(0, 117) + "..."
                }
                
                $markdownUpdates += [PSCustomObject]@{
                    UpdateID = $updateId++
                    MarkdownFile = $mdFile
                    LineNumber = $lineNum
                    OldPath = $oldPath
                    NewPath = $newPath
                    ChangeType = if ($mdFile -like "*poinsettia*") { "Path update + Plant rename" } else { "Path update" }
                    Context = $context
                }
                
                $foundCount++
            }
        }
    }
    
    Write-Host "    Found $foundCount path updates" -ForegroundColor Green
}

# Add special entry for file rename (poinsettia → hibiscus)
if (Test-Path "_builds\plant-displays\poinsettia-001-planning-build.md") {
    $markdownUpdates += [PSCustomObject]@{
        UpdateID = $updateId++
        MarkdownFile = "_builds\plant-displays\poinsettia-001-planning-build.md"
        LineNumber = 0
        OldPath = "[FILE RENAME]"
        NewPath = "_builds\plant-displays\hibiscus-001-planning-build.md"
        ChangeType = "File Rename"
        Context = "Rename build log file from poinsettia to hibiscus"
    }
    
    # Add entry for plant name text replacements
    $markdownUpdates += [PSCustomObject]@{
        UpdateID = $updateId++
        MarkdownFile = "_builds\plant-displays\hibiscus-001-planning-build.md"
        LineNumber = 0
        OldPath = "[TEXT REPLACE]"
        NewPath = "Replace 'Poinsettia' with 'Hibiscus' throughout file"
        ChangeType = "Text Content"
        Context = "Update all plant name references in title, body, and descriptions"
    }
}

# Add entry for project page plant section update
if (Test-Path "_projects\plant-displays.md") {
    $markdownUpdates += [PSCustomObject]@{
        UpdateID = $updateId++
        MarkdownFile = "_projects\plant-displays.md"
        LineNumber = 0
        OldPath = "[TEXT REPLACE]"
        NewPath = "Replace 'Poinsettia' with 'Hibiscus' in plant descriptions"
        ChangeType = "Text Content"
        Context = "Update plant name in collection overview section"
    }
}

# Export markdown updates
$markdownUpdates | Export-Csv "MARKDOWN-UPDATES.csv" -NoTypeInformation -Encoding UTF8

Write-Host "  Generated $($markdownUpdates.Count) markdown update entries" -ForegroundColor Green

# ==========================================
# SUMMARY
# ==========================================
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "DRY RUN GENERATION COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nFILE RENAME SUMMARY:" -ForegroundColor Yellow
Write-Host "  Total files to rename: $($renameInventory.Count)" -ForegroundColor White
Write-Host "  Plants affected:" -ForegroundColor White
$renameInventory | Group-Object Plant | ForEach-Object {
    Write-Host "    $($_.Name): $($_.Count) files" -ForegroundColor Gray
}

Write-Host "`nMARKDOWN UPDATE SUMMARY:" -ForegroundColor Yellow
Write-Host "  Total updates: $($markdownUpdates.Count)" -ForegroundColor White
Write-Host "  Files affected:" -ForegroundColor White
$markdownUpdates | Group-Object MarkdownFile | ForEach-Object {
    Write-Host "    $($_.Name): $($_.Count) updates" -ForegroundColor Gray
}

Write-Host "`nGENERATED FILES:" -ForegroundColor Yellow
Write-Host "  1. RENAME-INVENTORY.csv - File rename operations" -ForegroundColor White
Write-Host "  2. MARKDOWN-UPDATES.csv - Markdown path updates" -ForegroundColor White

Write-Host "`nNEXT STEPS:" -ForegroundColor Yellow
Write-Host "  1. Open both CSV files in Excel or VS Code" -ForegroundColor White
Write-Host "  2. Review RENAME-INVENTORY.csv - verify old→new filename mappings" -ForegroundColor White
Write-Host "  3. Review MARKDOWN-UPDATES.csv - verify markdown path updates" -ForegroundColor White
Write-Host "  4. Check for any unexpected changes or missing updates" -ForegroundColor White
Write-Host "  5. Once validated, proceed with actual execution" -ForegroundColor White

Write-Host "`n========================================" -ForegroundColor Cyan
