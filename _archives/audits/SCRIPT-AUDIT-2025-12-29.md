# Script Inventory & Documentation Audit
**Date:** 2025-12-29  
**Purpose:** Comprehensive audit of all active scripts vs documentation  
**Requested by:** User directive to "sort this out once and for all"

---

## Executive Summary

**Active Scripts Found:** 6 PowerShell scripts (+ 1 README.md)  
**Documented Scripts:** 3 scripts fully documented in scripts/README.md  
**Undocumented Scripts:** 3 scripts not mentioned in documentation  
**Conflicts Identified:** 1 potential naming workflow conflict  
**Deprecated Scripts:** 1 script (optimize-images.ps1) correctly archived

---

## Complete Script Inventory

### ✅ DOCUMENTED & CURRENT

#### 1. **imagemagick-optimize.ps1**
- **Status:** ✅ DOCUMENTED - PRIMARY TOOL
- **Purpose:** Optimizes images using ImageMagick with batch processing
- **Key Features:**
  - Handles HEIC/HEIF files natively (no Windows codec needed)
  - Preserves folder structure in target location
  - Supports multiple input folders with custom settings
  - Build logs: 800px @ 85% quality
  - Gallery: 1600px @ 90% quality
- **Documentation Location:** scripts/README.md lines 7-123
- **Usage Pattern:** User runs for each project with custom folder settings
- **Conflicts:** NONE - This is THE standard optimization tool
- **Last Used:** 2025-12-29 (Traditional English Cottage - 116 photos)

#### 2. **new-build-log.ps1**
- **Status:** ✅ DOCUMENTED
- **Purpose:** Creates new build log markdown files from template
- **Key Features:**
  - Auto-numbers build logs (001, 002, 003...)
  - Uses _templates/build-log-template.md
  - Creates in _builds/ folder
  - Prompts for project name and title
- **Documentation Location:** scripts/README.md lines 125-193
- **Usage Pattern:** User runs when starting new build log entry
- **Conflicts:** NONE
- **Dependencies:** Requires _templates/build-log-template.md

#### 3. **copy-project-images.ps1**
- **Status:** ✅ DOCUMENTED (but needs update - see below)
- **Purpose:** Copies optimized images from source to website assets folder
- **Key Features:**
  - Maps project source folders to website structure
  - Preserves subfolder organization
  - Hardcoded project mapping for 11 projects
- **Documentation Location:** scripts/README.md lines 195-266
- **Usage Pattern:** User runs after selecting which photos to use
- **Conflicts:** ⚠️ MINOR - Project mapping is hardcoded, may need updates
- **Hardcoded Projects in Script:**
  1. ancient forest → ancient-forest
  2. bamboo river lookout → bamboo-river-lookout
  3. bookshop memories → bookshop-memories
  4. caravaning → caravaning
  5. Country Garden → english-country-garden
  6. japanese-gardens → japanese-gardens
  7. Japanese winter scene → japanese-winter-scene
  8. Log cabin → log-cabin
  9. Medieval castle → medieval-castle
  10. mountain-stream → mountain-stream
  11. roman ruins → roman-ruins
  
  **MISSING:** traditional-english-cottage mapping

---

### ❓ UNDOCUMENTED BUT ACTIVE

#### 4. **combine-images-pairs.ps1**
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Creates grid layouts combining image pairs side-by-side
- **Key Features:**
  - Takes two images, normalizes to consistent height
  - Creates side-by-side composite with white gap
  - Uses ImageMagick composite operations
  - Useful for before/after comparisons
- **Usage Pattern:** Appears to be specialized utility script
- **Recommendation:** 🟡 **DOCUMENT IF ACTIVELY USED** - Useful for comparisons, but may be one-off utility
- **Conflicts:** NONE
- **Assessment:** Legitimate utility script, document if user wants it in standard workflow

#### 5. **download-background.ps1**
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Downloads background images from URLs for green screen work
- **Key Features:**
  - Simple helper to download from URL to backgrounds/ folder
  - Prompts for URL and filename
  - Creates backgrounds/ folder if needed
- **Usage Pattern:** Appears to be simple utility/helper script
- **Recommendation:** 🟡 **OPTIONAL DOCUMENTATION** - Very simple, may not need formal docs
- **Conflicts:** NONE
- **Assessment:** Simple helper, could document briefly or leave as-is

#### 6. **rename-project-images.ps1**
- **Status:** ❌ NOT DOCUMENTED
- **Purpose:** Renames files in subfolders with convention: projectname-foldername-###.jpg
- **Key Features:**
  - Takes project name and source folder path
  - Processes all subfolders
  - Creates rename with pattern: projectname-foldername-001.jpg
  - Numbers sequentially within each subfolder
- **Usage Pattern:** Bulk renaming of project photos
- **Recommendation:** ⚠️ **INVESTIGATE CONFLICT** - May conflict with CSV-based approach
- **Conflicts:** 🔴 **POTENTIAL WORKFLOW CONFLICT** (see below)
- **Assessment:** Need to clarify relationship with CSV inventory approach

---

## Conflict Analysis

### 🔴 CRITICAL: Naming Workflow Conflict

**Issue:** Two different approaches to renaming photos:

**Approach A: CSV Inventory Method (Current TEC Project)**
- Create inventory CSV with custom filename mapping
- Example: TEC-PHOTO-INVENTORY.csv
- Mapping: 20250710_083715.jpg → tec-build1-001.jpg
- Allows custom naming per project
- More flexible but requires CSV creation

**Approach B: Script Automation Method (rename-project-images.ps1)**
- Script automatically generates names: projectname-foldername-###.jpg
- Example: tec-planning-001.jpg, tec-cottage-001.jpg
- Faster but less flexible
- Follows strict folder-based convention

**Questions for User:**
1. Which approach is preferred going forward?
2. Should rename-project-images.ps1 be documented as standard workflow?
3. Or is CSV approach preferred for its flexibility?
4. Should rename-project-images.ps1 be deprecated if not used?

**Impact:** Traditional-english-cottage needs mapping updated:
- Current CSV uses: tec-plan-###, tec-build1-###, tec-build2-###, tec-build3-###, tec-build4-###, tec-gallery-###
- Script would generate: tec-planning-###, tec-cottage-###, tec-base-###, tec-plants-###, tec-finalisation-###, tec-gallery-###

---

### ⚠️ MINOR: Project Mapping Outdated

**Issue:** copy-project-images.ps1 has hardcoded project mapping

**Missing Project:** traditional-english-cottage
- Script has 11 projects hardcoded
- TEC project not included in mapping
- Will fail if user tries to copy TEC images

**Resolution Required:**
- Add to script: `"Traditional-English-Cottage" = "traditional-english-cottage"`
- OR document that users must manually update script for new projects
- OR redesign script to read from config file

---

## Recommendations

### Immediate Actions Required

1. **UPDATE copy-project-images.ps1**
   - Add traditional-english-cottage to project mapping
   - Consider adding comment explaining how to add new projects

2. **CLARIFY NAMING WORKFLOW**
   - User must decide: CSV method OR script automation method
   - Document chosen approach clearly
   - Either document rename-project-images.ps1 OR deprecate it

3. **DOCUMENT UTILITY SCRIPTS (Optional)**
   - combine-images-pairs.ps1 - useful for comparisons
   - download-background.ps1 - simple but could document briefly

### Documentation Updates Needed

**scripts/README.md additions:**
```markdown
### 4. rename-project-images.ps1 [IF KEEPING]
**Purpose:** Bulk rename project images with consistent convention

**Usage:**
```powershell
.\scripts\rename-project-images.ps1 `
    -ProjectName "traditional-english-cottage" `
    -SourcePath "C:\Path\To\Web-Optimized"
```

**Output:** Files renamed as projectname-foldername-###.jpg
- Example: tec-planning-001.jpg, tec-cottage-001.jpg

**Note:** This provides automated naming. For custom naming, use CSV inventory method instead.
```

### Long-term Improvements

1. **Config-driven project mapping**
   - Replace hardcoded projects in copy-project-images.ps1
   - Create projects-config.json or similar
   - Make script read config at runtime

2. **Consolidate naming approaches**
   - Either standardize on script automation
   - Or standardize on CSV inventory
   - Don't maintain both if redundant

3. **Script versioning**
   - Add version numbers to scripts
   - Add changelog comments at top
   - Track when last modified/tested

---

## Validation Checklist

- [x] All active scripts identified (6 PowerShell scripts)
- [x] All scripts analyzed for purpose and features
- [x] Documentation coverage assessed (3 of 6 documented)
- [x] Conflicts identified (1 naming workflow, 1 project mapping)
- [x] Recommendations provided
- [ ] **USER DECISION REQUIRED:** Naming workflow approach
- [ ] **ACTION REQUIRED:** Update copy-project-images.ps1 project mapping
- [ ] **ACTION REQUIRED:** Document or deprecate rename-project-images.ps1
- [ ] **OPTIONAL:** Document utility scripts

---

## Summary Statistics

| Category | Count | Percentage |
|----------|-------|------------|
| Total Scripts | 6 | 100% |
| Documented | 3 | 50% |
| Undocumented | 3 | 50% |
| Primary Tools | 1 | imagemagick-optimize.ps1 |
| Workflow Tools | 2 | new-build-log.ps1, copy-project-images.ps1 |
| Utility Scripts | 3 | combine, download, rename |
| Critical Conflicts | 1 | Naming workflow |
| Minor Issues | 1 | Project mapping |
| Deprecated Scripts | 1 | optimize-images.ps1 |

---

## User Decisions Required

### Decision 1: Naming Workflow
**Question:** Which approach for renaming photos?

**Option A: CSV Inventory (Current TEC approach)**
- Pros: Flexible custom naming, full control
- Cons: Requires CSV creation, more manual work
- When to use: When custom naming important

**Option B: Script Automation (rename-project-images.ps1)**
- Pros: Fast, consistent, automated
- Cons: Less flexible, folder-name based only
- When to use: When speed/consistency more important

**Recommendation:** Choose ONE as primary, document clearly, deprecate the other if redundant

### Decision 2: copy-project-images.ps1 Project Mapping
**Question:** How to handle project mapping?

**Option A: Update script manually for each new project**
- Add traditional-english-cottage now
- Document that users must edit script

**Option B: Create config file**
- Create projects-config.json
- Redesign script to read config
- More maintainable long-term

**Recommendation:** Option A for immediate fix, Option B for long-term improvement

### Decision 3: Utility Scripts Documentation
**Question:** Document combine-images-pairs.ps1 and download-background.ps1?

**Recommendation:** 
- Document combine-images-pairs.ps1 if used regularly for comparisons
- Keep download-background.ps1 undocumented (too simple)

---

**END OF AUDIT**

*Generated: 2025-12-29*  
*Next Review: When new scripts added or workflow changes*
