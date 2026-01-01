# Rename site files using hash-based mapping
$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SITE FILE RENAMER (HASH-BASED)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Load hash CSVs
Write-Host "`nLoading hash inventories..." -ForegroundColor Cyan
$sourceFiles = Import-Csv "SOURCE-FILE-HASHES.csv"
$siteFiles = Import-Csv "SITE-FILE-HASHES.csv"

Write-Host "Loaded $($sourceFiles.Count) source files" -ForegroundColor Green
Write-Host "Loaded $($siteFiles.Count) site files" -ForegroundColor Green

# Skip already-done plants
$skipPlants = @('daffodil', 'hibiscus')
Write-Host "Skipping: $($skipPlants -join ', ')" -ForegroundColor Yellow

# Create rename mappings by matching hashes
$renames = @()

foreach ($siteFile in $siteFiles) {
    # Skip already-done plants
    if ($skipPlants -contains $siteFile.PlantName) {
        continue
    }
    
    # Find matching source file by hash
    $sourceMatch = $sourceFiles | Where-Object { $_.Hash -eq $siteFile.Hash } | Select-Object -First 1
    
    if (-not $sourceMatch) {
        Write-Host "  WARNING: No source match for $($siteFile.FileName)" -ForegroundColor Yellow
        continue
    }
    
    # Check if rename is needed
    if ($siteFile.FileName -ne $sourceMatch.FileName) {
        $renames += [PSCustomObject]@{
            CurrentPath = $siteFile.FullPath
            CurrentFileName = $siteFile.FileName
            NewFileName = $sourceMatch.FileName
            PlantName = $siteFile.PlantName
            Category = $siteFile.Category
            Hash = $siteFile.Hash
        }
    }
}

# Display summary
Write-Host "`nFound $($renames.Count) files to rename" -ForegroundColor Green

if ($renames.Count -eq 0) {
    Write-Host "No files need renaming. Exiting." -ForegroundColor Yellow
    exit 0
}

$byPlant = $renames | Group-Object PlantName | Select-Object Name, Count | Sort-Object Name
Write-Host "`nBreakdown by plant:" -ForegroundColor Cyan
foreach ($group in $byPlant) {
    Write-Host "  $($group.Name): $($group.Count) files" -ForegroundColor White
}

Write-Host "`nSample renames (first 10):" -ForegroundColor Cyan
$renames | Select-Object -First 10 | ForEach-Object {
    Write-Host "  $($_.CurrentFileName) → $($_.NewFileName)" -ForegroundColor White
}

# Confirm
Write-Host "`nPress Enter to proceed with renaming, or Ctrl+C to cancel..." -ForegroundColor Yellow
Read-Host

# Perform renames
Write-Host "`nRenaming files..." -ForegroundColor Cyan
$success = 0
$failed = 0

foreach ($rename in $renames) {
    try {
        Rename-Item -Path $rename.CurrentPath -NewName $rename.NewFileName -ErrorAction Stop
        $success++
        
        if ($success % 10 -eq 0) {
            Write-Host "  Progress: $success / $($renames.Count)" -ForegroundColor Gray
        }
    }
    catch {
        Write-Host "  FAILED: $($rename.CurrentFileName) - $($_.Exception.Message)" -ForegroundColor Red
        $failed++
    }
}

# Final summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "RENAME COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Success: $success" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host "========================================" -ForegroundColor Cyan
