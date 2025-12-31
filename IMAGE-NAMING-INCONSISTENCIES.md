# Image Naming Inconsistencies Analysis

**Date:** December 31, 2025  
**Status:** Documentation of existing inconsistencies for future cleanup

## ⚠️ CRITICAL WARNING

**DO NOT assume existing naming is correct!** The site has inconsistent image naming conventions across projects. Always refer to the DEFINED STANDARD below, not existing files.

## DEFINED STANDARD (Correct Format)

**Format:** `[prefix]-[category]-[###].jpg`

**Three required sections separated by hyphens:**
1. **Prefix** - Shortened project name (2-4 characters, lowercase)
2. **Category** - Image type (planning, build1, gallery, research-boat, etc.)
3. **Number** - Three digits (001, 002, 003)

**Examples of CORRECT naming:**
```
log-cabin-build1-001.jpg
log-cabin-research-cabin-001.jpg
log-cabin-gallery-001.jpg
caravaning-planning-001.jpg
sr-pln-001.jpg (sea-rescue planning)
ecg-gal-001.jpg (english-country-garden gallery)
```

**Shortened Prefixes (Standard):**
- `log-cabin` → log-cabin (already short)
- `caravaning` → caravaning (already short)
- `sea-rescue` → `sr`
- `ss-great-britain` → `ss-gb`
- `english-country-garden` → `ecg`
- `bamboo-river-lookout` → `brl`
- `bookshop-memories` → `bsm`

## Analysis Summary

**Total images analyzed:** 733 files across 18 projects

### Naming Pattern Distribution

| Pattern | Count | Compliance | Examples |
|---------|-------|------------|----------|
| 3-part (prefix-category-###) | 422 | ✅ CORRECT | log-cabin-gallery-001.jpg, caravaning-car-001.jpg |
| 4-part | 223 | ❌ INCORRECT | cathy-flower-house-001.jpg, plant-displays-bluebells-build-001.jpg |
| 5-part | 81 | ❌ INCORRECT | bamboo-river-lookout-figures-001.jpg |
| 2-part | 4 | ❌ INCORRECT | bsm-001.jpg |
| 1-part (timestamps) | 3 | ❌ INCORRECT | 20251130_201537.jpg |

**Compliance Rate:** 57.6% (422/733 files follow the standard)

## Folder Structure Analysis

### Projects Using Correct Structure

**FLAT structure (all images in root):**
- ✅ log-cabin (115 images) - CORRECT naming
- ✅ bookshop-memories (4 images) - needs category added
- ✅ simon-coffee-shop (14 images)
- ✅ ss-great-britain (13 images)
- ❌ german-sail-boat (5 images) - has timestamp filenames

**SUBFOLDER structure:**
- ✅ sea-rescue (4 images in planning/) - CORRECT naming: sr-pln-###.jpg
- ⚠️ caravaning (97 images) - mixed: some correct, some have extra parts
- ⚠️ english-country-garden (267 images) - mostly correct but inconsistent prefixes
- ⚠️ bamboo-river-lookout (24 images) - 5-part names need fixing
- ❌ plant-displays (174 images) - 4-part names need standardization

### Empty Projects

**Redundant folders (should be deleted):**
- ❌ ancient-forest - no images, project not active
- ❌ cabin-in-woods - no images, project not active
- ❌ riverside-cabin - no images, project not active
- ❌ sa-farm-home - no images, project not active

**Intentionally empty (correct, for future use):**
- ✅ country-house - reserved for future project
- ✅ henrhyd-falls-south-wales - reserved for future project

## Specific Issues by Project

### ❌ HIGH PRIORITY - Major Inconsistencies

**bamboo-river-lookout** (24 images)
- Issue: 5-part naming (bamboo-river-lookout-figures-001.jpg)
- Should be: brl-figures-001.jpg
- Fix: Shorten prefix from full name to abbreviation

**plant-displays** (174 images)
- Issue: 4-part naming (plant-displays-bluebells-build-001.jpg)
- Should be: Store in subfolders with simpler naming OR use abbreviated prefix
- Current: plant-displays/bluebells/build/plant-displays-bluebells-build-001.jpg
- Better: plant-displays/bluebells/build/001.jpg OR pd-bluebells-build-001.jpg

**cathy-flower-house** (10 images)
- Issue: 4-part naming (cathy-flower-house-001.jpg)
- Should be: cfh-gallery-001.jpg (add category, shorten prefix)

**german-sail-boat** (5 images)
- Issue: Timestamp filenames (20251130_201537.jpg)
- Should be: gs-gallery-001.jpg

### ⚠️ MEDIUM PRIORITY - Minor Issues

**english-country-garden** (267 images)
- Issue: Mixed prefixes (ecg-, english-country-garden-)
- Should be: Standardize to ecg- prefix everywhere
- Some correct: ecg-gal-001.jpg ✅
- Some wrong: english-country-garden-planning-001.jpg ❌

**caravaning** (97 images)
- Issue: Some files have 4-part names (caravaning-scenary-004-figures.jpg)
- Should be: caravaning-scenary-004.jpg (remove extra descriptors)
- Most files are correct

**bookshop-memories** (4 images)
- Issue: 2-part naming (bsm-001.jpg)
- Should be: bsm-gallery-001.jpg (add category)

### ✅ LOW PRIORITY - Already Correct

**log-cabin** (115 images)
- ✅ Perfect example of correct naming
- All files follow: log-cabin-[category]-[###].jpg

**sea-rescue** (4 images)
- ✅ Correct naming: sr-pln-001.jpg through sr-pln-004.jpg
- ✅ Proper subfolder: planning/

**ss-great-britain** (13 images)
- ✅ Mostly correct naming pattern
- Files like: ss-great-britain-gallery-001.jpg (could shorten to ss-gb-)

## Recommended Fix Priority

### Phase 0: Cleanup (IMMEDIATE)
1. Delete redundant empty folders:
   - ancient-forest
   - cabin-in-woods
   - riverside-cabin
   - sa-farm-home

### Phase 1: New Projects (IMMEDIATE)
- All new projects MUST use the 3-part standard
- sea-rescue is the template to follow
- No exceptions for "existing patterns"

### Phase 2: High-Impact Corrections
1. german-sail-boat - rename timestamp files
2. bamboo-river-lookout - shorten prefix to brl-
3. cathy-flower-house - add categories, shorten prefix
4. bookshop-memories - add categories

### Phase 3: Large-Scale Standardization
1. plant-displays - decide on subfolder structure vs. abbreviated prefix
2. english-country-garden - standardize all to ecg- prefix
3. caravaning - remove extra descriptors from 4-part names

### Phase 4: Optional Improvements
1. ss-great-britain - shorten to ss-gb- prefix
2. simon-coffee-shop - add prefix (scs-) if desired

## Migration Script Requirements

When creating rename scripts, they must:
1. Update image files in assets/images/projects/
2. Update all markdown references in _projects/ and _builds/
3. Update front matter (featured_image, signature_image, progress_images, gallery)
4. Create backup before execution
5. Generate audit log of all changes

## Documentation References

- **Correct Standard:** See `assets/images/README.md` - Image Naming Convention section
- **Build Log Images:** See `_builds/README.md` - Image Naming Convention section
- **Historical Context:** See `NAMING-CONVENTION-ANALYSIS.md` (if exists)

---

**Action Required:** Do not replicate existing inconsistent patterns. Always use the 3-part standard for new images.
