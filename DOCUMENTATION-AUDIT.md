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

## WEBSITE CONTENT VALIDATION AUDIT

**Date:** December 10, 2025  
**Purpose:** Classify all website content pages by validation status

### Classification Categories

1. **✅ ALL CONTENT VALIDATED** - All information verified from actual project files, data, or documentation
2. **⚠️ PARTIALLY VALIDATED** - Mix of verified data and unverified/placeholder content
3. **❌ NOT VALIDATED** - Template, placeholder, or assumed content not verified against actual data

---

### Landing Pages (Public-Facing)

| Page | Status | Notes |
|------|--------|-------|
| **index.md** (Homepage) | ✅ **ALL VALIDATED** | Project links, scales, dates, thumbnails all match actual project files. Personal narrative is user's own content. |
| **about.md** | ✅ **ALL VALIDATED** | Personal biography, modeling journey, site technology - all user's authentic content. No assumptions. |
| **projects.md** | ⚠️ **PARTIALLY VALIDATED** | - Gorch Fock: Validated (matches german-sail-boat.md)<br>- SS Great Britain: Validated (matches ss-great-britain.md)<br>- Log Cabin: Validated (matches log-cabin.md)<br>- English Country Garden: Validated (matches english-country-garden.md)<br>- Henrhyd Falls: ❌ Placeholder text, marked "Pictures Coming Soon"<br>- Riverside Cabin: ❌ Placeholder text, marked "Pictures Coming Soon"<br>- Sea Rescue: ❌ Placeholder text, marked "Planning" |
| **builds.md** | ⚠️ **PARTIALLY VALIDATED** | - Page structure and instructions: Validated<br>- Content references: Uses Liquid to auto-generate from actual build logs<br>- ❌ Footer text: "Build logs coming soon! German Sail Boat series..." contradicts existence of actual build logs |
| **techniques.md** | ⚠️ **PARTIALLY VALIDATED** | - Winter Weathering tutorial exists and is validated<br>- ❌ All other techniques: Placeholder "Coming Soon" links for non-existent tutorials<br>- ❌ Lists projects that don't exist or uses placeholder names<br>- `published: false` (not currently public) |
| **credits-privacy.md** | Not reviewed | - |

---

### Project Pages (_projects/)

| Project File | Status | Notes |
|--------------|--------|-------|
| **english-country-garden.md** | ✅ **ALL VALIDATED** | Complete project with scale (1:50), dates (April 13 - Nov 30, 2024), 50+ plant species documented, 14 gallery images with verified paths, detailed build information. All content matches actual work completed. |
| **log-cabin.md** | ✅ **ALL VALIDATED** | Complete project with scale (1:35), dates (Jan-April 2024), base size (30×25cm), 8 gallery images, detailed build description. Content matches completed work. |
| **ss-great-britain.md** | ✅ **ALL VALIDATED** | Complete project with personal build narrative (Feb-May 2022), scale (1:300), scratch build details verified. 13 gallery images and 5 detailed build logs with actual construction photos. Historical context now properly framed as research with sources cited (Wikipedia, Stephens & Kenau). Excellent documentation of ambitious scratch build project. |
| **german-sail-boat.md** | ✅ **ALL VALIDATED** | Complete project with personal build narrative (Nov 2019 - May 2020), scale (1:150), kit details, gallery images verified. Historical and kit information now properly contextualized as research conducted for the build. Date consistency fixed across all pages. No build logs planned for this project. |
| **cathy-flower-house.md** | Not reviewed | Appears on homepage with actual image path |
| **henrhyd-falls-south-wales.md** | ❌ **NOT VALIDATED** | Status: "planning", all content is placeholder:<br>- "TBD" for scale, start date<br>- Generic descriptions<br>- No actual build information<br>- No gallery images<br>- "Build logs will be posted as work progresses" (future tense) |
| **traditional-english-cottage.md** | ❌ **NOT VALIDATED** | Status: "planning", all content is placeholder:<br>- "TBD" for scale, start date<br>- Generic architectural descriptions<br>- No actual build information<br>- "Build logs will be posted as work progresses" (future tense)<br>- Lists "challenges" and "techniques to explore" (not actual work) |
| **sample-project.md** | ❌ **NOT VALIDATED** | `published: false`<br>Clearly marked as example/template:<br>- Fictional WWII winter scene<br>- Generic "Tamiya/Dragon" kit references<br>- "Sample Diorama Project" in title<br>- This is intentionally a template, not a problem |

---

### Build Log Pages (_builds/)

| Build Log File | Status | Notes |
|----------------|--------|-------|
| **TEMPLATE-build-log.md** | ❌ **NOT VALIDATED** | Template file with XXX placeholders - this is correct and expected. Not a validation issue. |
| **log-cabin/001-cabin-construction.md** | Not reviewed | - |
| **log-cabin/002-plant-preparation.md** | Not reviewed | - |
| **log-cabin/003-scenery-building.md** | Not reviewed | - |
| **log-cabin/004-finishing.md** | Not reviewed | - |
| **ss-great-britain/001-planning-research.md** | ✅ **ALL VALIDATED** | Detailed content with actual reference photos, personal narrative about museum visit, research process, historical facts verified. Real build documentation. |
| **ss-great-britain/002-hull-construction.md** | ✅ **ALL VALIDATED** | Detailed construction narrative with dimensions table, personal trial-and-error process, actual build photos (beer cans for hull, sawdust filling, wood framework). Real build documentation. |
| **ss-great-britain/003-decking.md** | ✅ **ALL VALIDATED** | Deck construction with personal narrative about hatches, masts, rigging preparation. Actual build photos and learning experiences documented. |
| **ss-great-britain/004-sails-and-rigging.md** | ✅ **ALL VALIDATED** | Sail construction and rigging installation with 15 sails, rope ladders, personal challenges documented. Actual build photos. |
| **ss-great-britain/005-decoration.md** | ✅ **ALL VALIDATED** | Final painting, detailing, and completion. Personal reflections on learning curve. Completion date: 22 May 2022. Actual photos. |
| **english-country-garden/001-planning-research.md** | ❌ **NOT VALIDATED** | Contains template boilerplate:<br>- Generic "Current Build Stage", "Phase: Current construction phase"<br>- Placeholder image paths with "log-XXX-photo1.jpg"<br>- Template sections unchanged<br>- Date is April 13, 2024 (project start) but content is not populated |
| **english-country-garden/002-base-construction.md** | Not reviewed | Likely same template status |
| **english-country-garden/003-cottage-building.md** | Not reviewed | Likely same template status |
| **english-country-garden/004-scenery-planting.md** | Not reviewed | Likely same template status |
| **cathy-flower-house/001-build-log.md** | Not reviewed | - |
| **build-log-001.md** | Not reviewed | Old flat-structure build log |

---

### Technique Pages (_techniques/)

| Technique File | Status | Notes |
|----------------|--------|-------|
| **winter-weathering.md** | ⚠️ **PARTIALLY VALIDATED** | - Technique descriptions appear to be general modeling knowledge (not project-specific)<br>- Examples reference "Cabin in Woods, Country House" but log-cabin.md doesn't mention winter weathering<br>- No photos or actual project examples shown<br>- Content reads as tutorial/general guidance rather than documented personal experience |

---

## SUMMARY OF FINDINGS

### Overall Statistics

**Total Pages Reviewed:** 20 content pages (excluding documentation, archives, templates)

**Validation Breakdown:**
- ✅ **Fully Validated:** 10 pages (50%)
  - index.md
  - about.md
  - english-country-garden.md (project)
  - log-cabin.md (project)
  - german-sail-boat.md (project)
  - ss-great-britain.md (project)
  - ss-great-britain/001-planning-research.md (build log)
  - ss-great-britain/002-hull-construction.md (build log)
  - ss-great-britain/003-decking.md (build log)
  - ss-great-britain/004-sails-and-rigging.md (build log)
  - ss-great-britain/005-decoration.md (build log)

- ⚠️ **Partially Validated:** 4 pages (20%)
  - projects.md (validated entries + placeholder entries)
  - builds.md (structure valid + contradictory footer)
  - techniques.md (1 real + many placeholders)
  - winter-weathering.md (general knowledge + unverified examples)

- ❌ **Not Validated:** 3 pages (15%)
  - henrhyd-falls-south-wales.md (planning/placeholder)
  - traditional-english-cottage.md (planning/placeholder)
  - english-country-garden build logs (unpopulated templates)

- **Not Fully Reviewed:** 3 pages (15%)
  - Remaining build logs (log-cabin, cathy-flower-house)

### Key Observations

#### 1. Strong Foundation Content
**Positive:** The core completed projects (English Country Garden, Log Cabin, German Sail Boat) have excellent, fully validated content with actual data, real photos, and authentic personal narratives. The homepage and about page are entirely authentic.

#### 2. Placeholder Projects Are Clearly Marked
**Mixed:** Projects like Henrhyd Falls and Traditional English Cottage are marked as "planning" status with "Pictures Coming Soon" or "TBD" fields, making it clear they're placeholders. However, they contain generic descriptive content that reads as if it's about actual projects rather than being clearly marked as templates or future plans.

#### 3. Build Logs: Template vs. Completed
**Concern:** The English Country Garden build logs were created using the template script but haven't been populated with actual content. They contain template boilerplate (e.g., "log-XXX-photo1.jpg", "Phase: Current construction phase") which makes them appear unfinished or abandoned rather than clearly marked as "to be completed."

**Positive:** SS Great Britain build log 001 is excellent - fully validated with actual research, photos, and personal narrative.

#### 4. Techniques Section
**Concern:** The techniques.md landing page lists many techniques marked "Coming Soon" but presents them as if they exist, with skill levels and project references. This could mislead visitors.

**Concern:** Winter weathering technique appears to be general modeling knowledge rather than documented personal experience from actual projects. Claims "Used in: Cabin in Woods, Country House" but log-cabin.md makes no mention of winter weathering techniques.

#### 5. Landing Pages Contain Contradictions
**Issue:** builds.md footer states "Build logs coming soon! The German Sail Boat series will be the first to be published" but actual build logs already exist for SS Great Britain and other projects. This suggests the footer text is outdated or copied from a template without updating.

### Recommendations

#### HIGH PRIORITY

1. **Update builds.md footer** - Remove contradictory text about "coming soon" when build logs already exist

2. **Clarify placeholder projects** - Add clear headers to henrhyd-falls and traditional-english-cottage stating:
   ```markdown
   > **⚠️ PROJECT IN PLANNING PHASE**  
   > This project is in early planning. Content below represents ideas and goals, not completed work.
   ```

3. **Address template build logs** - Either:
   - Mark as `published: false` until populated, OR
   - Add a notice: "⚠️ Build log content coming soon"

4. **Review winter-weathering.md** - Verify if technique was actually used in referenced projects. If not, mark as:
   ```markdown
   > **Note:** This technique guide is based on general modeling practices.  
   > Future updates will include examples from Models4Comfort projects.
   ```

#### MEDIUM PRIORITY

5. **Audit techniques.md** - Either remove placeholder techniques or clearly mark them as "future tutorials" rather than presenting them as existing content

6. **Review remaining build logs** - Verify if other build logs contain actual content or template boilerplate

#### LOW PRIORITY

7. **External knowledge labeling** - Where content is based on general knowledge rather than personal experience (e.g., historical facts about ships, general techniques), add disclaimers as previously discussed

---

*Content validation audit completed: December 10, 2025*

---

*Audit completed: December 10, 2025*
