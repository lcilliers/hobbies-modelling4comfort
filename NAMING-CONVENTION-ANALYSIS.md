# Plant Displays Image Naming Convention Analysis

## Current Situation

### Statistics
- **Total images**: 169 files
- **Filename length**: 30-42 characters (avg 40.3)
- **Current pattern**: `plant-displays-[plant]-[category]-###.jpg`

### Problems Identified

1. **Excessive Redundancy**: The path already contains all the information
   - Path: `assets/images/projects/plant-displays/bluebells/planning/`
   - File: `plant-displays-bluebells-planning-001.jpg`
   - Repeats "plant-displays", "bluebells", and "planning" in the filename

2. **Length Issues**: 
   - 40+ character filenames
   - Difficult to read and manage
   - Will get worse with more plants (e.g., "bird-of-paradise", "lily-of-the-valley")

3. **Inconsistent Patterns**:
   - Standard: `plant-displays-[plant]-[category]-###.jpg` (156 files)
   - Combined: `[plant]-planning-[theme]-##.jpg` (7 bluebells, 6 daffodil)
   - Created confusion and mixing patterns

### Current Distribution

```
bluebells/
  build/       5 images
  gallery/     2 images  
  planning/   31 images (includes 7 combined themed images)

daffodil/
  build/       6 images
  gallery/     1 image
  planning/   25 images (includes 6 combined themed images)

ranunculus/
  build/       3 images
  gallery/    12 images
  planning/   43 images

snowdrops/
  build/       2 images
  gallery/     5 images
  planning/   17 images

poinsettia/
  planning/    6 images

protea/
  planning/    4 images

strelitzia/
  planning/    7 images
```

## Proposed New Convention

### Path Length Analysis
- Current longest path: 145 characters
- Legacy Windows limit: 260 characters (55.8% usage)
- Modern systems: No practical concern
- **Conclusion**: Path length is NOT a limiting factor, but shorter is still cleaner

### Option A: Abbreviated Categories + Simple Numbering

**Structure**: `[plant]/[b|g|p]/###.jpg`
- `b` = build
- `g` = gallery  
- `p` = planning

**Examples**:
```
assets/images/projects/plant-displays/
  bluebells/
    b/001.jpg, 002.jpg, 003.jpg
    g/001.jpg, 002.jpg
    p/english-bluebell-01.jpg, scenery-01.jpg, muscari-01.jpg
```

**Advantages**:
- ✅ Ultra-short category names (1 char)
- ✅ Consistent pattern across all plants
- ✅ Clear numbering within each category
- ✅ Flat structure for combined images

**Disadvantages**:
- ⚠️ Less immediately readable (what is "b"?)
- ⚠️ Requires documentation

### Option B: Keep Full Category Names (RECOMMENDED)

**Structure**: `[plant]/[build|gallery|planning]/###.jpg`

**Examples**:
```
assets/images/projects/plant-displays/
  bluebells/
    build/001.jpg, 002.jpg
    gallery/001.jpg, 002.jpg
    planning/
      english-bluebell-01.jpg
      spanish-bluebell-01.jpg
      muscari-01.jpg
      scenery-01.jpg
      bulbs/029.jpg
```

**Advantages**:
- ✅ Self-documenting and readable
- ✅ No confusion about folder purpose
- ✅ Only 18 chars vs 40+ char filenames (55% reduction)
- ✅ Path length still well within limits
- ✅ Professional and maintainable

**Subfolder Strategy**:
- **Source folders**: Keep themed subfolders for organization
  - `\\LSUK-SYNRACK\...\Bluebells\planning\flowers\`, `bulbs\`, etc.
- **Site folders**: TWO OPTIONS:
  1. **Keep subfolders** (mirrors source structure)
  2. **Flatten to main category** (combined images only at category level)

**Recommended: Keep subfolders on site** because:
- Maintains 1:1 mapping with source
- Easier to track and sync
- No confusion about where files are
- Path length is not a concern (145/260 chars)

### Final Recommendation: Option B with Subfolders

```
SITE STRUCTURE:
assets/images/projects/plant-displays/
  bluebells/
    build/
      001.jpg (was: plant-displays-bluebells-build-001.jpg)
    gallery/
      001.jpg (was: plant-displays-bluebells-build-001.jpg)
    planning/
      english-bluebell-01.jpg (was: bluebells-planning-english-bluebell-01.jpg)
      spanish-bluebell-01.jpg
      muscari-01.jpg
      scenery-01.jpg, scenery-02.jpg
      bulbs/
        029.jpg (was: plant-displays-bluebells-planning-029.jpg)
      English-Bluebell/
        03.jpg, 04.jpg, 10.jpg, 20.jpg, 25.jpg
      Spannish-bluebell/
        08.jpg, 09.jpg, 11.jpg, 13.jpg, 16.jpg, 17.jpg, 23.jpg, 27.jpg
      muscari/
        01.jpg, 15.jpg, 22.jpg
      scenery/
        06.jpg, 12.jpg, 14.jpg, 19.jpg, 21.jpg, 26.jpg, 28.jpg

SOURCE STRUCTURE (mirrors site):
\\LSUK-SYNRACK\...\plant displays\
  Bluebells\
    web-optimized\
      build/001.jpg
      gallery/001.jpg
      planning/
        english-bluebell-01.jpg
        bulbs/029.jpg
        English-Bluebell/03.jpg
```

**Naming Rules**:
1. **Simple images**: 2-3 digit numbers (01.jpg, 001.jpg)
   - Build/Gallery: 3-digit (001.jpg)
   - Subfolder sources: 2-digit (01.jpg)
2. **Combined themed images**: `theme-##.jpg` (english-bluebell-01.jpg)
3. **No prefixes**: Path provides all context

### Migration Strategy

1. **Create Complete Inventory**: Map every current filename to new filename
2. **Rename Site Files**: Update all files in `assets/images/projects/plant-displays/`
3. **Rename Source Files**: Update corresponding files in `\\LSUK-SYNRACK\HomeMedia\hobbies\model building\plant displays\`
4. **Update Markdown References**: Update all build logs and project pages
5. **Update Frontmatter**: Fix `signature_image` and `progress_images` paths
6. **Verify & Commit**: Test and commit changes

### Numbering Strategy

For each plant/category combination:
1. Keep existing sequence numbers where possible
2. For combined images, use descriptive theme names
3. New images get next available number

## Example Transformations

### Standard Images
```
OLD: plant-displays-bluebells-build-001.jpg
NEW: 001.jpg
PATH: assets/images/projects/plant-displays/bluebells/build/001.jpg

OLD: plant-displays-daffodil-planning-017.jpg  
NEW: 017.jpg
PATH: assets/images/projects/plant-displays/daffodil/planning/bulbs/017.jpg
```

### Combined Themed Images
```
OLD: bluebells-planning-english-bluebell-01.jpg
NEW: english-bluebell-01.jpg
PATH: assets/images/projects/plant-displays/bluebells/planning/english-bluebell-01.jpg

OLD: daffodil-planning-flowers-02.jpg
NEW: flowers-02.jpg
PATH: assets/images/projects/plant-displays/daffodil/planning/flowers-02.jpg
```

### Subfolder Source Images
```
OLD: plant-displays-bluebells-planning-003.jpg
NEW: 03.jpg (2-digit for subfolder sources)
PATH: assets/images/projects/plant-displays/bluebells/planning/English-Bluebell/03.jpg
```

## Benefits Summary

1. **Clarity**: Path provides context, filename is just an identifier
2. **Brevity**: 40 chars → 7 chars (82% reduction)
3. **Consistency**: Single pattern throughout
4. **Scalability**: Works regardless of plant name complexity
5. **Maintainability**: Easier to manage and reference
6. **Professional**: Matches industry best practices

## Next Steps

1. Generate complete inventory with old→new mapping
2. Create PowerShell script for batch renaming
3. Test on one plant first (e.g., poinsettia with only 6 images)
4. Apply to all plants systematically
5. Update all documentation and references
