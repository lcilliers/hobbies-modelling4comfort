# Rename Site Files Using CSV Mapping
# Uses MARKDOWN-IMAGE-REFERENCES.csv for authoritative name mapping

param(
    [Parameter(Mandatory=$false)]
    [switch]$Confirm = $true
)

$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SITE FILE RENAMER (CSV-BASED)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$workspaceRoot = "\\ukwsdev07\e$\Models4Comfort"
$csvPath = "MARKDOWN-IMAGE-REFERENCES.csv"

if (-not (Test-Path $csvPath)) {
    Write-Host "ERROR: $csvPath not found" -ForegroundColor Red
    exit 1
}

# Load CSV with authoritative mappings
Write-Host "`nLoading CSV mappings..." -ForegroundColor Cyan
$csvMappings = Import-Csv $csvPath

Write-Host "Loaded $($csvMappings.Count) image references" -ForegroundColor Green

# Build mapping: actual current site path -> new name
$pathMappings = @{}

foreach ($mapping in $csvMappings) {
    if (-not $mapping.NewFilename) {
        continue  # Skip unmapped entries
    }
    
    $currentPath = Join-Path $workspaceRoot $mapping.CurrentFullPath.Replace('/', '\')
    $newPath = Join-Path $workspaceRoot $mapping.NewFullPath.Replace('/', '\')
    
    # Only add if current != new
    if ($currentPath -ne $newPath) {
        $pathMappings[$currentPath] = @{
            CurrentPath = $currentPath
            NewPath = $newPath
            CurrentFilename = $mapping.CurrentFilename
            NewFilename = $mapping.NewFilename
            PlantName = $mapping.PlantName
            Category = $mapping.Category
        }
    }
}

Write-Host "Found $($pathMappings.Count) files needing rename from CSV" -ForegroundColor Yellow

# Verify files exist and prepare renames
$renames = @()
$notFound = @()

Write-Host "`nVerifying files exist..." -ForegroundColor Cyan

foreach ($key in $pathMappings.Keys) {
    $mapping = $pathMappings[$key]
    
    if (Test-Path $mapping.CurrentPath) {
        $renames += $mapping
    } else {
        $notFound += $mapping.CurrentPath
    }
}
Write-Host "Files found and ready to rename: $($renames.Count)" -ForegroundColor Green

if ($notFound.Count -gt 0) {
    Write-Host "Files not found (may already be renamed): $($notFound.Count)" -ForegroundColor Yellow
}

if ($renames.Count -eq 0) {
    Write-Host "`nNo files need renaming. All done!" -ForegroundColor Green
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

# Confirm
if ($Confirm) {
    Write-Host "`nProceed with renaming $($renames.Count) files? (y/n): " -NoNewline -ForegroundColor Yellow
    $response = Read-Host
    
    if ($response -ne 'y' -and $response -ne 'Y') {
        Write-Host "Cancelled." -ForegroundColor Yellow
        exit 0
    }
}

# Perform renames
Write-Host "`nRenaming files..." -ForegroundColor Cyan

$success = 0
$failed = 0
$errors = @()

foreach ($rename in $renames) {
    try {
        $newDir = Split-Path $rename.NewPath -Parent
        
        # Ensure directory exists (shouldn't need to create, but just in case)
        if (-not (Test-Path $newDir)) {
            New-Item -Path $newDir -ItemType Directory -Force | Out-Null
        }
        
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
