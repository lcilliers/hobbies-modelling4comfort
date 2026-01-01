# Rename Image Files by Plant
# Renames files in both source and site based on SOURCE-STRUCTURE-ANALYSIS.csv

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('bluebells', 'daffodil', 'ranunculus', 'snowdrops', 'protea', 'strelitzia', 'hibiscus', 'all')]
    [string]$Plant,
    
    [Parameter(Mandatory=$false)]
    [ValidateSet('source', 'site', 'both')]
    [string]$Location = 'both',
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "FILE RENAMER - $($Plant.ToUpper()) - $($Location.ToUpper())" -ForegroundColor Cyan
if ($DryRun) {
    Write-Host "DRY RUN MODE - NO CHANGES WILL BE MADE" -ForegroundColor Yellow
}
Write-Host "========================================" -ForegroundColor Cyan

$csvPath = "SOURCE-STRUCTURE-ANALYSIS.csv"

if (-not (Test-Path $csvPath)) {
    Write-Host "ERROR: $csvPath not found" -ForegroundColor Red
    exit 1
}

# Load source analysis
$allEntries = Import-Csv $csvPath

# Map plant names (handle case and daffodil spelling)
$plantMapping = @{
    'bluebells' = 'Bluebells'
    'daffodil' = 'Daffoldil'  # Source uses this spelling
    'ranunculus' = 'ranunculus'
    'snowdrops' = 'snowdrops'
    'protea' = 'Protea'
    'strelitzia' = 'strelitzia'
    'hibiscus' = 'Hibiscus'
}

# Filter entries
if ($Plant -eq 'all') {
    $entries = $allEntries | Where-Object { $_.NeedsRename -eq 'YES' }
} else {
    $sourcePlantName = $plantMapping[$Plant.ToLower()]
    $entries = $allEntries | Where-Object { 
        $_.PlantName -eq $sourcePlantName -and 
        $_.NeedsRename -eq 'YES' 
    }
}

if ($entries.Count -eq 0) {
    Write-Host "No files need renaming for $Plant" -ForegroundColor Yellow
    exit 0
}

Write-Host "`nFound $($entries.Count) files to rename" -ForegroundColor Green

# Show breakdown
Write-Host "`nBreakdown by category:" -ForegroundColor Cyan
$entries | Group-Object Category | ForEach-Object {
    Write-Host "  $($_.Name): $($_.Count) files" -ForegroundColor White
}

# Show sample renames
Write-Host "`nSample renames (first 5):" -ForegroundColor Cyan
$entries | Select-Object -First 5 | ForEach-Object {
    Write-Host "  $($_.CurrentFileName) → $($_.SuggestedNewName)" -ForegroundColor White
}

# Confirm
if (-not $DryRun) {
    Write-Host "`nProceed with renaming? (y/n): " -NoNewline -ForegroundColor Yellow
    $confirm = Read-Host
    
    if ($confirm -ne 'y' -and $confirm -ne 'Y') {
        Write-Host "Cancelled." -ForegroundColor Yellow
        exit 0
    }
}

# Perform renames
$sourceSuccess = 0
$sourceFailed = 0
$siteSuccess = 0
$siteFailed = 0
$errors = @()

Write-Host "`nProcessing renames..." -ForegroundColor Cyan

foreach ($entry in $entries) {
    # SOURCE RENAME
    if ($Location -eq 'source' -or $Location -eq 'both') {
        $sourcePath = $entry.FullSourcePath
        
        if (Test-Path $sourcePath) {
            $sourceDir = Split-Path $sourcePath -Parent
            $newSourcePath = Join-Path $sourceDir $entry.SuggestedNewName
            
            try {
                if ($DryRun) {
                    Write-Host "  [DRY RUN] SOURCE: $($entry.CurrentFileName) → $($entry.SuggestedNewName)" -ForegroundColor Gray
                    $sourceSuccess++
                } else {
                    Rename-Item -Path $sourcePath -NewName $entry.SuggestedNewName -ErrorAction Stop
                    $sourceSuccess++
                }
            } catch {
                $sourceFailed++
                $errors += "SOURCE: $sourcePath - $($_.Exception.Message)"
                Write-Host "  ✗ SOURCE FAILED: $($entry.CurrentFileName) - $($_.Exception.Message)" -ForegroundColor Red
            }
        } else {
            Write-Host "  ⚠ SOURCE NOT FOUND: $sourcePath" -ForegroundColor Yellow
            $sourceFailed++
        }
    }
    
    # SITE RENAME
    if ($Location -eq 'site' -or $Location -eq 'both') {
        $sitePath = $entry.FullSitePath
        
        if (Test-Path $sitePath) {
            $siteDir = Split-Path $sitePath -Parent
            $newSitePath = Join-Path $siteDir $entry.SuggestedNewName
            
            try {
                if ($DryRun) {
                    Write-Host "  [DRY RUN] SITE: $($entry.CurrentFileName) → $($entry.SuggestedNewName)" -ForegroundColor Gray
                    $siteSuccess++
                } else {
                    Rename-Item -Path $sitePath -NewName $entry.SuggestedNewName -ErrorAction Stop
                    $siteSuccess++
                }
            } catch {
                $siteFailed++
                $errors += "SITE: $sitePath - $($_.Exception.Message)"
                Write-Host "  ✗ SITE FAILED: $($entry.CurrentFileName) - $($_.Exception.Message)" -ForegroundColor Red
            }
        } else {
            # Site file might have old long name format - try to find it
            $plantLower = $entry.PlantName.ToLower()
            $category = $entry.Category
            $subfolder = $entry.Subfolder
            
            # Try old format: plant-displays-[plant]-[category]-###.jpg
            if ($entry.CurrentFileName -notmatch '^plant-displays-') {
                # Current filename might already be new format, skip
                Write-Host "  ⚠ SITE NOT FOUND (may already be renamed): $sitePath" -ForegroundColor Gray
            } else {
                Write-Host "  ⚠ SITE NOT FOUND: $sitePath" -ForegroundColor Yellow
                $siteFailed++
            }
        }
    }
}

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "RENAME COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nPlant: $Plant" -ForegroundColor White
Write-Host "Location: $Location" -ForegroundColor White

if ($Location -eq 'source' -or $Location -eq 'both') {
    Write-Host "`nSOURCE:" -ForegroundColor Cyan
    Write-Host "  Success: $sourceSuccess" -ForegroundColor Green
    Write-Host "  Failed: $sourceFailed" -ForegroundColor $(if ($sourceFailed -gt 0) { "Red" } else { "Gray" })
}

if ($Location -eq 'site' -or $Location -eq 'both') {
    Write-Host "`nSITE:" -ForegroundColor Cyan
    Write-Host "  Success: $siteSuccess" -ForegroundColor Green
    Write-Host "  Failed: $siteFailed" -ForegroundColor $(if ($siteFailed -gt 0) { "Red" } else { "Gray" })
}

if ($errors.Count -gt 0) {
    Write-Host "`nErrors:" -ForegroundColor Red
    $errors | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
}

if ($DryRun) {
    Write-Host "`n*** DRY RUN COMPLETE - No files were modified ***" -ForegroundColor Yellow
}

Write-Host "`n========================================" -ForegroundColor Cyan
