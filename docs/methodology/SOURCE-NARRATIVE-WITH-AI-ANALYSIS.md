# Source-Narrative Methodology with AI Image Analysis
## Iterative Cycles for Creating Comprehensive Project Documentation

**Version:** 2.0 - AI-Enhanced Workflow  
**Last Updated:** 2026-01-11  
**Status:** Active Methodology

---

## Overview

This methodology combines comprehensive narrative storytelling with AI-powered image analysis to create professional project documentation. The process is **iterative and cyclical**, with separate cycles for the project overview page and each build log.

### Key Principles

1. **Human Story First** - Your narrative and personal experience is the foundation
2. **AI as Assistant** - AI analyzes images and suggests organization, not replace your voice
3. **Iterative Process** - Multiple passes refine and improve content
4. **Validation Required** - All AI output must be reviewed and validated by you
5. **One Cycle at a Time** - Complete each cycle before moving to the next

### What Makes This Different

**Traditional Approach:**
- Write text → Find images → Insert images → Hope it works

**This Approach:**
- Write narrative → **AI analyzes images** → **AI recommends best images** → You review → You add personal context → Build pages

**Benefits:**
- AI identifies which images best illustrate each aspect
- AI provides objective ratings and comparisons
- You maintain complete creative control
- Better image selection through systematic analysis
- Faster workflow with higher quality results

---

## The Iterative Cycle Structure

### Cycle Types

**Cycle 0: Project Overview Page**
- High-level project summary
- Key statistics and timeline
- Best showcase images (gallery)
- Links to all build logs

**Cycle 1-N: Individual Build Logs**
- One cycle per build log
- Each represents a distinct phase or chapter
- Complete one cycle before starting next
- Sequential progression through project timeline

### Universal Cycle Phases

Every cycle (project page and each build log) follows the same 7 phases:

```
Phase 0: Preparation (Image optimization & organization)
Phase 1: Framework Creation
Phase 2: AI Image Analysis (Multi-pass)
Phase 3: Analysis Integration
Phase 4: Personal Narrative (Human)
Phase 5: Validation & Organization
Phase 6: Page Construction
Phase 7: Cycle Documentation
```

---

## Phase 0: Preparation
### Optimize and Organize Images Before Analysis

**Objective:** Ensure all images are properly optimized, named, and organized before starting the cycle.

### Steps

#### 1. Source Image Organization

Organize your source images by project phase:
```
\\server\photos\project-name\
├── planning\          # Research, sketches, inspiration
├── build1\           # First construction phase
├── build2\           # Second construction phase
├── build3\           # Third construction phase
├── finalisation\     # Assembly and completion
├── gallery\          # Final showcase photos
└── web-optimized\    # Output folder for optimized images
    ├── planning\
    ├── build1\
    ├── ...
```

#### 2. Image Optimization

**Script:** `imagemagick-optimize.ps1`

```powershell
# Optimize each folder
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "\\server\photos\project-name\planning" `
    -OutputSubFolder "\\server\photos\project-name\web-optimized\planning" `
    -MaxWidth 800 `
    -MaxHeight 800 `
    -JpegQuality 85

# For gallery photos, use higher quality
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "\\server\photos\project-name\gallery" `
    -OutputSubFolder "\\server\photos\project-name\web-optimized\gallery" `
    -MaxWidth 1600 `
    -MaxHeight 1600 `
    -JpegQuality 90
```

#### 3. Image Renaming

**Script:** Manual PowerShell (will create dedicated script)

Rename to 3-part convention: `[prefix]-[category]-[###].jpg`

```powershell
# Navigate to optimized folder
cd "\\server\photos\project-name\web-optimized\planning"

# Rename files
$files = Get-ChildItem -File | Sort-Object Name
$counter = 1
foreach ($file in $files) {
    $newName = "project-planning-{0:D3}.jpg" -f $counter
    Rename-Item -Path $file.FullName -NewName $newName
    $counter++
}
```

#### 4. Verify Organization

**Checklist:**
- [ ] All folders optimized
- [ ] All images renamed to convention
- [ ] No duplicate filenames
- [ ] File sizes appropriate (< 500KB for build, < 800KB for gallery)
- [ ] Ready for AI analysis

**Output:** Organized, optimized, properly named images ready for analysis

---

## Phase 1: Framework Creation
### Create Document Structure and Content Outline

**Objective:** Create the basic structure for the source-narrative document before adding content.

### For Project Overview Page

**Script:** `new-source-narrative.ps1` (to be created)

**Manual Process:**

1. **Create Source File**
   ```markdown
   # [Project Name] - SOURCE NARRATIVE - PROJECT OVERVIEW

   <!--
   ═══════════════════════════════════════════════════════════════
   CONTENT PROVENANCE
   ═══════════════════════════════════════════════════════════════
   All content is YOUR authentic experience and memories.
   Created: YYYY-MM-DD
   Cycle: Project Overview
   Validation Status: [NEEDS MORE]
   ═══════════════════════════════════════════════════════════════
   -->

   ## Project Metadata
   - **Project Name:**
   - **Scale:**
   - **Dimensions:**
   - **Start Date:**
   - **Completion Date:**
   - **Total Hours:**
   - **Inspiration:**

   ## High-Level Summary
   [TODO: Write 2-3 paragraph overview of entire project]

   ## Key Features
   - Feature 1:
   - Feature 2:
   - Feature 3:

   ## Major Challenges
   1. Challenge 1:
   2. Challenge 2:

   ## Key Learnings
   - Learning 1:
   - Learning 2:

   ## Build Log Structure
   - Build Log 1: [Phase name]
   - Build Log 2: [Phase name]
   - Build Log 3: [Phase name]

   ## Gallery Images Section
   [To be populated after AI analysis]
   ```

2. **Save As:** `project-name-SOURCE-NARRATIVE-overview.md`

### For Build Log

**Script:** `new-build-log-narrative.ps1` (to be created)

**Manual Process:**

1. **Create Source File**
   ```markdown
   # [Project Name] - SOURCE NARRATIVE - BUILD LOG [N]
   ## [Phase Name/Title]

   <!--
   ═══════════════════════════════════════════════════════════════
   CONTENT PROVENANCE
   ═══════════════════════════════════════════════════════════════
   All content is YOUR authentic experience and memories.
   Created: YYYY-MM-DD
   Cycle: Build Log [N]
   Phase: [Phase name]
   Validation Status: [NEEDS MORE]
   ═══════════════════════════════════════════════════════════════
   -->

   ## Build Log Metadata
   - **Build Number:** [N]
   - **Phase:** [Phase name]
   - **Timeline:** [Start date] - [End date]
   - **Hours Spent:** [Approximate]
   - **Primary Focus:** [What this phase accomplished]

   ## Narrative

   ### What This Phase Was About
   [TODO: Write overview of this phase]

   ### The Work
   [TODO: Describe what you did, step by step]

   ### Challenges and Solutions
   [TODO: What went wrong and how you fixed it]

   ### What I Learned
   [TODO: Key insights from this phase]

   ### Results
   [TODO: What you accomplished]

   ## Images for This Phase
   **Source Folder:** \\server\photos\project-name\web-optimized\[folder-name]\
   **Image Count:** [TBD after analysis]
   **Key Images:** [To be identified by AI analysis]
   ```

2. **Save As:** `project-name-SOURCE-NARRATIVE-build-[N].md`

**Output:** Empty framework document ready for content

---

## Phase 2: AI Image Analysis
### Multi-Pass Analysis to Understand and Evaluate Images

**Objective:** Use AI to systematically analyze all images for the current cycle, identify best candidates, and provide ratings/recommendations.

This phase consists of multiple analysis passes, each with a specific purpose.

### Pass 1: Broad Scan - General Descriptions

**Purpose:** Get AI descriptions of all images to understand what's available.

**Script:** `analyze-images.ps1`

```powershell
.\scripts\analyze-images.ps1 `
    -SourcePath "\\server\photos\project-name\web-optimized\build1" `
    -OutputPath "\\server\photos\project-name\analysis\build1-descriptions.csv" `
    -AnalysisType description `
    -ProjectName "project-name"
```

**Output:** `build1-descriptions.csv` with columns:
- FileName
- Description
- AltText
- Caption

**Review in PowerShell:**
```powershell
$csv = Import-Csv "\\server\photos\project-name\analysis\build1-descriptions.csv"
$csv | Select-Object FileName, Description | Format-Table -Wrap
```

### Pass 2: Content Filtering - Find Relevant Images

**Purpose:** Filter images by content relevance to specific aspects of this build phase.

**Example - Find images showing specific technique:**

```powershell
$csv = Import-Csv "build1-descriptions.csv"

# Find images related to foundation work
$foundation = $csv | Where-Object {
    $_.Description -like "*foundation*" -or 
    $_.Description -like "*base*" -or 
    $_.Caption -like "*foam*"
}

# Display results
$foundation | Select-Object FileName, Description
```

### Pass 3: Focused Analysis - Deep Dive on Candidates

**Purpose:** Analyze filtered images in detail for specific aspects.

**Copy selected images to temp folder:**
```powershell
$selected = @("proj-build1-005.jpg", "proj-build1-012.jpg", "proj-build1-018.jpg")
$tempFolder = "\\server\photos\project-name\analysis\temp-foundation"
New-Item -ItemType Directory -Path $tempFolder -Force | Out-Null

foreach ($img in $selected) {
    Copy-Item "\\server\photos\project-name\web-optimized\build1\$img" `
              -Destination $tempFolder
}
```

**Run focused analysis with custom prompt:**
```powershell
.\scripts\analyze-images.ps1 `
    -SourcePath $tempFolder `
    -OutputPath "\\server\photos\project-name\analysis\foundation-detailed.csv" `
    -AnalysisType custom `
    -CustomPrompt "Analyze the foundation construction shown. Focus on: 1) What materials are visible? 2) What construction techniques are demonstrated? 3) How effective is this photo at showing the process? (rate 1-10) 4) What stage of construction is shown? Be specific and technical." `
    -ProjectName "project-name"
```

### Pass 4: Comparative Analysis - Rate and Rank

**Purpose:** Compare similar images to identify the best ones.

**Example - Compare images showing same subject:**

```powershell
# Copy all images showing "cabin structure"
$cabinImages = $csv | Where-Object {$_.Description -like "*cabin*"}
$compareFolder = "\\server\photos\project-name\analysis\temp-cabin-compare"
New-Item -ItemType Directory -Path $compareFolder -Force | Out-Null

foreach ($img in $cabinImages) {
    Copy-Item "\\server\photos\project-name\web-optimized\build2\$($img.FileName)" `
              -Destination $compareFolder
}

# Analyze with comparison prompt
.\scripts\analyze-images.ps1 `
    -SourcePath $compareFolder `
    -OutputPath "\\server\photos\project-name\analysis\cabin-comparison.csv" `
    -AnalysisType custom `
    -CustomPrompt "Rate this image for showing cabin construction: 1) How clear is the cabin structure? (1-10) 2) How well does it show construction details? (1-10) 3) Photo quality and lighting? (1-10) 4) Overall usefulness for documentation? (1-10) 5) Which specific aspect of cabin construction does this best illustrate?" `
    -ProjectName "project-name"
```

**Review and identify best:**
```powershell
$comparison = Import-Csv "\\server\photos\project-name\analysis\cabin-comparison.csv"
foreach ($row in $comparison) {
    Write-Host "`nIMAGE: $($row.FileName)" -ForegroundColor Yellow
    Write-Host $row.Response
}

# Manual review to identify highest-rated images
```

### Pass 5: Grouping Analysis - Image Sequences

**Purpose:** Identify images that work well together as sequences, before/after pairs, or multi-angle views.

```powershell
.\scripts\analyze-images.ps1 `
    -SourcePath "\\server\photos\project-name\web-optimized\build3" `
    -OutputPath "\\server\photos\project-name\analysis\build3-sequences.csv" `
    -AnalysisType custom `
    -CustomPrompt "Identify if this image is part of a sequence or progression. Answer: 1) What stage or step does this show? 2) Is this a before, during, or after shot? 3) What other images would pair well with this (based on the same angle, same feature, or progression)? 4) Would this work better alone or as part of a series?" `
    -ProjectName "project-name"
```

### Analysis Pass Summary

At the end of Phase 2, you should have:

**Generated Files:**
- `[phase]-descriptions.csv` - All images with general descriptions
- `[aspect]-detailed.csv` - Focused analysis on specific topics
- `[feature]-comparison.csv` - Ratings comparing similar images
- `[phase]-sequences.csv` - Grouping recommendations

**Key Decisions Made:**
- Which images best illustrate each aspect
- Highest-rated images for each feature
- Images that should be grouped together
- Images to exclude (poor quality, duplicates, unclear)

**Output:** Comprehensive AI analysis data ready for integration

---

## Phase 3: Analysis Integration
### Add AI Findings to Source-Narrative

**Objective:** Integrate AI analysis results into the source-narrative document as reference data.

### Steps

#### 1. Create Analysis Appendix

Add to end of source-narrative file:

```markdown
---

## AI ANALYSIS APPENDIX
### Phase 2 Analysis Results - For Reference Only

**Analysis Date:** 2026-01-11  
**Total Images Analyzed:** [count]  
**Analysis Files Generated:** [list]

### Image Recommendations by Topic

#### Foundation Construction
**Best Images:**
1. `proj-build1-005.jpg` - Rating: 9/10 - Shows styrofoam shaping technique
2. `proj-build1-012.jpg` - Rating: 8/10 - Base assembly process
3. `proj-build1-018.jpg` - Rating: 8/10 - Final foundation result

**AI Notes:**
- Image 005 has best lighting and angle for technique demonstration
- Image 012 shows process steps clearly
- Consider using 005 and 018 as before/after pair

#### Cabin Structure
**Best Images:**
1. `proj-build2-023.jpg` - Rating: 10/10 - Complete wall assembly view
2. `proj-build2-031.jpg` - Rating: 9/10 - Log detail close-up
3. `proj-build2-045.jpg` - Rating: 8/10 - Roof construction in progress

**AI Notes:**
- Image 023 is exceptional quality, use as primary cabin image
- Image 031 shows craftsmanship detail well
- Images 023, 031, 045 form good progression sequence

### Images to Review
**Potential Issues:**
- `proj-build1-003.jpg` - Blurry, consider excluding
- `proj-build2-015.jpg` - Similar to 014, choose one
- `proj-build3-052.jpg` - Good content but poor lighting

### Suggested Image Groups
**Sequence 1: Foundation to Base**
- proj-build1-005, 012, 018 (progression)

**Sequence 2: Cabin Assembly**
- proj-build2-023, 031, 045 (overview → detail → construction)

**Pair 1: Before/After Weathering**
- proj-build3-062 (before) + proj-build3-089 (after)

---
[END OF APPENDIX - Continue with narrative below]
```

#### 2. Flag Recommended Images in Narrative

Update narrative sections with image markers based on AI recommendations:

```markdown
## Foundation Construction

I began with extruded polystyrene foam, carving it into a rocky base.

[IMAGE: proj-build1-005.jpg]
[AI-RECOMMENDED: 9/10 rating - Best shows technique]
*Caption: [TO WRITE - describe what I was doing here]*

The shaping took several hours of careful work with hot wire and knife.

[IMAGE: proj-build1-012.jpg]
[AI-RECOMMENDED: 8/10 rating - Shows process clearly]
*Caption: [TO WRITE]*

[IMAGE: proj-build1-018.jpg]
[AI-RECOMMENDED: 8/10 rating - Good result view]
[AI-NOTE: Works as before/after with 005]
*Caption: [TO WRITE]*
```

#### 3. Create Image Reference Table

Add table summarizing all image recommendations:

```markdown
### Image Reference Table

| Image | AI Rating | Purpose | Status | Notes |
|-------|-----------|---------|--------|-------|
| proj-build1-005.jpg | 9/10 | Technique demo | ✅ USE | Primary foundation image |
| proj-build1-012.jpg | 8/10 | Process | ✅ USE | Shows steps |
| proj-build1-018.jpg | 8/10 | Result | ✅ USE | Before/after with 005 |
| proj-build1-003.jpg | 3/10 | - | ❌ SKIP | Blurry |
| proj-build2-023.jpg | 10/10 | Showcase | ✅ USE | Best cabin image |
| proj-build2-031.jpg | 9/10 | Detail | REVIEW | Check if needed |
| ... | ... | ... | ... | ... |
```

**Output:** Source-narrative enhanced with AI recommendations for review

---

## Phase 4: Personal Narrative
### Add Your Voice, Context, and Decisions

**Objective:** YOU review AI recommendations, accept/reject/modify, and add personal context that AI cannot know.

**This is the most important phase** - where your authentic voice and experience are added.

### Steps

#### 1. Review AI Recommendations

Go through each AI-flagged image:

```markdown
[IMAGE: proj-build1-005.jpg]
[AI-RECOMMENDED: 9/10 rating - Best shows technique]
```

**Ask yourself:**
- Do I agree this is the best image?
- Does it show what I want to communicate?
- Is there context AI doesn't know?
- Should I use a different image?

**Make decisions:**
- ✅ **ACCEPT** - Keep AI recommendation
- ✏️ **MODIFY** - Use image but different context
- ❌ **REJECT** - Choose different image
- ➕ **ADD** - Include additional images

#### 2. Write Personal Captions

Replace `[TO WRITE]` with YOUR captions:

**Before:**
```markdown
[IMAGE: proj-build1-005.jpg]
[AI-RECOMMENDED: 9/10 rating]
*Caption: [TO WRITE - describe what I was doing here]*
```

**After:**
```markdown
[IMAGE: proj-build1-005.jpg]
[ACCEPTED - AI rating 9/10]
*Caption: This is where I learned that hot wire cutting needs practice - 
I burned through the foam three times before getting this smooth curve! 
The blue foam from the hardware store worked better than the pink 
insulation foam I tried first.*
```

#### 3. Add Context AI Cannot Know

**Emotional Context:**
```markdown
At this point I was getting frustrated. The cabin walls wouldn't align 
properly, and I spent two evenings trying different approaches before 
realizing the base wasn't level. Sometimes the simplest mistakes take 
longest to find!
```

**Technical Decisions:**
```markdown
I chose to use wood coffee stirrers instead of balsa because they were 
cheaper and gave a more rustic texture. Each "log" was individually 
stained with three different brown tones before assembly - tedious but 
worth it for the realistic variation.
```

**Learning Moments:**
```markdown
This is where I discovered the importance of working in good lighting. 
The detail work looked fine under my desk lamp, but in natural light 
I could see gaps I'd missed. I now always check my work by a window.
```

**Personal Touch:**
```markdown
My cat knocked over the cabin twice during this phase. The second time 
broke the chimney and I had to rebuild it - which actually turned out 
better than the original! Sometimes happy accidents improve the work.
```

**Time Reality:**
```markdown
AI analysis suggests 4-5 hours for this phase. Reality: closer to 12 hours 
because I'm a perfectionist and redid the roof tiles three times.
```

#### 4. Add Non-Visual Information

**Smells and Sensations:**
```markdown
The smell of super glue was overwhelming in the small workspace. I learned 
to open windows and take breaks. The tactile experience of handling tiny 
pieces with tweezers taught me patience I didn't know I had.
```

**Environmental Context:**
```markdown
I worked on this during January evenings after work, usually 9pm-midnight. 
The quiet focus time became meditative. Radio 4 playing in background, 
cup of tea, just me and tiny pieces of wood.
```

**Inspiration Evolution:**
```markdown
Initially inspired by X, but as work progressed I realized I wanted to 
capture Y instead. The project evolved from [original intent] to become 
more about [actual result].
```

#### 5. Make Final Image Selections

Review your complete narrative with AI-suggested images:

```markdown
## MY IMAGE DECISIONS - FINAL

### Foundation Section
✅ USING: proj-build1-005.jpg (AI rated 9/10) - Shows technique
✅ USING: proj-build1-018.jpg (AI rated 8/10) - Final result
❌ REJECTED: proj-build1-012.jpg - Too similar to 005, redundant
➕ ADDING: proj-build1-021.jpg - Not in AI analysis but shows 
   the crack repair that taught me important lesson

### Cabin Section
✅ USING: proj-build2-023.jpg (AI rated 10/10) - Primary cabin
✏️ MODIFIED: proj-build2-031.jpg - Using but for different purpose
   AI suggested for detail, I'm using to show mistake I made
❌ REJECTED: proj-build2-045.jpg - Roof not visible enough
➕ ADDING: proj-build2-053.jpg - Shows the texture technique
   that made this cabin unique

REASONING: I want to emphasize learning from mistakes, not just 
showcase perfect work. Some "lower rated" images tell better stories.
```

#### 6. Update Validation Markers

Mark completed sections:

```markdown
[COMPLETE]
## Foundation Construction
Timeline: January 28 - February 3, 2024

I began with extruded polystyrene foam...
[Full section with validated content and personal narrative]
```

**Remove AI markers:**
```markdown
<!-- Old:
[AI-RECOMMENDED: 9/10 rating - Best shows technique]
[TO WRITE - describe what I was doing here]
-->

<!-- New: -->
*Caption: This is where I learned that hot wire cutting needs practice...*
```

### Phase 4 Checklist

Before proceeding to Phase 5:

- [ ] Reviewed all AI image recommendations
- [ ] Made accept/reject/modify decisions for each
- [ ] Written personal captions for all selected images
- [ ] Added emotional and contextual information
- [ ] Included non-visual details (smells, sounds, timeline reality)
- [ ] Documented learning moments and mistakes
- [ ] Added personal reasoning for image choices
- [ ] Updated validation markers
- [ ] Removed AI suggestion markers from accepted content
- [ ] Narrative feels authentic and in my voice

**Output:** Source-narrative with validated content and authentic personal voice

---

## Phase 5: Validation & Organization
### Verify Accuracy and Organize Content

**Objective:** Final check that all content is accurate, complete, and properly organized.

### Technical Validation

**Script:** `validate-source-narrative.ps1` (to be created)

**Manual Checklist:**

#### Image Path Validation
- [ ] All referenced images exist at specified paths
- [ ] All image filenames match 3-part convention
- [ ] No duplicate image references
- [ ] No broken image markers

```powershell
# Check if images exist
$narrative = Get-Content "project-SOURCE-NARRATIVE-build1.md" -Raw
$imageRefs = [regex]::Matches($narrative, '\[IMAGE:\s*(.+?)\]')

foreach ($match in $imageRefs) {
    $imagePath = "\\server\photos\project\web-optimized\build1\$($match.Groups[1].Value.Trim())"
    if (-not (Test-Path $imagePath)) {
        Write-Host "❌ MISSING: $($match.Groups[1].Value)" -ForegroundColor Red
    } else {
        Write-Host "✅ EXISTS: $($match.Groups[1].Value)" -ForegroundColor Green
    }
}
```

#### Technical Data Validation
- [ ] Dates are accurate (verified against project notes/photos)
- [ ] Hours estimates are realistic
- [ ] Dimensions are correct
- [ ] Scale is accurate
- [ ] Materials list matches what was actually used
- [ ] Technique descriptions are technically correct

#### Content Validation
- [ ] No `[TODO]` markers remain
- [ ] No `[AI-CHECK]` markers in validated sections
- [ ] All captions written (no `[TO WRITE]` markers)
- [ ] All sections marked `[COMPLETE]` or `[NEEDS MORE]`
- [ ] No placeholder text remains
- [ ] No generic template language

### Narrative Quality Check

#### Story Flow
- [ ] Chronological order makes sense
- [ ] Transitions between sections are smooth
- [ ] Each section has clear purpose
- [ ] Beginning, middle, end structure
- [ ] Conclusion ties back to introduction

#### Voice Consistency
- [ ] Authentic personal voice throughout
- [ ] Consistent tense (past tense for retrospective)
- [ ] Consistent perspective (first person)
- [ ] No AI-generated formal language without personal touch

#### Completeness
- [ ] All major phases covered
- [ ] Challenges and solutions documented
- [ ] Learning moments included
- [ ] Results and reflections present
- [ ] Context for decisions explained

### Organization Check

#### Section Structure
- [ ] Clear hierarchy (H1 → H2 → H3)
- [ ] Logical grouping of related content
- [ ] Appropriate section lengths (not too long/short)
- [ ] Each section has clear topic

#### Image Distribution
- [ ] Images evenly distributed through narrative
- [ ] Not too many images in one section
- [ ] Key moments have visual support
- [ ] Image sequences properly ordered
- [ ] Gallery images separate from inline images

### Cross-Reference Validation

#### Build Log Connections
- [ ] References to previous build logs are accurate
- [ ] Forward references note "to be covered in Build Log X"
- [ ] Timeline continuity with other build logs
- [ ] No contradictions between build logs

#### Project Page Alignment
- [ ] Build log aligns with project overview
- [ ] Dates match project timeline
- [ ] Hours contribute to project total
- [ ] Key features mentioned align with project description

### Final Validation Checklist

```markdown
## VALIDATION REPORT - Build Log [N]
**Date:** YYYY-MM-DD
**Validator:** [Your name]
**Status:** [VALIDATED / NEEDS REVISION]

### Technical Validation
- [x] All images exist and are accessible
- [x] All filenames follow convention
- [x] Dates verified accurate
- [x] Technical details correct

### Content Validation
- [x] No placeholder markers remain
- [x] All sections complete
- [x] Personal narrative added
- [x] Authentic voice throughout

### Organization Validation
- [x] Logical structure
- [x] Smooth transitions
- [x] Appropriate image distribution
- [x] Clear hierarchy

### Cross-Reference Validation
- [x] Aligns with project overview
- [x] Consistent with other build logs
- [x] No contradictions

**APPROVED FOR PHASE 6: Page Construction**
Signature: [Your name]
Date: YYYY-MM-DD
```

**Output:** Validated, accurate, complete source-narrative ready for page construction

---

## Phase 6: Page Construction
### Convert Source-Narrative to Jekyll Pages

**Objective:** Transform validated source-narrative into properly formatted Jekyll markdown pages.

### For Project Overview Page

**Script:** `build-project-page.ps1` (to be created)

**Manual Process:**

#### 1. Create Project Page File

Location: `_projects/project-name.md`

#### 2. Build Front Matter

```yaml
---
layout: project
title: "Project Name"
permalink: /projects/project-name/
date: 2024-12-15
categories: [diorama, technique-category]
tags: [tag1, tag2, tag3]
published: true

# Project Metadata
scale: "1:35"
dimensions: "30cm x 20cm x 15cm"
start_date: "2024-01-20"
completion_date: "2024-12-15"
total_hours: 130

# Gallery Images
gallery:
  - url: "/assets/images/projects/project-name/gallery/proj-gallery-001.jpg"
    caption: "Final view from front showing main cabin and landscaping"
  - url: "/assets/images/projects/project-name/gallery/proj-gallery-002.jpg"
    caption: "Side angle highlighting rock cliff and waterfall"
  - url: "/assets/images/projects/project-name/gallery/proj-gallery-003.jpg"
    caption: "Close-up of cabin weathering and detail work"

# Hero Image
hero_image: "/assets/images/projects/project-name/gallery/proj-gallery-001.jpg"

# Build Logs
build_logs:
  - title: "Foundation and Base"
    url: "/builds/project-name/001-foundation/"
  - title: "Cabin Construction"
    url: "/builds/project-name/002-cabin/"
  - title: "Landscaping and Details"
    url: "/builds/project-name/003-landscaping/"
---
```

#### 3. Add Project Summary

Extract high-level summary from source-narrative:

```markdown
## Project Overview

[2-3 paragraph summary from source-narrative overview section]

## Key Features

- Feature 1 description
- Feature 2 description
- Feature 3 description

## Build Process

This project was completed in [N] phases over [timeframe]:

1. **[Phase 1]** - [Brief description]
2. **[Phase 2]** - [Brief description]
3. **[Phase 3]** - [Brief description]

## Challenges and Solutions

[Key challenges paragraph from source-narrative]

## What I Learned

[Key learnings from source-narrative]

## Gallery

{% include gallery.html %}

## Build Logs

{% for log in page.build_logs %}
- [{{ log.title }}]({{ log.url }})
{% endfor %}
```

#### 4. Copy Images to Website

```powershell
# Copy gallery images
Copy-Item "\\server\photos\project-name\web-optimized\gallery\*" `
          -Destination "\\workspace\Models4Comfort\assets\images\projects\project-name\gallery\"
```

### For Build Log Pages

**Script:** `build-build-log-page.ps1` (to be created)

**Manual Process:**

#### 1. Create Build Log File

Location: `_builds/project-name/[number]-[slug].md`

Example: `_builds/log-cabin/001-foundation-and-base.md`

#### 2. Build Front Matter

```yaml
---
layout: build
title: "Foundation and Base Construction"
project: "Log Cabin"
project_url: "/projects/log-cabin/"
build_number: 1
date: 2024-02-03
categories: [build-log]
tags: [foundation, styrofoam, base-construction]
published: true

# Build Metadata
timeline: "January 28 - February 3, 2024"
hours_spent: 15
primary_focus: "Creating rocky cliff base from foam"

# Images for this build
image_folder: "/assets/images/builds/log-cabin/build1/"
---
```

#### 3. Convert Narrative Content

Transform source-narrative sections into build log content:

```markdown
## Overview

[Extract "What This Phase Was About" from source-narrative]

## The Work

[Extract "The Work" section from source-narrative]

### Foundation Shaping

[Content with images]

![Styrofoam shaping]({{ page.image_folder }}log-cabin-build1-005.jpg)
*This is where I learned that hot wire cutting needs practice - I burned 
through the foam three times before getting this smooth curve!*

### Base Assembly

[Content with images]

![Base assembly process]({{ page.image_folder }}log-cabin-build1-012.jpg)
*The base structure coming together. Blue foam worked better than pink 
insulation foam.*

## Challenges

[Extract "Challenges and Solutions" from source-narrative]

## What I Learned

[Extract "What I Learned" from source-narrative]

## Results

[Extract "Results" from source-narrative with final images]

## Next Steps

In the next build log, I'll cover [preview of next phase].
```

#### 4. Copy Build Images to Website

```powershell
# Copy build images
Copy-Item "\\server\photos\project-name\web-optimized\build1\*" `
          -Destination "\\workspace\Models4Comfort\assets\images\builds\project-name\build1\"
```

### Image Path Conversion

Convert image markers to Jekyll image syntax:

**Source-Narrative Format:**
```markdown
[IMAGE: proj-build1-005.jpg]
*Caption: My caption here*
```

**Jekyll Format:**
```markdown
![Alt text]({{ page.image_folder }}proj-build1-005.jpg)
*Caption: My caption here*
```

**Script helper:**
```powershell
# Convert image markers (pseudo-code for script)
$content = Get-Content "source-narrative.md" -Raw
$content = $content -replace '\[IMAGE:\s*(.+?)\]', '![Alt text]({{ page.image_folder }}$1)'
```

### Validation After Construction

**Checklist:**
- [ ] Front matter complete and accurate
- [ ] All sections present from source-narrative
- [ ] Images paths correct for Jekyll structure
- [ ] Gallery images working
- [ ] Links between pages functional
- [ ] Markdown formatting valid

### Test Locally

```powershell
# Start Jekyll local server
cd \\workspace\Models4Comfort
bundle exec jekyll serve

# View at http://localhost:4000
```

**Verify:**
- [ ] Page renders correctly
- [ ] Images display properly
- [ ] Gallery works
- [ ] Links to other pages work
- [ ] Responsive on mobile

**Output:** Published Jekyll pages on website

---

## Phase 7: Cycle Documentation
### Record What Was Done and Archive Analysis

**Objective:** Document the cycle completion and archive all analysis data for future reference.

### Cycle Completion Record

Create cycle record file: `project-name-CYCLE-[N]-RECORD.md`

```markdown
# [Project Name] - Cycle [N] Completion Record
## [Build Log Name/Project Overview]

**Cycle Type:** [Project Overview / Build Log N]
**Completion Date:** YYYY-MM-DD
**Total Time Spent:** [hours]

---

## Phase Completion Summary

### Phase 0: Preparation
**Status:** ✅ COMPLETE
**Date:** YYYY-MM-DD
- Optimized [N] images
- Renamed all to convention
- Organized into folders: [list]

### Phase 1: Framework
**Status:** ✅ COMPLETE
**Date:** YYYY-MM-DD
- Created source-narrative framework
- Defined sections and structure
- File: `project-name-SOURCE-NARRATIVE-build[N].md`

### Phase 2: AI Analysis
**Status:** ✅ COMPLETE
**Date:** YYYY-MM-DD

**Analysis Passes Completed:**
1. Broad scan: [N] images → `build[N]-descriptions.csv`
2. Content filtering: [N] images matched criteria
3. Focused analysis: [N] images → `[topic]-detailed.csv`
4. Comparative: [N] images → `[feature]-comparison.csv`
5. Grouping: [N] images → `build[N]-sequences.csv`

**Key Findings:**
- Best image for [aspect]: [filename] (rating: [N]/10)
- Best image for [aspect]: [filename] (rating: [N]/10)
- Recommended sequence: [list]

**Total Analysis Cost:** $[amount]

### Phase 3: Analysis Integration
**Status:** ✅ COMPLETE
**Date:** YYYY-MM-DD
- Added AI appendix to source-narrative
- Flagged [N] recommended images
- Created reference table

### Phase 4: Personal Narrative
**Status:** ✅ COMPLETE
**Date:** YYYY-MM-DD

**Decisions Made:**
- ✅ Accepted [N] AI recommendations
- ❌ Rejected [N] AI recommendations
- ➕ Added [N] images not in AI analysis
- ✏️ Modified [N] AI suggestions

**Personal Content Added:**
- [N] custom captions written
- [N] context paragraphs added
- [N] learning moments documented
- [N] non-visual details included

### Phase 5: Validation
**Status:** ✅ COMPLETE
**Date:** YYYY-MM-DD
- All images verified exist
- Technical data validated
- Content completeness confirmed
- Cross-references checked

### Phase 6: Page Construction
**Status:** ✅ COMPLETE
**Date:** YYYY-MM-DD

**Pages Created:**
- [ ] Project overview page: `_projects/project-name.md`
- [ ] Build log page: `_builds/project-name/00[N]-[slug].md`

**Images Deployed:** [N] images copied to website assets

**Publication Status:** [PUBLISHED / DRAFT]

### Phase 7: Documentation
**Status:** ✅ COMPLETE (this document)
**Date:** YYYY-MM-DD

---

## Analysis Files Generated

**Location:** `\\server\photos\project-name\analysis\`

**Files:**
- `build[N]-descriptions.csv` - [size], [N] images
- `[topic]-detailed.csv` - [size], [N] images
- `[feature]-comparison.csv` - [size], [N] images
- `build[N]-sequences.csv` - [size], [N] images

**Archived:** ✅ YES / ❌ NO

---

## Images Used

### Selected for Build Log

| Image | Source | AI Rating | Used For | Notes |
|-------|--------|-----------|----------|-------|
| proj-build1-005.jpg | build1 | 9/10 | Technique demo | Accepted AI rec |
| proj-build1-018.jpg | build1 | 8/10 | Results | Accepted AI rec |
| proj-build1-021.jpg | build1 | N/A | Mistake story | Added by me |
| ... | ... | ... | ... | ... |

**Total Images Used:** [N]
**Total Images Analyzed:** [N]
**Selection Rate:** [%]

---

## What Worked Well

**AI Analysis:**
- [What AI did well]
- [Helpful recommendations]
- [Time saved]

**Workflow:**
- [Efficient parts]
- [Good processes]

**Personal Additions:**
- [Value of human context]
- [Stories AI couldn't capture]

---

## What to Improve Next Cycle

**AI Analysis:**
- [ ] Try different prompt for [aspect]
- [ ] Analyze [category] images differently
- [ ] Skip [redundant analysis pass]

**Workflow:**
- [ ] Do [step] earlier/later
- [ ] Combine [phases]
- [ ] Add [missing step]

**Personal Process:**
- [ ] Write more detail about [topic]
- [ ] Capture [information] during build
- [ ] Document [aspect] better

---

## Next Cycle Preview

**Next Cycle:** [Build Log N+1 / Project Overview if this was last build log]
**Focus:** [What next cycle will cover]
**Estimated Start:** YYYY-MM-DD
**Preparation Needed:**
- [ ] Optimize images for [next phase]
- [ ] Review [materials] from build
- [ ] Gather [reference information]

---

## Lessons Learned

### For Future Projects
1. [Lesson 1]
2. [Lesson 2]
3. [Lesson 3]

### For This Project's Remaining Cycles
1. [Lesson 1]
2. [Lesson 2]

---

**Cycle [N] Status:** ✅ COMPLETE  
**Ready to proceed to Cycle [N+1]:** YES / NO  
**Blockers:** [None / List any blockers]

---

*Cycle completed by [Your Name] on [Date]*
```

### Archive Analysis Data

```powershell
# Create archive structure
$archivePath = "\\server\photos\project-name\analysis\archive\cycle-[N]-[date]"
New-Item -ItemType Directory -Path $archivePath -Force

# Move analysis files to archive
Move-Item "\\server\photos\project-name\analysis\build[N]-*.csv" -Destination $archivePath
Move-Item "\\server\photos\project-name\analysis\temp-*" -Destination $archivePath

# Copy cycle record
Copy-Item "project-name-CYCLE-[N]-RECORD.md" -Destination $archivePath
```

### Update Project Index

Add cycle completion to project tracking file:

```markdown
# [Project Name] - Cycle Tracking

## Project Overview
- **Total Cycles Planned:** [N]
- **Cycles Completed:** [N]
- **Status:** [IN PROGRESS / COMPLETE]

## Cycle Completion Status

| Cycle | Type | Status | Completed | Duration | Images |
|-------|------|--------|-----------|----------|--------|
| 0 | Project Overview | ✅ | 2026-01-05 | 8 hours | 25 |
| 1 | Build Log 1 | ✅ | 2026-01-11 | 6 hours | 18 |
| 2 | Build Log 2 | 🔄 | In progress | - | - |
| 3 | Build Log 3 | ⏸️ | Not started | - | - |

## Next Actions
- [ ] Start Cycle 2
- [ ] Optimize images for Build Log 2
- [ ] Review Cycle 1 lessons learned
```

**Output:** Complete documentation of cycle for future reference

---

## Cross-Cycle Considerations

### Version Control Integration

**Commit Strategy:**

```bash
# After Phase 1 (Framework)
git add projects-working/source-narratives/project-name-build[N].md
git commit -m "docs(project): Add build log [N] framework"

# After Phase 4 (Personal Narrative)
git add projects-working/source-narratives/project-name-build[N].md
git commit -m "docs(project): Complete build log [N] narrative"

# After Phase 6 (Page Construction)
git add _builds/project-name/00[N]-*.md
git add assets/images/builds/project-name/build[N]/
git commit -m "content(project): Publish build log [N]"

# Tag cycle completion
git tag "cycle-[N]-complete"
```

### Image Reuse Tracking

Some images may appear in multiple build logs or project overview. Track this:

```markdown
## Image Reuse Log

| Image | Original | Also Used In | Purpose |
|-------|----------|--------------|---------|
| proj-gallery-001.jpg | Gallery | Project overview, Build 4 | Hero image |
| proj-build2-023.jpg | Build 2 | Project overview | Key technique |
| ... | ... | ... | ... |

**Important:** Use consistent captions when image appears multiple times,  
or explain why caption differs if context changes.
```

### Prompt Evolution

Track which AI prompts work best:

```markdown
## Prompt Effectiveness Log

### Cycle 1
**Best Prompt:** "Focus ONLY on [feature]. Rate 1-10 for [specific aspect]"
**Why it worked:** Specific, focused, included ratings
**Result:** Clear comparisons, easy decisions

**Worst Prompt:** "Analyze this image for quality"
**Why it failed:** Too vague, got generic responses
**Lesson:** Always specify what aspect to analyze

### Cycle 2
[Update with new findings]
```

### Consistency Guidelines

**Between Build Logs:**
- Maintain consistent terminology
- Use same measurement units
- Keep similar narrative structure
- Reference previous learning moments
- Build on earlier explanations

**Example:**
```markdown
<!-- Build Log 1 -->
I used coffee stirrers for the logs, staining each individually...

<!-- Build Log 2 -->
Continuing with the coffee stirrer technique from Build Log 1, I applied 
it to the smaller shed structure...
```

### Time Tracking

Keep realistic time estimates for future planning:

```markdown
## Actual Time by Phase (Build Log [N])

| Phase | Estimated | Actual | Variance | Notes |
|-------|-----------|--------|----------|-------|
| 0: Prep | 1 hour | 1.5 hours | +0.5 | More images than expected |
| 1: Framework | 0.5 hour | 0.5 hour | 0 | As planned |
| 2: AI Analysis | 2 hours | 3 hours | +1 | Multiple passes needed |
| 3: Integration | 0.5 hour | 0.75 hour | +0.25 | Detailed notes |
| 4: Personal | 3 hours | 5 hours | +2 | Lots of stories to tell |
| 5: Validation | 1 hour | 0.75 hour | -0.25 | Good organization |
| 6: Construction | 2 hours | 2.5 hours | +0.5 | Some reformatting |
| 7: Documentation | 0.5 hour | 1 hour | +0.5 | Thorough recording |
| **TOTAL** | **10.5 hours** | **15 hours** | **+4.5 hours** | |

**Lesson:** Phase 4 (Personal Narrative) takes longer than expected - 
build in more time for future cycles.
```

---

## Workflow Scripts Reference

### Created Scripts

**Location:** `\\workspace\Models4Comfort\scripts\`

1. **`imagemagick-optimize.ps1`** ✅ EXISTS
   - Optimizes and converts images
   - Phase 0: Preparation

2. **`analyze-images.ps1`** ✅ EXISTS
   - AI image analysis with multiple modes
   - Phase 2: AI Analysis

3. **`new-source-narrative.ps1`** 🆕 TO BE CREATED
   - Creates source-narrative framework
   - Phase 1: Framework Creation

4. **`validate-source-narrative.ps1`** 🆕 TO BE CREATED
   - Validates content and image paths
   - Phase 5: Validation

5. **`build-project-page.ps1`** 🆕 TO BE CREATED
   - Converts source-narrative to project page
   - Phase 6: Page Construction

6. **`build-build-log-page.ps1`** 🆕 TO BE CREATED
   - Converts source-narrative to build log page
   - Phase 6: Page Construction

7. **`archive-cycle-data.ps1`** 🆕 TO BE CREATED
   - Archives analysis data
   - Phase 7: Cycle Documentation

### Script Usage by Phase

| Phase | Scripts Used | Purpose |
|-------|--------------|---------|
| 0: Prep | `imagemagick-optimize.ps1` | Optimize images |
| 1: Framework | `new-source-narrative.ps1` | Create structure |
| 2: AI Analysis | `analyze-images.ps1` (multiple passes) | Analyze images |
| 3: Integration | (Manual process) | Add AI data to narrative |
| 4: Personal | (Manual process) | Add your voice |
| 5: Validation | `validate-source-narrative.ps1` | Check accuracy |
| 6: Construction | `build-project-page.ps1` or `build-build-log-page.ps1` | Create pages |
| 7: Documentation | `archive-cycle-data.ps1` | Archive data |

---

## Quick Start Checklist

### Starting a New Cycle

- [ ] Previous cycle complete (or first cycle)
- [ ] Images for this phase organized
- [ ] API billing has credits
- [ ] 4-6 hours available for cycle completion
- [ ] Clear on what this cycle will cover

### During the Cycle

- [ ] Following phases in order
- [ ] Not skipping validation steps
- [ ] Making decisions (not just accepting AI)
- [ ] Adding personal context
- [ ] Documenting as you go

### Completing the Cycle

- [ ] All phases marked complete
- [ ] Source-narrative validated
- [ ] Pages published or drafted
- [ ] Analysis data archived
- [ ] Cycle record created
- [ ] Ready for next cycle

---

## FAQs

**Q: Can I skip Phase 2 (AI Analysis) if I already know which images to use?**  
A: Yes, but AI analysis often reveals better options you might not have considered. At minimum, do Pass 1 (broad scan) to have descriptions for reference.

**Q: Do I have to complete a cycle in one session?**  
A: No. You can pause between phases. Just mark where you stopped in the cycle record.

**Q: Can I work on multiple cycles simultaneously?**  
A: Not recommended. Complete one cycle before starting the next to maintain focus and consistency.

**Q: What if AI recommends an image I don't like?**  
A: Reject it! Phase 4 is where YOU make all final decisions. AI is advisory only.

**Q: How long does a complete cycle take?**  
A: Typically 10-15 hours total. Phase 4 (Personal Narrative) takes longest (4-6 hours).

**Q: Can I modify the phases for my needs?**  
A: Yes, but maintain validation (Phase 5) and documentation (Phase 7). These ensure quality and continuity.

**Q: What if I don't have Anthropic API access?**  
A: You can manually analyze images (more time) or use description analysis mode only and skip comparative passes.

---

## Version History

**Version 2.0** (2026-01-11)
- Complete rewrite incorporating AI image analysis
- Added iterative cycle structure
- Seven-phase process defined
- Scripts identified and documented
- Multi-pass AI analysis workflow

**Version 1.0** (2025-12-XX)
- Original source-narrative methodology
- Basic narrative-first approach
- Image marker system

---

**Methodology Status:** ✅ ACTIVE  
**Last Updated:** 2026-01-11  
**Maintained By:** Models4Comfort Project

*This methodology is continuously refined based on actual project experience.*
