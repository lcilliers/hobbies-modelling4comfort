# Rename Site Files Using Cross-Reference
# Maps MARKDOWN CSV (current site names) to SOURCE CSV (correct sequential targets)

$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SITE FILE RENAMER (CROSS-REFERENCE)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$workspaceRoot = "\\ukwsdev07\e$\Models4Comfort"

# Load both CSVs
Write-Host "`nLoading CSVs..." -ForegroundColor Cyan
$sourceEntries = Import-Csv "SOURCE-STRUCTURE-ANALYSIS.csv"
$markdownEntries = Import-Csv "MARKDOWN-IMAGE-REFERENCES.csv"

Write-Host "Loaded $($sourceEntries.Count) source entries" -ForegroundColor Green
Write-Host "Loaded $($markdownEntries.Count) markdown entries" -ForegroundColor Green

# Skip already-processed plants
$alreadyDone = @('daffodil', 'hibiscus')
Write-Host "Skipping already-processed: $($alreadyDone -join ', ')" -ForegroundColor Yellow

# Build cross-reference mapping
$renames = @()

foreach ($mdEntry in $markdownEntries) {
    # Skip if no mapping
    if (-not $mdEntry.NewFileName) {
        continue
    }
    
    # Extract plant from old filename
    $oldName = $mdEntry.ActualFilename
    if ($oldName -match '^([a-z]+)-') {
        $plant = $matches[1]
    } else {
        continue
    }
    
    # Skip already-done plants
    if ($alreadyDone -contains $plant) {
        continue
    }
    
    # Find the SOURCE entry that matches this file's characteristics
    # We need to match by plant+category and position in the sequence
    # The MARKDOWN entry has the current site filename
    # The SOURCE entry has the correct target sequential number
    
    # Extract category from old name
    if ($oldName -match '^[a-z]+-([a-z]+)-') {
        $category = $matches[1]
    } else {
        continue
    }
    
    # Extract theme/subfolder from old name (e.g., "english-bluebell", "muscari", "scenery")
    # bluebells-planning-english-bluebell-01.jpg -> english-bluebell
    # bluebells-planning-muscari-01.jpg -> muscari
    if ($oldName -match "^$plant-$category-(.+)-\d+\.jpg$") {
        $theme = $matches[1]
    } else {
        # No theme (simple numbered file)
        $theme = $null
    }
    
    # Find matching SOURCE entry by theme
    $sourceMatch = $null
    if ($theme) {
        $sourceMatch = $sourceEntries | Where-Object {
            $_.PlantName.ToLower() -eq $plant -and
            $_.Category -eq $category -and
            $_.CurrentFileName -match $theme
        } | Select-Object -First 1
    }
    
    if ($sourceMatch) {
        $fullPath = Join-Path $mdEntry.CurrentFullPath $oldName
        
        if (Test-Path $fullPath) {
            $renames += @{
                CurrentPath = $fullPath
                CurrentFilename = $oldName
                NewFilename = $sourceMatch.SuggestedNewName
                Plant = $plant
                Category = $category
                Theme = $theme
            }
        }
    }
}

# Display summary
Write-Host "`nFound $($renames.Count) site files to rename" -ForegroundColor Green

if ($renames.Count -eq 0) {
    Write-Host "`nNo files need renaming. Exiting." -ForegroundColor Yellow
    exit 0
}

$byPlant = $renames | Group-Object Plant | Select-Object Name, Count | Sort-Object Name
Write-Host "`nBreakdown by plant:" -ForegroundColor Cyan
foreach ($group in $byPlant) {
    Write-Host "  $($group.Name): $($group.Count) files" -ForegroundColor White
}

# Show sample renames
Write-Host "`nSample renames (first 10):" -ForegroundColor Cyan
$renames | Select-Object -First 10 | ForEach-Object {
    Write-Host "  $($_.CurrentFilename) → $($_.NewFilename)" -ForegroundColor White
}

# Confirm before proceeding
Write-Host "`nPress Enter to proceed with renaming, or Ctrl+C to cancel..." -ForegroundColor Yellow
Read-Host

# Perform renames
Write-Host "`nRenaming files..." -ForegroundColor Cyan
$success = 0
$failed = 0
$counter = 0

foreach ($rename in $renames) {
    $counter++
    if ($counter % 10 -eq 0) {
        Write-Host "  Progress: $counter / $($renames.Count)" -ForegroundColor Gray
    }
    
    try {
        $parentDir = Split-Path $rename.CurrentPath
        $newPath = Join-Path $parentDir $rename.NewFilename
        
        Rename-Item -Path $rename.CurrentPath -NewName $rename.NewFilename -ErrorAction Stop
        $success++
    }
    catch {
        Write-Host "  FAILED: $($rename.CurrentFilename) - $($_.Exception.Message)" -ForegroundColor Red
        $failed++
    }
}

# Final summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SITE RENAME COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "`nSuccess: $success" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host "`n========================================" -ForegroundColor Cyan
