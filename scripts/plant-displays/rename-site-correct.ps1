# Rename Site Files Using SOURCE CSV
# Uses SOURCE-STRUCTURE-ANALYSIS.csv for correct authoritative mapping

$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SITE FILE RENAMER (SOURCE CSV)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$workspaceRoot = "\\ukwsdev07\e$\Models4Comfort"
$csvPath = "SOURCE-STRUCTURE-ANALYSIS.csv"

if (-not (Test-Path $csvPath)) {
    Write-Host "ERROR: $csvPath not found" -ForegroundColor Red
    exit 1
}

# Load SOURCE CSV (authoritative)
Write-Host "`nLoading SOURCE CSV..." -ForegroundColor Cyan
$sourceEntries = Import-Csv $csvPath

Write-Host "Loaded $($sourceEntries.Count) source entries" -ForegroundColor Green

# Skip plants already processed
$alreadyDone = @('Daffoldil')
Write-Host "Skipping already-processed: $($alreadyDone -join ', ')" -ForegroundColor Yellow

# Build site rename mappings
$renames = @()

foreach ($entry in $sourceEntries) {
    if ($entry.NeedsRename -ne 'YES') {
        continue
    }
    
    # Skip already-processed plants
    if ($alreadyDone -contains $entry.PlantName) {
        continue
    }
    
    # Build site path - handle daffoldil vs daffodil spelling difference
    $plantLower = $entry.PlantName.ToLower()
    if ($plantLower -eq 'daffoldil') {
        $plantLower = 'daffodil'  # Site uses correct spelling
    }
    
    $category = $entry.Category
    $subfolder = $entry.Subfolder
    $currentFilename = $entry.CurrentFileName
    
    # Build actual site path
    if ($subfolder) {
        $sitePath = Join-Path $workspaceRoot "assets\images\projects\plant-displays\$plantLower\$category\$subfolder\$currentFilename"
    } else {
        $sitePath = Join-Path $workspaceRoot "assets\images\projects\plant-displays\$plantLower\$category\$currentFilename"
    }
    
    if (Test-Path $sitePath) {
        $renames += @{
            CurrentPath = $sitePath
            CurrentFilename = $entry.CurrentFileName
            NewFilename = $entry.SuggestedNewName
            PlantName = $entry.PlantName
            Category = $entry.Category
        }
    }
}

Write-Host "Found $($renames.Count) site files to rename" -ForegroundColor Yellow

if ($renames.Count -eq 0) {
    Write-Host "`nNo files need renaming. Exiting." -ForegroundColor Green
    exit 0
}

# Show breakdown
Write-Host "`nBreakdown by plant:" -ForegroundColor Cyan
$renames | Group-Object PlantName | ForEach-Object {
    Write-Host "  $($_.Name): $($_.Count) files" -ForegroundColor White
}

# Show samples
Write-Host "`nSample renames (first 10):" -ForegroundColor Cyan
$renames | Select-Object -First 10 | ForEach-Object {
    Write-Host "  $($_.CurrentFilename) → $($_.NewFilename)" -ForegroundColor Gray
}

# Auto-proceed

# Perform renames
Write-Host "`nRenaming files..." -ForegroundColor Cyan

$success = 0
$failed = 0
$errors = @()

foreach ($rename in $renames) {
    try {
        Rename-Item -Path $rename.CurrentPath -NewName $rename.NewFilename -ErrorAction Stop
        $success++
        
        if ($success % 10 -eq 0) {
            Write-Host "  Progress: $success / $($renames.Count)" -ForegroundColor Gray
        }
    } catch {
        $failed++
        $errors += "$($rename.CurrentPath) - $($_.Exception.Message)"
        Write-Host "  ✗ FAILED: $($rename.CurrentFilename) - $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SITE RENAME COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nSuccess: $success" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Gray" })

if ($errors.Count -gt 0) {
    Write-Host "`nErrors:" -ForegroundColor Red
    $errors | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
}

Write-Host "`n========================================" -ForegroundColor Cyan
