# Plant Displays Series - Project Management Guide

## Project Overview

The Plant Displays Series is a unique, ongoing scratch-build project focused on creating detailed botanical models for selected plant species. Unlike other projects on this site, this is a **living collection** that will grow over time, with individual plants at various stages of completion.

**Location:** `\\LSUK-SYNRACK\HomeMedia\hobbies\model building\plant displays\`

## Project Concept

Each plant display is an artistic and informative representation (not strictly scientific/botanical) that may include:

- **Leaf models** (scratch-built, pressed, resin-cast)
- **Flower models** (scratch-built from paper/clay, resin-cast where possible)
- **Seedling representation**
- **Mature plant model**
- **Seasonal display**
- **Root systems** (carved from wood)
- **Seeds/bulbs/corms** (between DC fix and Perspex, carved wood)
- **Situational mini-diorama** (plant in landscape context)
- **Etched identification plate** (date, plant name, author)

**Design Philosophy:**
- Impressionistic display rather than strict botanical accuracy
- No manufactured plastic or 3D-printed materials
- Each plant board is both artistic and informative
- Board size and layout varies per plant based on flower complexity
- Completion may take several years per plant (material collection, seasonal work)

## Plant Selection Criteria

Plants chosen based on:
- Most loved/favorite species
- From own garden
- Dramatic or interesting characteristics
- In memory of specific events or people

## Unique Project Structure

### Directory Organization

```
plant displays/
├── plant-display-gallery/        # Project-wide gallery images
├── [Plant Name 1]/
│   ├── planning/                 # Design sketches, research, planning docs
│   ├── build/                    # Construction progress photos
│   ├── gallery/                  # Final/showcase images
│   └── web-optimized/            # Processed images for site (created during workflow)
├── [Plant Name 2]/
│   ├── planning/
│   ├── build/
│   ├── gallery/
│   └── web-optimized/
└── ...
```

### Current Plants in Collection

As of December 28, 2025:

1. **Daffodil** - 27 images (20 planning, 6 build, 1 gallery) - Intermediate difficulty
2. **Snowdrops** - 24 images (17 planning, 2 build, 5 gallery) - Intermediate difficulty  
3. **Bluebells** - 33 images (28 planning, 5 build) - Intermediate difficulty
4. **Ranunculus** - 58 images (44 planning, 3 build, 11 gallery) - Advanced difficulty - **Most documented**
5. **Protea** - 4 planning images - Advanced difficulty
6. **Strelitzia (Bird of Paradise)** - 7 planning images - Advanced difficulty
7. **Poinsettia** - 6 planning images - Intermediate difficulty

**Status:** All at different stages of completion; more plants will be added over time.
**Total Images Processed:** 159 images across 7 plants

## Website Structure

### Main Project Page
**File:** `_projects/plant-displays.md`

Contains:
- Project overview and concept explanation
- Design philosophy and techniques
- Featured plant gallery (selected showcase images)
- Individual plant summaries with status and links to build logs

### Build Logs (Per Plant)
**Directory:** `_builds/plant-displays/`

**Current Implementation (December 2025):**
Each plant currently has a single comprehensive build log documenting all phases:
- `[plant-name]-001-planning-build.md` - Complete documentation including:
  - Planning & research phase (ALL planning images)
  - Construction progress (ALL build images)  
  - Gallery section (ALL gallery images when available)
  - Techniques and challenges

**Build Log Frontmatter Requirements:**
```yaml
---
layout: build
project: /projects/plant-displays/  # MUST include leading / and trailing /
plant: [plant-name]                  # lowercase
build_number: 1
title: "[Plant Name] - Planning & Construction"
date: YYYY-MM-DD
estimated_time: "Ongoing"
difficulty: "Intermediate" or "Advanced"
focus_areas:
  - "Key technique 1"
  - "Key technique 2"
progress_images:                     # Only reference images that actually exist
  - path: "assets/images/projects/plant-displays/[plant]/planning/[filename].jpg"
    caption: "Description"
---
```

**Important Notes:**
- Build logs are at **individual plant level**, not project level
- The `project:` field MUST be `/projects/plant-displays/` (with slashes) for navigation to work
- Only include progress_images that exist (don't reference build/gallery if folders are empty)
- Include ALL planning, build, and gallery images in the log body (not just 2-3 samples)

**Future Expansion:**
As plants progress, additional detailed logs may be created:
- `002-leaf-construction.md` - Leaf models (scratch, pressed, resin)
- `003-flower-creation.md` - Flower models and techniques
- `004-root-systems.md` - Root/bulb/corm construction
- `005-assembly-display.md` - Board layout and final assembly

### Image Organization

**Source Structure:**
```
\\LSUK-SYNRACK\HomeMedia\hobbies\model building\plant displays\
└── [Plant Name]/
    ├── planning/        # Source images
    ├── build/           # Source images  
    ├── gallery/         # Source images
    └── web-optimized/   # Generated during processing
        ├── planning/
        ├── build/
        └── gallery/
```

**Site Structure:**
```
\\ukwsdev07\e$\Models4Comfort\assets\images\projects\plant-displays\
├── featured/            # Project-wide featured images for main page
└── [plant-name]/        # Individual plant images
    ├── planning/
    ├── build/
    └── gallery/
```

### Gallery Handling Strategy

1. **Main Project Page Gallery:**
   - Featured images from various plants (5-8 showcase images)
   - Provides overview of collection's diversity and artistry
   - Manually selected from plant-specific galleries

2. **Plant-Specific Galleries:**
   - Included in final build log (`005-assembly-display.md` or similar)
   - Shows completed plant display from multiple angles
   - Documents the finished board with all components

3. **Build Progress Images:**
   - Embedded in respective build logs throughout construction process
   - Shows techniques, challenges, and progression

## Workflow for Adding/Updating Plants

### Initial Setup (New Plant)
1. Verify source folder structure: `planning/`, `build/`, `gallery/` (may be empty)
2. Create web-optimized folders within plant folder at source
3. Process images from all three source folders using ImageMagick
4. Create plant directory in site: `assets/images/projects/plant-displays/[plant-name]/`
5. Copy optimized images to site (planning/, build/, gallery/ as needed)
6. Create build log: `_builds/plant-displays/[plant-name]-001-planning-build.md`
   - Use `project: /projects/plant-displays/` in frontmatter
   - Include ALL images in respective sections (not just samples)
   - Only reference images in progress_images that actually exist
7. Add plant entry in `_projects/plant-displays.md`:
   - Update "Current Collection Status" section with plant details
   - Add to "Build Logs" section with link: `/builds/plant-displays/[plant-name]-001-planning-build/`
8. Update featured_image if needed (use path without leading /)
9. Update gallery section with forward slashes `/` not backslashes `\`
10. Commit and push changes
11. Verify on live site:
    - Signature image displays correctly
    - Navigation buttons work (back to project overview)
    - All images load properly

### Completed December 2025 Workflow
All 7 current plants have been:
- ✅ Images processed (159 total across all plants)
- ✅ Build logs created with comprehensive image galleries
- ✅ Main project page updated with plant summaries and links
- ✅ Navigation and signature images verified working

### Updating Existing Plant
1. Process any new images from source folders
2. Copy to web-optimized and site folders
3. Update or create new build logs documenting progress
4. Update plant status in `_projects/plant-displays.md`
5. Update featured gallery if plant is complete or has showcase-worthy images
6. Commit and push changes

## Image Processing Commands

### For Individual Plant
```powershell
$plantName = "daffodil"  # lowercase for file naming
$sourcePath = "\\LSUK-SYNRACK\HomeMedia\hobbies\model building\plant displays\Daffoldil"
$webOptPath = "$sourcePath\web-optimized"
$sitePath = "\\ukwsdev07\e$\Models4Comfort\assets\images\projects\plant-displays\$plantName"

# Create directories
New-Item -ItemType Directory -Path "$webOptPath\planning" -Force
New-Item -ItemType Directory -Path "$webOptPath\build" -Force
New-Item -ItemType Directory -Path "$webOptPath\gallery" -Force
New-Item -ItemType Directory -Path "$sitePath\planning" -Force
New-Item -ItemType Directory -Path "$sitePath\build" -Force
New-Item -ItemType Directory -Path "$sitePath\gallery" -Force

# Process planning images
$counter = 1
Get-ChildItem "$sourcePath\planning" -File -Include *.jpg,*.jpeg,*.png | ForEach-Object {
    $newName = "plant-displays-$plantName-planning-{0:D3}.jpg" -f $counter
    $webOptFile = "$webOptPath\planning\$newName"
    $siteFile = "$sitePath\planning\$newName"
    & magick convert $_.FullName -auto-orient -resize "1920x1920>" -quality 85% -strip $webOptFile
    Copy-Item $webOptFile $siteFile -Force
    $counter++
}

# Process build images
$counter = 1
Get-ChildItem "$sourcePath\build" -File -Include *.jpg,*.jpeg,*.png | ForEach-Object {
    $newName = "plant-displays-$plantName-build-{0:D3}.jpg" -f $counter
    $webOptFile = "$webOptPath\build\$newName"
    $siteFile = "$sitePath\build\$newName"
    & magick convert $_.FullName -auto-orient -resize "1920x1920>" -quality 85% -strip $webOptFile
    Copy-Item $webOptFile $siteFile -Force
    $counter++
}

# Process gallery images
$counter = 1
Get-ChildItem "$sourcePath\gallery" -File -Include *.jpg,*.jpeg,*.png | ForEach-Object {
    $newName = "plant-displays-$plantName-gallery-{0:D3}.jpg" -f $counter
    $webOptFile = "$webOptPath\gallery\$newName"
    $siteFile = "$sitePath\gallery\$newName"
    & magick convert $_.FullName -auto-orient -resize "1920x1920>" -quality 85% -strip $webOptFile
    Copy-Item $webOptFile $siteFile -Force
    $counter++
}
```

## Build Log Naming Convention

Format: `[plant-name]-[sequence]-[topic].md`

Examples:
- `daffodil-001-planning-design.md`
- `daffodil-002-bulb-carving.md`
- `daffodil-003-flower-construction.md`
- `protea-001-leaf-structure.md`

Stored in: `_builds/plant-displays/`

## Project Page Updates

When adding plant status or updating progress, edit the "Individual Plants" section in `_projects/plant-displays.md`:

```markdown
### [Plant Name]
**Status:** [Planning / In Progress / Completed / On Hold]  
**Started:** [Date]  
**Components:** [List what's been completed: leaf, flower, roots, etc.]

Brief description of this specific plant and its significance.

[Build Logs →](link to first build log)
```

## Special Considerations

### Material Collection
Some plants require seasonal material collection (pressed flowers, seed pods, etc.), so completion timelines are flexible and natural.

### Board Dimensions
Board size and layout vary per plant based on flower/leaf size and complexity. Some plants may need multiple boards or selective component inclusion.

### Technique Documentation
Extract general techniques (resin casting, flower pressing, wood carving, etc.) to `_techniques/` section when patterns emerge across multiple plants.

### Future Candidate Plants
Mentioned in planning:
- Rose
- Foxgloves
- Dahlia

## Maintenance Notes

- This is a **long-term, evolving project**
- New plants will be added over months/years
- Existing plants will be updated as components are completed
- Some plants may remain "In Progress" for extended periods
- Gallery images may be added long after initial documentation

## Related Files

- Main project page: `_projects/plant-displays.md`
- Build logs directory: `_builds/plant-displays/`
- Site images: `assets/images/projects/plant-displays/`
- Source images: `\\LSUK-SYNRACK\HomeMedia\hobbies\model building\plant displays\`

---

*This README provides guidance for future updates to this unique, ongoing botanical modeling series.*
