# Scripts for Models4Comfort Website

This folder contains PowerShell scripts to help manage your website content.

## 📜 Available Scripts

### 1. imagemagick-optimize.ps1 ⭐ **RECOMMENDED**

**Purpose**: Advanced image optimization with HEIC support and green screen removal

**What it does**:
- ✅ **Perfect HEIC conversion** - Handles iPhone/Google Photos HEIC files natively
- ✅ **Green screen replacement** - Remove solid green backgrounds and replace with custom images
- ✅ Resizes images to web-friendly dimensions (default: 1920px max)
- ✅ Compresses JPEG files with high quality
- ✅ Converts all image formats to optimized JPEG
- ✅ Auto-rotates based on EXIF data
- ✅ Strips metadata for privacy
- ✅ Processes all formats: JPG, PNG, BMP, GIF, TIFF, WEBP, **HEIC**, **HEIF**

**Prerequisites**: 
Requires ImageMagick - See [IMAGEMAGICK-GUIDE.md](../IMAGEMAGICK-GUIDE.md) for installation

**Usage**:
```powershell
# Basic image optimization
.\scripts\imagemagick-optimize.ps1 -SourceFolder "C:\Path\To\Images"

# Custom quality and size
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "\\lsuk-synrack\HomeMedia\hobbies\model building\ss-great-britain" `
    -MaxWidth 1920 `
    -MaxHeight 1920 `
    -JpegQuality 90

# GREEN SCREEN REPLACEMENT - Perfect for diorama photography!
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "C:\DioramaPhotos\GreenScreen" `
    -ReplaceGreenScreen `
    -BackgroundImage "C:\Backgrounds\ocean-sunset.jpg" `
    -GreenTolerance 15
```

**Parameters**:
- `SourceFolder` (required) - Folder containing images
- `MaxWidth` (optional, default: 1920) - Maximum width in pixels
- `MaxHeight` (optional, default: 1920) - Maximum height in pixels
- `JpegQuality` (optional, default: 85) - Quality (1-100)
- `OutputSubFolder` (optional, default: "web-optimized") - Output folder name
- `ReplaceGreenScreen` (optional) - Enable green screen removal
- `BackgroundImage` (optional) - Background image path (required if ReplaceGreenScreen enabled)
- `GreenTolerance` (optional, default: 10) - Green color matching tolerance (0-100)
- `Recursive` (optional) - Process subfolders

**Output**:
Creates a subfolder with optimized images ready for web use.

---

### 2. optimize-images.ps1 (Fallback)

**Purpose**: Resize and compress images using Windows .NET (no external dependencies)

**What it does**:
- ✅ Resizes images to web-friendly dimensions (default: 1920px max)
- ✅ Compresses JPEG files (default: 85% quality)
- ✅ Converts all image formats to optimized JPEG
- ⚠️ **HEIC support limited** - Requires Windows HEIF codec (may not work reliably)
- ✅ Maintains aspect ratios
- ✅ Creates optimized versions in subfolder
- ✅ Shows before/after file sizes and savings
- ✅ Processes most common formats (JPG, PNG, BMP, GIF, TIFF, WEBP)

**Usage**:
```powershell
# Basic usage - optimize all images in a folder
.\scripts\optimize-images.ps1 -SourceFolder "C:\Path\To\Images"

# Custom settings
.\scripts\optimize-images.ps1 `
    -SourceFolder "\\lsuk-synrack\HomeMedia\hobbies\model building\ancient forest" `
    -MaxWidth 1920 `
    -MaxHeight 1920 `
    -JpegQuality 85 `
    -OutputSubFolder "web-optimized"

# Process only current folder (not subfolders)
.\scripts\optimize-images.ps1 -SourceFolder "C:\Path" -Recursive:$false
```

**Parameters**:
- `SourceFolder` (required) - Folder containing images to optimize
- `MaxWidth` (optional, default: 1920) - Maximum width in pixels
- `MaxHeight` (optional, default: 1920) - Maximum height in pixels
- `JpegQuality` (optional, default: 85) - JPEG compression quality (1-100)
- `OutputSubFolder` (optional, default: "web-optimized") - Name of output subfolder
- `Recursive` (optional, default: true) - Process subfolders

**Output**:
Creates a subfolder with optimized images ready for web use.

---

### 2. copy-project-images.ps1
**Purpose**: Copy images from source folders to website structure

**What it does**:
- ✅ Copies images from your model building folders
- ✅ Organizes into correct website structure
- ✅ Supports dry-run mode for preview
- ✅ Maps source folder names to web-friendly names

**Usage**:
```powershell
# Run the script
.\scripts\copy-project-images.ps1

# It will prompt for dry-run mode
# Answer 'Y' to preview, 'N' to actually copy
```

**Project Mapping**:
- `ancient forest` → `ancient-forest`
- `cabin in woods` → `cabin-in-woods`
- `Caravaning` → `caravaning`
- `country house` → `country-house`
- `english country garden` → `english-country-garden`
- `Henrhyd falls south wales` → `henrhyd-falls-south-wales`
- `plant display` → `plant-display`
- `riverside cabin` → `riverside-cabin`
- `SA_farm_home` → `sa-farm-home`
- `Sea Rescue` → `sea-rescue`
- `SS Great Britain` → `ss-great-britain`

---

## 🔄 Recommended Workflow

### Step 1: Select Your Images
Manually select the best images from each project folder in:
```
\\lsuk-synrack\HomeMedia\hobbies\model building\[project-name]\
```

### Step 2: Optimize for Web
For each project, run the optimization script:

```powershell
# Example: Optimize images for Ancient Forest project
.\scripts\optimize-images.ps1 `
    -SourceFolder "\\lsuk-synrack\HomeMedia\hobbies\model building\ancient forest"

# This creates: ancient forest\web-optimized\
```

### Step 3: Copy Optimized Images to Website
Manually copy from the `web-optimized` subfolder to your website:

```powershell
# Copy optimized images to website assets
Copy-Item "\\lsuk-synrack\HomeMedia\hobbies\model building\ancient forest\web-optimized\*" `
    -Destination "\\ukwsdev07\UKWSDEV07-E\Models4Comfort\assets\images\projects\ancient-forest\"
```

Or use the copy script after organizing your optimized images.

### Step 4: Create Project Markdown Files
Create markdown files in `_projects/` for each diorama project.

---

## 💡 Tips & Best Practices

### Image Optimization Settings

**For Hero/Featured Images** (main showcase):
```powershell
.\scripts\optimize-images.ps1 `
    -SourceFolder "path" `
    -MaxWidth 1920 `
    -JpegQuality 90
```

**For Gallery Images** (detail shots):
```powershell
.\scripts\optimize-images.ps1 `
    -SourceFolder "path" `
    -MaxWidth 1200 `
    -JpegQuality 85
```

**For Thumbnails** (if creating separately):
```powershell
.\scripts\optimize-images.ps1 `
    -SourceFolder "path" `
    -MaxWidth 400 `
    -JpegQuality 80
```

### File Size Guidelines
- **Hero images**: 200-500 KB (1920px wide)
- **Gallery images**: 150-300 KB (1200px wide)
- **Detail shots**: 100-200 KB (800px wide)

### Quality Settings
- **90-95%**: Highest quality (larger files)
- **85%**: Excellent quality, good balance (recommended)
- **75-80%**: Good quality, smaller files
- **70% or lower**: Noticeable quality loss

---

## 🐛 Troubleshooting

### "Access Denied" Error
- Ensure you have read access to source folders
- Run PowerShell as Administrator if needed
- Check network drive connectivity

### "Image cannot be loaded" Error
- File may be corrupted
- Unsupported image format
- File is locked/in use by another program
- **For HEIC files**: Install "HEIF Image Extensions" from Microsoft Store

### HEIC/HEIF Files Not Converting
If you see "HEIC conversion failed":

1. **Install HEIF Image Extensions**:
   - Open Microsoft Store
   - Search for "HEIF Image Extensions"
   - Install the free codec from Microsoft
   - Restart PowerShell and try again

2. **Alternative**: Convert HEIC to JPG first using:
   - Windows Photos app (open and "Save As")
   - Online converters (heictojpg.com)
   - Third-party tools (IrfanView, XnView)

### Large File Warnings
If GitHub warns about large files:
- Reduce MaxWidth to 1600 or 1200
- Lower JpegQuality to 80
- Consider using fewer images per project

### Script Execution Policy
If scripts won't run:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 🔧 Advanced Usage

### Batch Process Multiple Projects
Create a batch script:

```powershell
$projects = @(
    "ancient forest",
    "cabin in woods",
    "country house"
)

foreach ($project in $projects) {
    $sourcePath = "\\lsuk-synrack\HomeMedia\hobbies\model building\$project"
    Write-Host "Processing: $project" -ForegroundColor Cyan
    .\scripts\optimize-images.ps1 -SourceFolder $sourcePath
}
```

### Custom Output Location
Save optimized images elsewhere:

```powershell
# Optimize and save to a different location
.\scripts\optimize-images.ps1 `
    -SourceFolder "source\path" `
    -OutputSubFolder "..\..\website\assets\images\projects\project-name"
```

---

## 📚 Additional Resources

- **PowerShell Help**: `Get-Help .\scripts\optimize-images.ps1 -Detailed`
- **Image Guidelines**: See `assets/images/README.md`
- **Project Setup**: See `PROJECT-README.md`

---

## 🆘 Need Help?

If you encounter issues:
1. Check the troubleshooting section above
2. Review the script output for error messages
3. Ensure all paths are correct and accessible
4. Test with a single image first

---

*Scripts use Windows .NET Framework (built-in, no additional software required)*
