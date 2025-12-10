# Documentation Audit & Consolidation Plan

**Date:** December 10, 2025  
**Purpose:** Review all README and guidance files, identify conflicts, overlaps, and distinguish between historical records vs. ongoing guidance

---

## FILE CLASSIFICATION

### 📋 ACTIVE GUIDANCE FILES (Standards & Templates)

These files provide ongoing guidance, standards, and templates for future work:

1. **README.md** (Root)
   - **Purpose:** Quick start guide to the project
   - **Status:** ✅ Active - Primary entry point
   - **Content:** 4 static site generator options, quick links to other docs
   - **Action:** Keep as-is, ensure links are current

2. **SITE-EDITING-GUIDE.md**
   - **Purpose:** Comprehensive guide for editing website content
   - **Status:** ✅ Active - Primary editing reference
   - **Content:** Front matter standards, image guidelines, markdown formatting, link practices, writing style, build log organization
   - **Issues Found:**
     - Contains some assumptions/examples (e.g., "German Sail Boat" project) - these should be marked as examples
     - Build log naming section conflicts with new folder-based structure
   - **Action:** Update to match current folder-based build log structure, add disclaimer about example content

3. **PUBLISHING-GUIDE.md**
   - **Purpose:** Quick reference for git workflow
   - **Status:** ✅ Active - Essential workflow guide
   - **Content:** 3-step git process, image optimization, troubleshooting
   - **Issues Found:** None
   - **Action:** Keep as-is

4. **IMAGEMAGICK-GUIDE.md**
   - **Purpose:** Guide for ImageMagick installation and usage
   - **Status:** ✅ Active - Technical reference
   - **Content:** Installation, HEIC conversion, green screen removal, batch optimization
   - **Issues Found:** None - good technical documentation
   - **Action:** Keep as-is

5. **FRONT-MATTER-GUIDE.md**
   - **Purpose:** Complete reference for YAML front matter
   - **Status:** ✅ Active - Technical reference
   - **Content:** Detailed explanation of all front matter fields, examples, best practices
   - **Issues Found:** None
   - **Action:** Keep as-is

6. **IMAGE-LAYOUT-GUIDE.md** (referenced but not read)
   - **Purpose:** Guide for image layouts in build logs
   - **Status:** ✅ Active (assumed)
   - **Action:** Verify content aligns with current standards

7. **_builds/TEMPLATE-build-log.md**
   - **Purpose:** Template for creating new build logs
   - **Status:** ✅ Active - Critical template
   - **Content:** Complete build log structure with XXX placeholders
   - **Issues Found:** Template uses generic placeholders - GOOD (not assumptions)
   - **Action:** Add header comment clarifying this is a template and placeholders should be replaced

8. **scripts/README.md**
   - **Purpose:** Documentation for PowerShell scripts
   - **Status:** ✅ Active - Technical reference
   - **Content:** new-build-log.ps1, imagemagick-optimize.ps1, optimize-images.ps1, copy-project-images.ps1
   - **Issues Found:** None
   - **Action:** Keep as-is

9. **_builds/README.md**
   - **Purpose:** Guidance on build log folder structure and creation
   - **Status:** ✅ Active - Reference for build logs
   - **Content:** Folder organization, naming conventions, script usage, publishing workflow
   - **Issues Found:** None - aligns with current structure
   - **Action:** Keep as-is

10. **assets/images/README.md**
    - **Purpose:** Image organization and optimization guidance
    - **Status:** ✅ Active - Reference for images
    - **Content:** Folder structure, naming, optimization, copying workflow
    - **Issues Found:** None
    - **Action:** Keep as-is

---

### 📜 HISTORICAL RECORD FILES (Past Actions)

These files document what happened in the past and should NOT be used as guidance for future work:

1. **NEW-PAGES-SUMMARY.md**
   - **Purpose:** Documents pages created on December 1, 2025
   - **Status:** ⚠️ HISTORICAL RECORD - Not current guidance
   - **Content:** 
     - Summary of builds.md, techniques.md, about.md creation
     - Lists placeholder content that may now be replaced
     - Describes what "was created" (past tense)
   - **Issues:** Mixes historical record with guidance instructions
   - **Action:** 
     - RENAME to `ARCHIVE-2025-12-01-new-pages.md`
     - Add header: "⚠️ HISTORICAL RECORD - Documents work completed December 1, 2025"
     - Move to new `_archives/` folder

2. **SESSION-LOG-2025-12-02.md**
   - **Purpose:** Records decisions and work from December 2, 2025 session
   - **Status:** ✅ HISTORICAL RECORD - Already clearly marked
   - **Content:** Build log system implementation decisions, SS Great Britain setup
   - **Issues:** None - clearly marked as session log
   - **Action:** 
     - Move to `_archives/sessions/` folder
     - Keep filename format for chronological reference

3. **SETUP-COMPLETE.md**
   - **Purpose:** Summary of initial setup completion
   - **Status:** ⚠️ HISTORICAL RECORD - Describes past setup
   - **Content:** Lists what was accomplished during initial setup
   - **Issues:** Might be confused as current status
   - **Action:**
     - RENAME to `ARCHIVE-2025-initial-setup.md`
     - Add header: "⚠️ HISTORICAL RECORD - Initial setup completed [date]"
     - Move to `_archives/` folder

---

### 🤔 POTENTIAL OVERLAP / CONSOLIDATION CANDIDATES

1. **PROJECT-README.md vs README.md**
   - **PROJECT-README.md:**
     - 400+ lines, very comprehensive
     - Covers all 4 static site generators
     - Creating content instructions
     - Deployment details
     - Development prerequisites
   - **README.md:**
     - Short, quick-start focused
     - Links to PROJECT-README.md
     - Essential info only
   
   **Analysis:** 
   - README.md serves as entry point → PROJECT-README.md for details
   - This is GOOD structure (short + detailed)
   - PROJECT-README.md has significant overlap with SITE-EDITING-GUIDE.md
   
   **Recommendation:** 
   - Keep README.md as entry point
   - CONSOLIDATE PROJECT-README.md content INTO SITE-EDITING-GUIDE.md
   - Rename PROJECT-README.md → ARCHIVE-project-setup-reference.md
   - Update README.md to point to SITE-EDITING-GUIDE.md instead

2. **SITE-EDITING-GUIDE.md Content Overlaps**
   
   Overlaps with:
   - PROJECT-README.md (content creation, front matter, images)
   - FRONT-MATTER-GUIDE.md (front matter standards)
   - IMAGEMAGICK-GUIDE.md (image optimization)
   - IMAGE-LAYOUT-GUIDE.md (image layouts)
   
   **Analysis:**
   - SITE-EDITING-GUIDE tries to be comprehensive (420 lines)
   - Duplicates detailed info from specialized guides
   - Should be a "hub" that links to specialized guides
   
   **Recommendation:**
   - Keep SITE-EDITING-GUIDE.md as primary editor's reference
   - Reduce duplication - link to specialized guides instead of repeating
   - Structure as: Brief overview + link to detailed guide

---

## CONFLICTS IDENTIFIED

### 1. Build Log Organization
**Conflict:** Different descriptions of build log structure

- **SITE-EDITING-GUIDE.md (lines ~200-250):**
  - Shows: `german-sail-boat-###.md` (flat structure)
  - Front matter: `project: german-sail-boat`
  
- **_builds/README.md (current standard):**
  - Shows: `_builds/project-name/###-stage.md` (folder structure)
  - Front matter: `project: project-slug`

**Resolution:** SITE-EDITING-GUIDE.md is OUTDATED
- Update SITE-EDITING-GUIDE.md to match _builds/README.md folder structure
- Remove old naming examples
- Cross-reference to _builds/README.md for full details

### 2. Front Matter Standards
**Overlap:** Three files discuss front matter

- **SITE-EDITING-GUIDE.md:** Quick reference examples
- **FRONT-MATTER-GUIDE.md:** Complete detailed guide
- **_builds/README.md:** Build log specific requirements

**Resolution:** 
- FRONT-MATTER-GUIDE.md is authoritative
- SITE-EDITING-GUIDE.md should link to it, not duplicate
- _builds/README.md should show build-log-specific examples only

### 3. Image Optimization Instructions
**Duplication:** Three places document optimization

- **SITE-EDITING-GUIDE.md:** Brief overview
- **IMAGEMAGICK-GUIDE.md:** Complete technical guide
- **scripts/README.md:** Script usage examples

**Resolution:**
- IMAGEMAGICK-GUIDE.md is technical reference
- scripts/README.md shows practical usage
- SITE-EDITING-GUIDE.md should have 3-line summary + links

---

## ASSUMPTIONS vs FACTS AUDIT

### Files With Unvalidated Assumptions:

1. **SITE-EDITING-GUIDE.md**
   - ❌ Uses "German Sail Boat" throughout as if it's a real example
   - ❌ Shows gallery examples that may not match actual project files
   - ❌ Build log examples use outdated structure
   - ✅ Front matter standards are factual
   - ✅ Markdown formatting guidance is factual

2. **NEW-PAGES-SUMMARY.md** 
   - ⚠️ Describes placeholder content that may have changed
   - ⚠️ Lists projects that might not exist yet
   - ⚠️ Shows template content as if it's real

3. **TEMPLATE-build-log.md**
   - ✅ GOOD - Clearly uses XXX placeholders, not assumptions

### Recommendations for Clarity:

**Add Disclaimer Headers:**

```markdown
## ⚠️ EXAMPLES vs YOUR CONTENT

**Examples in this guide** (like "German Sail Boat") are for illustration only.  
Always check your actual project files in `_projects/` for real data.  
Never assume example content reflects your actual website.
```

**Distinguish External Knowledge:**

When guidance includes general knowledge (not from the project):

```markdown
## Best Practices for Diorama Photography

> **Note:** These are general modeling photography guidelines, not specific to your projects.
> Based on: Industry standards and common practices.
```

---

## RECOMMENDED FILE STRUCTURE

### Active Documentation (Keep in Root)
```
Models4Comfort/
├── README.md                      # Quick start (current)
├── SITE-EDITING-GUIDE.md          # Primary editing guide (updated)
├── PUBLISHING-GUIDE.md            # Git workflow (current)
├── IMAGEMAGICK-GUIDE.md           # Image processing (current)
├── FRONT-MATTER-GUIDE.md          # Front matter reference (current)
├── IMAGE-LAYOUT-GUIDE.md          # Layout reference (current)
├── COMMENTS-SETUP.md              # Comments setup (current)
├── _builds/
│   ├── README.md                  # Build log guidance (current)
│   ├── TEMPLATE-build-log.md      # Build log template (current)
│   └── {projects}/
├── scripts/
│   └── README.md                  # Script documentation (current)
└── assets/images/
    └── README.md                  # Image guidance (current)
```

### Historical Archives (New Folder)
```
Models4Comfort/
└── _archives/
    ├── README.md                  # "This folder contains historical records"
    ├── 2025-initial-setup.md      # (was SETUP-COMPLETE.md)
    ├── 2025-12-01-new-pages.md    # (was NEW-PAGES-SUMMARY.md)
    └── sessions/
        └── 2025-12-02-build-log-implementation.md  # (was SESSION-LOG-2025-12-02.md)
```

### Deprecated/Superseded (New Folder or Delete)
```
Models4Comfort/
└── _deprecated/
    ├── README.md                  # "These files are superseded by current guides"
    └── PROJECT-README.md          # Content moved to SITE-EDITING-GUIDE.md
```

---

## ACTION PLAN

### Phase 1: Create Archive Structure
1. ✅ Create `_archives/` folder
2. ✅ Create `_archives/sessions/` folder
3. ✅ Create `_archives/README.md` with explanation
4. ✅ Move SESSION-LOG-2025-12-02.md → `_archives/sessions/`
5. ✅ Rename and move SETUP-COMPLETE.md → `_archives/2025-initial-setup.md`
6. ✅ Rename and move NEW-PAGES-SUMMARY.md → `_archives/2025-12-01-new-pages.md`
7. ✅ Add "HISTORICAL RECORD" headers to all archived files

### Phase 2: Consolidate PROJECT-README.md
1. ✅ Review PROJECT-README.md content sections
2. ✅ Identify unique content not in SITE-EDITING-GUIDE.md
3. ✅ Merge unique content into SITE-EDITING-GUIDE.md
4. ✅ Move PROJECT-README.md → `_deprecated/PROJECT-README.md`
5. ✅ Update README.md links to point to SITE-EDITING-GUIDE.md

### Phase 3: Update SITE-EDITING-GUIDE.md
1. ✅ Add disclaimer about examples vs actual content
2. ✅ Update build log organization to match current folder structure
3. ✅ Replace duplicated content with links to specialized guides:
   - Front matter → link to FRONT-MATTER-GUIDE.md
   - Images → link to IMAGEMAGICK-GUIDE.md
   - Image layouts → link to IMAGE-LAYOUT-GUIDE.md
4. ✅ Mark assumptions clearly: "Based on general knowledge: [content]"
5. ✅ Update all examples to match actual current structure

### Phase 4: Update Template
1. ✅ Add header to TEMPLATE-build-log.md:
   ```markdown
   <!--
   📋 BUILD LOG TEMPLATE
   
   This is a template file with placeholder values marked as XXX.
   Replace all XXX values with your actual project information.
   Do not use this file directly - copy it to create new build logs.
   
   Recommended: Use scripts/new-build-log.ps1 to create logs automatically.
   -->
   ```

### Phase 5: Verify All Cross-References
1. ✅ Check all internal links in documentation
2. ✅ Verify script paths and examples
3. ✅ Ensure folder structure matches documentation
4. ✅ Test that examples use actual project names or clearly marked placeholders

### Phase 6: Create Documentation Map
1. ✅ Add to README.md a "Documentation Guide" section:
   ```markdown
   ## 📚 Documentation Guide
   
   **Getting Started:**
   - README.md (this file) - Quick start
   - SITE-EDITING-GUIDE.md - How to edit content
   - PUBLISHING-GUIDE.md - How to publish changes
   
   **Technical References:**
   - FRONT-MATTER-GUIDE.md - YAML front matter explained
   - IMAGEMAGICK-GUIDE.md - Image processing & optimization
   - IMAGE-LAYOUT-GUIDE.md - Image layout options
   
   **Specialized Guidance:**
   - _builds/README.md - Build log creation
   - scripts/README.md - Script usage
   - assets/images/README.md - Image organization
   
   **Historical Records:**
   - _archives/ - Past session logs and setup records
   ```

---

## PRINCIPLES FOR FUTURE DOCUMENTATION

### 1. Distinguish Facts from Examples
- **Facts:** Data from actual project files, verified settings
- **Examples:** Hypothetical scenarios for illustration
- **Label clearly:** "Example:" or "From project file:"

### 2. Distinguish Facts from External Knowledge
- **Project Facts:** Information from Models4Comfort files
- **General Knowledge:** Industry standards, common practices
- **Label clearly:** 
  ```markdown
  > **General Knowledge:** These are standard practices in scale modeling.
  ```

### 3. Separate Historical Records from Guidance
- **Guidance:** Instructions for future work
- **Historical:** Records of past work
- **Keep separate:** Active docs vs _archives/

### 4. Single Source of Truth
- Each topic has ONE authoritative guide
- Other files link to it, don't duplicate
- Example: FRONT-MATTER-GUIDE.md is THE front matter reference

### 5. Clear Purpose Statements
Every doc should start with:
```markdown
# Document Title

**Purpose:** [What this document is for]
**Type:** [Guidance / Reference / Historical Record]
**Last Updated:** [Date]
```

### 6. Avoid Assumptions in Templates
- Use XXX or [PLACEHOLDER] for values to fill in
- Don't use realistic-looking fake data
- Include comments explaining what to replace

---

## NEXT STEPS FOR USER

**Review this audit and confirm:**
1. Do you agree with the file classifications?
2. Should any files be classified differently?
3. Are there other files I didn't review that need checking?
4. Do you want me to proceed with the Action Plan?

**I will NOT proceed with changes until you confirm the approach.**

---

*Audit completed: December 10, 2025*
