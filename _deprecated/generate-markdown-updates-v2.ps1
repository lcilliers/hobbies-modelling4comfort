# Generate Markdown Updates from Source Structure Analysis
# Uses the validated SOURCE-STRUCTURE-ANALYSIS.csv to create markdown update plan

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "MARKDOWN UPDATES GENERATOR" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$workspaceRoot = "\\ukwsdev07\e$\Models4Comfort"
$csvPath = "SOURCE-STRUCTURE-ANALYSIS.csv"

if (-not (Test-Path $csvPath)) {
    Write-Host "ERROR: CSV file not found: $csvPath" -ForegroundColor Red
    exit 1
}

# Load source analysis
$sourceAnalysis = Import-Csv $csvPath
Write-Host "`nLoaded: $($sourceAnalysis.Count) entries from source analysis" -ForegroundColor Green

# Build lookup: actual site filename -> new simple name
# Strategy: Scan actual site folders to get REAL filenames, map to new format
Write-Host "`nScanning actual site structure..." -ForegroundColor Cyan

$sitePathMapping = @{}
$sitePlantBase = Join-Path $workspaceRoot "assets\images\projects\plant-displays"

# Scan each plant folder
$plantFolders = Get-ChildItem $sitePlantBase -Directory

foreach ($plantFolder in $plantFolders) {
    $plantName = $plantFolder.Name
    Write-Host "  Scanning plant: $plantName" -ForegroundColor Gray
    
    # Scan each category (build, gallery, planning)
    $categoryFolders = Get-ChildItem $plantFolder.FullName -Directory
    
    foreach ($categoryFolder in $categoryFolders) {
        $category = $categoryFolder.Name
        
        # Get all jpg files recursively in this category
        $imageFiles = Get-ChildItem $categoryFolder.FullName -Filter "*.jpg" -Recurse -File
        
        foreach ($imageFile in $imageFiles) {
            # Build the actual current site relative path (as it exists NOW in markdown)
            $relativePath = $imageFile.FullName.Replace($workspaceRoot + "\", "").Replace("\", "/")
            
            # Find matching entry in source analysis based on plant + category + position
            # We need to match by category and sequential position within that category
            $matchingEntries = $sourceAnalysis | Where-Object { 
                $_.PlantName.ToLower() -eq $plantName -and 
                $_.Category -eq $category 
            }
            
            # Extract number from current filename if possible
            if ($imageFile.Name -match '(\d+)\.jpg$') {
                $currentNum = [int]$matches[1]
                
                # Try to find matching entry by number
                $matchedEntry = $matchingEntries | Where-Object {
                    $_.SuggestedNewName -match "(\d+)\.jpg$" -and
                    [int]$matches[1] -eq $currentNum
                } | Select-Object -First 1
                
                if ($matchedEntry) {
                    $subfolder = if ($imageFile.Directory.Name -ne $category) { 
                        $imageFile.Directory.FullName.Replace($categoryFolder.FullName, "").TrimStart("\").Replace("\", "/")
                    } else { "" }
                    
                    # Build new path
                    if ($subfolder) {
                        $newPath = "assets/images/projects/plant-displays/$plantName/$category/$subfolder/$($matchedEntry.SuggestedNewName)"
                    } else {
                        $newPath = "assets/images/projects/plant-displays/$plantName/$category/$($matchedEntry.SuggestedNewName)"
                    }
                    
                    $sitePathMapping[$relativePath] = $newPath
                }
            }
        }
    }
}

Write-Host "Created path mapping with $($sitePathMapping.Count) entries from actual site files" -ForegroundColor Green

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

$markdownUpdates = @()
$updateId = 1

Write-Host "`nAnalyzing markdown files..." -ForegroundColor Cyan

foreach ($mdFile in $markdownFiles) {
    $fullMdPath = Join-Path $workspaceRoot $mdFile
    
    if (-not (Test-Path $fullMdPath)) {
        Write-Host "  WARNING: $mdFile not found" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "  Processing: $mdFile" -ForegroundColor White
    $lines = Get-Content $fullMdPath
    $foundCount = 0
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        $lineNum = $i + 1
        
        # Find all image paths in this line
        $pattern = 'assets/images/projects/plant-displays/[^"\s)}\]]+\.jpg'
        $matches = [regex]::Matches($line, $pattern)
        
        foreach ($match in $matches) {
            $currentPath = $match.Value
            
            # Look up new path from our mapping
            $newPath = $sitePathMapping[$currentPath]
            
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
                    CurrentPath = $currentPath
                    NewPath = $newPath
                    ChangeType = if ($mdFile -like "*poinsettia*") { "Path + Plant rename" } else { "Path update" }
                    Context = $context
                }
                
                $foundCount++
            }
        }
    }
    
    Write-Host "    Found $foundCount path updates" -ForegroundColor Gray
}

# Add special entries for poinsettia→hibiscus transformations
if (Test-Path (Join-Path $workspaceRoot "_builds\plant-displays\poinsettia-001-planning-build.md")) {
    $markdownUpdates += [PSCustomObject]@{
        UpdateID = $updateId++
        MarkdownFile = "_builds\plant-displays\poinsettia-001-planning-build.md"
        LineNumber = 0
        CurrentPath = "[FILE RENAME]"
        NewPath = "_builds\plant-displays\hibiscus-001-planning-build.md"
        ChangeType = "File Rename"
        Context = "Rename build log file from poinsettia to hibiscus"
    }
    
    $markdownUpdates += [PSCustomObject]@{
        UpdateID = $updateId++
        MarkdownFile = "_builds\plant-displays\hibiscus-001-planning-build.md (after rename)"
        LineNumber = 0
        CurrentPath = "[TEXT: 'Poinsettia']"
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
        CurrentPath = "[TEXT: 'Poinsettia']"
        NewPath = "[TEXT: 'Hibiscus']"
        ChangeType = "Text Replace"
        Context = "Replace 'Poinsettia' with 'Hibiscus' in plant descriptions"
    }
}

# Export to CSV
$outputPath = "MARKDOWN-UPDATES.csv"
$markdownUpdates | Export-Csv $outputPath -NoTypeInformation -Encoding UTF8

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "GENERATION COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nTotal markdown updates: $($markdownUpdates.Count)" -ForegroundColor Green
Write-Host "Output saved to: $outputPath" -ForegroundColor Yellow

Write-Host "`nBreakdown by file:" -ForegroundColor Cyan
$markdownUpdates | Group-Object MarkdownFile | Sort-Object Name | ForEach-Object {
    $updateTypes = $_.Group | Group-Object ChangeType
    Write-Host "  $($_.Name): $($_.Count) updates" -ForegroundColor White
    $updateTypes | ForEach-Object {
        Write-Host "    - $($_.Name): $($_.Count)" -ForegroundColor Gray
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
