<#
.SYNOPSIS
    Download a background image from a URL

.DESCRIPTION
    Simple helper script to download background images for green screen replacement

.PARAMETER Url
    Direct URL to the image file

.PARAMETER OutputPath
    Path where to save the image (optional, defaults to backgrounds folder)

.EXAMPLE
    .\scripts\download-background.ps1 -Url "https://images.unsplash.com/photo-xxxxx" -OutputPath "backgrounds\ocean-sky.jpg"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$Url,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath = ""
)

# Create backgrounds folder if it doesn't exist
$backgroundsFolder = Join-Path $PSScriptRoot "..\backgrounds"
if (-not (Test-Path $backgroundsFolder)) {
    New-Item -ItemType Directory -Path $backgroundsFolder -Force | Out-Null
    Write-Host "Created backgrounds folder: $backgroundsFolder" -ForegroundColor Green
}

# Determine output path
if (-not $OutputPath) {
    $filename = "background-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".jpg"
    $OutputPath = Join-Path $backgroundsFolder $filename
} else {
    if (-not [System.IO.Path]::IsPathRooted($OutputPath)) {
        $OutputPath = Join-Path $backgroundsFolder $OutputPath
    }
}

# Download the image
try {
    Write-Host "Downloading image..." -ForegroundColor Cyan
    Write-Host "  From: $Url" -ForegroundColor White
    Write-Host "  To:   $OutputPath" -ForegroundColor White
    
    Invoke-WebRequest -Uri $Url -OutFile $OutputPath -UseBasicParsing
    
    $fileSize = [math]::Round((Get-Item $OutputPath).Length / 1MB, 2)
    Write-Host ""
    Write-Host "✓ Download complete!" -ForegroundColor Green
    Write-Host "  File: $OutputPath" -ForegroundColor White
    Write-Host "  Size: $fileSize MB" -ForegroundColor White
    
    # Try to get image dimensions using ImageMagick if available
    try {
        $dims = & magick identify -format "%wx%h" $OutputPath 2>$null
        if ($dims) {
            Write-Host "  Dimensions: $dims" -ForegroundColor White
        }
    } catch {
        # ImageMagick not available, skip dimensions
    }
    
    Write-Host ""
    Write-Host "You can now use this background with:" -ForegroundColor Cyan
    Write-Host "  .\scripts\imagemagick-optimize.ps1 -SourceFolder 'YOUR_PHOTOS' -ReplaceGreenScreen -BackgroundImage '$OutputPath'" -ForegroundColor Yellow
    
} catch {
    Write-Host "✗ Download failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
