# COMPLETE Script Inventory & Documentation Audit
**Date:** 2025-12-29  
**Scope:** ALL PowerShell scripts in workspace  
**Total Scripts Found:** 28 active scripts (+ 1 deprecated)

---

## Executive Summary

**PREVIOUS AUDIT WAS INCOMPLETE**
- Previous audit only covered 6 scripts in scripts/ folder (21% coverage)
- Missed 22 scripts in root directory (79% of all scripts)
- This is the COMPLETE audit

**Statistics:**
- **Root Directory:** 22 PowerShell scripts
- **scripts/ Folder:** 6 PowerShell scripts  
- **_deprecated/ Folder:** 1 script (optimize-images.ps1)
- **Documented in scripts/README.md:** Only 3 scripts (11% of total)
- **Undocumented:** 25 scripts (89% of total)

**Script Categories Identified:**
1. **Primary Workflow Tools** (3 scripts) - Documented
2. **Plant Displays Project Scripts** (15 scripts) - NOT documented
3. **Utility Scripts** (3 scripts) - NOT documented
4. **Project-Specific Generators** (7 scripts) - Obsolete/one-off

---

## PART 1: Scripts Folder (Documented)

### ✅ Category: Primary Workflow Tools

#### 1. imagemagick-optimize.ps1
- **Location:** scripts/
- **Status:** ✅ DOCUMENTED - PRIMARY TOOL
- **Purpose:** Optimizes images using ImageMagick
- **Documentation:** scripts/README.md lines 7-123
- **Assessment:** CURRENT AND ACTIVE
- **Last Used:** 2025-12-29 (TEC project - 116 photos)

#### 2. new-build-log.ps1
- **Location:** scripts/
- **Status:** ✅ DOCUMENTED
- **Purpose:** Creates new build log markdown files
- **Documentation:** scripts/README.md lines 125-193
- **Assessment:** CURRENT AND ACTIVE

#### 3. copy-project-images.ps1
- **Location:** scripts/
- **Status:** ✅ DOCUMENTED (needs update)
- **Purpose:** Copies optimized images to website
- **Documentation:** scripts/README.md lines 195-266
- **Issue:** Hardcoded project mapping missing traditional-english-cottage
- **Assessment:** CURRENT BUT NEEDS UPDATE

### ❓ Category: Utility Scripts (Undocumented)

#### 4. combine-images-pairs.ps1
- **Location:** scripts/
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Creates side-by-side image comparisons
- **Key Features:** Normalizes height, adds white gap, uses ImageMagick
- **Assessment:** Utility script - document if regularly used

#### 5. download-background.ps1
- **Location:** scripts/
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Downloads background images from URLs
- **Assessment:** Very simple helper - optional documentation

#### 6. rename-project-images.ps1
- **Location:** scripts/
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Bulk rename with projectname-foldername-###.jpg pattern
- **Conflict:** ⚠️ Conflicts with CSV inventory approach
- **Assessment:** **DECIDE:** Document as standard OR deprecate

---

## PART 2: Root Directory Scripts (Plant Displays Project)

### 📊 Category: Analysis & Inventory Scripts

#### 7. analyze-source-structure.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Maps source files, generates sequential naming suggestions
- **Output:** SOURCE-STRUCTURE-ANALYSIS.csv
- **Key Features:**
  - Scans plant displays source folder
  - Maps plant codes (Bluebells→blu, Daffoldil→daf, etc.)
  - Generates suggested sequential names
  - Groups by plant+category
- **Plant Displays Project:** Core analysis tool
- **Assessment:** **PROJECT-SPECIFIC** - Used for plant-displays renaming workflow

#### 8. analyze-conflicts.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Analyzes conflicts between site renames and source structure
- **Specific:** Daffodil project - 3 conflicting files analysis
- **Output:** Console report with conflict details
- **Assessment:** **ONE-OFF TROUBLESHOOTING** - Specific to daffodil conflicts

#### 9. extract-markdown-image-refs.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Extracts image references from markdown, maps to new names
- **Output:** MARKDOWN-IMAGE-REFERENCES.csv (original), later MARKDOWN-IMAGE-REFERENCES-BACKUP.csv
- **Key Features:**
  - Scans 8 markdown files (7 build logs + project page)
  - Extracts all image paths
  - Maps old names to new sequential names
  - Only processes images actually referenced
- **Plant Displays Project:** Core mapping tool
- **Assessment:** **PROJECT-SPECIFIC** - Used for plant-displays renaming

#### 10. hash-source-files.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Generates MD5 hash inventory for source files
- **Output:** SOURCE-FILE-HASHES.csv
- **Scans:** 7 plant folders in source location
- **Assessment:** **PROJECT-SPECIFIC** - Hash-based file matching

#### 11. hash-site-files.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Generates MD5 hash inventory for site files
- **Output:** SITE-FILE-HASHES.csv
- **Scans:** 7 plant folders in assets/images/projects/plant-displays
- **Assessment:** **PROJECT-SPECIFIC** - Hash-based file matching

#### 12. build-site-source-hash-map.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Maps site files to source files using MD5 hashes
- **Inputs:** SOURCE-STRUCTURE-ANALYSIS.csv + site files
- **Output:** Console mapping report
- **Key Features:** Calculates hashes, matches files, identifies orphans
- **Assessment:** **PROJECT-SPECIFIC** - Hash-based cross-reference

### 🔄 Category: File Renaming Scripts

#### 13. rename-site-files.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Renames site files using MARKDOWN-IMAGE-REFERENCES.csv
- **Parameters:** -Confirm switch (default true)
- **Output:** Renamed files + console progress
- **Assessment:** **PROJECT-SPECIFIC** - Primary site rename executor

#### 14. rename-files-by-plant.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Renames files in source AND/OR site by plant
- **Parameters:** 
  - -Plant (bluebells|daffodil|ranunculus|snowdrops|protea|strelitzia|hibiscus|all)
  - -Location (source|site|both) - default: both
  - -DryRun switch
- **Input:** SOURCE-STRUCTURE-ANALYSIS.csv
- **Assessment:** **PROJECT-SPECIFIC** - Granular rename control by plant

#### 15. rename-images.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Renames all plant display images from verbose to sequential
- **Parameters:** -WhatIf, -SiteOnly, -SourceOnly
- **Input:** RENAME-INVENTORY.csv
- **Assessment:** **PROJECT-SPECIFIC** - Bulk rename executor

#### 16. rename-site-by-hash.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Renames site files using hash-based matching
- **Inputs:** SOURCE-FILE-HASHES.csv + SITE-FILE-HASHES.csv
- **Features:** Skips already-done plants (daffodil, hibiscus)
- **Assessment:** **PROJECT-SPECIFIC** - Hash-based rename approach

#### 17. rename-site-by-sequence.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Renames site files by sequential position matching
- **Input:** SOURCE-STRUCTURE-ANALYSIS.csv
- **Features:** Matches by position within plant+category, skips done plants
- **Assessment:** **PROJECT-SPECIFIC** - Sequential position-based rename

#### 18. rename-site-correct.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Renames site files using SOURCE CSV as authority
- **Input:** SOURCE-STRUCTURE-ANALYSIS.csv
- **Features:** Skips processed plants, handles daffoldil→daffodil spelling
- **Assessment:** **PROJECT-SPECIFIC** - CSV-authoritative rename

#### 19. rename-site-cross-ref.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Cross-references MARKDOWN and SOURCE CSVs for renaming
- **Inputs:** SOURCE-STRUCTURE-ANALYSIS.csv + MARKDOWN-IMAGE-REFERENCES.csv
- **Features:** Maps markdown current names to source sequential targets
- **Assessment:** **PROJECT-SPECIFIC** - Cross-reference mapping rename

#### 20. rollback-site-renames.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Reverses 110 successful renames using backup CSV
- **Input:** MARKDOWN-IMAGE-REFERENCES-BACKUP.csv
- **Assessment:** **PROJECT-SPECIFIC** - Emergency rollback tool

### 📝 Category: Markdown Update Scripts

#### 21. update-markdown-by-plant.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Updates markdown image references one plant at a time
- **Parameters:** -Plant (bluebells|daffodil|ranunculus|snowdrops|protea|strelitzia|all)
- **Input:** MARKDOWN-IMAGE-REFERENCES.csv
- **Features:** Groups by markdown file, shows preview, confirms changes
- **Assessment:** **PROJECT-SPECIFIC** - Granular markdown updater

### 🧪 Category: Dry Run / CSV Generators

#### 22. generate-dry-run-csvs.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** V1 - Generates RENAME-INVENTORY.csv + MARKDOWN-UPDATES.csv
- **Output:** Two CSVs showing all planned changes
- **Assessment:** **OBSOLETE** - Superseded by v2 and FINAL versions

#### 23. generate-dry-run-csvs-v2.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** V2 - Fixed version of dry run CSV generator
- **Output:** RENAME-INVENTORY.csv + MARKDOWN-UPDATES.csv
- **Assessment:** **OBSOLETE** - Superseded by FINAL version

#### 24. generate-dry-run-FINAL.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** FINAL - Dry run generator with proper UNC path handling
- **Output:** RENAME-INVENTORY.csv + MARKDOWN-UPDATES.csv
- **Features:** Handles UNC paths correctly, comprehensive validation CSVs
- **Assessment:** **PROJECT-SPECIFIC** - Final working dry-run generator

#### 25. generate-markdown-updates.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** V1 - Generates MARKDOWN-UPDATES.csv from RENAME-INVENTORY.csv
- **Parameters:** -InventoryPath, -OutputPath
- **Assessment:** **OBSOLETE** - Superseded by v2

#### 26. generate-markdown-updates-v2.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** V2 - Generates markdown updates from SOURCE-STRUCTURE-ANALYSIS.csv
- **Output:** MARKDOWN-UPDATES.csv
- **Features:** Scans actual site structure, builds lookup mapping
- **Assessment:** **PROJECT-SPECIFIC** - Markdown update planner

### ✅ Category: Validation Scripts

#### 27. validate-csv-completeness.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Validates all source web-optimized files are in CSV
- **Input:** SOURCE-STRUCTURE-ANALYSIS.csv
- **Output:** Console validation report per plant
- **Features:** Compares actual files vs CSV entries, identifies gaps
- **Assessment:** **PROJECT-SPECIFIC** - CSV completeness checker

#### 28. validate-site-files.ps1
- **Location:** Root
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Validates site files directly from disk
- **Inputs:** SITE-FILE-HASHES.csv + SOURCE-FILE-HASHES.csv
- **Features:** Identifies old format, wrong format, duplicates, orphans
- **Output:** Console validation report
- **Assessment:** **PROJECT-SPECIFIC** - Site file integrity validator

---

## PART 3: Deprecated Scripts

#### 29. optimize-images.ps1 ✅ CORRECTLY DEPRECATED
- **Location:** _deprecated/
- **Status:** DEPRECATED (2025-12-29)
- **Reason:** Unreliable HEIC support, uses .NET System.Drawing
- **Replacement:** imagemagick-optimize.ps1
- **Safeguard:** Requires "YES" input to proceed
- **Assessment:** ✅ PROPERLY HANDLED

---

## Analysis Summary

### Script Purpose Distribution

| Category | Count | % of Total | Status |
|----------|-------|------------|--------|
| **Primary Workflow** | 3 | 11% | ✅ Documented |
| **Plant Displays Project** | 18 | 64% | ❌ Not documented |
| **Obsolete Versions** | 4 | 14% | ❌ Should archive |
| **Utility Scripts** | 3 | 11% | ❓ Decision needed |
| **TOTAL ACTIVE** | 28 | 100% | 89% undocumented |

### Plant Displays Project Script Workflow

The 18 plant-displays scripts form a complete workflow:

**Phase 1: Analysis**
1. analyze-source-structure.ps1 → SOURCE-STRUCTURE-ANALYSIS.csv
2. hash-source-files.ps1 → SOURCE-FILE-HASHES.csv
3. hash-site-files.ps1 → SITE-FILE-HASHES.csv
4. build-site-source-hash-map.ps1 (uses hashes)
5. extract-markdown-image-refs.ps1 → MARKDOWN-IMAGE-REFERENCES.csv

**Phase 2: Planning**
6. generate-dry-run-FINAL.ps1 → RENAME-INVENTORY.csv + MARKDOWN-UPDATES.csv
7. validate-csv-completeness.ps1 (validation)
8. validate-site-files.ps1 (validation)

**Phase 3: Execution**
9. rename-files-by-plant.ps1 (granular by plant)
10. rename-site-files.ps1 (uses markdown CSV)
11. rename-site-by-hash.ps1 (hash matching)
12. rename-site-by-sequence.ps1 (position matching)
13. rename-site-correct.ps1 (CSV authority)
14. rename-site-cross-ref.ps1 (cross-reference)
15. update-markdown-by-plant.ps1 (update references)

**Phase 4: Rollback**
16. rollback-site-renames.ps1 (emergency undo)

**Obsolete Scripts:**
- generate-dry-run-csvs.ps1 (v1)
- generate-dry-run-csvs-v2.ps1 (v2)
- generate-markdown-updates.ps1 (v1)
- generate-markdown-updates-v2.ps1 (v2)

---

## Critical Issues Identified

### 🔴 Issue 1: Script Organization Chaos
**Problem:** 22 scripts in root directory, only 6 in scripts/ folder  
**Impact:** Workspace clutter, difficult to find scripts, unclear what's current  
**Severity:** HIGH

**Recommendation:**
```
Option A: Move all current scripts to scripts/ folder
- Move 18 plant-displays scripts to scripts/plant-displays/
- Archive 4 obsolete scripts to _deprecated/
- Keep only scripts/README.md in scripts/

Option B: Create project-specific folders
- scripts/plant-displays/ (18 scripts)
- scripts/utilities/ (3 scripts)
- _deprecated/obsolete-generators/ (4 scripts)
```

### 🔴 Issue 2: Multiple Rename Script Versions
**Problem:** 7 different rename scripts with overlapping functionality  
**Impact:** Confusion about which script to use, inconsistent approaches  
**Severity:** HIGH

**Scripts with redundant purposes:**
- rename-site-files.ps1 (uses markdown CSV)
- rename-files-by-plant.ps1 (uses source CSV, plant-specific)
- rename-images.ps1 (uses rename inventory)
- rename-site-by-hash.ps1 (hash matching)
- rename-site-by-sequence.ps1 (position matching)
- rename-site-correct.ps1 (source CSV authority)
- rename-site-cross-ref.ps1 (cross-reference)

**Recommendation:** Document which script is THE authoritative current tool, deprecate or archive the others

### 🔴 Issue 3: Obsolete Script Versions Not Archived
**Problem:** 4 obsolete v1/v2 scripts still in root directory  
**Impact:** Risk of using wrong version, clutter  
**Severity:** MEDIUM

**Should be archived:**
- generate-dry-run-csvs.ps1 (v1) → _deprecated/
- generate-dry-run-csvs-v2.ps1 (v2) → _deprecated/
- generate-markdown-updates.ps1 (v1) → _deprecated/
- generate-markdown-updates-v2.ps1 (v2) → _deprecated/

Keep only: generate-dry-run-FINAL.ps1

### 🔴 Issue 4: 89% of Scripts Undocumented
**Problem:** Only 3 of 28 scripts documented in scripts/README.md  
**Impact:** Users don't know scripts exist, unclear how to use  
**Severity:** HIGH

### ⚠️ Issue 5: Naming Workflow Conflict (from previous audit)
**Problem:** rename-project-images.ps1 conflicts with CSV inventory approach  
**Status:** Still unresolved  
**Impact:** Two competing workflows for same task

---

## Recommendations

### Immediate Actions Required

1. **Archive Obsolete Scripts** (Priority: HIGH)
   ```powershell
   Move-Item generate-dry-run-csvs.ps1 _deprecated/
   Move-Item generate-dry-run-csvs-v2.ps1 _deprecated/
   Move-Item generate-markdown-updates.ps1 _deprecated/
   Move-Item generate-markdown-updates-v2.ps1 _deprecated/
   ```

2. **Organize Plant Displays Scripts** (Priority: HIGH)
   ```powershell
   New-Item -ItemType Directory -Path "scripts\plant-displays"
   # Move all 18 plant-displays scripts there
   # Update any hardcoded paths in scripts
   ```

3. **Document Plant Displays Workflow** (Priority: HIGH)
   - Create scripts/plant-displays/README.md
   - Document the complete workflow phases
   - Explain which scripts are current vs troubleshooting-only

4. **Clarify Rename Script Strategy** (Priority: HIGH)
   - Identify THE primary rename script
   - Document when to use which script
   - OR consolidate into one master script
   - Archive/deprecate redundant versions

5. **Update scripts/README.md** (Priority: MEDIUM)
   - Add section on plant-displays scripts
   - Add section on utility scripts
   - Add cross-reference to plant-displays/README.md

6. **Resolve Naming Workflow Conflict** (Priority: MEDIUM)
   - User decision: CSV inventory OR automated script approach?
   - Document or deprecate rename-project-images.ps1 accordingly

### Long-term Improvements

1. **Script Versioning System**
   - Add version numbers to all scripts
   - Add changelog at top of each script
   - Track last-modified dates

2. **Consolidation**
   - Merge redundant rename scripts into one flexible tool
   - Create unified dry-run generator
   - Reduce 7 rename scripts to 1-2 primary tools

3. **Project Templates**
   - Create project workflow templates
   - Make plant-displays workflow reusable for future projects
   - Extract common patterns into libraries

4. **Testing Framework**
   - Add -DryRun to all scripts that modify files
   - Create validation tests
   - Automated backup before destructive operations

---

## User Decisions Required

### Decision 1: Script Organization
**Question:** How should scripts be organized?

**Option A:** By folder structure
- scripts/primary/ (3 scripts)
- scripts/plant-displays/ (18 scripts)
- scripts/utilities/ (3 scripts)

**Option B:** By usage frequency
- scripts/ (6 frequently used)
- scripts/project-specific/plant-displays/ (18 scripts)
- scripts/utilities/ (3 scripts)

**Option C:** Keep as-is, just document
- No reorganization, comprehensive README instead

### Decision 2: Plant Displays Scripts
**Question:** Should plant-displays scripts be documented or archived?

**Option A:** Document completely
- Create scripts/plant-displays/README.md
- Keep all 18 scripts as reference for future projects
- Document complete workflow

**Option B:** Archive as project-complete
- Move to _archives/plant-displays-scripts/
- Add summary documentation
- These scripts were one-off for plant-displays project

**Option C:** Keep current ones, archive obsolete
- Keep final working scripts (10-12 scripts)
- Archive troubleshooting/experimental ones (6-8 scripts)

### Decision 3: Rename Scripts Consolidation
**Question:** What to do with 7 different rename scripts?

**Option A:** Keep all, document purposes
- Each serves different use case
- Document when to use each

**Option B:** Identify primary, archive others
- One script is "the way" going forward
- Others archived as "worked but not standard"

**Option C:** Consolidate into master script
- Create new rename-master.ps1
- Unified interface with mode selection
- Archive old scripts

### Decision 4: Documentation Depth
**Question:** How much documentation for project-specific scripts?

**Option A:** Full documentation
- Treat all scripts as reusable tools
- Complete usage examples for each

**Option B:** Summary only
- Brief description of each
- "See script comments for details"

**Option C:** Workflow documentation
- Document the workflow, not individual scripts
- Scripts explained in context of workflow phases

---

## Validation Checklist

- [x] All 28 active scripts identified
- [x] Each script purpose analyzed
- [x] Obsolete scripts identified (4 scripts)
- [x] Redundant scripts identified (7 rename scripts)
- [x] Project-specific vs general tools categorized
- [x] Documentation gaps identified (89% undocumented)
- [x] Conflicts identified (naming workflow + multiple versions)
- [ ] **USER DECISIONS REQUIRED** (4 major decisions above)
- [ ] Scripts organized into folders
- [ ] Obsolete scripts archived
- [ ] Plant displays workflow documented
- [ ] Rename strategy clarified
- [ ] README files updated

---

## Comparison: Previous vs Complete Audit

| Metric | Previous Audit | Complete Audit | Difference |
|--------|----------------|----------------|------------|
| Scripts Found | 6 | 28 | +22 scripts |
| Coverage | 21% | 100% | +79% |
| Documented | 3 | 3 | (same) |
| Undocumented | 3 | 25 | +22 scripts |
| Conflicts Found | 1 | 5 | +4 issues |
| Recommendations | 3 | 15 | +12 actions |

**Previous audit missed:** Entire plant-displays project workflow (18 scripts)

---

**END OF COMPLETE AUDIT**

*Generated: 2025-12-29*  
*Scope: Complete workspace script inventory*  
*Next Review: After user decisions and reorganization*
