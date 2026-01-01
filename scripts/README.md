# Scripts for Models4Comfort Website

This folder contains PowerShell scripts to help manage your website content.

## ⚠️ CRITICAL: Use ImageMagick Script for All Image Optimization

**ALWAYS use `imagemagick-optimize.ps1` for image optimization.**

This script:
- ✅ Handles ALL image formats including HEIC/HEIF perfectly
- ✅ Has been tested and proven reliable across all projects
- ✅ Supports green screen replacement for diorama photography
- ✅ Properly processes images with correct orientation and metadata

**DO NOT use** `optimize-images.ps1` (deprecated - moved to `_deprecated/` folder)

---

## 📜 Available Scripts

### 1. imagemagick-optimize.ps1 ⭐ **PRIMARY IMAGE OPTIMIZATION SCRIPT**

**Purpose**: Advanced image optimization with perfect HEIC support and green screen removal

**What it does**:
- ✅ **Perfect HEIC/HEIF conversion** - Handles iPhone/Google Photos HEIC files natively
- ✅ **Green screen replacement** - Remove solid green backgrounds and replace with custom images
- ✅ Resizes images to web-friendly dimensions (default: 1920px max)
- ✅ Compresses JPEG files with high quality
- ✅ Converts all image formats to optimized JPEG
- ✅ Auto-rotates based on EXIF data
- ✅ Strips metadata for privacy
- ✅ Processes all formats: JPG, PNG, BMP, GIF, TIFF, WEBP, **HEIC**, **HEIF**
- ✅ **Proven reliable** - Successfully used on all projects including log-cabin, traditional-english-cottage, etc.

**Prerequisites**: 
Requires ImageMagick - See [../docs/guides/IMAGEMAGICK-GUIDE.md](../docs/guides/IMAGEMAGICK-GUIDE.md) for installation

**Usage**:
```powershell
# Basic image optimization (MOST COMMON USE)
.\scripts\imagemagick-optimize.ps1 -SourceFolder "C:\Path\To\Images"

# Optimize with custom target folder (Web-Optimized structure)
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "\\lsuk-synrack\HomeMedia\hobbies\model building\Traditional-country-cottage\Cottage" `
    -OutputSubFolder "../../Web-Optimized/Cottage" `
    -MaxWidth 800 `
    -MaxHeight 800 `
    -JpegQuality 85

# High-quality gallery images
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "\\lsuk-synrack\HomeMedia\hobbies\model building\project-name\Gallery" `
    -OutputSubFolder "../../Web-Optimized/Gallery" `
    -MaxWidth 1600 `
    -MaxHeight 1600 `
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
- `OutputSubFolder` (optional, default: "web-optimized") - Output folder name (can use relative paths like "../../Web-Optimized/subfolder")
- `MaxWidth` (optional, default: 1920) - Maximum width in pixels
- `MaxHeight` (optional, default: 1920) - Maximum height in pixels
- `JpegQuality` (optional, default: 85) - Quality (1-100)
- `ReplaceGreenScreen` (optional) - Enable green screen removal
- `BackgroundImage` (optional) - Background image path (required if ReplaceGreenScreen enabled)
- `GreenTolerance` (optional, default: 10) - Green color matching tolerance (0-100)
- `Recursive` (optional) - Process subfolders

**Recommended Settings**:
- **Build log photos**: MaxWidth 800, Quality 85
- **Gallery photos**: MaxWidth 1600, Quality 90
- **Planning/reference**: MaxWidth 800, Quality 85

**Output**:
Creates optimized images in the specified output folder, ready for web use.

---

### 2. new-build-log.ps1

**Purpose**: Quickly create new build log entries from the template

**What it does**:
- ✅ Creates project folder if it doesn't exist
- ✅ Copies template to correct location with proper naming
- ✅ Auto-updates front matter (title, date, project, build_number)
- ✅ Formats build number with leading zeros (001, 002, 003)
- ✅ Optionally opens the file in VS Code for immediate editing
- ✅ Validates project and title use proper naming (lowercase, hyphens)

**Usage**:
```powershell
# Create a new build log
.\scripts\new-build-log.ps1 -ProjectName "ss-great-britain" -BuildNumber 2 -Title "hull-construction"

# With specific date and auto-open in editor
.\scripts\new-build-log.ps1 `
    -ProjectName "gorch-fock" `
    -BuildNumber 1 `
    -Title "kit-review-unboxing" `
    -Date "2025-12-01" `
    -OpenInEditor

# Create first log for a new project (folder created automatically)
.\scripts\new-build-log.ps1 -ProjectName "new-diorama-project" -BuildNumber 1 -Title "planning-phase"
```

**Parameters**:
- `-ProjectName` (required) - Project slug using lowercase and hyphens (e.g., "ss-great-britain")
- `-BuildNumber` (required) - Sequential log number (1, 2, 3, etc.)
- `-Title` (required) - Short description with hyphens (e.g., "hull-construction")
- `-Date` (optional) - Date in YYYY-MM-DD format (defaults to today)
- `-OpenInEditor` (optional) - Opens the file in VS Code after creation

**Output**:
- Creates: `_builds/{project-name}/{number}-{title}.md`
- Example: `_builds/ss-great-britain/002-hull-construction.md`

---

### 3. copy-project-images.ps1

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

## �️ Specialized Scripts

This folder also contains specialized script collections for specific purposes:

### Plant Displays Script Suite (`plant-displays/`)

A comprehensive set of 18 PowerShell scripts for managing plant display documentation and image organization. These scripts support the plant displays sub-project with specialized workflows.

**Key Scripts**:
- **Source Analysis**: `analyze-source-structure.ps1` - Analyzes source photo folders
- **Naming & Organization**: `rename-files-by-plant.ps1`, `rename-images.ps1` - Systematic file renaming
- **Markdown Management**: `generate-markdown-updates.ps1`, `update-markdown-by-plant.ps1` - Update documentation
- **Hash-Based Operations**: `hash-site-files.ps1`, `hash-source-files.ps1`, `rename-site-by-hash.ps1` - Hash-based file tracking and renaming
- **Validation**: `validate-csv-completeness.ps1`, `validate-site-files.ps1` - Quality assurance
- **Cross-Reference**: `rename-site-cross-ref.ps1` - Cross-reference validation
- **Conflict Resolution**: `analyze-conflicts.ps1` - Identify and resolve naming conflicts
- **Utilities**: `extract-markdown-image-refs.ps1`, `build-site-source-hash-map.ps1` - Various utilities

**Documentation**: See [plant-displays/README.md](plant-displays/README.md) for detailed documentation

**Working Files**: See `../projects-working/plant-displays/` for CSVs and data files

**Purpose**: These scripts manage complex workflows for cataloging and documenting plant photography with precise naming conventions, markdown generation, and cross-validation between source files and web content.

---

## �🔄 Recommended Workflow

### Step 1: Optimize Images with ImageMagick

**For each source folder**, run the ImageMagick optimization script:

```powershell
# Example: Optimize Cottage construction photos (build log images)
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "\\lsuk-synrack\HomeMedia\hobbies\model building\Traditional-country-cottage\Cottage" `
    -OutputSubFolder "../../Web-Optimized/Cottage" `
    -MaxWidth 800 `
    -MaxHeight 800 `
    -JpegQuality 85

# Example: Optimize Gallery photos (showcase images)
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "\\lsuk-synrack\HomeMedia\hobbies\model building\Traditional-country-cottage\Gallery" `
    -OutputSubFolder "../../Web-Optimized/Gallery" `
    -MaxWidth 1600 `
    -MaxHeight 1600 `
    -JpegQuality 90
```

### Step 2: Review Optimized Images
Check the output in the Web-Optimized folder:
```
\\lsuk-synrack\HomeMedia\hobbies\model building\[project-name]\Web-Optimized\
```

### Step 3: Select Images for Site
Decide which optimized images to use on the website (you may not need all of them).

### Step 4: Copy Selected Images to Website
Manually copy selected optimized images to your website assets folder:

```powershell
# Copy optimized images to website assets
Copy-Item "\\lsuk-synrack\HomeMedia\hobbies\model building\project-name\Web-Optimized\subfolder\*" `
    -Destination "\\ukwsdev07\e$\Models4Comfort\assets\images\projects\project-name\"
```

### Step 5: Create Project Markdown Files
Create markdown files in `_projects/` for each diorama project following the [Source-Narrative Methodology](../docs/methodology/SOURCE-NARRATIVE-METHODOLOGY.md).

---

## 💡 Tips & Best Practices

### Image Optimization Settings

**For Build Log Images** (process shots):
```powershell
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "path" `
    -MaxWidth 800 `
    -MaxHeight 800 `
    -JpegQuality 85
```

**For Gallery Images** (final showcase):
```powershell
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "path" `
    -MaxWidth 1600 `
    -MaxHeight 1600 `
    -JpegQuality 90
```

**For Planning/Reference Images**:
```powershell
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "path" `
    -MaxWidth 800 `
    -MaxHeight 800 `
    -JpegQuality 85
```

### File Size Guidelines
- **Build log images**: 80-150 KB (800px wide)
- **Gallery images**: 300-500 KB (1600px wide)
- **Planning images**: 80-150 KB (800px wide)

### Quality Settings
- **90-95%**: Highest quality, use for final gallery images
- **85%**: Excellent quality, good balance (recommended for build logs)
- **80%**: Good quality, smaller files
- **75% or lower**: Not recommended - noticeable quality loss

---

## 🐛 Troubleshooting

### "ImageMagick not found" Error
1. Download and install ImageMagick from https://imagemagick.org/script/download.php#windows
2. See [../docs/guides/IMAGEMAGICK-GUIDE.md](../docs/guides/IMAGEMAGICK-GUIDE.md) for detailed installation instructions
3. Restart PowerShell after installation

### "Access Denied" Error
- Ensure you have read access to source folders
- Run PowerShell as Administrator if needed
- Check network drive connectivity

### "Image cannot be loaded" Error
- File may be corrupted
- Unsupported image format
- File is locked/in use by another program

### HEIC/HEIF Files Not Converting
The ImageMagick script handles HEIC files natively. If you still have issues:
1. Ensure ImageMagick is properly installed
2. Try re-installing ImageMagick with all format support enabled
3. Check that the HEIC file isn't corrupted (try opening in Windows Photos)

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

### Batch Process Multiple Folders
Process all folders for a project at once:

```powershell
# Process all folders for Traditional English Cottage project
$sourcePath = "\\lsuk-synrack\HomeMedia\hobbies\model building\Traditional-country-cottage"
$folders = @('planning', 'Cottage', 'Base', 'Plants', 'Finalisation')

foreach ($folder in $folders) {
    Write-Host "Processing: $folder" -ForegroundColor Cyan
    & .\scripts\imagemagick-optimize.ps1 `
        -SourceFolder "$sourcePath\$folder" `
        -OutputSubFolder "../../Web-Optimized/$folder" `
        -MaxWidth 800 `
        -MaxHeight 800 `
        -JpegQuality 85
}

# Process Gallery separately with higher quality
& .\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "$sourcePath\Gallery" `
    -OutputSubFolder "../../Web-Optimized/Gallery" `
    -MaxWidth 1600 `
    -MaxHeight 1600 `
    -JpegQuality 90
```

---

## 📚 Additional Resources

- **PowerShell Help**: `Get-Help .\scripts\imagemagick-optimize.ps1 -Detailed`
- **Image Guidelines**: See [../assets/images/README.md](../assets/images/README.md)
- **ImageMagick Guide**: See [../docs/guides/IMAGEMAGICK-GUIDE.md](../docs/guides/IMAGEMAGICK-GUIDE.md)
- **Source-Narrative Methodology**: See [../docs/methodology/SOURCE-NARRATIVE-METHODOLOGY.md](../docs/methodology/SOURCE-NARRATIVE-METHODOLOGY.md)
- **Plant Displays Scripts**: See [plant-displays/README.md](plant-displays/README.md) for specialized script documentation

---

## 🆘 Need Help?

If you encounter issues:
1. Check the troubleshooting section above
2. Review the script output for error messages
3. Ensure all paths are correct and accessible
4. Ensure ImageMagick is properly installed
5. Test with a single image first

---

## 📁 Deprecated Scripts

The following scripts have been moved to `_deprecated/` and should NOT be used:
- **optimize-images.ps1** - Unreliable HEIC support, use `imagemagick-optimize.ps1` instead

---

*Primary script uses ImageMagick (requires installation) - See [../docs/guides/IMAGEMAGICK-GUIDE.md](../docs/guides/IMAGEMAGICK-GUIDE.md)*
