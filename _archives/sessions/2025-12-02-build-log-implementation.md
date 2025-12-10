# Session Log - Build Log System Implementation
**Date:** December 2, 2025  
**Focus:** SS Great Britain project setup and build log automation

## Session Overview

This session focused on implementing a scalable build log system with photo organization and automation tools for the Models4Comfort diorama website.

## Key Decisions & Standards

### Build Log Organization Structure

**Decision:** Separate markdown files per build log, organized in project-based folders

**Structure Implemented:**
```
_builds/
├── README.md                        # Usage instructions
├── TEMPLATE-build-log.md           # Template for new logs
├── {project-slug}/                 # One folder per project
│   ├── 001-stage-title.md
│   ├── 002-stage-title.md
│   └── ###-stage-title.md
```

**Rationale:**
- Scalable for many logs over time
- Keeps related logs organized together
- Easy to find and edit individual logs
- No manual updates needed to builds.md landing page

### File Naming Convention

**Standard:** `###-descriptive-title.md`

**Rules:**
- 3-digit zero-padded numbers (001, 002, 003)
- Lowercase only
- Hyphens instead of spaces
- Descriptive but concise titles

**Examples:**
- `001-planning-research.md`
- `002-hull-construction.md`
- `003-decking.md`

### Front Matter Standards

**Required Fields:**
```yaml
---
layout: post
title: "Project Name - Build Log #X: Stage Title"
date: YYYY-MM-DD
project: project-slug              # MUST match folder name
build_number: X                    # Sequential number
categories: [cat1, cat2]
tags: [tag1, tag2, tag3]
excerpt: "One sentence summary"    # Shows in listings
---
```

**Critical Rules:**
- `project:` must exactly match the folder name under `_builds/`
- `date:` must be valid YYYY-MM-DD format (Jekyll requirement)
- `excerpt:` is required for automatic listing display
- Use lowercase, hyphenated slugs consistently

### Image Organization Standards

**Photo Location:**
```
assets/images/builds/{project-slug}/
```

**Naming Convention:**
```
{project-slug}-{category}-###.jpg
```

**Categories:**
- `build` - Construction progress photos
- `reference` - Historical/research photos
- `gallery` - Final display photos

**Examples:**
- `ss-great-britain-build-001.jpg`
- `ss-great-britain-reference-042.jpg`
- `ss-great-britain-gallery-008.jpg`

**Photo Distribution (SS Great Britain Example):**
- Build Log #001: 8 reference photos (reference-001 to 008)
- Build Log #002: 10 build photos (build-002 to 011)
- Build Log #003: 8 build photos (build-012 to 019)
- Build Log #004: 8 build photos (build-020 to 027)
- Build Log #005: 6 build photos (build-028 to 034)
- Build Log #006: 10 build photos (build-035 to 042, plus 001, 031)

### Image Embedding Standard

**Syntax:**
```markdown
![Description]({{ 'assets/images/builds/project/photo.jpg' | relative_url }})
*Caption: Description of what the photo shows*
```

**Rules:**
- Always use `relative_url` filter for portability
- Descriptive alt text in `[]`
- Caption in italics on next line
- Leave blank line after caption before next content

### CSS Styling for Images

**Implemented:**
```css
.post-content img,
.build-content img {
  max-width: 100%;
  height: auto;
  max-height: 800px;        /* 500px on mobile */
  display: block;
  margin: auto;
  border-radius: 8px;
  box-shadow: var(--shadow);
}
```

**Purpose:**
- Prevents oversized image display
- Consistent sizing across all build logs
- Responsive for mobile devices
- Professional appearance with shadows and rounded corners

## Automation Tools Created

### 1. new-build-log.ps1

**Purpose:** Create new build log files from template with automatic setup

**Location:** `scripts/new-build-log.ps1`

**Usage:**
```powershell
.\scripts\new-build-log.ps1 -ProjectName "project-slug" -BuildNumber 2 -Title "stage-name"
```

**Parameters:**
- `-ProjectName` (required) - Project slug (lowercase, hyphens)
- `-BuildNumber` (required) - Sequential number (1-999)
- `-Title` (required) - Stage description (lowercase, hyphens)
- `-Date` (optional) - YYYY-MM-DD format (defaults to today)
- `-OpenInEditor` (optional) - Opens file in VS Code after creation

**What It Does:**
1. Creates project folder if it doesn't exist
2. Copies TEMPLATE-build-log.md to new location
3. Renames with proper convention: `###-title.md`
4. Updates front matter:
   - Generates proper title from parts
   - Sets date (today or specified)
   - Sets project slug
   - Sets build number
5. Shows next steps for editing and committing

**Validation:**
- Project name must be lowercase with hyphens only
- Title must be lowercase with hyphens only
- Build number must be 1-999
- Date must be YYYY-MM-DD format if provided

### 2. rename-project-images.ps1

**Purpose:** Batch rename photos with consistent convention

**Location:** `scripts/rename-project-images.ps1`

**Usage:**
```powershell
.\scripts\rename-project-images.ps1 -SourcePath "\\path\to\images" -WhatIf
```

**Features:**
- `-WhatIf` preview mode to see changes before applying
- Processes subfolders: build/, galery/, design-examples/
- Maps folder names to categories (galery→gallery, design-examples→reference)
- Sequential numbering with 3-digit padding
- Summary table showing results

**Naming Pattern:**
```
{project-name}-{category}-###.jpg
```

### 3. Existing Scripts Referenced

**imagemagick-optimize.ps1** - Advanced image optimization
- HEIC/HEIF conversion support
- Green screen removal capability
- Resizing and compression
- Recommended for photo preparation

**optimize-images.ps1** - Fallback optimizer
- Windows .NET based (no external dependencies)
- Good for basic optimization

## Liquid Templating Implementation

### Automatic Build Log Listing

**Location:** `builds.md`

**Latest 10 Logs:**
```liquid
{% assign recent_logs = site.builds | sort: 'date' | reverse | limit: 10 %}
{% for log in recent_logs %}
**[{{ log.title }}]({{ log.url | relative_url }})**
*{{ log.date | date: "%B %d, %Y" }}* - {{ log.excerpt }}
{% endfor %}
```

**By Project Grouping:**
```liquid
{% assign projects = site.builds | map: 'project' | uniq | sort %}
{% for project in projects %}
  {% assign project_logs = site.builds | where: 'project', project | sort: 'date' | reverse %}
  {% for log in project_logs %}
  **[{{ log.title }}]({{ log.url | relative_url }})**
  *{{ log.date | date: "%B %d, %Y" }}* - {{ log.excerpt }}
  {% endfor %}
{% endfor %}
```

**Key Features:**
- Completely automatic - no manual updates needed
- Sorts by date (newest first)
- Groups by project for organization
- Shows title, date, and excerpt
- Links directly to build log page

## Jekyll Configuration Updates

### Collections Setup

```yaml
collections:
  builds:
    output: true
    permalink: /builds/:name/
```

### Exclusions (Critical!)

```yaml
exclude:
  - _builds/TEMPLATE-build-log.md    # Prevents Jekyll error
  - scripts/                          # No need to publish scripts
```

**Reason:** Template has placeholder date `YYYY-MM-DD` which causes Jekyll build error if not excluded.

## Project Files Created/Modified

### New Files

1. **_builds/TEMPLATE-build-log.md**
   - Copyable template for new logs
   - All standard sections with XXX placeholders
   - Photo gallery examples with Liquid syntax
   - 110+ lines, comprehensive structure

2. **_builds/README.md**
   - Usage instructions for build log system
   - Methods for creating logs (script, manual, GitHub)
   - Front matter requirements
   - Photo organization guidelines
   - Publishing workflow
   - Writing tips

3. **scripts/new-build-log.ps1**
   - 170+ lines
   - Automated build log creation
   - Parameter validation
   - Front matter updates
   - Folder auto-creation

4. **scripts/README.md** (updated)
   - Added new-build-log.ps1 as script #1
   - Full documentation with examples
   - Renumbered existing scripts (2-4)

### Modified Files

1. **builds.md**
   - Added Liquid templating for automatic listing
   - "Latest Build Updates (Last 10)" section
   - "Build Logs by Project" section
   - Removed static placeholder links

2. **_config.yml**
   - Added TEMPLATE-build-log.md to exclude list
   - Added scripts/ to exclude list
   - Prevents Jekyll build errors

3. **assets/css/main.css**
   - Added build log image styling
   - Max dimensions (800px desktop, 500px mobile)
   - Centering and spacing
   - Caption styling
   - Rounded corners and shadows

## SS Great Britain Project Implementation

### Project Setup

**Project File:** `_projects/ss-great-britain.md`

**Status:** Completed (was "planning")
**Dates:** February 2022 - May 2022
**Manufacturer:** Revell 1:150 scale
**Featured Image:** `ss-great-britain-gallery-008.jpg`
**Gallery:** 8 images (gallery-001 through 008)

### Build Logs Created

1. **001-planning-research.md** (Date: 2022-02-10)
   - Comprehensive planning phase documentation
   - 87 reference images documented
   - Kit selection process
   - Research sources
   - Phased approach strategy
   - 8 reference photos embedded

2. **002-hull-construction.md** (Date: 2025-12-02)
   - Hull construction phase
   - 10 build photos embedded (build-002 to 011)

3. **003-decking.md** (Date: 2025-12-02)
   - Deck construction phase
   - 8 build photos embedded (build-012 to 019)

4. **004-sails-and-rigging.md** (Date: 2025-12-02)
   - Rigging phase
   - 8 build photos embedded (build-020 to 027)

5. **005-decoration.md** (Date: 2025-12-02)
   - Decoration phase
   - 6 build photos embedded (build-028 to 034)

6. **006-finish.md** (Date: 2025-12-02)
   - Final completion phase
   - 10 build photos embedded (build-035 to 042, plus 001, 031)

### Photos Deployed

**Total:** 94 photos (23.97 MB)
- **42 build photos:** ss-great-britain-build-001.jpg through 042.jpg
- **52 reference photos:** ss-great-britain-reference-001.jpg through 087.jpg (not all sequential)

**Source Location:** `\\lsuk-synrack\HomeMedia\hobbies\model building\SS-great-britain\web-optimized\`

**Destination:** `assets/images/builds/ss-great-britain/`

### Photo Distribution by Build Log

- **Log 001:** 8 reference photos (001-008) + note about 44 more available
- **Log 002:** 10 photos (build-002 to 011)
- **Log 003:** 8 photos (build-012 to 019)
- **Log 004:** 8 photos (build-020 to 027)
- **Log 005:** 6 photos (build-028 to 034)
- **Log 006:** 10 photos (build-035 to 042, plus 001 and 031)

**Note:** Photos were already organized in subfolders at source, matching build log structure

## Log Cabin Project Setup

**Purpose:** Test automation with new project

**Created:**
- `_projects/log-cabin.md` - Project file (status: planning)
- `_builds/log-cabin/` - Project folder
- `_builds/log-cabin/001-project-planning.md` - First build log

**Test Results:**
- ✅ Folder auto-creation working
- ✅ Front matter updates correct
- ✅ File naming convention followed
- ✅ Template copied successfully

## Gorch Fock Note

**Decision:** Removed `_builds/gorch-fock/` folder
**Reason:** No build photos or details recorded for this project
**Action:** Deleted empty folder to keep structure clean

## Standards for Future Projects

### Starting a New Project

1. **Create project file** in `_projects/{project-slug}.md`
2. **Use the script** to create first build log:
   ```powershell
   .\scripts\new-build-log.ps1 -ProjectName "project-slug" -BuildNumber 1 -Title "planning"
   ```
3. **Organize photos** from source location
4. **Rename photos** if needed using rename-project-images.ps1
5. **Copy photos** to `assets/images/builds/{project-slug}/`
6. **Update build logs** with photo galleries
7. **Commit and push**

### Photo Workflow

1. **Select photos** from source (network storage)
2. **Optimize** using imagemagick-optimize.ps1 if needed
3. **Rename** using rename-project-images.ps1 for consistency
4. **Copy** to assets/images/builds/{project-slug}/
5. **Embed** in build logs using standard syntax
6. **Add captions** as placeholders initially
7. **Fill in descriptions** during content editing phase

### Content Editing Workflow

1. Open build log file in VS Code
2. Replace "Caption: Add description" with actual descriptions
3. Fill in template sections:
   - Current Build Stage
   - Work Completed
   - Techniques Used
   - Challenges & Solutions
   - Materials & Tools
   - Next Steps
   - Time Investment
4. Update categories and tags in front matter
5. Commit changes with descriptive message
6. Push to GitHub (auto-deploys in 2-3 minutes)

## GitHub Pages Deployment

**Repository:** lcilliers/hobbies-modelling4comfort
**Branch:** main
**URL:** https://lcilliers.github.io/hobbies-modelling4comfort
**Workflow:** GitHub Actions (automatic on push)
**Build Time:** 2-3 minutes after push

## Common Issues & Solutions

### Issue: Jekyll Build Error - Invalid Date

**Problem:** Template file has `YYYY-MM-DD` placeholder causing build failure

**Solution:** Add to _config.yml exclude list:
```yaml
exclude:
  - _builds/TEMPLATE-build-log.md
```

### Issue: Photos Display Too Large

**Problem:** No size constraints on build log images

**Solution:** Added CSS in main.css:
```css
.post-content img,
.build-content img {
  max-width: 100%;
  max-height: 800px;
  object-fit: contain;
}
```

### Issue: Manual Builds Page Updates Required

**Problem:** Adding new logs required editing builds.md manually

**Solution:** Implemented Liquid templating for automatic listing

## Browser-Based Editing Options

**GitHub Web Editor:**
- Navigate to file on github.com
- Click pencil icon to edit
- Commit directly from browser

**GitHub.dev (VS Code in Browser):**
- Press `.` (period) on repository page
- Full VS Code interface in browser
- No local VS Code installation needed

**Advanced Options (Mentioned):**
- Netlify CMS / Decap CMS - Form-based content editing
- Forestry.io - Another CMS option

## Key Lessons & Best Practices

1. **Template files need exclusion** - Any file in _builds/ with placeholder dates must be excluded from Jekyll
2. **Project slug consistency is critical** - Folder names, project field, and image paths must all match exactly
3. **Automation saves time** - Script eliminates manual front matter updates and folder creation
4. **Photo organization upfront** - Renaming and organizing photos before copying prevents confusion later
5. **Liquid templating eliminates maintenance** - Automatic listing means never updating builds.md manually
6. **CSS constraints necessary** - Without max dimensions, photos can be wildly inconsistent
7. **Documentation is essential** - README files make the system usable later

## Next Steps (User's Plan)

1. **Complete SS Great Britain content**
   - Add photo descriptions/captions
   - Fill in technique details
   - Document challenges and solutions
   - Complete materials and tools sections
   - Add time investment details

2. **Future Projects**
   - User will request help when ready for next project
   - Same workflow can be applied to any new project
   - Framework is scalable and repeatable

## File Locations Quick Reference

```
Project Structure:
├── _builds/
│   ├── README.md                          # Usage guide
│   ├── TEMPLATE-build-log.md             # Copy for new logs
│   ├── log-cabin/
│   │   └── 001-project-planning.md
│   └── ss-great-britain/
│       ├── 001-planning-research.md
│       ├── 002-hull-construction.md
│       ├── 003-decking.md
│       ├── 004-sails-and-rigging.md
│       ├── 005-decoration.md
│       └── 006-finish.md
├── _projects/
│   ├── log-cabin.md
│   └── ss-great-britain.md
├── assets/
│   ├── css/
│   │   └── main.css                      # Image styling
│   └── images/
│       ├── builds/
│       │   └── ss-great-britain/         # 94 build/ref photos
│       └── projects/
│           └── ss-great-britain/         # 8 gallery photos
├── scripts/
│   ├── README.md                         # Script documentation
│   ├── new-build-log.ps1                # Build log creator
│   ├── rename-project-images.ps1        # Photo renamer
│   └── imagemagick-optimize.ps1         # Image optimizer
├── builds.md                             # Auto-listing page
└── _config.yml                           # Jekyll config
```

## Commands Reference

```powershell
# Create new build log
.\scripts\new-build-log.ps1 -ProjectName "project-slug" -BuildNumber 2 -Title "stage-name"

# With auto-open in VS Code
.\scripts\new-build-log.ps1 -ProjectName "project" -BuildNumber 1 -Title "planning" -OpenInEditor

# Rename photos (preview first)
.\scripts\rename-project-images.ps1 -SourcePath "\\path\to\images" -WhatIf
.\scripts\rename-project-images.ps1 -SourcePath "\\path\to\images"

# Git workflow
git add .
git commit -m "Description of changes"
git push

# Check status
git status
git log --oneline -5
```

## Success Metrics

- ✅ 6 build logs created for SS Great Britain
- ✅ 94 photos deployed and linked
- ✅ Automation script working perfectly
- ✅ CSS styling consistent and professional
- ✅ Automatic listing via Liquid working
- ✅ Template system in place
- ✅ Documentation comprehensive
- ✅ Jekyll build succeeds without errors
- ✅ Framework scalable for future projects

---

**End of Session Log**  
*This document should be referenced in future sessions to maintain consistency and avoid re-implementing existing solutions.*
