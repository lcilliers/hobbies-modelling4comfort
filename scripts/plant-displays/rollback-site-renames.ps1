# Rollback Site File Renames
# Reverses the 110 successful renames using the backup CSV

$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "ROLLBACK SITE FILE RENAMES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$workspaceRoot = "\\ukwsdev07\e$\Models4Comfort"
$csvPath = "MARKDOWN-IMAGE-REFERENCES-BACKUP.csv"

if (-not (Test-Path $csvPath)) {
    Write-Host "ERROR: Backup CSV not found" -ForegroundColor Red
    exit 1
}

# Load the backup CSV which has the mappings we used
$csvMappings = Import-Csv $csvPath

# Find files that were successfully renamed (NewFilename exists on disk)
$rollbacks = @()

foreach ($mapping in $csvMappings) {
    if (-not $mapping.NewFilename) {
        continue
    }
    
    $newPath = Join-Path $workspaceRoot $mapping.NewFullPath.Replace('/', '\')
    $oldPath = Join-Path $workspaceRoot $mapping.CurrentFullPath.Replace('/', '\')
    
    # If the NEW name exists on disk, we need to rename it back to OLD name
    if (Test-Path $newPath) {
        $rollbacks += @{
            CurrentPath = $newPath
            OriginalPath = $oldPath
            CurrentFilename = $mapping.NewFilename
            OriginalFilename = $mapping.CurrentFilename
            PlantName = $mapping.PlantName
        }
    }
}

Write-Host "`nFound $($rollbacks.Count) files to rollback" -ForegroundColor Yellow

if ($rollbacks.Count -eq 0) {
    Write-Host "`nNo files to rollback. Exiting." -ForegroundColor Green
    exit 0
}

# Show breakdown
Write-Host "`nBreakdown by plant:" -ForegroundColor Cyan
$rollbacks | Group-Object PlantName | ForEach-Object {
    Write-Host "  $($_.Name): $($_.Count) files" -ForegroundColor White
}

# Show samples
Write-Host "`nSample rollbacks (first 10):" -ForegroundColor Cyan
$rollbacks | Select-Object -First 10 | ForEach-Object {
    Write-Host "  $($_.CurrentFilename) → $($_.OriginalFilename)" -ForegroundColor Gray
}

# Auto-proceed (no confirmation)

# Perform rollbacks
Write-Host "`nRolling back..." -ForegroundColor Cyan

$success = 0
$failed = 0
$errors = @()

foreach ($rollback in $rollbacks) {
    try {
        Rename-Item -Path $rollback.CurrentPath -NewName $rollback.OriginalFilename -ErrorAction Stop
        $success++
        
        if ($success % 10 -eq 0) {
            Write-Host "  Progress: $success / $($rollbacks.Count)" -ForegroundColor Gray
        }
    } catch {
        $failed++
        $errors += "$($rollback.CurrentPath) - $($_.Exception.Message)"
        Write-Host "  ✗ FAILED: $($rollback.CurrentFilename) - $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "ROLLBACK COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nSuccess: $success" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Gray" })

if ($errors.Count -gt 0) {
    Write-Host "`nErrors:" -ForegroundColor Red
    $errors | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
}

Write-Host "`n========================================" -ForegroundColor Cyan
