# Generate hash inventory for SOURCE files
$ErrorActionPreference = "Stop"

Write-Host "Generating SOURCE file hash inventory..." -ForegroundColor Cyan

$sourceBasePath = "\\LSUK-SYNRACK\HomeMedia\hobbies\model building\plant displays"
$plantFolders = @('Bluebells', 'Daffoldil', 'Hibiscus', 'Protea', 'ranunculus', 'snowdrops', 'strelitzia')

$results = @()

foreach ($plantFolder in $plantFolders) {
    $webOptPath = Join-Path $sourceBasePath "$plantFolder\web-optimized"
    
    if (-not (Test-Path $webOptPath)) {
        Write-Host "  Skipping $plantFolder - web-optimized not found" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "  Processing $plantFolder..." -ForegroundColor Gray
    
    # Get all jpg files recursively
    $files = Get-ChildItem $webOptPath -Recurse -Filter "*.jpg"
    
    foreach ($file in $files) {
        # Calculate hash
        $hash = (Get-FileHash $file.FullName -Algorithm MD5).Hash
        
        # Extract category from path (folder after web-optimized)
        $relativePath = $file.FullName.Substring($webOptPath.Length + 1)
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

Write-Host "`nFound $($results.Count) source files" -ForegroundColor Green

# Export to CSV
$results | Export-Csv "SOURCE-FILE-HASHES.csv" -NoTypeInformation
Write-Host "Exported to SOURCE-FILE-HASHES.csv" -ForegroundColor Green
