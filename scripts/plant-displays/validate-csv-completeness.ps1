# Validation Script - Compare actual files vs CSV entries
# Verifies that all images in source web-optimized folders are included in the CSV

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "CSV COMPLETENESS VALIDATION" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$sourceBase = "\\LSUK-SYNRACK\HomeMedia\hobbies\model building\plant displays"
$csvPath = "SOURCE-STRUCTURE-ANALYSIS.csv"

if (-not (Test-Path $csvPath)) {
    Write-Host "ERROR: CSV file not found: $csvPath" -ForegroundColor Red
    exit 1
}

# Load CSV
$csvEntries = Import-Csv $csvPath
Write-Host "`nCSV loaded: $($csvEntries.Count) entries" -ForegroundColor Green

# Get all plant folders
$plantFolders = Get-ChildItem $sourceBase -Directory | Where-Object { $_.Name -ne 'web-optimized' }

Write-Host "`nValidating each plant..." -ForegroundColor Yellow

$allValid = $true
$totalActualFiles = 0
$totalCsvEntries = 0

foreach ($plantFolder in $plantFolders | Sort-Object Name) {
    $plantName = $plantFolder.Name
    
    # Look for web-optimized folder
    $webOptPath = Join-Path $plantFolder.FullName "web-optimized"
    
    if (-not (Test-Path $webOptPath)) {
        Write-Host "`n${plantName}: No web-optimized folder" -ForegroundColor Gray
        continue
    }
    
    # Count actual files in web-optimized
    $actualFiles = Get-ChildItem $webOptPath -Filter "*.jpg" -Recurse -File
    $actualCount = $actualFiles.Count
    
    # Count CSV entries for this plant
    $csvPlantEntries = $csvEntries | Where-Object { $_.PlantName -eq $plantName }
    $csvCount = $csvPlantEntries.Count
    
    $totalActualFiles += $actualCount
    $totalCsvEntries += $csvCount
    
    # Compare
    if ($actualCount -eq $csvCount) {
        Write-Host "`n✓ $plantName" -ForegroundColor Green
        Write-Host "  Actual files: $actualCount" -ForegroundColor Gray
        Write-Host "  CSV entries:  $csvCount" -ForegroundColor Gray
    }
    else {
        $allValid = $false
        Write-Host "`n✗ $plantName - MISMATCH!" -ForegroundColor Red
        Write-Host "  Actual files: $actualCount" -ForegroundColor Yellow
        Write-Host "  CSV entries:  $csvCount" -ForegroundColor Yellow
        Write-Host "  Difference:   $($actualCount - $csvCount)" -ForegroundColor Yellow
        
        # List actual files to help identify missing ones
        if ($actualCount -ne $csvCount) {
            Write-Host "`n  Listing actual files in web-optimized:" -ForegroundColor Cyan
            
            # Get CSV filenames for this plant
            $csvFilenames = @{}
            foreach ($entry in $csvPlantEntries) {
                $csvFilenames[$entry.CurrentFileName] = $true
            }
            
            # Check each actual file
            $missingInCsv = @()
            $extraInCsv = @()
            
            foreach ($file in $actualFiles) {
                if (-not $csvFilenames.ContainsKey($file.Name)) {
                    $missingInCsv += $file
                }
            }
            
            if ($missingInCsv.Count -gt 0) {
                Write-Host "`n  Files in source but NOT in CSV: $($missingInCsv.Count)" -ForegroundColor Red
                $missingInCsv | ForEach-Object {
                    $relPath = $_.FullName.Replace("$webOptPath\", '')
                    Write-Host "    - $relPath" -ForegroundColor Yellow
                }
            }
            
            # Check for files in CSV that don't exist in source
            $actualFilenames = @{}
            foreach ($file in $actualFiles) {
                $actualFilenames[$file.Name] = $true
            }
            
            foreach ($entry in $csvPlantEntries) {
                if (-not $actualFilenames.ContainsKey($entry.CurrentFileName)) {
                    $extraInCsv += $entry
                }
            }
            
            if ($extraInCsv.Count -gt 0) {
                Write-Host "`n  Files in CSV but NOT in source: $($extraInCsv.Count)" -ForegroundColor Red
                $extraInCsv | ForEach-Object {
                    Write-Host "    - $($_.WebOptimizedBranch)\$($_.CurrentFileName)" -ForegroundColor Yellow
                }
            }
        }
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "VALIDATION SUMMARY" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nTotal actual files in source: $totalActualFiles" -ForegroundColor White
Write-Host "Total CSV entries:            $totalCsvEntries" -ForegroundColor White

if ($allValid) {
    Write-Host "`n✓ ALL PLANTS VALID - CSV matches source perfectly!" -ForegroundColor Green
}
else {
    Write-Host "`n✗ VALIDATION FAILED - Some plants have mismatches!" -ForegroundColor Red
    Write-Host "`nNext steps:" -ForegroundColor Yellow
    Write-Host "1. Review the mismatches listed above" -ForegroundColor White
    Write-Host "2. Check if files are in unexpected locations" -ForegroundColor White
    Write-Host "3. Regenerate CSV after confirming source structure" -ForegroundColor White
}

Write-Host "`n========================================" -ForegroundColor Cyan
