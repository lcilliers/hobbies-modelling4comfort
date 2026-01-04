# ImageMagick Guide for Diorama Photography

## ⚠️ CRITICAL: Use ImageMagick for ALL Image Optimization

**ALWAYS use the `imagemagick-optimize.ps1` script** for image optimization on this project.

**Why?**
- ✅ Perfect HEIC/HEIF support (iPhone/Google Photos images)
- ✅ Reliable conversion and optimization
- ✅ Proven to work across all projects (log-cabin, traditional-english-cottage, etc.)
- ✅ Green screen replacement capability

**Quick Start:**
```powershell
# Optimize images in a folder
.\scripts\imagemagick-optimize.ps1 -SourceFolder "path\to\images"
```

See [../../scripts/README.md](../../scripts/README.md) for complete usage examples.

---

## Installation

### Windows Installation

**Option 1: Direct Download (Recommended)**
1. Visit: https://imagemagick.org/script/download.php#windows
2. Download: `ImageMagick-7.x.x-Q16-HDRI-x64-dll.exe`
3. Run installer
4. ✅ **Important**: Check "Install legacy utilities" during installation
5. ✅ **Important**: Check "Add to system PATH"
6. Restart PowerShell/VS Code after installation

**Option 2: Windows Package Manager**
```powershell
winget install ImageMagick.ImageMagick
```

**Option 3: Chocolatey**
```powershell
choco install imagemagick
```

### Verify Installation
```powershell
magick --version
```

## Features

### 1. **HEIC/HEIF Conversion** ✅
ImageMagick handles HEIC files from iPhone/Google Photos natively!

```powershell
# Convert single HEIC to JPG
magick input.heic output.jpg

# Convert and resize
magick input.heic -resize 1920x1920> output.jpg
```

### 2. **Batch Optimization** 🚀
Resize, compress, and convert multiple images at once.

```powershell
.\scripts\imagemagick-optimize.ps1 -SourceFolder "\\lsuk-synrack\HomeMedia\hobbies\model building\German-sail-boat"
```

### 3. **Green Screen Removal** 🎬
Perfect for diorama photography! Replace solid green backgrounds with custom images.

```powershell
# Replace green screen with a new background
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "C:\Photos\MyDiorama" `
    -ReplaceGreenScreen `
    -BackgroundImage "backgrounds\blue-polygonal-shapes.jpg" `
    -GreenTolerance 15
```

## Script Usage

### Basic Image Optimization

**Convert and optimize all images in a folder:**
```powershell
.\scripts\imagemagick-optimize.ps1 -SourceFolder "\\lsuk-synrack\HomeMedia\hobbies\model building\ss-great-britain"
```

**Custom quality and size:**
```powershell
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "\\lsuk-synrack\HomeMedia\hobbies\model building\cabin-in-woods" `
    -MaxWidth 1200 `
    -MaxHeight 1200 `
    -JpegQuality 90
```

**Process all subfolders recursively:**
```powershell
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "\\lsuk-synrack\HomeMedia\hobbies\model building" `
    -Recursive
```

### Green Screen Replacement

**Replace green background with image:**
```powershell
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "C:\Photos\GreenScreenShots" `
    -ReplaceGreenScreen `
    -BackgroundImage "backgrounds\blue-polygonal-shapes.jpg" `
    -GreenTolerance 10
```

**Higher tolerance for varied green shades:**
```powershell
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "C:\Photos\GreenScreenShots" `
    -ReplaceGreenScreen `
    -BackgroundImage "backgrounds\blue-polygonal-shapes.jpg" `
    -GreenTolerance 20
```

## Parameters Reference

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `-SourceFolder` | String | *Required* | Path to folder with images |
| `-MaxWidth` | Int | 1920 | Maximum width in pixels |
| `-MaxHeight` | Int | 1920 | Maximum height in pixels |
| `-JpegQuality` | Int | 85 | JPEG quality (1-100) |
| `-OutputSubFolder` | String | "web-optimized" | Output folder path. Use **absolute paths** (UNC or drive) for precise control, or relative paths/names |
| `-ReplaceGreenScreen` | Switch | Off | Enable green screen removal |
| `-BackgroundImage` | String | "" | Background image path (required with -ReplaceGreenScreen) |
| `-GreenTolerance` | Int | 10 | Green color matching tolerance (0-100) |
| `-Recursive` | Switch | Off | Process subfolders |

**⚠️ Important:** For `-OutputSubFolder`, **always use absolute paths** to avoid confusion:
- ✅ Absolute: `"\\server\share\Web-Optimized\Folder"` or `"C:\full\path"`
- ⚠️ Relative: `"../../Web-Optimized/Folder"` (may create unexpected locations)
- ⚠️ Subfolder: `"web-optimized"` (creates within source folder)

## Green Screen Photography Tips

### Best Practices for Diorama Green Screens

1. **Lighting is Key** 💡
   - Even, diffused lighting on green screen
   - Avoid shadows and hot spots
   - Separate lighting for subject and background

2. **Color Selection** 🎨
   - Pure green works best: `#00FF00`
   - Avoid green in your diorama models
   - Blue screen is alternative if models have green

3. **Distance** 📏
   - Keep diorama 3-6 feet from green screen
   - Reduces green spill/reflection on models

4. **Tolerance Settings** 🎯
   - Start with tolerance: `10`
   - Increase if edge pixels remain green
   - Decrease if too much is removed

5. **Material** 🖼️
   - Matte green fabric/paper (not glossy)
   - Wrinkle-free surface
   - Consider green screen paint for large setups

### Example Workflow

**1. Capture Photos**
- Diorama in front of green screen
- Consistent lighting
- Multiple angles

**2. Prepare Background**
- Choose matching perspective
- Similar lighting direction
- Appropriate resolution (1920x1920 or higher)

**3. Process with ImageMagick**
```powershell
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "C:\Diorama-Photos\SailingShip-GreenScreen" `
    -ReplaceGreenScreen `
    -BackgroundImage "C:\Backgrounds\ocean-sunset.jpg" `
    -GreenTolerance 15 `
    -MaxWidth 1920 `
    -JpegQuality 90
```

**4. Review Results**
- Check edges for green fringing
- Adjust tolerance if needed
- Re-run with different backgrounds

## Advanced ImageMagick Commands

### Manual Green Screen Removal
```powershell
# Basic green screen replacement
magick diorama.jpg -fuzz 10% -transparent green background.jpg -composite output.jpg

# With resize
magick background.jpg -resize 1920x1920^ -gravity center -extent 1920x1920 `
       \( diorama.jpg -fuzz 15% -transparent green -resize 1920x1920> \) `
       -gravity center -composite -quality 85 output.jpg
```

### Batch Convert HEIC Files
```powershell
# Convert all HEIC in folder to JPG
Get-ChildItem "*.heic" | ForEach-Object {
    magick $_.FullName -quality 85 "$($_.BaseName).jpg"
}
```

### Create Thumbnail Grid
```powershell
# Create contact sheet of all images
magick montage *.jpg -geometry 300x300+5+5 -tile 4x contact-sheet.jpg
```

### Add Watermark
```powershell
# Add text watermark
magick input.jpg -pointsize 20 -fill white -gravity southeast `
       -annotate +10+10 "© 2025 Models4Comfort" output.jpg
```

## Color Reference

### Green Screen Colors

| Name | Hex | RGB | Use Case |
|------|-----|-----|----------|
| Chroma Key Green | `#00FF00` | `0,255,0` | Standard |
| Digital Green | `#0F0` | `0,255,0` | Bright conditions |
| Studio Green | `#3A9D23` | `58,157,35` | Video/Film |

### Testing Tolerance

Start with low tolerance and increase:
- **5-10%**: Tight selection (pure green only)
- **10-15%**: Standard range (recommended)
- **15-25%**: Wider range (varied lighting)
- **25%+**: Very aggressive (may remove too much)

## Troubleshooting

### Green Fringing Around Edges
**Solution**: Increase tolerance by 5%
```powershell
-GreenTolerance 15  # Try 20, 25, etc.
```

### Too Much Removed
**Solution**: Decrease tolerance
```powershell
-GreenTolerance 5
```

### HEIC Not Converting
**Solution**: Update ImageMagick to latest version
```powershell
winget upgrade ImageMagick.ImageMagick
```

### Slow Processing
**Solution**: Process smaller batches or reduce resolution
```powershell
-MaxWidth 1200 -MaxHeight 1200
```

## Background Image Resources

### Free Stock Photo Sites
- **Unsplash** (https://unsplash.com) - High-quality, free
- **Pexels** (https://pexels.com) - Free stock photos
- **Pixabay** (https://pixabay.com) - Free images & videos

### Search Terms for Dioramas
- "Ocean waves texture"
- "Forest background blur"
- "Sky clouds horizon"
- "Urban street bokeh"
- "Mountain landscape"
- "Desert sand dunes"
- "Waterfall background"
- "Garden bokeh"

## Next Steps

1. **Install ImageMagick** following instructions above
2. **Test with one image** to learn the workflow
3. **Create background image collection** for your dioramas
4. **Process project folders** one at a time
5. **Copy optimized images** to website assets

## Integration with Website

After processing, copy to your website:

```powershell
# Copy optimized images to website structure
.\scripts\copy-project-images.ps1 -SourceRoot "\\lsuk-synrack\HomeMedia\hobbies\model building"
```

Then commit and push:
```powershell
git add assets/images/
git commit -m "Add optimized diorama photos"
git push
```
