# Validate site files directly from disk
$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SITE FILE VALIDATION" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$siteBasePath = "\\ukwsdev07\e$\Models4Comfort\assets\images\projects\plant-displays"
$plantFolders = @('bluebells', 'daffodil', 'hibiscus', 'protea', 'ranunculus', 'snowdrops', 'strelitzia')
$plantCodes = @{
    'bluebells' = 'blu'
    'daffodil' = 'daf'
    'hibiscus' = 'hib'
    'protea' = 'pro'
    'ranunculus' = 'ran'
    'snowdrops' = 'sno'
    'strelitzia' = 'str'
}

# Load source hashes for comparison
Write-Host "`nLoading source hashes..." -ForegroundColor Cyan
$sourceFiles = Import-Csv "SOURCE-FILE-HASHES.csv"
$sourceHashes = @{}
foreach ($sf in $sourceFiles) {
    $sourceHashes[$sf.Hash] = $sf
}
Write-Host "Loaded $($sourceFiles.Count) source files" -ForegroundColor Green

# Scan site files
Write-Host "`nScanning site files..." -ForegroundColor Cyan
$allSiteFiles = @()
$oldFormatFiles = @()
$wrongFormatFiles = @()
$notInSource = @()
$duplicateHashes = @{}

foreach ($plantFolder in $plantFolders) {
    $plantPath = Join-Path $siteBasePath $plantFolder
    
    if (-not (Test-Path $plantPath)) {
        Write-Host "  WARNING: $plantFolder folder not found" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "  Processing $plantFolder..." -ForegroundColor Gray
    
    # Get all jpg files recursively
    $files = Get-ChildItem $plantPath -Recurse -Filter "*.jpg"
    
    foreach ($file in $files) {
        # Calculate hash
        $hash = (Get-FileHash $file.FullName -Algorithm MD5).Hash
        
        # Track duplicates
        if ($duplicateHashes.ContainsKey($hash)) {
            $duplicateHashes[$hash] += @($file.FullName)
        } else {
            $duplicateHashes[$hash] = @($file.FullName)
        }
        
        # Extract category from path
        $relativePath = $file.FullName.Substring($plantPath.Length + 1)
        $pathParts = $relativePath -split '\\'
        $category = $pathParts[0]
        
        $expectedCode = $plantCodes[$plantFolder]
        
        # Check naming convention
        $isOldFormat = $file.Name -like 'plant-displays-*'
        $isCorrectFormat = $file.Name -match "^$expectedCode-[a-z]+-\d{3}\.jpg$"
        
        if ($isOldFormat) {
            $oldFormatFiles += [PSCustomObject]@{
                PlantFolder = $plantFolder
                Category = $category
                FileName = $file.Name
                FullPath = $file.FullName
                Hash = $hash
            }
        }
        elseif (-not $isCorrectFormat) {
            $wrongFormatFiles += [PSCustomObject]@{
                PlantFolder = $plantFolder
                Category = $category
                FileName = $file.Name
                FullPath = $file.FullName
                Hash = $hash
            }
        }
        
        # Check if exists in source
        if (-not $sourceHashes.ContainsKey($hash)) {
            $notInSource += [PSCustomObject]@{
                PlantFolder = $plantFolder
                Category = $category
                FileName = $file.Name
                FullPath = $file.FullName
                Hash = $hash
            }
        }
        
        $allSiteFiles += [PSCustomObject]@{
            PlantFolder = $plantFolder
            Category = $category
            FileName = $file.Name
            FullPath = $file.FullName
            Hash = $hash
        }
    }
}

# Report results
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "VALIDATION RESULTS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nTotal site files: $($allSiteFiles.Count)" -ForegroundColor White

# Old format files
if ($oldFormatFiles.Count -gt 0) {
    Write-Host "`nOLD FORMAT FILES (plant-displays-*): $($oldFormatFiles.Count)" -ForegroundColor Red
    $oldFormatFiles | Select-Object PlantFolder, Category, FileName | Format-Table -AutoSize
} else {
    Write-Host "`nOld format files: 0" -ForegroundColor Green
}

# Wrong format files
if ($wrongFormatFiles.Count -gt 0) {
    Write-Host "`nWRONG FORMAT FILES: $($wrongFormatFiles.Count)" -ForegroundColor Yellow
    $wrongFormatFiles | Select-Object PlantFolder, Category, FileName | Format-Table -AutoSize
} else {
    Write-Host "Wrong format files: 0" -ForegroundColor Green
}

# Files not in source
if ($notInSource.Count -gt 0) {
    Write-Host "`nFILES NOT IN SOURCE: $($notInSource.Count)" -ForegroundColor Yellow
    $notInSource | Select-Object PlantFolder, Category, FileName | Format-Table -AutoSize
} else {
    Write-Host "Files not in source: 0" -ForegroundColor Green
}

# Duplicate hashes
$dupes = $duplicateHashes.GetEnumerator() | Where-Object { $_.Value.Count -gt 1 }
if ($dupes.Count -gt 0) {
    Write-Host "`nDUPLICATE FILES (same content): $($dupes.Count) hashes" -ForegroundColor Cyan
    foreach ($dupe in $dupes) {
        Write-Host "`nHash: $($dupe.Key)" -ForegroundColor Gray
        $dupe.Value | ForEach-Object {
            $relPath = $_.Replace("$siteBasePath\", "")
            Write-Host "  $relPath" -ForegroundColor White
        }
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
if ($oldFormatFiles.Count -eq 0 -and $wrongFormatFiles.Count -eq 0 -and $notInSource.Count -eq 0) {
    Write-Host "ALL CHECKS PASSED" -ForegroundColor Green
} else {
    Write-Host "ISSUES FOUND - SEE ABOVE" -ForegroundColor Yellow
}
Write-Host "========================================" -ForegroundColor Cyan
