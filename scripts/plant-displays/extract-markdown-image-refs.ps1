# Extract Image References from Markdown and Map to New Names
# Only processes images that are actually referenced in markdown files

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "MARKDOWN IMAGE REFERENCE EXTRACTOR" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$workspaceRoot = "\\ukwsdev07\e$\Models4Comfort"
$csvPath = "SOURCE-STRUCTURE-ANALYSIS.csv"

# Load source analysis for mapping
$sourceAnalysis = Import-Csv $csvPath
Write-Host "`nLoaded: $($sourceAnalysis.Count) entries from source analysis" -ForegroundColor Green

# Plant code mapping
$plantCodes = @{
    'bluebells' = 'blu'
    'daffodil' = 'daf'
    'ranunculus' = 'ran'
    'snowdrops' = 'sno'
    'poinsettia' = 'hib'  # Rename to hibiscus
    'hibiscus' = 'hib'
    'protea' = 'pro'
    'strelitzia' = 'str'
}

# Markdown files to scan
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

# Extract all image references
Write-Host "`nExtracting image references from markdown..." -ForegroundColor Cyan

$allImageRefs = @()
$refId = 1

foreach ($mdFile in $markdownFiles) {
    $fullMdPath = Join-Path $workspaceRoot $mdFile
    
    if (-not (Test-Path $fullMdPath)) {
        Write-Host "  SKIP: $mdFile not found" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "  Scanning: $mdFile" -ForegroundColor White
    $content = Get-Content $fullMdPath -Raw
    
    # Find all plant-displays image paths
    $pattern = 'assets/images/projects/plant-displays/([^/]+)/([^/]+)/([^"\s)}\]]+\.jpg)'
    $matches = [regex]::Matches($content, $pattern)
    
    $foundCount = 0
    foreach ($match in $matches) {
        $fullPath = $match.Groups[0].Value
        $plantName = $match.Groups[1].Value
        $category = $match.Groups[2].Value
        $filename = $match.Groups[3].Value
        
        # Check if this is a subfolder or just filename
        $subfolder = ""
        if ($filename -match '^(.+)/([^/]+)$') {
            $subfolder = $matches[1]
            $filename = $matches[2]
        }
        
        $allImageRefs += [PSCustomObject]@{
            RefID = $refId++
            MarkdownFile = $mdFile
            CurrentFullPath = $fullPath
            PlantName = $plantName
            Category = $category
            Subfolder = $subfolder
            CurrentFilename = $filename
            NewFilename = ""  # To be filled
            NewFullPath = ""  # To be filled
        }
        
        $foundCount++
    }
    
    Write-Host "    Found $foundCount references" -ForegroundColor Gray
}

Write-Host "`nTotal image references found: $($allImageRefs.Count)" -ForegroundColor Green

# Now map to new names
Write-Host "`nMapping to new names..." -ForegroundColor Cyan

# Build site file inventory with actual filenames
$siteBasePath = Join-Path $workspaceRoot "assets\images\projects\plant-displays"
$siteFileInventory = @{}

Get-ChildItem $siteBasePath -Filter "*.jpg" -Recurse -File | ForEach-Object {
    $relPath = $_.FullName.Replace($workspaceRoot + "\", "").Replace("\", "/")
    $siteFileInventory[$relPath] = $_
}

Write-Host "Site inventory: $($siteFileInventory.Count) files" -ForegroundColor Gray

# Map each reference
$mappedCount = 0
$unmappedRefs = @()

foreach ($ref in $allImageRefs) {
    $currentPath = $ref.CurrentFullPath
    
    # Check if this file exists in site
    if ($siteFileInventory.ContainsKey($currentPath)) {
        $siteFile = $siteFileInventory[$currentPath]
        $actualFilename = $siteFile.Name
        
        # Try to extract number from current filename
        $currentNum = $null
        if ($actualFilename -match '[-_]0*(\d+)\.jpg$') {
            $currentNum = [int]$matches[1]
        }
        
        # Get plant code
        $plantCode = $plantCodes[$ref.PlantName.ToLower()]
        if (-not $plantCode) {
            Write-Host "  WARNING: No code for plant '$($ref.PlantName)'" -ForegroundColor Yellow
            continue
        }
        
        # Build new filename: [code]-[category]-[###].jpg
        # Use the current number if available, otherwise we'll need to assign
        if ($currentNum) {
            $newFilename = "$plantCode-$($ref.Category)-$($currentNum.ToString('000')).jpg"
        } else {
            Write-Host "  WARNING: Cannot extract number from '$actualFilename'" -ForegroundColor Yellow
            $unmappedRefs += $ref
            continue
        }
        
        # Build new full path
        if ($ref.Subfolder) {
            $newFullPath = "assets/images/projects/plant-displays/$($ref.PlantName)/$($ref.Category)/$($ref.Subfolder)/$newFilename"
        } else {
            $newFullPath = "assets/images/projects/plant-displays/$($ref.PlantName)/$($ref.Category)/$newFilename"
        }
        
        $ref.NewFilename = $newFilename
        $ref.NewFullPath = $newFullPath
        $mappedCount++
    } else {
        Write-Host "  WARNING: File not found in site: $currentPath" -ForegroundColor Yellow
        $unmappedRefs += $ref
    }
}

Write-Host "Successfully mapped: $mappedCount references" -ForegroundColor Green
if ($unmappedRefs.Count -gt 0) {
    Write-Host "Unmapped references: $($unmappedRefs.Count)" -ForegroundColor Yellow
}

# Export to CSV
$outputPath = "MARKDOWN-IMAGE-REFERENCES.csv"
$allImageRefs | Export-Csv $outputPath -NoTypeInformation -Encoding UTF8

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "EXTRACTION COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "`nOutput saved to: $outputPath" -ForegroundColor Yellow
Write-Host "Total references: $($allImageRefs.Count)" -ForegroundColor White
Write-Host "Mapped: $mappedCount" -ForegroundColor Green
Write-Host "Unmapped: $($unmappedRefs.Count)" -ForegroundColor $(if ($unmappedRefs.Count -gt 0) { "Yellow" } else { "Green" })

# Show breakdown by file
Write-Host "`nBreakdown by markdown file:" -ForegroundColor Cyan
$allImageRefs | Group-Object MarkdownFile | Sort-Object Name | ForEach-Object {
    Write-Host "  $($_.Name): $($_.Count) images" -ForegroundColor White
}

# Show breakdown by plant
Write-Host "`nBreakdown by plant:" -ForegroundColor Cyan
$allImageRefs | Group-Object PlantName | Sort-Object Name | ForEach-Object {
    Write-Host "  $($_.Name): $($_.Count) images" -ForegroundColor White
}

if ($unmappedRefs.Count -gt 0) {
    Write-Host "`nUnmapped references:" -ForegroundColor Yellow
    $unmappedRefs | ForEach-Object {
        Write-Host "  $($_.CurrentFullPath)" -ForegroundColor Gray
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
