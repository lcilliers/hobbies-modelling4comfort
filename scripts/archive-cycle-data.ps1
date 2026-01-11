<#
.SYNOPSIS
    Archives AI analysis data after cycle completion.

.DESCRIPTION
    Organizes and archives all AI analysis CSV files, temporary folders, and cycle 
    documentation into a structured archive for future reference.

.PARAMETER ProjectName
    The name of the project

.PARAMETER CycleNumber
    The cycle number to archive (0 for project overview, 1+ for build logs)

.PARAMETER AnalysisPath
    Path to the analysis folder containing CSV files

.PARAMETER ArchiveBasePath
    Base path for archives. Defaults to [AnalysisPath]\archive\

.EXAMPLE
    .\archive-cycle-data.ps1 -ProjectName "log-cabin" -CycleNumber 1 -AnalysisPath "\\server\photos\log-cabin\analysis"

.NOTES
    Part of SOURCE-NARRATIVE-WITH-AI-ANALYSIS methodology Phase 7: Cycle Documentation
    Created: 2026-01-11
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,
    
    [Parameter(Mandatory=$true)]
    [int]$CycleNumber,
    
    [Parameter(Mandatory=$true)]
    [string]$AnalysisPath,
    
    [Parameter(Mandatory=$false)]
    [string]$ArchiveBasePath
)

# Set archive base path
if (-not $ArchiveBasePath) {
    $ArchiveBasePath = Join-Path $AnalysisPath "archive"
}

# Create archive directory structure
$timestamp = Get-Date -Format "yyyy-MM-dd"
$archiveName = "cycle-$($CycleNumber.ToString("D2"))-$timestamp"
$archivePath = Join-Path $ArchiveBasePath $archiveName

Write-Host "`n═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "ARCHIVING CYCLE $CycleNumber DATA" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════`n" -ForegroundColor Cyan

Write-Host "Project: $ProjectName" -ForegroundColor Yellow
Write-Host "Cycle: $CycleNumber" -ForegroundColor Yellow
Write-Host "Archive: $archivePath`n" -ForegroundColor Yellow

# Create archive directory
if (-not (Test-Path $archivePath)) {
    New-Item -ItemType Directory -Path $archivePath -Force | Out-Null
    Write-Host "✅ Created archive directory" -ForegroundColor Green
} else {
    Write-Host "⚠️  Archive directory already exists" -ForegroundColor Yellow
}

# Create subdirectories
$csvPath = Join-Path $archivePath "csv-files"
$tempPath = Join-Path $archivePath "temp-folders"
$docsPath = Join-Path $archivePath "documentation"

New-Item -ItemType Directory -Path $csvPath -Force | Out-Null
New-Item -ItemType Directory -Path $tempPath -Force | Out-Null
New-Item -ItemType Directory -Path $docsPath -Force | Out-Null

Write-Host "✅ Created subdirectories" -ForegroundColor Green

# ═══════════════════════════════════════════════════════════════
# 1. ARCHIVE CSV FILES
# ═══════════════════════════════════════════════════════════════

Write-Host "`n1. Archiving CSV Analysis Files..." -ForegroundColor Magenta

$csvFiles = Get-ChildItem -Path $AnalysisPath -Filter "*.csv" -File
$csvCount = 0

if ($csvFiles.Count -gt 0) {
    foreach ($file in $csvFiles) {
        Copy-Item -Path $file.FullName -Destination $csvPath
        Write-Host "   📄 $($file.Name)" -ForegroundColor Gray
        $csvCount++
    }
    Write-Host "   ✅ Archived $csvCount CSV file(s)" -ForegroundColor Green
} else {
    Write-Host "   ℹ️  No CSV files found" -ForegroundColor Gray
}

# ═══════════════════════════════════════════════════════════════
# 2. ARCHIVE TEMP FOLDERS
# ═══════════════════════════════════════════════════════════════

Write-Host "`n2. Archiving Temporary Folders..." -ForegroundColor Magenta

$tempFolders = Get-ChildItem -Path $AnalysisPath -Filter "temp-*" -Directory
$tempCount = 0

if ($tempFolders.Count -gt 0) {
    foreach ($folder in $tempFolders) {
        $destFolder = Join-Path $tempPath $folder.Name
        Copy-Item -Path $folder.FullName -Destination $destFolder -Recurse
        Write-Host "   📁 $($folder.Name)" -ForegroundColor Gray
        $tempCount++
    }
    Write-Host "   ✅ Archived $tempCount temp folder(s)" -ForegroundColor Green
} else {
    Write-Host "   ℹ️  No temp folders found" -ForegroundColor Gray
}

# ═══════════════════════════════════════════════════════════════
# 3. CREATE ARCHIVE INDEX
# ═══════════════════════════════════════════════════════════════

Write-Host "`n3. Creating Archive Index..." -ForegroundColor Magenta

$indexContent = @"
# Archive Index - Cycle $CycleNumber
## $ProjectName

**Archive Date:** $timestamp
**Cycle Number:** $CycleNumber
**Archive Path:** $archivePath

---

## Contents

### CSV Analysis Files ($csvCount files)
"@

if ($csvFiles.Count -gt 0) {
    foreach ($file in $csvFiles) {
        $size = [math]::Round($file.Length / 1KB, 2)
        $indexContent += "`n- **$($file.Name)** - $size KB"
    }
} else {
    $indexContent += "`n- None"
}

$indexContent += @"

### Temporary Folders ($tempCount folders)
"@

if ($tempFolders.Count -gt 0) {
    foreach ($folder in $tempFolders) {
        $fileCount = (Get-ChildItem -Path $folder.FullName -File -Recurse).Count
        $indexContent += "`n- **$($folder.Name)** - $fileCount file(s)"
    }
} else {
    $indexContent += "`n- None"
}

$indexContent += @"


---

## How to Use This Archive

### View CSV Analysis Results

``````powershell
# Import and view CSV data
`$data = Import-Csv "$archivePath\csv-files\[filename].csv"
`$data | Format-Table -Wrap
``````

### Review Temp Folder Images

Images used in focused analysis passes are archived in temp-folders\ subdirectories.

### Compare with Other Cycles

Compare analysis approaches and results across cycles to refine your process.

---

**Archive Status:** ✅ COMPLETE  
**Created:** $timestamp  
**Project:** $ProjectName
"@

$indexPath = Join-Path $archivePath "INDEX.md"
$indexContent | Out-File -FilePath $indexPath -Encoding utf8

Write-Host "   ✅ Created INDEX.md" -ForegroundColor Green

# ═══════════════════════════════════════════════════════════════
# 4. CREATE CYCLE STATISTICS
# ═══════════════════════════════════════════════════════════════

Write-Host "`n4. Generating Cycle Statistics..." -ForegroundColor Magenta

$totalImages = 0
$totalCost = 0

# Count images analyzed from CSV files
foreach ($file in $csvFiles) {
    $csvData = Import-Csv -Path $file.FullName
    $totalImages += $csvData.Count
}

# Estimate cost (rough estimate: $0.12 per image)
$totalCost = $totalImages * 0.12

$statsContent = @"
# Cycle $CycleNumber Statistics
## $ProjectName

**Analysis Date:** $timestamp

---

## Analysis Summary

- **Total Images Analyzed:** $totalImages
- **Analysis Passes:** $($csvFiles.Count)
- **Temp Folders Created:** $($tempFolders.Count)
- **Estimated API Cost:** `$$($totalCost.ToString("F2"))

## CSV Files Generated

| File | Row Count | Size (KB) |
|------|-----------|-----------|
"@

foreach ($file in $csvFiles) {
    $csvData = Import-Csv -Path $file.FullName
    $size = [math]::Round($file.Length / 1KB, 2)
    $statsContent += "`n| $($file.Name) | $($csvData.Count) | $size |"
}

$statsContent += @"


## Analysis Efficiency

- **Images per Pass:** $([math]::Round($totalImages / [math]::Max($csvFiles.Count, 1), 2))
- **Cost per Image:** `$$([math]::Round($totalCost / [math]::Max($totalImages, 1), 3))

---

**Generated:** $timestamp
"@

$statsPath = Join-Path $archivePath "STATISTICS.md"
$statsContent | Out-File -FilePath $statsPath -Encoding utf8

Write-Host "   ✅ Created STATISTICS.md" -ForegroundColor Green

# ═══════════════════════════════════════════════════════════════
# 5. OPTIONAL: REMOVE SOURCE FILES
# ═══════════════════════════════════════════════════════════════

Write-Host "`n5. Cleanup Options..." -ForegroundColor Magenta

Write-Host "`n   Archive complete. Source files are still in:" -ForegroundColor Gray
Write-Host "   $AnalysisPath`n" -ForegroundColor Cyan

$response = Read-Host "   Remove source CSV and temp folders? (y/N)"

if ($response -eq 'y' -or $response -eq 'Y') {
    foreach ($file in $csvFiles) {
        Remove-Item -Path $file.FullName -Force
        Write-Host "   🗑️  Removed: $($file.Name)" -ForegroundColor Gray
    }
    
    foreach ($folder in $tempFolders) {
        Remove-Item -Path $folder.FullName -Recurse -Force
        Write-Host "   🗑️  Removed: $($folder.Name)\" -ForegroundColor Gray
    }
    
    Write-Host "`n   ✅ Source files removed" -ForegroundColor Green
} else {
    Write-Host "`n   ℹ️  Source files retained" -ForegroundColor Gray
}

# ═══════════════════════════════════════════════════════════════
# SUMMARY
# ═══════════════════════════════════════════════════════════════

Write-Host "`n═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "ARCHIVE COMPLETE" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════`n" -ForegroundColor Cyan

Write-Host "Archive Location:" -ForegroundColor Yellow
Write-Host "$archivePath`n" -ForegroundColor Cyan

Write-Host "Contents:" -ForegroundColor Yellow
Write-Host "  • $csvCount CSV file(s)" -ForegroundColor Gray
Write-Host "  • $tempCount temp folder(s)" -ForegroundColor Gray
Write-Host "  • INDEX.md (contents listing)" -ForegroundColor Gray
Write-Host "  • STATISTICS.md (analysis stats)" -ForegroundColor Gray

Write-Host "`nTotal Images Analyzed: $totalImages" -ForegroundColor Yellow
Write-Host "Estimated Cost: `$$($totalCost.ToString("F2"))`n" -ForegroundColor Yellow

Write-Host "✅ Cycle $CycleNumber data archived successfully!`n" -ForegroundColor Green
