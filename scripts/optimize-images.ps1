# PowerShell Image Optimization Script for Web
# Uses Windows .NET System.Drawing to resize and compress images
# Processes all common image formats and saves optimized versions

# Configuration
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
    [switch]$PreserveOriginal,
    
    [Parameter(Mandatory=$false)]
    [switch]$Recursive
)

# Requires .NET Framework (built into Windows)
Add-Type -AssemblyName System.Drawing

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

# Function to get JPEG encoder
function Get-JpegEncoder {
    param([int]$Quality)
    
    $jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | 
        Where-Object { $_.MimeType -eq "image/jpeg" }
    
    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter(
        [System.Drawing.Imaging.Encoder]::Quality, 
        $Quality
    )
    
    return @{
        Codec = $jpegCodec
        Params = $encoderParams
    }
}

# Function to calculate new dimensions maintaining aspect ratio
function Get-NewDimensions {
    param(
        [int]$OriginalWidth,
        [int]$OriginalHeight,
        [int]$MaxWidth,
        [int]$MaxHeight
    )
    
    # If image is already smaller, keep original size
    if ($OriginalWidth -le $MaxWidth -and $OriginalHeight -le $MaxHeight) {
        return @{
            Width = $OriginalWidth
            Height = $OriginalHeight
            NeedsResize = $false
        }
    }
    
    # Calculate aspect ratio
    $widthRatio = $MaxWidth / $OriginalWidth
    $heightRatio = $MaxHeight / $OriginalHeight
    $ratio = [Math]::Min($widthRatio, $heightRatio)
    
    return @{
        Width = [int]($OriginalWidth * $ratio)
        Height = [int]($OriginalHeight * $ratio)
        NeedsResize = $true
    }
}

# Function to check if HEIC/HEIF conversion is needed
function Test-HeicFile {
    param([string]$FilePath)
    $ext = [System.IO.Path]::GetExtension($FilePath).ToLower()
    return $ext -eq ".heic" -or $ext -eq ".heif"
}

# Function to convert HEIC to temporary JPEG using Windows API
function Convert-HeicToTemp {
    param([string]$InputPath)
    
    try {
        # Try using Windows 10+ built-in HEIF codec
        Add-Type -AssemblyName System.Runtime.WindowsRuntime
        
        $tempFile = [System.IO.Path]::GetTempFileName() + ".jpg"
        
        # Use Windows.Graphics.Imaging API (Windows 10 1809+)
        [Windows.Storage.StorageFile,Windows.Storage,ContentType=WindowsRuntime] | Out-Null
        [Windows.Graphics.Imaging.BitmapDecoder,Windows.Graphics,ContentType=WindowsRuntime] | Out-Null
        [Windows.Graphics.Imaging.BitmapEncoder,Windows.Graphics,ContentType=WindowsRuntime] | Out-Null
        
        $task = [Windows.Storage.StorageFile]::GetFileFromPathAsync($InputPath)
        $task.AsTask().Wait()
        $file = $task.GetResults()
        
        $task = $file.OpenAsync([Windows.Storage.FileAccessMode]::Read)
        $task.AsTask().Wait()
        $stream = $task.GetResults()
        
        $task = [Windows.Graphics.Imaging.BitmapDecoder]::CreateAsync($stream)
        $task.AsTask().Wait()
        $decoder = $task.GetResults()
        
        $task = [Windows.Storage.StorageFile]::GetFileFromPathAsync($tempFile)
        $task.AsTask().Wait()
        $outFile = $task.GetResults()
        
        $task = $outFile.OpenAsync([Windows.Storage.FileAccessMode]::ReadWrite)
        $task.AsTask().Wait()
        $outStream = $task.GetResults()
        
        $task = [Windows.Graphics.Imaging.BitmapEncoder]::CreateAsync([Windows.Graphics.Imaging.BitmapEncoder]::JpegEncoderId, $outStream)
        $task.AsTask().Wait()
        $encoder = $task.GetResults()
        
        $task = $decoder.GetPixelDataAsync()
        $task.AsTask().Wait()
        $pixels = $task.GetResults()
        
        $encoder.SetPixelData(
            $decoder.BitmapPixelFormat,
            $decoder.BitmapAlphaMode,
            $decoder.PixelWidth,
            $decoder.PixelHeight,
            $decoder.DpiX,
            $decoder.DpiY,
            $pixels.DetachPixelData()
        )
        
        $task = $encoder.FlushAsync()
        $task.AsTask().Wait()
        
        $stream.Dispose()
        $outStream.Dispose()
        
        return $tempFile
        
    } catch {
        Write-Warning "  ⚠ HEIC conversion failed (Windows HEIF codec may not be installed)"
        Write-Host "    Install from: Microsoft Store > 'HEIF Image Extensions'" -ForegroundColor Yellow
        return $null
    }
}

# Function to optimize a single image
function Optimize-Image {
    param(
        [string]$InputPath,
        [string]$OutputPath
    )
    
    $tempFileToCleanup = $null
    
    try {
        # Check if HEIC/HEIF file needs conversion first
        $actualInputPath = $InputPath
        if (Test-HeicFile -FilePath $InputPath) {
            Write-Host "  → Converting HEIC to JPEG..." -ForegroundColor Yellow
            $tempFileToCleanup = Convert-HeicToTemp -InputPath $InputPath
            if ($null -eq $tempFileToCleanup) {
                throw "HEIC conversion failed. Please install 'HEIF Image Extensions' from Microsoft Store."
            }
            $actualInputPath = $tempFileToCleanup
        }
        
        # Load the image
        $image = [System.Drawing.Image]::FromFile($actualInputPath)
        $originalWidth = $image.Width
        $originalHeight = $image.Height
        $originalSize = (Get-Item $InputPath).Length
        
        # Calculate new dimensions
        $newDims = Get-NewDimensions -OriginalWidth $originalWidth -OriginalHeight $originalHeight `
                                     -MaxWidth $MaxWidth -MaxHeight $MaxHeight
        
        if ($newDims.NeedsResize) {
            # Create new bitmap with calculated dimensions
            $newImage = New-Object System.Drawing.Bitmap($newDims.Width, $newDims.Height)
            $graphics = [System.Drawing.Graphics]::FromImage($newImage)
            
            # Set high quality rendering
            $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
            $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
            $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
            
            # Draw resized image
            $graphics.DrawImage($image, 0, 0, $newDims.Width, $newDims.Height)
            
            # Save as JPEG with compression
            $encoder = Get-JpegEncoder -Quality $JpegQuality
            $newImage.Save($OutputPath, $encoder.Codec, $encoder.Params)
            
            # Cleanup
            $graphics.Dispose()
            $newImage.Dispose()
        } else {
            # Image doesn't need resizing, just compress
            $encoder = Get-JpegEncoder -Quality $JpegQuality
            $image.Save($OutputPath, $encoder.Codec, $encoder.Params)
        }
        
        $image.Dispose()
        
        # Cleanup temp file if it was created
        if ($null -ne $tempFileToCleanup -and (Test-Path $tempFileToCleanup)) {
            Remove-Item $tempFileToCleanup -Force -ErrorAction SilentlyContinue
        }
        
        # Get optimized size
        $optimizedSize = (Get-Item $OutputPath).Length
        
        # Update statistics
        $script:totalOriginalSize += $originalSize
        $script:totalOptimizedSize += $optimizedSize
        $script:processedFiles++
        
        # Calculate savings
        $savings = [math]::Round((($originalSize - $optimizedSize) / $originalSize) * 100, 1)
        $originalMB = [math]::Round($originalSize / 1MB, 2)
        $optimizedMB = [math]::Round($optimizedSize / 1MB, 2)
        
        if ($newDims.NeedsResize) {
            Write-Host "  ✓ " -NoNewline -ForegroundColor Green
            Write-Host "$((Get-Item $InputPath).Name) " -NoNewline
            Write-Host "($originalWidth×$originalHeight → $($newDims.Width)×$($newDims.Height)) " -NoNewline -ForegroundColor Yellow
            Write-Host "$originalMB MB → $optimizedMB MB " -NoNewline
            Write-Host "(-$savings%)" -ForegroundColor Cyan
        } else {
            Write-Host "  ✓ " -NoNewline -ForegroundColor Green
            Write-Host "$((Get-Item $InputPath).Name) " -NoNewline
            Write-Host "(compressed only) " -NoNewline -ForegroundColor Gray
            Write-Host "$originalMB MB → $optimizedMB MB " -NoNewline
            Write-Host "(-$savings%)" -ForegroundColor Cyan
        }
        
        return $true
        
    } catch {
        # Cleanup temp file if it was created
        if ($null -ne $tempFileToCleanup -and (Test-Path $tempFileToCleanup)) {
            Remove-Item $tempFileToCleanup -Force -ErrorAction SilentlyContinue
        }
        
        $script:errors += @{
            File = $InputPath
            Error = $_.Exception.Message
        }
        Write-Error "  ✗ Failed: $((Get-Item $InputPath).Name) - $($_.Exception.Message)"
        return $false
    }
}

# Main execution
Write-Info "=================================================="
Write-Info "  Image Optimization Script for Web"
Write-Info "  Supports: JPG, PNG, BMP, GIF, TIFF, WEBP, HEIC"
Write-Info "=================================================="
Write-Host ""

# Validate source folder
if (-not (Test-Path $SourceFolder)) {
    Write-Error "Error: Source folder not found: $SourceFolder"
    exit 1
}

$SourceFolder = Resolve-Path $SourceFolder

Write-Info "Configuration:"
Write-Host "  Source Folder:    $SourceFolder" -ForegroundColor White
Write-Host "  Max Dimensions:   ${MaxWidth}×${MaxHeight} px" -ForegroundColor White
Write-Host "  JPEG Quality:     $JpegQuality%" -ForegroundColor White
Write-Host "  Output Subfolder: $OutputSubFolder" -ForegroundColor White
Write-Host "  Recursive:        $Recursive" -ForegroundColor White
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
$searchOption = if ($Recursive) { "-Recurse" } else { "" }
$imageFiles = Get-ChildItem -Path $SourceFolder -Include $imageExtensions -File @searchOption | 
              Where-Object { $_.DirectoryName -ne $outputPath }

$script:totalFiles = $imageFiles.Count

if ($script:totalFiles -eq 0) {
    Write-Warning "No image files found in the source folder."
    exit 0
}

Write-Success "Found $script:totalFiles image(s) to process"
Write-Host ""

# Confirm before processing
Write-Host "Ready to process images. Continue? (Y/N): " -NoNewline -ForegroundColor Yellow
$confirm = Read-Host
if ($confirm -ne "Y" -and $confirm -ne "y") {
    Write-Info "Operation cancelled."
    exit 0
}
Write-Host ""

# Process each image
Write-Info "Processing images..."
Write-Host ""

$progress = 0
foreach ($file in $imageFiles) {
    $progress++
    Write-Host "[$progress/$script:totalFiles] " -NoNewline -ForegroundColor Gray
    
    # Generate output filename (always save as .jpg for web)
    $outputFileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name) + ".jpg"
    $outputFilePath = Join-Path $outputPath $outputFileName
    
    # Process the image
    Optimize-Image -InputPath $file.FullName -OutputPath $outputFilePath
}

# Summary
Write-Host ""
Write-Info "=================================================="
Write-Info "  Processing Complete!"
Write-Info "=================================================="
Write-Host ""
Write-Success "Processed:        $script:processedFiles files"
Write-Warning "Skipped/Failed:   $script:skippedFiles files"
Write-Host ""

$totalOriginalMB = [math]::Round($script:totalOriginalSize / 1MB, 2)
$totalOptimizedMB = [math]::Round($script:totalOptimizedSize / 1MB, 2)
$totalSavings = if ($script:totalOriginalSize -gt 0) {
    [math]::Round((($script:totalOriginalSize - $script:totalOptimizedSize) / $script:totalOriginalSize) * 100, 1)
} else { 0 }

Write-Host "Original Size:    $totalOriginalMB MB" -ForegroundColor White
Write-Host "Optimized Size:   $totalOptimizedMB MB" -ForegroundColor White
Write-Host "Total Savings:    $totalSavings%" -ForegroundColor Cyan
Write-Host ""
Write-Success "Optimized images saved to: $outputPath"

# Show errors if any
if ($script:errors.Count -gt 0) {
    Write-Host ""
    Write-Warning "Errors encountered:"
    foreach ($error in $script:errors) {
        Write-Host "  • $($error.File): $($error.Error)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Info "Next steps:"
Write-Host "1. Review optimized images in: $outputPath" -ForegroundColor White
Write-Host "2. Copy optimized images to your website assets folder" -ForegroundColor White
Write-Host "3. Use the copy-project-images.ps1 script if needed" -ForegroundColor White
Write-Host ""
