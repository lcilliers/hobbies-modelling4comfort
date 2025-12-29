# Generate Comprehensive Dry Run CSVs - FIXED VERSION
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
    'poinsettia' = 'poi'  # Will be moved to hibiscus first
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

foreach ($plant in $plantCodes.Keys) {
    $plantFolder = Join-Path $basePath $plant
    
    if (-not (Test-Path $plantFolder)) {
        Write-Host "  WARNING: $plantFolder not found, skipping" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "  Processing: $plant" -ForegroundColor White
    
    # Get all JPG files recursively
    $files = Get-ChildItem $plantFolder -Filter "*.jpg" -Recurse -File | Sort-Object FullName
    
    foreach ($file in $files) {
        # Parse directory structure
        $fullPlantPath = (Resolve-Path $plantFolder).Path
        $relativeFolderPath = $file.DirectoryName.Replace($fullPlantPath, '').TrimStart('\')
        
        # Extract category (build/gallery/planning)
        $category = if ($relativeFolderPath) { 
            $relativeFolderPath.Split('\')[0] 
        } else { 
            'root' 
        }
        
        # Extract subfolder if exists
        $pathParts = if ($relativeFolderPath) { $relativeFolderPath.Split('\') } else { @() }
        $subfolder = if ($pathParts.Length -gt 1) { 
            $pathParts[1..($pathParts.Length-1)] -join '\' 
        } else { 
            '' 
        }
        
        # Create folder key for sequential numbering within each folder
        $folderKey = "$plant|$category|$subfolder"
        if (-not $folderCounters.ContainsKey($folderKey)) {
            $folderCounters[$folderKey] = 1
        }
        
        # Get current (old) name
        $oldName = $file.Name
        
        # Generate new name based on pattern
        $code = $plantCodes[$plant]
        $newName = $null
        
        # Check if this is a combined/themed image (already has descriptive name)
        # Pattern: plant-planning-themename-##.jpg or bluebells-planning-english-bluebell-01.jpg
        if ($oldName -match "^($plant|bluebells|daffodil)-planning-([a-z-]+)-\d+\.jpg$") {
            $themeName = $Matches[2]
            $number = $folderCounters[$folderKey].ToString('000')
            $newName = "$code-planning-$themeName-$number.jpg"
        }
        else {
            # Regular image - generate standard name
            $number = $folderCounters[$folderKey].ToString('000')
            $newName = "$code-$category-$number.jpg"
        }
        
        $folderCounters[$folderKey]++
        
        # Build relative paths (for Jekyll)
        $oldRelPath = $file.FullName.Replace("$PWD\", '').Replace('\', '/')
        
        # New relative path keeps same directory, just changes filename
        $newFileDir = $file.DirectoryName.Replace("$PWD\", '').Replace('\', '/')
        $newRelPath = "$newFileDir/$newName"
        
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
            Notes = if ($oldName -match "-planning-([a-z-]+)-") { "Themed image" } else { "" }
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

# Create lookup: old relative path -> new relative path
$pathLookup = @{}
foreach ($entry in $renameInventory) {
    $pathLookup[$entry.OldRelPath] = $entry.NewRelPath
}

Write-Host "  Created path lookup with $($pathLookup.Count) mappings" -ForegroundColor Gray

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
            
            # Look up new path from our mapping
            $newPath = $null
            foreach ($key in $pathLookup.Keys) {
                # Convert key to forward slashes for comparison
                $keyNorm = $key -replace '\\', '/'
                if ($keyNorm -eq $oldPath) {
                    $newPath = $pathLookup[$key] -replace '\\', '/'
                    break
                }
            }
            
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
                    ChangeType = if ($mdFile -like "*poinsettia*") { "Path + Plant rename" } else { "Path update" }
                    Context = $context
                }
                
                $foundCount++
            }
            else {
                Write-Host "    WARNING: No mapping for $oldPath" -ForegroundColor Yellow
            }
        }
    }
    
    Write-Host "    Found $foundCount path updates" -ForegroundColor Green
}

# Add special entries for poinsettia→hibiscus transformations
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
    
    $markdownUpdates += [PSCustomObject]@{
        UpdateID = $updateId++
        MarkdownFile = "_builds\plant-displays\hibiscus-001-planning-build.md (after rename)"
        LineNumber = 0
        OldPath = "[TEXT: 'Poinsettia']"
        NewPath = "[TEXT: 'Hibiscus']"
        ChangeType = "Text Replace"
        Context = "Replace all 'Poinsettia' with 'Hibiscus' in title, frontmatter, body"
    }
}

# Add entry for project page plant section update
if (Test-Path "_projects\plant-displays.md") {
    $markdownUpdates += [PSCustomObject]@{
        UpdateID = $updateId++
        MarkdownFile = "_projects\plant-displays.md"
        LineNumber = 0
        OldPath = "[TEXT: 'Poinsettia']"
        NewPath = "[TEXT: 'Hibiscus']"
        ChangeType = "Text Replace"
        Context = "Replace 'Poinsettia' with 'Hibiscus' in plant descriptions section"
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
$renameInventory | Group-Object Plant | Sort-Object Name | ForEach-Object {
    Write-Host "    $($_.Name): $($_.Count) files" -ForegroundColor Gray
}

Write-Host "`nMARKDOWN UPDATE SUMMARY:" -ForegroundColor Yellow
Write-Host "  Total updates: $($markdownUpdates.Count)" -ForegroundColor White
Write-Host "  Files affected: $($($markdownUpdates.MarkdownFile | Select-Object -Unique).Count)" -ForegroundColor White
$markdownUpdates | Group-Object MarkdownFile | Sort-Object Name | ForEach-Object {
    $updateTypes = $_.Group | Group-Object ChangeType
    Write-Host "    $($_.Name): $($_.Count) updates" -ForegroundColor Gray
    $updateTypes | ForEach-Object {
        Write-Host "      - $($_.Name): $($_.Count)" -ForegroundColor DarkGray
    }
}

Write-Host "`nGENERATED FILES:" -ForegroundColor Yellow
Write-Host "  1. RENAME-INVENTORY.csv - $($renameInventory.Count) file rename operations" -ForegroundColor White
Write-Host "  2. MARKDOWN-UPDATES.csv - $($markdownUpdates.Count) markdown update operations" -ForegroundColor White

Write-Host "`nVALIDATION CHECKLIST:" -ForegroundColor Yellow
Write-Host "  [ ] Open RENAME-INVENTORY.csv - verify OldName→NewName mappings" -ForegroundColor White
Write-Host "  [ ] Check combined images retain theme names (english-bluebell, flowers, etc.)" -ForegroundColor White
Write-Host "  [ ] Verify sequential numbering per folder (no gaps or duplicates)" -ForegroundColor White
Write-Host "  [ ] Open MARKDOWN-UPDATES.csv - verify OldPath→NewPath updates" -ForegroundColor White
Write-Host "  [ ] Check line numbers and context make sense" -ForegroundColor White
Write-Host "  [ ] Verify poinsettia→hibiscus text replacements included" -ForegroundColor White
Write-Host "  [ ] Count total: 169 file renames + ~160 markdown updates" -ForegroundColor White

Write-Host "`n========================================" -ForegroundColor Cyan
