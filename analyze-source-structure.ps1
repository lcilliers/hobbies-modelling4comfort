# Analyze Source Folder Structure
# Maps source files to extract plant name and category from folder structure
# Generates suggested new names with sequential numbering across subfolders

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "SOURCE STRUCTURE ANALYZER" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$sourceBase = "\\LSUK-SYNRACK\HomeMedia\hobbies\model building\plant displays"

# Plant code mapping
$plantCodes = @{
    'Bluebells' = 'blu'
    'Daffoldil' = 'daf'
    'ranunculus' = 'ran'
    'snowdrops' = 'sno'
    'Hibiscus' = 'hib'
    'Protea' = 'pro'
    'strelitzia' = 'str'
}

Write-Host "`nScanning source folder: $sourceBase" -ForegroundColor Yellow

if (-not (Test-Path $sourceBase)) {
    Write-Host "ERROR: Source path not accessible: $sourceBase" -ForegroundColor Red
    exit 1
}

# Get all plant folders
$plantFolders = Get-ChildItem $sourceBase -Directory | Where-Object { $_.Name -ne 'web-optimized' }

Write-Host "Found plant folders: $($plantFolders.Count)" -ForegroundColor Green

$sourceAnalysis = @()
$entryId = 1

# Track sequential numbering per plant+category (not per subfolder)
$categoryCounters = @{}

foreach ($plantFolder in $plantFolders) {
    $plantName = $plantFolder.Name
    Write-Host "`nProcessing: $plantName" -ForegroundColor Cyan
    
    # Look for web-optimized folder
    $webOptPath = Join-Path $plantFolder.FullName "web-optimized"
    
    if (-not (Test-Path $webOptPath)) {
        Write-Host "  No web-optimized folder found" -ForegroundColor Yellow
        continue
    }
    
    # Get all files under web-optimized recursively, sorted by path
    $files = Get-ChildItem $webOptPath -Filter "*.jpg" -Recurse -File | Sort-Object FullName
    
    Write-Host "  Found $($files.Count) JPG files in web-optimized" -ForegroundColor Gray
    
    foreach ($file in $files) {
        # Strip base path to get relative structure
        $relativePath = $file.FullName.Replace("$sourceBase\", '')
        
        # Extract category (folder immediately after web-optimized)
        # Path format: PlantName\web-optimized\Category\[Subfolder\]filename.jpg
        $webOptIndex = $relativePath.IndexOf('\web-optimized\')
        if ($webOptIndex -ge 0) {
            $afterWebOpt = $relativePath.Substring($webOptIndex + '\web-optimized\'.Length)
            $pathParts = $afterWebOpt.Split('\')
            
            $category = if ($pathParts.Length -gt 0) { $pathParts[0] } else { 'unknown' }
            $subfolder = if ($pathParts.Length -gt 2) { 
                $pathParts[1..($pathParts.Length - 2)] -join '\' 
            } else { 
                '' 
            }
            
            $branchPath = if ($subfolder) { "$category\$subfolder" } else { $category }
            
            # Get plant code
            $code = $plantCodes[$plantName]
            if (-not $code) {
                $code = $plantName.Substring(0, 3).ToLower()
            }
            
            # Generate suggested new name
            # Key is plant+category (numbering runs across subfolders)
            $counterKey = "$plantName|$category"
            
            # Initialize counter if not exists
            if (-not $categoryCounters.ContainsKey($counterKey)) {
                $categoryCounters[$counterKey] = 1
            }
            
            $currentFileName = $file.Name
            
            # Generate simple sequential name: code-category-###.jpg
            # Sequential numbering is unique within plant+category
            $number = $categoryCounters[$counterKey].ToString('000')
            $suggestedNewName = "$code-$category-$number.jpg"
            
            $categoryCounters[$counterKey]++
            
            # Build site path
            $plantLower = $plantName.ToLower()
            $siteBasePath = "\\ukwsdev07\e$\Models4Comfort\assets\images\projects\plant-displays"
            if ($subfolder) {
                $fullSitePath = "$siteBasePath\$plantLower\$category\$subfolder\$currentFileName"
            } else {
                $fullSitePath = "$siteBasePath\$plantLower\$category\$currentFileName"
            }
            
            $sourceAnalysis += [PSCustomObject]@{
                EntryID = $entryId++
                FullSourcePath = $file.FullName
                FullSitePath = $fullSitePath
                PlantName = $plantName
                Category = $category
                Subfolder = $subfolder
                WebOptimizedBranch = $branchPath
                CurrentFileName = $currentFileName
                SuggestedNewName = $suggestedNewName
                NeedsRename = if ($currentFileName -ne $suggestedNewName) { "YES" } else { "NO" }
            }
        }
    }
}

# Export to CSV
$outputPath = "SOURCE-STRUCTURE-ANALYSIS.csv"
$sourceAnalysis | Export-Csv $outputPath -NoTypeInformation -Encoding UTF8

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "ANALYSIS COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nTotal files analyzed: $($sourceAnalysis.Count)" -ForegroundColor Green
Write-Host "Output saved to: $outputPath" -ForegroundColor Yellow

Write-Host "`nBreakdown by plant:" -ForegroundColor Cyan
$sourceAnalysis | Group-Object PlantName | Sort-Object Name | ForEach-Object {
    Write-Host "  $($_.Name): $($_.Count) files" -ForegroundColor White
    $_.Group | Group-Object Category | ForEach-Object {
        Write-Host "    - $($_.Name): $($_.Count)" -ForegroundColor Gray
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
