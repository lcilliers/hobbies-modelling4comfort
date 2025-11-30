# Image Organization Guide

## Project Image Folders Created

The following folders have been created to match your existing project structure:

```
assets/images/projects/
├── ancient-forest/
├── cabin-in-woods/
├── caravaning/
├── country-house/
├── english-country-garden/
├── henrhyd-falls-south-wales/
├── plant-display/
├── riverside-cabin/
├── sa-farm-home/
├── sea-rescue/
├── ss-great-britain/
└── techniques/ (for tutorial images from guidance_and_tutorials)
```

## Copying Your Images

### Option 1: Manual Copy (Recommended for Control)

Copy images from your source folders to the corresponding website folders:

**Source**: `\\lsuk-synrack\HomeMedia\hobbies\model building\[project-name]\`
**Destination**: `\\ukwsdev07\UKWSDEV07-E\Models4Comfort\assets\images\projects\[project-name]\`

Example:
- Copy from: `\\lsuk-synrack\HomeMedia\hobbies\model building\ancient forest\`
- Copy to: `\\ukwsdev07\UKWSDEV07-E\Models4Comfort\assets\images\projects\ancient-forest\`

### Option 2: PowerShell Script (Automated)

Run the script `copy-project-images.ps1` (see below) to copy all images automatically.

## Image Naming Recommendations

For each project folder, organize images like:

```
ancient-forest/
├── hero.jpg              # Main showcase image
├── overview-01.jpg       # Overall views
├── overview-02.jpg
├── detail-01.jpg         # Close-up details
├── detail-02.jpg
├── detail-03.jpg
├── process-01.jpg        # Build process shots
├── process-02.jpg
└── final.jpg             # Final completed shot
```

## Image Optimization

Before copying to the website, consider:

1. **Resize large images**:
   - Max width: 1920px for hero images
   - Max width: 1200px for gallery images
   - Max width: 800px for detail shots

2. **Compress images**:
   - Target: 200-400KB per image
   - Tools: TinyPNG, Squoosh.app, or Windows Photos app

3. **Convert to web-friendly formats**:
   - Use .jpg for photos
   - Use .png for graphics with transparency
   - Consider .webp for better compression (modern browsers)

## After Copying Images

1. Create markdown files for each project in `_projects/`
2. Reference images using:
   ```markdown
   ![Description](/assets/images/projects/ancient-forest/hero.jpg)
   ```

3. For galleries, use the front matter format:
   ```yaml
   gallery:
     - url: "/assets/images/projects/ancient-forest/detail-01.jpg"
       caption: "Forest floor detail"
     - url: "/assets/images/projects/ancient-forest/detail-02.jpg"
       caption: "Tree bark texture"
   ```

## Git Considerations

- GitHub repos have a 100MB file size limit per file
- Keep total repo under 1GB for best performance
- Large repos may need Git LFS (Large File Storage)

## Next Steps

1. Copy your images to the corresponding folders
2. Create project markdown files (use `_projects/sample-project.md` as template)
3. Update image paths in the markdown files
4. Commit and push to GitHub
