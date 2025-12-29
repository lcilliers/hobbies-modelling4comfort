# Generate hash inventory for SITE files
$ErrorActionPreference = "Stop"

Write-Host "Generating SITE file hash inventory..." -ForegroundColor Cyan

$siteBasePath = "\\ukwsdev07\e$\Models4Comfort\assets\images\projects\plant-displays"
$plantFolders = @('bluebells', 'daffodil', 'hibiscus', 'protea', 'ranunculus', 'snowdrops', 'strelitzia')

$results = @()

foreach ($plantFolder in $plantFolders) {
    $plantPath = Join-Path $siteBasePath $plantFolder
    
    if (-not (Test-Path $plantPath)) {
        Write-Host "  Skipping $plantFolder - folder not found" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "  Processing $plantFolder..." -ForegroundColor Gray
    
    # Get all jpg files recursively
    $files = Get-ChildItem $plantPath -Recurse -Filter "*.jpg"
    
    foreach ($file in $files) {
        # Calculate hash
        $hash = (Get-FileHash $file.FullName -Algorithm MD5).Hash
        
        # Extract category from path (folder after plant name)
        $relativePath = $file.FullName.Substring($plantPath.Length + 1)
        $pathParts = $relativePath -split '\\'
        $category = $pathParts[0]
        
        $results += [PSCustomObject]@{
            FullPath = $file.FullName
            PlantName = $plantFolder
            Category = $category
            FileName = $file.Name
            Hash = $hash
        }
    }
}

Write-Host "`nFound $($results.Count) site files" -ForegroundColor Green

# Export to CSV
$results | Export-Csv "SITE-FILE-HASHES.csv" -NoTypeInformation
Write-Host "Exported to SITE-FILE-HASHES.csv" -ForegroundColor Green
