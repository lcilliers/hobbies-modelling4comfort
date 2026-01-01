# Generate Markdown Updates CSV for Dry Run Validation
# This script analyzes all markdown files and generates a CSV showing every path change needed

param(
    [string]$InventoryPath = ".\RENAME-INVENTORY.csv",
    [string]$OutputPath = ".\MARKDOWN-UPDATES.csv"
)

Write-Host "Loading rename inventory..." -ForegroundColor Cyan
$inventory = Import-Csv $InventoryPath

# Create lookup dictionary: old relative path -> new relative path
$pathMapping = @{}
foreach ($row in $inventory) {
    $oldRelPath = $row.FullPath -replace '\\\\ukwsdev07\\e\$\\Models4Comfort\\', '' -replace '\\', '/'
    $newRelPath = $row.NewRelPath -replace '\\', '/'
    $pathMapping[$oldRelPath] = $newRelPath
}

Write-Host "Found $($pathMapping.Count) path mappings" -ForegroundColor Green

# Markdown files to analyze
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

$updates = @()
$updateId = 1

foreach ($mdFile in $markdownFiles) {
    if (-not (Test-Path $mdFile)) {
        Write-Host "  WARNING: $mdFile not found" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "`nAnalyzing: $mdFile" -ForegroundColor Cyan
    $content = Get-Content $mdFile -Raw
    $lines = Get-Content $mdFile
    
    $foundCount = 0
    
    # Search for image paths in the markdown
    # Pattern: assets/images/projects/plant-displays/...
    $pattern = 'assets/images/projects/plant-displays/[^"\s)}\]]+\.jpg'
    
    $matches = [regex]::Matches($content, $pattern)
    
    foreach ($match in $matches) {
        $oldPath = $match.Value
        
        # Find matching new path from inventory
        $newPath = $null
        foreach ($key in $pathMapping.Keys) {
            if ($key -eq $oldPath) {
                $newPath = $pathMapping[$key]
                break
            }
        }
        
        if ($newPath) {
            # Find line number
            $lineNum = 0
            for ($i = 0; $i -lt $lines.Count; $i++) {
                if ($lines[$i] -match [regex]::Escape($oldPath)) {
                    $lineNum = $i + 1
                    break
                }
            }
            
            # Get context (the line containing the path)
            $context = if ($lineNum -gt 0) { 
                $lines[$lineNum - 1].Trim() 
            } else { 
                "Context not found" 
            }
            
            # Truncate long context
            if ($context.Length -gt 100) {
                $context = $context.Substring(0, 97) + "..."
            }
            
            $updates += [PSCustomObject]@{
                UpdateID = $updateId++
                MarkdownFile = $mdFile
                LineNumber = $lineNum
                OldPath = $oldPath
                NewPath = $newPath
                ChangeType = if ($mdFile -like "*poinsettia*") { "Rename (poinsettia→hibiscus)" } else { "Rename (convention)" }
                Context = $context
            }
            
            $foundCount++
        }
        else {
            Write-Host "  No mapping found for: $oldPath" -ForegroundColor Yellow
        }
    }
    
    Write-Host "  Found $foundCount path updates" -ForegroundColor Green
}

# Special handling for poinsettia→hibiscus file rename
if (Test-Path "_builds\plant-displays\poinsettia-001-planning-build.md") {
    $updates += [PSCustomObject]@{
        UpdateID = $updateId++
        MarkdownFile = "_builds\plant-displays\poinsettia-001-planning-build.md"
        LineNumber = 0
        OldPath = "N/A - FILE RENAME"
        NewPath = "_builds\plant-displays\hibiscus-001-planning-build.md"
        ChangeType = "File Rename"
        Context = "Rename build log file from poinsettia to hibiscus"
    }
}

# Export to CSV
$updates | Export-Csv $OutputPath -NoTypeInformation -Encoding UTF8

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "MARKDOWN UPDATES SUMMARY" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total updates: $($updates.Count)" -ForegroundColor Green
Write-Host "Files affected: $($updates.MarkdownFile | Select-Object -Unique | Measure-Object).Count" -ForegroundColor Green
Write-Host "`nOutput saved to: $OutputPath" -ForegroundColor Yellow
Write-Host "`nBreakdown by file:" -ForegroundColor Cyan
$updates | Group-Object MarkdownFile | ForEach-Object {
    Write-Host "  $($_.Name): $($_.Count) updates" -ForegroundColor White
}

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Review RENAME-INVENTORY.csv for file rename changes" -ForegroundColor White
Write-Host "2. Review MARKDOWN-UPDATES.csv for markdown path updates" -ForegroundColor White
Write-Host "3. Validate each row to ensure correct mappings" -ForegroundColor White
Write-Host "4. Once validated, execute the actual rename and update operations" -ForegroundColor White
