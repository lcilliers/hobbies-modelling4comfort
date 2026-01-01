# CRITICAL CONFLICT AUDIT - Daffodil Planning Files
Date: December 29, 2025

## THE PROBLEM

The site has "combined themed images" that DO NOT EXIST in the source structure.
The MARKDOWN-IMAGE-REFERENCES.csv was built from scanning actual site files referenced in markdown.
These site files have DIFFERENT sequential numbers than the source files.

## DETAILED ANALYSIS

### CONFLICT 1: daf-planning-001.jpg

**SITE (Currently exists - was successfully renamed):**
- Original name: daffodil-planning-flowers-01.jpg
- Renamed to: daf-planning-001.jpg ✓ (SUCCEEDED)
- RefID: 22
- Markdown: _builds\plant-displays\daffodil-001-planning-build.md

**SOURCE (What should be daf-planning-001.jpg):**
- EntryID: 44
- Original name: plant-displays-daffodil-planning-017.jpg
- Subfolder: bulbs
- Should be: daf-planning-001.jpg

**MISMATCH:** The site's daf-planning-001.jpg is a "flowers" themed image.
The source's daf-planning-001.jpg should be a "bulbs" image from subfolder.
These are DIFFERENT FILES!

---

### CONFLICT 2: daffodil-planning-bulbs-01.jpg

**SITE (Still exists - failed to rename):**
- Current name: daffodil-planning-bulbs-01.jpg
- Wanted to become: daf-planning-001.jpg ✗ (FAILED - already exists)
- RefID: 25
- Markdown: _builds\plant-displays\daffodil-001-planning-build.md

**SOURCE (Actual bulbs file):**
- Source has 1 file in bulbs subfolder:
  - plant-displays-daffodil-planning-017.jpg → daf-planning-001.jpg

**MISMATCH:** The site's "bulbs-01" combined image wanted to become daf-planning-001.jpg,
but that name was already taken by the "flowers-01" image.
The source's actual bulbs file (017) also should be daf-planning-001.jpg.

---

### CONFLICT 3: daffodil-planning-templates-01.jpg

**SITE (Still exists - failed to rename):**
- Current name: daffodil-planning-templates-01.jpg  
- Wanted to become: daf-planning-001.jpg ✗ (FAILED - already exists)
- RefID: 27
- Markdown: _builds\plant-displays\daffodil-001-planning-build.md

**SOURCE (Actual templates files):**
- Source has 3 files in templates subfolder:
  - plant-displays-daffodil-planning-004.jpg → daf-planning-023.jpg
  - plant-displays-daffodil-planning-005.jpg → daf-planning-024.jpg
  - plant-displays-daffodil-planning-009.jpg → daf-planning-025.jpg

**MISMATCH:** The site's "templates-01" combined image wanted to become daf-planning-001.jpg.
The source's actual templates files should be daf-planning-023/024/025.

---

### CONFLICT 4: daffodil-planning-scenes-01.jpg

**SITE (Still exists - failed to rename):**
- Current name: daffodil-planning-scenes-01.jpg
- Wanted to become: daf-planning-001.jpg ✗ (FAILED - already exists)
- RefID: 26
- Markdown: _builds\plant-displays\daffodil-001-planning-build.md

**SOURCE (Actual scenes files):**
- Source has 3 files in scenes subfolder:
  - plant-displays-daffodil-planning-001.jpg → daf-planning-020.jpg
  - plant-displays-daffodil-planning-010.jpg → daf-planning-021.jpg
  - plant-displays-daffodil-planning-018.jpg → daf-planning-022.jpg

**MISMATCH:** The site's "scenes-01" combined image wanted to become daf-planning-001.jpg.
The source's actual scenes files should be daf-planning-020/021/022.

---

## ROOT CAUSE

The site has "COMBINED THEMED IMAGES" in the root planning folder:
- daffodil-planning-flowers-01.jpg through flowers-03.jpg
- daffodil-planning-bulbs-01.jpg
- daffodil-planning-templates-01.jpg  
- daffodil-planning-scenes-01.jpg

These were ALL assigned RefID entries that mapped them to daf-planning-001.jpg because
the extract-markdown-image-refs.ps1 script extracted numbers from filenames and
ALL of these ended with "-01.jpg", so they all got mapped to 001.

The source has ACTUAL individual files organized in subfolders:
- bulbs/ has plant-displays-daffodil-planning-017.jpg
- flowers/ has multiple plant-displays-daffodil-planning-###.jpg files
- scenes/ has plant-displays-daffodil-planning-001/010/018.jpg
- templates/ has plant-displays-daffodil-planning-004/005/009.jpg

These have COMPLETELY DIFFERENT numbering schemes!

## IMPACT

**Site renames completed: 110 files**
- Many of these may have WRONG sequential numbers
- The numbers came from the site's combined images, not the source structure

**Files that should exist but may be wrong:**
- daf-planning-001.jpg (currently is "flowers-01", should be "bulbs/017")
- daf-planning-002.jpg (currently is ?, should be based on source)
- daf-planning-003.jpg (currently is ?, should be based on source)

## RECOMMENDATION

**CRITICAL: ROLLBACK REQUIRED**

We need to:
1. Undo the 110 site file renames
2. Build a NEW mapping based ONLY on source structure
3. Delete the "combined themed images" from site (they don't exist in source)
4. Copy files from source to site with correct names
5. Update markdown to reference only the files that actually exist in source
