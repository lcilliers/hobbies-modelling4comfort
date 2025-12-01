<#
.SYNOPSIS
    Advanced image optimization and manipulation using ImageMagick
    Supports HEIC conversion, resizing, and green screen replacement

.DESCRIPTION
    This script uses ImageMagick to:
    1. Convert HEIC/HEIF to JPEG
    2. Resize and optimize images for web
    3. Replace green screen backgrounds with another image
    
    Prerequisites: ImageMagick must be installed
    Download from: https://imagemagick.org/script/download.php#windows

.PARAMETER SourceFolder
    Path to folder containing images to process

.PARAMETER MaxWidth
    Maximum width in pixels (default: 1920)

.PARAMETER MaxHeight
    Maximum height in pixels (default: 1920)

.PARAMETER JpegQuality
    JPEG quality percentage (1-100, default: 85)

.PARAMETER OutputSubFolder
    Name of subfolder to create for output (default: "web-optimized")

.PARAMETER ReplaceGreenScreen
    Enable green screen background replacement

.PARAMETER BackgroundImage
    Path to image to use as replacement background (required if ReplaceGreenScreen is enabled)

.PARAMETER GreenTolerance
    Tolerance for green color matching (0-100, default: 10). Higher = more aggressive removal

.PARAMETER Recursive
    Process subfolders recursively

.EXAMPLE
    .\imagemagick-optimize.ps1 -SourceFolder "C:\Photos\MyProject"
    
.EXAMPLE
    .\imagemagick-optimize.ps1 -SourceFolder "C:\Photos\MyProject" -MaxWidth 1200 -JpegQuality 90
    
.EXAMPLE
    .\imagemagick-optimize.ps1 -SourceFolder "C:\Photos\GreenScreen" -ReplaceGreenScreen -BackgroundImage "C:\Backgrounds\forest.jpg"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$SourceFolder,
    
    [Parameter(Mandatory=$false)]
    [int]$MaxWidth = 1920,
    
    [Parameter(Mandatory=$false)]
    [int]$MaxHeight = 1920,
    
    [Parameter(Mandatory=$false)]
    [int]$JpegQuality = 85,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputSubFolder = "web-optimized",
    
    [Parameter(Mandatory=$false)]
    [switch]$ReplaceGreenScreen,
    
    [Parameter(Mandatory=$false)]
    [string]$BackgroundImage = "",
    
    [Parameter(Mandatory=$false)]
    [int]$GreenTolerance = 10,
    
    [Parameter(Mandatory=$false)]
    [switch]$Recursive
)

# Supported image extensions
$imageExtensions = @(
    "*.jpg", "*.jpeg", "*.png", "*.bmp", "*.gif", "*.tiff", "*.tif", "*.webp", "*.heic", "*.heif",
    "*.JPG", "*.JPEG", "*.PNG", "*.BMP", "*.GIF", "*.TIFF", "*.TIF", "*.WEBP", "*.HEIC", "*.HEIF"
)

# Statistics
$script:totalFiles = 0
$script:processedFiles = 0
$script:skippedFiles = 0
$script:totalOriginalSize = 0
$script:totalOptimizedSize = 0
$script:errors = @()

# Color output
function Write-Success { param([string]$Message) Write-Host $Message -ForegroundColor Green }
function Write-Info { param([string]$Message) Write-Host $Message -ForegroundColor Cyan }
function Write-Warning { param([string]$Message) Write-Host $Message -ForegroundColor Yellow }
function Write-Error { param([string]$Message) Write-Host $Message -ForegroundColor Red }

# Check if ImageMagick is installed
function Test-ImageMagick {
    try {
        $result = & magick --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            $version = ($result | Select-Object -First 1) -replace "Version: ImageMagick ", ""
            Write-Success "✓ ImageMagick found: $version"
            return $true
        }
    } catch {
        Write-Error "✗ ImageMagick not found!"
        Write-Host ""
        Write-Host "Please install ImageMagick:" -ForegroundColor Yellow
        Write-Host "  1. Download from: https://imagemagick.org/script/download.php#windows" -ForegroundColor White
        Write-Host "  2. Or use: winget install ImageMagick.ImageMagick" -ForegroundColor White
        Write-Host "  3. Make sure to add ImageMagick to your PATH during installation" -ForegroundColor White
        Write-Host ""
        return $false
    }
}

# Function to optimize a single image
function Optimize-ImageMagick {
    param(
        [string]$InputPath,
        [string]$OutputPath,
        [string]$BackgroundPath = ""
    )
    
    try {
        $originalSize = (Get-Item $InputPath).Length
        $inputName = (Get-Item $InputPath).Name
        
        # Build ImageMagick command
        $magickArgs = @()
        
        if ($ReplaceGreenScreen -and $BackgroundPath) {
            # Green screen replacement workflow
            # 1. Load background image and resize to match dimensions
            # 2. Load foreground (green screen) image
            # 3. Make green pixels transparent
            # 4. Composite over background
            
            $magickArgs += @(
                "-size", "${MaxWidth}x${MaxHeight}",
                $BackgroundPath,
                "-resize", "${MaxWidth}x${MaxHeight}^",
                "-gravity", "center",
                "-extent", "${MaxWidth}x${MaxHeight}",
                "(",
                $InputPath,
                "-fuzz", "${GreenTolerance}%",
                "-transparent", "green",
                "-resize", "${MaxWidth}x${MaxHeight}>",
                ")",
                "-gravity", "center",
                "-composite",
                "-quality", $JpegQuality,
                $OutputPath
            )
        } else {
            # Standard optimization workflow
            $magickArgs += @(
                $InputPath,
                "-auto-orient",                    # Fix orientation from EXIF
                "-strip",                          # Remove metadata
                "-resize", "${MaxWidth}x${MaxHeight}>",  # Resize only if larger (> preserves aspect ratio)
                "-quality", $JpegQuality,          # Set JPEG quality
                "-sampling-factor", "4:2:0",       # Standard JPEG subsampling
                $OutputPath
            )
        }
        
        # Execute ImageMagick
        $output = & magick @magickArgs 2>&1
        
        if ($LASTEXITCODE -ne 0) {
            throw "ImageMagick failed: $output"
        }
        
        # Get optimized size
        $optimizedSize = (Get-Item $OutputPath).Length
        
        # Update statistics
        $script:totalOriginalSize += $originalSize
        $script:totalOptimizedSize += $optimizedSize
        $script:processedFiles++
        
        # Calculate savings
        $savings = if ($originalSize -gt 0) { 
            [math]::Round((($originalSize - $optimizedSize) / $originalSize) * 100, 1) 
        } else { 
            0 
        }
        $originalMB = [math]::Round($originalSize / 1MB, 2)
        $optimizedMB = [math]::Round($optimizedSize / 1MB, 2)
        
        Write-Host "  ✓ " -NoNewline -ForegroundColor Green
        Write-Host "$inputName " -NoNewline
        Write-Host "$originalMB MB → $optimizedMB MB " -NoNewline
        Write-Host "(-$savings%)" -ForegroundColor Cyan
        
        return $true
        
    } catch {
        $script:errors += @{Path = $InputPath; Error = $_.Exception.Message}
        Write-Host "  ✗ Failed: $((Get-Item $InputPath).Name) - $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Main execution
Write-Info "=================================================="
Write-Info "  ImageMagick Image Processor"
if ($ReplaceGreenScreen) {
    Write-Info "  Mode: Green Screen Replacement + Optimization"
} else {
    Write-Info "  Mode: Optimization & Format Conversion"
}
Write-Info "  Supports: JPG, PNG, BMP, GIF, TIFF, WEBP, HEIC"
Write-Info "=================================================="
Write-Host ""

# Check ImageMagick
if (-not (Test-ImageMagick)) {
    exit 1
}
Write-Host ""

# Validate source folder
if (-not (Test-Path $SourceFolder)) {
    Write-Error "Error: Source folder not found: $SourceFolder"
    exit 1
}

$SourceFolder = (Resolve-Path $SourceFolder).ProviderPath

# Validate green screen parameters
if ($ReplaceGreenScreen) {
    if (-not $BackgroundImage) {
        Write-Error "Error: -BackgroundImage is required when -ReplaceGreenScreen is enabled"
        exit 1
    }
    if (-not (Test-Path $BackgroundImage)) {
        Write-Error "Error: Background image not found: $BackgroundImage"
        exit 1
    }
    $BackgroundImage = (Resolve-Path $BackgroundImage).ProviderPath
}

Write-Info "Configuration:"
Write-Host "  Source Folder:    $SourceFolder" -ForegroundColor White
Write-Host "  Max Dimensions:   ${MaxWidth}×${MaxHeight} px" -ForegroundColor White
Write-Host "  JPEG Quality:     $JpegQuality%" -ForegroundColor White
Write-Host "  Output Subfolder: $OutputSubFolder" -ForegroundColor White
Write-Host "  Recursive:        $Recursive" -ForegroundColor White
if ($ReplaceGreenScreen) {
    Write-Host "  Green Screen:     Enabled" -ForegroundColor Yellow
    Write-Host "  Background:       $BackgroundImage" -ForegroundColor White
    Write-Host "  Green Tolerance:  $GreenTolerance%" -ForegroundColor White
}
Write-Host ""

# Create output folder
$outputPath = Join-Path $SourceFolder $OutputSubFolder
if (-not (Test-Path $outputPath)) {
    New-Item -ItemType Directory -Path $outputPath -Force | Out-Null
    Write-Success "Created output folder: $outputPath"
} else {
    Write-Warning "Output folder already exists: $outputPath"
    $response = Read-Host "Continue and overwrite existing files? (Y/N)"
    if ($response -ne "Y" -and $response -ne "y") {
        Write-Info "Operation cancelled."
        exit 0
    }
}
Write-Host ""

# Find all image files
Write-Info "Scanning for images..."
if ($Recursive) {
    $imageFiles = Get-ChildItem -Path $SourceFolder -Include $imageExtensions -File -Recurse | 
                  Where-Object { $_.DirectoryName -ne $outputPath }
} else {
    $imageFiles = Get-ChildItem -Path $SourceFolder -File | 
                  Where-Object { 
                      $_.DirectoryName -ne $outputPath -and 
                      $imageExtensions -contains "*$($_.Extension)"
                  }
}

$script:totalFiles = $imageFiles.Count

if ($script:totalFiles -eq 0) {
    Write-Warning "No image files found in the source folder."
    exit 0
}

Write-Success "Found $($script:totalFiles) image(s) to process"
Write-Host ""

$response = Read-Host "Ready to process images. Continue? (Y/N)"
if ($response -ne "Y" -and $response -ne "y") {
    Write-Info "Operation cancelled."
    exit 0
}
Write-Host ""

# Process images
Write-Info "Processing images..."
Write-Host ""

$counter = 0
foreach ($file in $imageFiles) {
    $counter++
    Write-Host "[$counter/$($script:totalFiles)] " -NoNewline -ForegroundColor Cyan
    
    # Determine output filename (always convert to .jpg)
    $outputFileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name) + ".jpg"
    $outputFile = Join-Path $outputPath $outputFileName
    
    # Process the image
    Optimize-ImageMagick -InputPath $file.FullName -OutputPath $outputFile -BackgroundPath $BackgroundImage | Out-Null
}

# Summary
Write-Host ""
Write-Info "=================================================="
Write-Info "  Processing Complete!"
Write-Info "=================================================="
Write-Host ""

Write-Host "Processed:        " -NoNewline
Write-Host "$($script:processedFiles) files" -ForegroundColor Green

Write-Host "Skipped/Failed:   " -NoNewline
Write-Host "$($script:errors.Count) files" -ForegroundColor $(if ($script:errors.Count -gt 0) { "Red" } else { "Gray" })

Write-Host ""
$originalMB = [math]::Round($script:totalOriginalSize / 1MB, 2)
$optimizedMB = [math]::Round($script:totalOptimizedSize / 1MB, 2)
$totalSavings = if ($script:totalOriginalSize -gt 0) {
    [math]::Round((($script:totalOriginalSize - $script:totalOptimizedSize) / $script:totalOriginalSize) * 100, 1)
} else {
    0
}

Write-Host "Original Size:    $originalMB MB" -ForegroundColor White
Write-Host "Optimized Size:   $optimizedMB MB" -ForegroundColor White
Write-Host "Total Savings:    " -NoNewline
Write-Host "$totalSavings%" -ForegroundColor Cyan

Write-Host ""
Write-Success "Optimized images saved to: $outputPath"

if ($script:errors.Count -gt 0) {
    Write-Host ""
    Write-Warning "Errors encountered:"
    foreach ($err in $script:errors) {
        Write-Host "  • " -NoNewline -ForegroundColor Red
        Write-Host "$($err.Path): " -NoNewline
        Write-Host $err.Error -ForegroundColor Gray
    }
}

Write-Host ""
Write-Info "Next steps:"
Write-Host "1. Review optimized images in: $outputPath" -ForegroundColor White
Write-Host "2. Copy optimized images to your website assets folder" -ForegroundColor White
Write-Host "3. Use the copy-project-images.ps1 script if needed" -ForegroundColor White
