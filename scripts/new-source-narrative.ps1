<#
.SYNOPSIS
    Creates a new source-narrative framework for a project or build log cycle.

.DESCRIPTION
    This script generates a templated markdown file with the proper structure for 
    writing source narratives. It creates either a project overview framework or 
    a build log framework based on parameters.

.PARAMETER ProjectName
    The name of the project (e.g., "log-cabin", "henrhyd-falls")

.PARAMETER CycleType
    Type of cycle: "project-overview" or "build-log"

.PARAMETER BuildNumber
    Build log number (required if CycleType is "build-log")

.PARAMETER BuildPhase
    Description of build phase (e.g., "Foundation and Base", "Cabin Construction")

.PARAMETER OutputPath
    Where to save the source-narrative file. Defaults to projects-working/source-narratives/

.PARAMETER ImageSourcePath
    Path to the web-optimized images for this cycle

.EXAMPLE
    .\new-source-narrative.ps1 -ProjectName "log-cabin" -CycleType "project-overview" -ImageSourcePath "\\server\photos\log-cabin\web-optimized\gallery"

.EXAMPLE
    .\new-source-narrative.ps1 -ProjectName "log-cabin" -CycleType "build-log" -BuildNumber 1 -BuildPhase "Foundation and Base" -ImageSourcePath "\\server\photos\log-cabin\web-optimized\build1"

.NOTES
    Part of SOURCE-NARRATIVE-WITH-AI-ANALYSIS methodology Phase 1: Framework Creation
    Created: 2026-01-11
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,
    
    [Parameter(Mandatory=$true)]
    [ValidateSet("project-overview", "build-log")]
    [string]$CycleType,
    
    [Parameter(Mandatory=$false)]
    [int]$BuildNumber,
    
    [Parameter(Mandatory=$false)]
    [string]$BuildPhase,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath = "$PSScriptRoot\..\projects-working\source-narratives",
    
    [Parameter(Mandatory=$false)]
    [string]$ImageSourcePath
)

# Validation
if ($CycleType -eq "build-log" -and (-not $BuildNumber -or -not $BuildPhase)) {
    Write-Error "BuildNumber and BuildPhase are required for build-log cycle type"
    exit 1
}

# Create output directory if it doesn't exist
if (-not (Test-Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
}

# Get today's date
$today = Get-Date -Format "yyyy-MM-dd"

# Build filename
if ($CycleType -eq "project-overview") {
    $filename = "$ProjectName-SOURCE-NARRATIVE-overview.md"
} else {
    $filename = "$ProjectName-SOURCE-NARRATIVE-build-$($BuildNumber.ToString("D2")).md"
}

$fullPath = Join-Path $OutputPath $filename

# Check if file already exists
if (Test-Path $fullPath) {
    Write-Warning "File already exists: $fullPath"
    $response = Read-Host "Overwrite? (y/N)"
    if ($response -ne 'y' -and $response -ne 'Y') {
        Write-Host "Aborted. File not created." -ForegroundColor Yellow
        exit 0
    }
}

# Generate content based on cycle type
if ($CycleType -eq "project-overview") {
    $content = @"
# $ProjectName - SOURCE NARRATIVE - PROJECT OVERVIEW

<!--
═══════════════════════════════════════════════════════════════
CONTENT PROVENANCE
═══════════════════════════════════════════════════════════════
All content is YOUR authentic experience and memories.
Created: $today
Cycle: Project Overview
Validation Status: [NEEDS MORE]
═══════════════════════════════════════════════════════════════
-->

## Project Metadata
- **Project Name:** $ProjectName
- **Scale:** [TODO: e.g., 1:35]
- **Dimensions:** [TODO: e.g., 30cm x 20cm x 15cm]
- **Start Date:** [TODO: YYYY-MM-DD]
- **Completion Date:** [TODO: YYYY-MM-DD or "In Progress"]
- **Total Hours:** [TODO: Approximate]
- **Inspiration:** [TODO: What inspired this project?]

## High-Level Summary
[TODO: Write 2-3 paragraph overview of entire project]

[TODO: Paragraph 1 - What is this project? What does it represent?]

[TODO: Paragraph 2 - Why did you build it? What was the goal?]

[TODO: Paragraph 3 - What makes it special or unique?]

## Key Features
[TODO: List 3-5 distinctive features of this project]
- Feature 1: [Description]
- Feature 2: [Description]
- Feature 3: [Description]

## Major Challenges
[TODO: What were the biggest challenges across the entire project?]
1. Challenge 1: [Description and how you overcame it]
2. Challenge 2: [Description and how you overcame it]
3. Challenge 3: [Description and how you overcame it]

## Key Learnings
[TODO: What did you learn from this project?]
- Learning 1: [Description]
- Learning 2: [Description]
- Learning 3: [Description]

## Build Log Structure
[TODO: List all build logs/phases]
- Build Log 1: [Phase name]
- Build Log 2: [Phase name]
- Build Log 3: [Phase name]

## Gallery Images Section
[To be populated after AI analysis in Phase 2]

**Source Images Path:** $ImageSourcePath
**Total Images:** [TBD after analysis]

---

## PHASE 2 PREPARATION NOTES

### Images to Analyze
- Path: $ImageSourcePath
- Count: [Run: ``Get-ChildItem -Path '$ImageSourcePath' -File | Measure-Object``]

### Analysis Plan
- [ ] Pass 1: Broad scan for descriptions
- [ ] Pass 2: Filter for gallery-quality images (high ratings, good composition)
- [ ] Pass 3: Focused analysis on best images for specific aspects
- [ ] Pass 4: Comparative analysis to choose absolute best
- [ ] Pass 5: Grouping recommendations for image sequences

---

## TODO CHECKLIST

### Phase 1: Framework (Current)
- [x] Framework document created
- [ ] All metadata fields completed
- [ ] High-level summary written
- [ ] Key features listed
- [ ] Major challenges documented
- [ ] Key learnings listed
- [ ] Build log structure outlined

### Phase 2: AI Analysis (Next)
- [ ] Images optimized and renamed
- [ ] Broad scan completed
- [ ] Best images identified
- [ ] Ratings and comparisons done
- [ ] Image sequences defined

### Phase 3: Analysis Integration
- [ ] AI appendix added to this document
- [ ] Image recommendations flagged
- [ ] Reference table created

### Phase 4: Personal Narrative
- [ ] All [TODO] markers replaced with content
- [ ] Personal captions written
- [ ] Context and stories added
- [ ] Final image selections made

### Phase 5: Validation
- [ ] Technical data verified
- [ ] Content completeness checked
- [ ] Images verified to exist
- [ ] Ready for page construction

### Phase 6: Page Construction
- [ ] Project page created
- [ ] Front matter populated
- [ ] Images copied to website
- [ ] Page tested locally

### Phase 7: Documentation
- [ ] Cycle record created
- [ ] Analysis data archived
- [ ] Lessons learned documented

---

*Source-narrative framework created: $today*
*Ready for Phase 1 content completion*
"@
} else {
    # Build Log framework
    $content = @"
# $ProjectName - SOURCE NARRATIVE - BUILD LOG $($BuildNumber.ToString("D2"))
## $BuildPhase

<!--
═══════════════════════════════════════════════════════════════
CONTENT PROVENANCE
═══════════════════════════════════════════════════════════════
All content is YOUR authentic experience and memories.
Created: $today
Cycle: Build Log $BuildNumber
Phase: $BuildPhase
Validation Status: [NEEDS MORE]
═══════════════════════════════════════════════════════════════
-->

## Build Log Metadata
- **Build Number:** $BuildNumber
- **Phase:** $BuildPhase
- **Timeline:** [TODO: Start date - End date]
- **Hours Spent:** [TODO: Approximate]
- **Primary Focus:** [TODO: What this phase accomplished in one sentence]

## Narrative

### What This Phase Was About
[TODO: Write 1-2 paragraph overview of what this build log covers]

[TODO: What was the goal of this phase?]

[TODO: Where did this fit in the overall project timeline?]

### The Work

[TODO: Describe what you did, step by step. Break into subsections if needed.]

#### [TODO: Subsection 1 - e.g., "Preparing Materials"]

[TODO: Content for this step]

[IMAGE: TODO-filename.jpg]
*Caption: [TO WRITE]*

#### [TODO: Subsection 2 - e.g., "Main Construction"]

[TODO: Content for this step]

[IMAGE: TODO-filename.jpg]
*Caption: [TO WRITE]*

#### [TODO: Subsection 3 - e.g., "Finishing Details"]

[TODO: Content for this step]

[IMAGE: TODO-filename.jpg]
*Caption: [TO WRITE]*

### Challenges and Solutions

[TODO: What went wrong and how did you fix it?]

**Challenge 1:** [Description]
**Solution:** [How you solved it]
**Learning:** [What you learned]

**Challenge 2:** [Description]
**Solution:** [How you solved it]
**Learning:** [What you learned]

### What I Learned

[TODO: Key insights from this phase]

1. [Learning point 1]
2. [Learning point 2]
3. [Learning point 3]

### Results

[TODO: What you accomplished in this phase]

[TODO: Describe the final state after this phase]

[IMAGE: TODO-final-result.jpg]
*Caption: [TO WRITE - final result of this phase]*

## Images for This Phase
**Source Folder:** $ImageSourcePath  
**Image Count:** [TBD after analysis]  
**Key Images:** [To be identified by AI analysis]

---

## PHASE 2 PREPARATION NOTES

### Images to Analyze
- Path: $ImageSourcePath
- Count: [Run: ``Get-ChildItem -Path '$ImageSourcePath' -File | Measure-Object``]

### Analysis Focus for This Build Log
[TODO: What aspects should AI focus on when analyzing?]
- Aspect 1: [e.g., "Foundation construction techniques"]
- Aspect 2: [e.g., "Material textures"]
- Aspect 3: [e.g., "Work in progress vs final states"]

### Analysis Plan
- [ ] Pass 1: Broad scan for descriptions
- [ ] Pass 2: Filter for images showing [key focus areas]
- [ ] Pass 3: Focused analysis on [specific aspect]
- [ ] Pass 4: Comparative analysis to rank similar images
- [ ] Pass 5: Grouping recommendations for sequences

---

## TODO CHECKLIST

### Phase 1: Framework (Current)
- [x] Framework document created
- [ ] All metadata fields completed
- [ ] Narrative overview written
- [ ] Work steps outlined
- [ ] Challenges documented
- [ ] Learnings listed
- [ ] Results described

### Phase 2: AI Analysis (Next)
- [ ] Images optimized and renamed
- [ ] Broad scan completed
- [ ] Best images identified
- [ ] Ratings and comparisons done
- [ ] Image sequences defined

### Phase 3: Analysis Integration
- [ ] AI appendix added to this document
- [ ] Image recommendations flagged
- [ ] Reference table created

### Phase 4: Personal Narrative
- [ ] All [TODO] markers replaced with content
- [ ] Personal captions written
- [ ] Context and stories added
- [ ] Final image selections made
- [ ] Authentic voice throughout

### Phase 5: Validation
- [ ] Technical data verified
- [ ] Content completeness checked
- [ ] Images verified to exist
- [ ] Cross-references accurate

### Phase 6: Page Construction
- [ ] Build log page created
- [ ] Front matter populated
- [ ] Images copied to website
- [ ] Page tested locally

### Phase 7: Documentation
- [ ] Cycle record created
- [ ] Analysis data archived
- [ ] Lessons learned documented

---

## NOTES

### Connection to Previous Build Log
[TODO: How does this connect to the previous phase?]

### Connection to Next Build Log
[TODO: What will the next phase cover?]

### Timeline Context
[TODO: What else was happening in your life during this phase? Time of year? Other projects?]

---

*Source-narrative framework created: $today*
*Ready for Phase 1 content completion*
"@
}

# Write file
$content | Out-File -FilePath $fullPath -Encoding utf8

Write-Host "`n✅ Source-narrative framework created successfully!" -ForegroundColor Green
Write-Host "`nFile: $fullPath" -ForegroundColor Cyan
Write-Host "`nCycle Type: $CycleType" -ForegroundColor Yellow

if ($CycleType -eq "build-log") {
    Write-Host "Build Number: $BuildNumber" -ForegroundColor Yellow
    Write-Host "Phase: $BuildPhase" -ForegroundColor Yellow
}

Write-Host "`nNext Steps:" -ForegroundColor Magenta
Write-Host "1. Open the file and complete all [TODO] markers"
Write-Host "2. Fill in the metadata fields"
Write-Host "3. Write the narrative content"
Write-Host "4. Proceed to Phase 2: AI Image Analysis"
Write-Host "`nPhase 1 Status: Framework Created ✓" -ForegroundColor Green
Write-Host "Phase 2 Next: Run analyze-images.ps1 for AI analysis" -ForegroundColor Cyan
