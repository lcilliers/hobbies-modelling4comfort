# PowerShell Script to Copy Project Images
# This script copies images from your source folders to the website structure

# Configuration
$sourceBase = "\\lsuk-synrack\HomeMedia\hobbies\model building"
$destBase = "\\ukwsdev07\UKWSDEV07-E\Models4Comfort\assets\images\projects"

# Project mapping (source folder name -> destination folder name)
$projectMap = @{
    "ancient forest" = "ancient-forest"
    "cabin in woods" = "cabin-in-woods"
    "Caravaning" = "caravaning"
    "country house" = "country-house"
    "english country garden" = "english-country-garden"
    "Henrhyd falls south wales" = "henrhyd-falls-south-wales"
    "plant display" = "plant-display"
    "riverside cabin" = "riverside-cabin"
    "SA_farm_home" = "sa-farm-home"
    "Sea Rescue" = "sea-rescue"
    "SS Great Britain" = "ss-great-britain"
}

# Image file extensions to copy
$imageExtensions = @("*.jpg", "*.jpeg", "*.png", "*.gif", "*.webp", "*.JPG", "*.JPEG", "*.PNG")

Write-Host "=== Project Image Copy Script ===" -ForegroundColor Cyan
Write-Host ""

# Function to copy images with optional resizing
function Copy-ProjectImages {
    param(
        [string]$SourceFolder,
        [string]$DestFolder,
        [string]$ProjectName,
        [switch]$DryRun
    )
    
    if (-not (Test-Path $SourceFolder)) {
        Write-Host "⚠️  Source folder not found: $SourceFolder" -ForegroundColor Yellow
        return
    }
    
    # Ensure destination exists
    if (-not (Test-Path $DestFolder)) {
        New-Item -ItemType Directory -Path $DestFolder -Force | Out-Null
    }
    
    $imageFiles = Get-ChildItem -Path $SourceFolder -Include $imageExtensions -File -Recurse
    $count = $imageFiles.Count
    
    if ($count -eq 0) {
        Write-Host "  No images found in $ProjectName" -ForegroundColor Gray
        return
    }
    
    Write-Host "📁 $ProjectName - Found $count images" -ForegroundColor Green
    
    $copied = 0
    foreach ($file in $imageFiles) {
        $destFile = Join-Path $DestFolder $file.Name
        
        if ($DryRun) {
            Write-Host "  Would copy: $($file.Name) ($([math]::Round($file.Length/1MB, 2)) MB)" -ForegroundColor Gray
        } else {
            try {
                Copy-Item -Path $file.FullName -Destination $destFile -Force
                $copied++
                Write-Host "  ✓ Copied: $($file.Name)" -ForegroundColor Gray
            } catch {
                Write-Host "  ✗ Failed to copy: $($file.Name) - $($_.Exception.Message)" -ForegroundColor Red
            }
        }
    }
    
    if (-not $DryRun) {
        Write-Host "  Copied $copied of $count images" -ForegroundColor Cyan
    }
    Write-Host ""
}

# Main execution
Write-Host "Source: $sourceBase" -ForegroundColor White
Write-Host "Destination: $destBase" -ForegroundColor White
Write-Host ""

# Ask for confirmation
$response = Read-Host "Do you want to perform a dry run first? (Y/N)"
$dryRun = $response -eq "Y" -or $response -eq "y"

if ($dryRun) {
    Write-Host "=== DRY RUN MODE - No files will be copied ===" -ForegroundColor Yellow
    Write-Host ""
}

# Copy each project
foreach ($project in $projectMap.GetEnumerator()) {
    $sourcePath = Join-Path $sourceBase $project.Key
    $destPath = Join-Path $destBase $project.Value
    
    Copy-ProjectImages -SourceFolder $sourcePath -DestFolder $destPath -ProjectName $project.Value -DryRun:$dryRun
}

# Copy guidance/tutorials to techniques folder
$guidanceSource = Join-Path $sourceBase "guidance_and_tutorials"
$techniquesDest = "\\ukwsdev07\UKWSDEV07-E\Models4Comfort\assets\images\techniques"
if (Test-Path $guidanceSource) {
    Write-Host "📁 Copying tutorial images..." -ForegroundColor Cyan
    Copy-ProjectImages -SourceFolder $guidanceSource -DestFolder $techniquesDest -ProjectName "techniques" -DryRun:$dryRun
}

Write-Host "=== Complete ===" -ForegroundColor Cyan

if ($dryRun) {
    Write-Host ""
    Write-Host "This was a dry run. To actually copy the files, run the script again and answer 'N' to dry run." -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Green
    Write-Host "1. Review the copied images in assets/images/projects/" -ForegroundColor White
    Write-Host "2. Create project markdown files in _projects/ folder" -ForegroundColor White
    Write-Host "3. Reference images in your markdown files" -ForegroundColor White
    Write-Host "4. Commit and push to GitHub" -ForegroundColor White
}
