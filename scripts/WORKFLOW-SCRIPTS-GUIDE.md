# Workflow Scripts for Source-Narrative with AI Analysis

This directory contains PowerShell scripts to support the iterative cycle-based workflow for creating project documentation with AI image analysis.

**Methodology:** See [docs/methodology/SOURCE-NARRATIVE-WITH-AI-ANALYSIS.md](../docs/methodology/SOURCE-NARRATIVE-WITH-AI-ANALYSIS.md)

---

## Quick Reference

### Complete Workflow

```powershell
# Phase 0: Preparation
.\imagemagick-optimize.ps1 -SourceFolder "\\server\photos\project\build1" -OutputSubFolder "\\server\photos\project\web-optimized\build1"
# Then rename images manually

# Phase 1: Framework Creation
.\new-source-narrative.ps1 -ProjectName "project-name" -CycleType "build-log" -BuildNumber 1 -BuildPhase "Phase Name" -ImageSourcePath "\\server\photos\project\web-optimized\build1"

# Phase 2: AI Analysis (multiple passes)
.\analyze-images.ps1 -SourcePath "\\server\photos\project\web-optimized\build1" -OutputPath "\\server\photos\project\analysis\build1-descriptions.csv" -AnalysisType description
.\analyze-images.ps1 -SourcePath "\\temp\filtered" -OutputPath "\\server\photos\project\analysis\detailed.csv" -AnalysisType custom -CustomPrompt "Your focused prompt here"

# Phase 3-4: Manual (integration and personal narrative)

# Phase 5: Validation
.\validate-source-narrative.ps1 -SourceNarrativePath ".\projects-working\source-narratives\project-build-01.md" -ImageBasePath "\\server\photos\project\web-optimized\build1"

# Phase 6: Page Construction
# (To be created)

# Phase 7: Archive
.\archive-cycle-data.ps1 -ProjectName "project-name" -CycleNumber 1 -AnalysisPath "\\server\photos\project\analysis"
```

---

## Scripts by Phase

### Phase 0: Preparation

#### `imagemagick-optimize.ps1` ✅ EXISTS
**Purpose:** Optimize and resize images for web use

**Usage:**
```powershell
.\imagemagick-optimize.ps1 `
    -SourceFolder "\\server\photos\log-cabin\build1" `
    -OutputSubFolder "\\server\photos\log-cabin\web-optimized\build1" `
    -MaxWidth 800 `
    -MaxHeight 800 `
    -JpegQuality 85

# For gallery images, use higher quality
.\imagemagick-optimize.ps1 `
    -SourceFolder "\\server\photos\log-cabin\gallery" `
    -OutputSubFolder "\\server\photos\log-cabin\web-optimized\gallery" `
    -MaxWidth 1600 `
    -MaxHeight 1600 `
    -JpegQuality 90
```

**Output:** Optimized images in web-optimized folder

**Image Renaming (Manual):**
After optimization, rename to convention: `[prefix]-[category]-[###].jpg`

```powershell
# Navigate to optimized folder
cd "\\server\photos\project\web-optimized\build1"

# Rename files
$files = Get-ChildItem -File | Sort-Object Name
$counter = 1
foreach ($file in $files) {
    $newName = "proj-build1-{0:D3}.jpg" -f $counter
    Rename-Item -Path $file.FullName -NewName $newName
    $counter++
}
```

---

### Phase 1: Framework Creation

#### `new-source-narrative.ps1` ✅ CREATED
**Purpose:** Generate source-narrative framework document

**Usage for Project Overview:**
```powershell
.\new-source-narrative.ps1 `
    -ProjectName "log-cabin" `
    -CycleType "project-overview" `
    -ImageSourcePath "\\server\photos\log-cabin\web-optimized\gallery"
```

**Usage for Build Log:**
```powershell
.\new-source-narrative.ps1 `
    -ProjectName "log-cabin" `
    -CycleType "build-log" `
    -BuildNumber 1 `
    -BuildPhase "Foundation and Base Construction" `
    -ImageSourcePath "\\server\photos\log-cabin\web-optimized\build1"
```

**Output:** Markdown file in `projects-working/source-narratives/`
- Project overview: `project-name-SOURCE-NARRATIVE-overview.md`
- Build log: `project-name-SOURCE-NARRATIVE-build-##.md`

**Next Steps:**
1. Open the generated file
2. Fill in all `[TODO]` markers
3. Complete metadata fields
4. Write narrative content
5. Proceed to Phase 2

---

### Phase 2: AI Analysis

#### `analyze-images.ps1` ✅ EXISTS
**Purpose:** AI-powered image analysis with multiple modes

**Configuration:**
First-time setup requires API key in `config.ps1` (see [docs/guides/image-analysis-with-ai.md](../docs/guides/image-analysis-with-ai.md))

**Pass 1: Broad Scan (Descriptions)**
```powershell
.\analyze-images.ps1 `
    -SourcePath "\\server\photos\log-cabin\web-optimized\build1" `
    -OutputPath "\\server\photos\log-cabin\analysis\build1-descriptions.csv" `
    -AnalysisType description `
    -ProjectName "log-cabin"
```

Output fields: FileName, Description, AltText, Caption

**View results:**
```powershell
$csv = Import-Csv "\\server\photos\log-cabin\analysis\build1-descriptions.csv"
$csv | Select-Object FileName, Description | Format-Table -Wrap
```

**Pass 2: Content Filtering**
```powershell
# Filter by keyword
$csv = Import-Csv "build1-descriptions.csv"
$foundation = $csv | Where-Object { $_.Description -like "*foundation*" }

# Copy filtered images to temp folder for focused analysis
$tempFolder = "\\server\photos\log-cabin\analysis\temp-foundation"
New-Item -ItemType Directory -Path $tempFolder -Force | Out-Null
foreach ($img in $foundation) {
    Copy-Item "\\server\photos\log-cabin\web-optimized\build1\$($img.FileName)" -Destination $tempFolder
}
```

**Pass 3: Focused Analysis (Custom Prompts)**
```powershell
.\analyze-images.ps1 `
    -SourcePath "\\server\photos\log-cabin\analysis\temp-foundation" `
    -OutputPath "\\server\photos\log-cabin\analysis\foundation-detailed.csv" `
    -AnalysisType custom `
    -CustomPrompt "Analyze the foundation construction shown. Focus on: 1) What materials are visible? 2) What construction techniques are demonstrated? 3) How effective is this photo at showing the process? (rate 1-10) 4) What stage of construction is shown? Be specific and technical." `
    -ProjectName "log-cabin"
```

Output field: FileName, Response (contains full AI analysis)

**Pass 4: Comparative Analysis (Ratings)**
```powershell
# Copy similar images to compare
$cabinImages = $csv | Where-Object {$_.Description -like "*cabin*"}
$compareFolder = "\\server\photos\log-cabin\analysis\temp-cabin-compare"
New-Item -ItemType Directory -Path $compareFolder -Force | Out-Null
foreach ($img in $cabinImages) {
    Copy-Item "\\server\photos\log-cabin\web-optimized\build2\$($img.FileName)" -Destination $compareFolder
}

# Analyze with rating scales
.\analyze-images.ps1 `
    -SourcePath $compareFolder `
    -OutputPath "\\server\photos\log-cabin\analysis\cabin-comparison.csv" `
    -AnalysisType custom `
    -CustomPrompt "Rate this image for showing cabin construction: 1) How clear is the cabin structure? (1-10) 2) How well does it show construction details? (1-10) 3) Photo quality and lighting? (1-10) 4) Overall usefulness for documentation? (1-10) 5) Which specific aspect of cabin construction does this best illustrate?" `
    -ProjectName "log-cabin"
```

**View ratings:**
```powershell
$comparison = Import-Csv "cabin-comparison.csv"
foreach ($row in $comparison) {
    Write-Host "`nIMAGE: $($row.FileName)" -ForegroundColor Yellow
    Write-Host $row.Response
}
```

**Pass 5: Grouping Analysis (Sequences)**
```powershell
.\analyze-images.ps1 `
    -SourcePath "\\server\photos\log-cabin\web-optimized\build3" `
    -OutputPath "\\server\photos\log-cabin\analysis\build3-sequences.csv" `
    -AnalysisType custom `
    -CustomPrompt "Identify if this image is part of a sequence or progression. Answer: 1) What stage or step does this show? 2) Is this a before, during, or after shot? 3) What other images would pair well with this? 4) Would this work better alone or as part of a series?" `
    -ProjectName "log-cabin"
```

**Best Practices:**
- Use `description` type for initial broad scan
- Use `custom` with specific questions for focused analysis
- Include rating scales (1-10) in custom prompts for easy comparison
- Filter images between passes to focus analysis
- Multi-pass approach: broad → filter → focused → compare
- See [docs/guides/image-analysis-with-ai.md](../docs/guides/image-analysis-with-ai.md) for detailed best practices

**Cost Management:**
- Haiku model: ~$0.10-0.15 per image
- 20 images ≈ $2-3
- Filter before expensive passes
- Start with small batches to test prompts

---

### Phase 3: Analysis Integration

**Manual Process:** Add AI findings to source-narrative document

1. Create AI Analysis Appendix section
2. Add image recommendations with ratings
3. Create image reference table
4. Flag recommended images in narrative

See methodology document for detailed format and examples.

---

### Phase 4: Personal Narrative

**Manual Process:** Add your voice and context

1. Review AI recommendations
2. Make accept/reject/modify decisions
3. Write personal captions
4. Add non-visual context (emotions, challenges, learnings)
5. Document reasoning for image choices

**This is the most important phase** - where authenticity comes from.

---

### Phase 5: Validation

#### `validate-source-narrative.ps1` ✅ CREATED
**Purpose:** Validate source-narrative completeness and accuracy

**Usage:**
```powershell
.\validate-source-narrative.ps1 `
    -SourceNarrativePath ".\projects-working\source-narratives\log-cabin-SOURCE-NARRATIVE-build-01.md" `
    -ImageBasePath "\\server\photos\log-cabin\web-optimized\build1"
```

**With strict mode (warnings as errors):**
```powershell
.\validate-source-narrative.ps1 `
    -SourceNarrativePath ".\projects-working\source-narratives\log-cabin-SOURCE-NARRATIVE-build-01.md" `
    -ImageBasePath "\\server\photos\log-cabin\web-optimized\build1" `
    -Strict
```

**What it checks:**
1. Image references - All referenced images exist
2. Placeholder markers - No `[TODO]` or `[TO WRITE]` remain
3. Captions - All images have completed captions
4. Metadata - Required fields filled in
5. Content completeness - Key sections present, substantial content
6. Validation status - Document marked appropriately

**Exit codes:**
- `0` = Validation passed
- `1` = Validation failed

**Output:** Detailed validation report with:
- ✅ Passed checks
- ⚠️ Warnings (allowed unless `-Strict`)
- ❌ Errors (must fix before proceeding)

---

### Phase 6: Page Construction

#### `build-project-page.ps1` 🚧 TO BE CREATED
**Purpose:** Convert source-narrative to Jekyll project page

**Planned Usage:**
```powershell
.\build-project-page.ps1 `
    -SourceNarrative ".\projects-working\source-narratives\log-cabin-SOURCE-NARRATIVE-overview.md" `
    -OutputPath "_projects\log-cabin.md" `
    -ImageDestination "assets\images\projects\log-cabin"
```

#### `build-build-log-page.ps1` 🚧 TO BE CREATED
**Purpose:** Convert source-narrative to Jekyll build log page

**Planned Usage:**
```powershell
.\build-build-log-page.ps1 `
    -SourceNarrative ".\projects-working\source-narratives\log-cabin-SOURCE-NARRATIVE-build-01.md" `
    -OutputPath "_builds\log-cabin\001-foundation-and-base.md" `
    -ImageDestination "assets\images\builds\log-cabin\build1"
```

**What these will do:**
1. Parse source-narrative markdown
2. Extract metadata and content
3. Generate Jekyll front matter
4. Convert image markers to Jekyll syntax
5. Copy images to website assets
6. Create properly formatted page

**Manual Alternative:**
Until scripts are created, manually:
1. Create Jekyll page file
2. Copy front matter template
3. Extract content from source-narrative
4. Convert `[IMAGE: filename]` to `![Alt]({{ page.image_folder }}filename)`
5. Copy images to assets folder

---

### Phase 7: Cycle Documentation

#### `archive-cycle-data.ps1` ✅ CREATED
**Purpose:** Archive AI analysis data and create cycle record

**Usage:**
```powershell
.\archive-cycle-data.ps1 `
    -ProjectName "log-cabin" `
    -CycleNumber 1 `
    -AnalysisPath "\\server\photos\log-cabin\analysis"
```

**What it does:**
1. Creates archive directory: `analysis\archive\cycle-##-YYYY-MM-DD\`
2. Copies all CSV files to `csv-files\` subfolder
3. Copies all temp folders to `temp-folders\` subfolder
4. Creates `INDEX.md` with contents listing
5. Creates `STATISTICS.md` with analysis metrics
6. Optionally removes source files after archiving

**Output structure:**
```
analysis\archive\cycle-01-2026-01-11\
├── csv-files\
│   ├── build1-descriptions.csv
│   ├── foundation-detailed.csv
│   └── cabin-comparison.csv
├── temp-folders\
│   ├── temp-foundation\
│   └── temp-cabin-compare\
├── INDEX.md
└── STATISTICS.md
```

**Archive contents:**
- INDEX.md: Complete listing of archived files
- STATISTICS.md: Analysis metrics (image count, cost estimate, efficiency)
- All CSV analysis results
- All temporary image folders

**Use archived data to:**
- Compare analysis approaches across cycles
- Reference past image selections
- Track analysis costs over time
- Improve prompts for future cycles

---

## Common Workflows

### Starting a New Project Overview Cycle

```powershell
# 1. Optimize gallery images
.\imagemagick-optimize.ps1 -SourceFolder "\\server\photos\project\gallery" -OutputSubFolder "\\server\photos\project\web-optimized\gallery" -MaxWidth 1600 -JpegQuality 90

# 2. Rename images (manual)
cd "\\server\photos\project\web-optimized\gallery"
# Rename to: project-gallery-001.jpg, etc.

# 3. Create framework
.\new-source-narrative.ps1 -ProjectName "project" -CycleType "project-overview" -ImageSourcePath "\\server\photos\project\web-optimized\gallery"

# 4. AI analysis
.\analyze-images.ps1 -SourcePath "\\server\photos\project\web-optimized\gallery" -OutputPath "\\server\photos\project\analysis\gallery-descriptions.csv" -AnalysisType description

# 5. Continue with methodology phases 3-7
```

### Starting a New Build Log Cycle

```powershell
# 1. Optimize build images
.\imagemagick-optimize.ps1 -SourceFolder "\\server\photos\project\build1" -OutputSubFolder "\\server\photos\project\web-optimized\build1"

# 2. Rename images (manual)
cd "\\server\photos\project\web-optimized\build1"
# Rename to: project-build1-001.jpg, etc.

# 3. Create framework
.\new-source-narrative.ps1 -ProjectName "project" -CycleType "build-log" -BuildNumber 1 -BuildPhase "Foundation" -ImageSourcePath "\\server\photos\project\web-optimized\build1"

# 4. Multi-pass AI analysis (see Phase 2 above)

# 5. Continue with methodology phases 3-7
```

### Complete Cycle with Validation

```powershell
# After personal narrative (Phase 4), validate before page construction
.\validate-source-narrative.ps1 -SourceNarrativePath ".\projects-working\source-narratives\project-build-01.md" -ImageBasePath "\\server\photos\project\web-optimized\build1"

# If validation passes, proceed to Phase 6 (page construction)
# Then archive
.\archive-cycle-data.ps1 -ProjectName "project" -CycleNumber 1 -AnalysisPath "\\server\photos\project\analysis"
```

---

## Troubleshooting

### API Issues
**Problem:** Authentication errors  
**Solution:** Check [docs/guides/image-analysis-with-ai.md](../docs/guides/image-analysis-with-ai.md) for API setup

### Image Not Found Errors
**Problem:** Validation shows missing images  
**Solution:** 
- Check image paths in source-narrative match actual files
- Ensure images follow naming convention
- Verify ImageBasePath parameter is correct

### Empty AI Responses
**Problem:** CSV fields are empty  
**Solution:**
- Use `custom` analysis type with direct questions
- Include rating scales for structure
- Check API credits/billing

### Validation Fails
**Problem:** Script reports errors  
**Solution:**
- Review error list carefully
- Fix all `[TODO]` markers
- Complete all captions
- Use `-Strict` mode to catch warnings

---

## Script Status

| Script | Status | Phase | Priority |
|--------|--------|-------|----------|
| imagemagick-optimize.ps1 | ✅ EXISTS | 0 | - |
| new-source-narrative.ps1 | ✅ CREATED | 1 | High |
| analyze-images.ps1 | ✅ EXISTS | 2 | - |
| validate-source-narrative.ps1 | ✅ CREATED | 5 | High |
| build-project-page.ps1 | 🚧 TO CREATE | 6 | Medium |
| build-build-log-page.ps1 | 🚧 TO CREATE | 6 | Medium |
| archive-cycle-data.ps1 | ✅ CREATED | 7 | High |

---

## Additional Resources

- **Methodology:** [docs/methodology/SOURCE-NARRATIVE-WITH-AI-ANALYSIS.md](../docs/methodology/SOURCE-NARRATIVE-WITH-AI-ANALYSIS.md)
- **AI Analysis Guide:** [docs/guides/image-analysis-with-ai.md](../docs/guides/image-analysis-with-ai.md)
- **ImageMagick Guide:** [docs/guides/IMAGEMAGICK-GUIDE.md](../docs/guides/IMAGEMAGICK-GUIDE.md)
- **Image Workflows:** [assets/images/README.md](../assets/images/README.md)

---

**Last Updated:** 2026-01-11  
**Workflow Version:** 2.0 - AI-Enhanced Iterative Cycles  
**Maintained By:** Models4Comfort Project
