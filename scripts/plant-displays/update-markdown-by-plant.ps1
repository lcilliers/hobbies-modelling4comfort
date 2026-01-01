# Update Markdown Image References by Plant
# Allows updating one plant at a time for careful review

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('bluebells', 'daffodil', 'ranunculus', 'snowdrops', 'protea', 'strelitzia', 'all')]
    [string]$Plant
)

$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "MARKDOWN UPDATER - $($Plant.ToUpper())" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$csvPath = "MARKDOWN-IMAGE-REFERENCES.csv"

if (-not (Test-Path $csvPath)) {
    Write-Host "ERROR: $csvPath not found. Run extract-markdown-image-refs.ps1 first." -ForegroundColor Red
    exit 1
}

# Load references
$allRefs = Import-Csv $csvPath

# Filter by plant (skip poinsettia - has no files, will be handled when hibiscus build log exists)
if ($Plant -eq 'all') {
    $plantRefs = $allRefs | Where-Object { 
        $_.PlantName -ne 'poinsettia' -and 
        $_.NewFilename 
    }
} else {
    $plantRefs = $allRefs | Where-Object { 
        $_.PlantName -eq $Plant -and 
        $_.NewFilename 
    }
}

if ($plantRefs.Count -eq 0) {
    Write-Host "No updates needed for $Plant" -ForegroundColor Yellow
    exit 0
}

Write-Host "`nFound $($plantRefs.Count) image references to update" -ForegroundColor Green

# Group by markdown file
$fileGroups = $plantRefs | Group-Object MarkdownFile

Write-Host "`nFiles to update:" -ForegroundColor Cyan
foreach ($group in $fileGroups) {
    Write-Host "  $($group.Name): $($group.Count) updates" -ForegroundColor White
}

# Show sample updates
Write-Host "`nSample updates (first 5):" -ForegroundColor Cyan
$plantRefs | Select-Object -First 5 | ForEach-Object {
    Write-Host "  OLD: $($_.CurrentFilename)" -ForegroundColor Gray
    Write-Host "  NEW: $($_.NewFilename)" -ForegroundColor Green
    Write-Host ""
}

# Ask for confirmation
Write-Host "Proceed with updates? (y/n): " -NoNewline -ForegroundColor Yellow
$confirm = Read-Host

if ($confirm -ne 'y' -and $confirm -ne 'Y') {
    Write-Host "Cancelled." -ForegroundColor Yellow
    exit 0
}

# Perform updates
Write-Host "`nUpdating files..." -ForegroundColor Cyan

$updatedFiles = @{}
$totalReplacements = 0

foreach ($group in $fileGroups) {
    $mdFile = $group.Name
    $fullPath = "\\ukwsdev07\e$\Models4Comfort\$mdFile"
    
    if (-not (Test-Path $fullPath)) {
        Write-Host "  SKIP: $mdFile not found" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "`n  Processing: $mdFile" -ForegroundColor White
    
    # Read file content
    $content = Get-Content $fullPath -Raw
    $originalContent = $content
    $fileReplacements = 0
    
    # Apply each replacement for this file
    foreach ($ref in $group.Group) {
        $oldPath = $ref.CurrentFullPath
        $newPath = $ref.NewFullPath
        
        if ($content -match [regex]::Escape($oldPath)) {
            $content = $content -replace [regex]::Escape($oldPath), $newPath
            $fileReplacements++
            $totalReplacements++
        }
    }
    
    # Write back if changes were made
    if ($content -ne $originalContent) {
        $content | Set-Content $fullPath -NoNewline
        $updatedFiles[$mdFile] = $fileReplacements
        Write-Host "    ✓ Updated: $fileReplacements replacements" -ForegroundColor Green
    } else {
        Write-Host "    ⚠ No changes made (paths may already be updated)" -ForegroundColor Yellow
    }
}

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "UPDATE COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nPlant: $Plant" -ForegroundColor White
Write-Host "Files updated: $($updatedFiles.Count)" -ForegroundColor Green
Write-Host "Total replacements: $totalReplacements" -ForegroundColor Green

if ($updatedFiles.Count -gt 0) {
    Write-Host "`nUpdated files:" -ForegroundColor Cyan
    foreach ($file in $updatedFiles.Keys) {
        Write-Host "  $file - $($updatedFiles[$file]) changes" -ForegroundColor White
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
