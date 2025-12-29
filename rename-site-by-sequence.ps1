# Rename Site Files by Sequential Matching
# Matches site files by position within plant+category to SOURCE CSV targets

$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SITE FILE RENAMER (SEQUENTIAL MATCH)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$workspaceRoot = "\\ukwsdev07\e$\Models4Comfort"
$siteBasePath = Join-Path $workspaceRoot "assets\images\projects\plant-displays"

# Load SOURCE CSV
$sourceEntries = Import-Csv "SOURCE-STRUCTURE-ANALYSIS.csv"
Write-Host "Loaded $($sourceEntries.Count) source entries" -ForegroundColor Green

# Skip already-done plants
$skipPlants = @('daffodil', 'hibiscus')
Write-Host "Skipping: $($skipPlants -join ', ')" -ForegroundColor Yellow

# Group SOURCE entries by plant+category for matching
$sourceByPlantCat = $sourceEntries | Where-Object { $_.NeedsRename -eq 'YES' } | Group-Object { "$($_.PlantName)|$($_.Category)" }

$renames = @()

foreach ($group in $sourceByPlantCat) {
    $parts = $group.Name -split '\|'
    $plantName = $parts[0]
    $category = $parts[1]
    
    $plantLower = $plantName.ToLower()
    if ($plantLower -eq 'daffoldil') { $plantLower = 'daffodil' }
    
    # Skip already-done plants
    if ($skipPlants -contains $plantLower) {
        continue
    }
    
    # Get sorted SOURCE entries for this plant+category
    $sourceFiles = $group.Group | Sort-Object { [int]($_.SuggestedNewName -replace '\D') }
    
    # Scan site folder for this plant+category
    $sitePath = Join-Path $siteBasePath "$plantLower\$category"
    
    if (-not (Test-Path $sitePath)) {
        Write-Host "  WARNING: Site path not found: $sitePath" -ForegroundColor Yellow
        continue
    }
    
    # Get all jpg files in this category (including subfolders), sorted by name
    $siteFiles = Get-ChildItem $sitePath -Recurse -Filter "*.jpg" | Sort-Object FullName
    
    if ($siteFiles.Count -ne $sourceFiles.Count) {
        Write-Host "  WARNING: $plantLower/$category - Site has $($siteFiles.Count) files, SOURCE has $($sourceFiles.Count)" -ForegroundColor Yellow
    }
    
    # Match files sequentially
    for ($i = 0; $i -lt [Math]::Min($siteFiles.Count, $sourceFiles.Count); $i++) {
        $siteFile = $siteFiles[$i]
        $sourceEntry = $sourceFiles[$i]
        
        if ($siteFile.Name -ne $sourceEntry.SuggestedNewName) {
            $renames += @{
                CurrentPath = $siteFile.FullName
                CurrentName = $siteFile.Name
                NewName = $sourceEntry.SuggestedNewName
                Plant = $plantLower
                Category = $category
            }
        }
    }
}

# Display summary
Write-Host "`nFound $($renames.Count) files to rename" -ForegroundColor Green

if ($renames.Count -eq 0) {
    Write-Host "No files need renaming. Exiting." -ForegroundColor Yellow
    exit 0
}

$byPlant = $renames | Group-Object Plant | Select-Object Name, Count | Sort-Object Name
Write-Host "`nBy plant:" -ForegroundColor Cyan
foreach ($group in $byPlant) {
    Write-Host "  $($group.Name): $($group.Count) files" -ForegroundColor White
}

Write-Host "`nSample renames (first 15):" -ForegroundColor Cyan
$renames | Select-Object -First 15 | ForEach-Object {
    Write-Host "  $($_.Plant)/$($_.Category)/$($_.CurrentName) → $($_.NewName)" -ForegroundColor White
}

# Confirm
Write-Host "`nPress Enter to proceed, or Ctrl+C to cancel..." -ForegroundColor Yellow
Read-Host

# Perform renames
Write-Host "`nRenaming files..." -ForegroundColor Cyan
$success = 0
$failed = 0

foreach ($rename in $renames) {
    try {
        Rename-Item -Path $rename.CurrentPath -NewName $rename.NewName -ErrorAction Stop
        $success++
        
        if ($success % 10 -eq 0) {
            Write-Host "  Progress: $success / $($renames.Count)" -ForegroundColor Gray
        }
    }
    catch {
        Write-Host "  FAILED: $($rename.CurrentName) → $($rename.NewName) - $($_.Exception.Message)" -ForegroundColor Red
        $failed++
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "RENAME COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Success: $success" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host "========================================" -ForegroundColor Cyan
