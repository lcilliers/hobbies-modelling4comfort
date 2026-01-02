# Image Organization Guide

## ⚠️ CRITICAL WARNING - Naming Convention Inconsistency

**DO NOT assume existing image names are correct!** The site currently has inconsistent naming conventions across projects (only 57.6% compliance). When adding new images:

1. **ALWAYS use the standard defined below** - do not copy existing incorrect patterns
2. **REQUIRED READING: `IMAGE-NAMING-INCONSISTENCIES.md`** - Full analysis of what needs fixing and which folders are redundant
3. **The correct format is mandatory** for all new images (existing images will be migrated later)
4. **Before creating new project folders**, check the inconsistencies document to avoid duplication

## Image Naming Convention (MANDATORY STANDARD)

**Format:** `[prefix]-[category]-[###].jpg`

**Three required sections separated by hyphens:**
1. **Prefix** - Shortened project name (2-4 characters, lowercase)
2. **Category** - The subfolder name where the image is stored (lowercase)
3. **Number** - Three digits (001, 002, 003)

**CRITICAL: Category = Subfolder Name**
- The category MUST match the subfolder where the image is stored
- Example: File in `planning/` folder → category is `planning` → filename `tec-planning-001.jpg`
- Example: File in `build1/` folder → category is `build1` → filename `tec-build1-001.jpg`
- If there are sub-subfolders within a category folder, ignore them for naming - all files in that category should be sequential

**Examples of CORRECT naming:**
```
log-cabin-build1-001.jpg          ✅ Perfect
log-cabin-research-cabin-001.jpg  ✅ Perfect
sr-pln-001.jpg                    ✅ Perfect (sea-rescue planning)
ecg-gal-001.jpg                   ✅ Perfect (english-country-garden gallery)
```

**Examples of INCORRECT naming (DO NOT COPY):**
```
bamboo-river-lookout-figures-001.jpg  ❌ Too many parts (5-part)
cathy-flower-house-001.jpg            ❌ Missing category (4-part)
bsm-001.jpg                           ❌ Missing category (2-part)
20251130_201537.jpg                   ❌ Timestamp filename
```

**Standard Prefix Abbreviations:**
- `log-cabin` (already short)
- `caravaning` (already short)
- `sea-rescue` → `sr`
- `ss-great-britain` → `ss-gb`
- `english-country-garden` → `ecg`
- `bamboo-river-lookout` → `brl`
- `bookshop-memories` → `bsm`
- `simon-coffee-shop` → `scs`
- `cathy-flower-house` → `cfh`
- `german-sail-boat` → `gs`

**Common Categories:**
- `planning` (or abbreviated: `pln`) - Planning and research images
- `build1`, `build2`, etc. - Build progress by stage
- `gallery` (or abbreviated: `gal`) - Final showcase images
- `research-[topic]` - Reference materials (research-boat, research-figure, etc.)
- `figures` (or `fig`) - Figure-related content
- `scenary` (or `scn`) - Scenery elements

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

## Image Naming Convention

**Format:** `[prefix]-[category]-[###].jpg`

**Three required sections:**
1. **Prefix** - Shortened project name (2-4 letters)
2. **Category** - Image type (planning, build1, gallery, research-boat, etc.)
3. **Number** - Three digits (001, 002, 003)

**Examples:**
```
log-cabin-build1-001.jpg
log-cabin-research-cabin-001.jpg
log-cabin-gallery-001.jpg
caravaning-planning-001.jpg
sr-planning-001.jpg (sea-rescue)
```

**Shortened Prefixes:**
- `log-cabin` (not log-cabin-in-woods)
- `caravaning` (not caravaning-diorama)  
- `sr` (sea-rescue)
- `ss-gb` (ss-great-britain)

**Common Categories (based on folder structure):**
- `planning` - Planning and research images (stored in planning/ folder)
- `build1`, `build2`, `build3`, `build4` - Build progress by stage (stored in build1/, build2/, etc. folders)
- `gallery` - Final showcase images (stored in gallery/ folder)
- `research-[topic]` - Reference materials by topic (stored in research-boat/, research-figure/, etc. folders)

**Note:** You cannot interpret image content - you must rely on the folder structure to determine the category. The human organizes images into folders, and those folder names become the category in the filename.

**Folder Organization:**
```
project-name/
├── prefix-build1-001.jpg
├── prefix-build1-002.jpg
├── prefix-gallery-001.jpg
├── prefix-planning-001.jpg
└── planning/                    # Optional subfolder for complex projects
    ├── prefix-planning-001.jpg
    └── prefix-planning-002.jpg
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
