# Build Hash-Based Mapping Between Site and Source Files
# Uses file hashes to correctly identify which site file corresponds to which source file

$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "BUILDING HASH-BASED SITE-SOURCE MAP" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$sourceBasePath = "\\LSUK-SYNRACK\HomeMedia\hobbies\model building\plant displays"
$siteBasePath = "\\ukwsdev07\e$\Models4Comfort\assets\images\projects\plant-displays"

# Load SOURCE CSV for target names
$sourceEntries = Import-Csv "SOURCE-STRUCTURE-ANALYSIS.csv"
Write-Host "Loaded $($sourceEntries.Count) source entries" -ForegroundColor Green

# Calculate hashes for all source files
Write-Host "`nCalculating source file hashes..." -ForegroundColor Cyan
$sourceHashes = @{}
$counter = 0

foreach ($entry in $sourceEntries) {
    $counter++
    if ($counter % 20 -eq 0) {
        Write-Host "  Progress: $counter / $($sourceEntries.Count)" -ForegroundColor Gray
    }
    
    if (Test-Path $entry.FullSourcePath) {
        try {
            $hash = (Get-FileHash -Path $entry.FullSourcePath -Algorithm MD5).Hash
            $sourceHashes[$hash] = $entry
        }
        catch {
            Write-Host "  WARNING: Cannot hash $($entry.FullSourcePath)" -ForegroundColor Yellow
        }
    }
}

Write-Host "Calculated $($sourceHashes.Count) source file hashes" -ForegroundColor Green

# Scan all site files and calculate hashes
Write-Host "`nScanning site files and calculating hashes..." -ForegroundColor Cyan
$siteFiles = Get-ChildItem $siteBasePath -Recurse -Filter "*.jpg"
Write-Host "Found $($siteFiles.Count) site files" -ForegroundColor Green

$mappings = @()
$matched = 0
$unmatched = 0
$counter = 0

foreach ($siteFile in $siteFiles) {
    $counter++
    if ($counter % 20 -eq 0) {
        Write-Host "  Progress: $counter / $($siteFiles.Count)" -ForegroundColor Gray
    }
    
    try {
        $hash = (Get-FileHash -Path $siteFile.FullName -Algorithm MD5).Hash
        
        if ($sourceHashes.ContainsKey($hash)) {
            $sourceEntry = $sourceHashes[$hash]
            
            $mappings += [PSCustomObject]@{
                SiteCurrentPath = $siteFile.FullName
                SiteCurrentName = $siteFile.Name
                SourceCurrentName = $sourceEntry.CurrentFileName
                TargetNewName = $sourceEntry.SuggestedNewName
                PlantName = $sourceEntry.PlantName
                Category = $sourceEntry.Category
                Subfolder = $sourceEntry.Subfolder
                Hash = $hash
                NeedsRename = if ($siteFile.Name -ne $sourceEntry.SuggestedNewName) { "YES" } else { "NO" }
            }
            $matched++
        }
        else {
            # Site file not found in source
            $unmatched++
            Write-Host "  WARNING: No source match for $($siteFile.Name)" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "  ERROR: Cannot hash $($siteFile.FullName)" -ForegroundColor Red
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "HASH MATCHING COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Matched: $matched" -ForegroundColor Green
Write-Host "Unmatched: $unmatched" -ForegroundColor $(if ($unmatched -gt 0) { "Yellow" } else { "Green" })

# Save mapping to CSV
$outputPath = "SITE-SOURCE-HASH-MAP.csv"
$mappings | Export-Csv -Path $outputPath -NoTypeInformation
Write-Host "`nSaved mapping to $outputPath" -ForegroundColor Green

# Show summary
$needsRename = $mappings | Where-Object { $_.NeedsRename -eq 'YES' }
Write-Host "`nFiles needing rename: $($needsRename.Count)" -ForegroundColor Cyan

$byPlant = $needsRename | Group-Object PlantName | Select-Object Name, Count | Sort-Object Name
Write-Host "`nBy plant:" -ForegroundColor Cyan
foreach ($group in $byPlant) {
    Write-Host "  $($group.Name): $($group.Count) files" -ForegroundColor White
}

Write-Host "`nSample mappings (first 10 needing rename):" -ForegroundColor Cyan
$needsRename | Select-Object -First 10 | ForEach-Object {
    Write-Host "  $($_.SiteCurrentName) → $($_.TargetNewName)" -ForegroundColor White
}

Write-Host "`n========================================" -ForegroundColor Cyan
