# Image Analysis with AI

## Overview

This guide explains how to use AI-powered image analysis to automatically generate descriptions, alt text, captions, and technical critiques of your model-making images.

## What We Built

A PowerShell script (`analyze-images.ps1`) that:
- Processes entire folders of project images
- Sends images to Claude AI for analysis
- Generates structured output (CSV or JSON)
- Integrates with existing workflow and scripts
- Supports multiple analysis modes

## Setup

### 1. Get an Anthropic API Key

1. Visit [console.anthropic.com](https://console.anthropic.com)
2. Create an account or sign in
3. Navigate to API Keys section
4. Generate a new key (format: `sk-ant-api03-...`)
5. Keep it secure - never share or commit to version control

**Cost:** Pay-as-you-go. Roughly $3 per 1,000 images with Claude 3.5 Sonnet.

### 1b. Set Up Billing (REQUIRED)

⚠️ **CRITICAL:** API keys won't work without billing setup, even if generated.

1. In [console.anthropic.com](https://console.anthropic.com), go to **Settings** → **Billing**
2. Add a payment method (credit card required)
3. Add initial credits (minimum $10 recommended)
4. Billing activates immediately - no need to regenerate API key

**Without billing:** All API requests will fail with `not_found_error` for models.

### 2. Configure the API Key

1. Copy `scripts/config.template.ps1` to `scripts/config.ps1`
2. Open `config.ps1` and add your API key:
   ```powershell
   $env:ANTHROPIC_API_KEY = "sk-ant-api03-your-actual-key-here"
   ```
3. Save the file (it's already in `.gitignore` for security)

## Usage

### Basic Image Description

Generate descriptions, alt text, and captions:

```powershell
.\scripts\analyze-images.ps1 `
    -SourcePath "assets\images\henrhyd-falls" `
    -OutputPath "output\henrhyd-falls-descriptions.csv"
```

### Technical Critique

Get critical evaluation of techniques and craftsmanship:

```powershell
.\scripts\analyze-images.ps1 `
    -SourcePath "assets\images\log-cabin" `
    -OutputPath "output\log-cabin-critique.csv" `
    -AnalysisType technical-critique `
    -ProjectName "log-cabin"
```

### Technique Analysis

Identify specific techniques, materials, and skill levels:

```powershell
.\scripts\analyze-images.ps1 `
    -SourcePath "assets\images\bookshop-memories" `
    -OutputPath "output\bookshop-techniques.csv" `
    -AnalysisType technique-analysis
```

### Improvement Suggestions

Get constructive feedback and recommendations:

```powershell
.\scripts\analyze-images.ps1 `
    -SourcePath "assets\images\sea-rescue" `
    -OutputPath "output\sea-rescue-feedback.csv" `
    -AnalysisType improvement-suggestions
```

### Custom Analysis

Use your own prompt for specific analysis needs:

```powershell
.\scripts\analyze-images.ps1 `
    -SourcePath "assets\images\project" `
    -OutputPath "output\custom-analysis.csv" `
    -AnalysisType custom `
    -CustomPrompt "Describe the weathering techniques used and rate their realism from 1-10"
```

### JSON Output

Get results in JSON format instead of CSV:

```powershell
.\scripts\analyze-images.ps1 `
    -SourcePath "assets\images\project" `
    -OutputPath "output\results.json" `
    -OutputFormat json
```

## Analysis Types

### `description` (default)
- Detailed description (2-3 sentences)
- Alt text for accessibility (max 125 characters)
- Suggested caption

**Output fields:** `Description`, `AltText`, `Caption`

### `technical-critique`
- Techniques identified
- Technical strengths
- Areas for improvement
- Overall assessment

**Output fields:** `Techniques`, `Strengths`, `Improvements`, `Assessment`

### `technique-analysis`
- Specific techniques demonstrated
- Materials identified
- Skill level (beginner/intermediate/advanced)
- Effectiveness rating

**Output fields:** `Techniques`, `Materials`, `SkillLevel`, `Effectiveness`

### `improvement-suggestions`
- Brief summary
- What's working well
- Improvement suggestions
- Recommended next steps

**Output fields:** `Summary`, `WorkingWell`, `Suggestions`, `NextSteps`

### `custom`
- Use your own prompt
- Requires `-CustomPrompt` parameter
- Results depend on your prompt structure

## Output Format

### CSV Example
```csv
FileName,FilePath,RelativePath,Project,Description,AltText,Caption,AnalyzedDate
image-001.jpg,C:\path\to\image-001.jpg,image-001.jpg,log-cabin,"Description text","Alt text","Caption",2026-01-11 15:30:00
```

### JSON Example
```json
[
  {
    "FileName": "image-001.jpg",
    "FilePath": "C:\\path\\to\\image-001.jpg",
    "RelativePath": "image-001.jpg",
    "Project": "log-cabin",
    "Description": "Description text",
    "AltText": "Alt text",
    "Caption": "Caption",
    "AnalyzedDate": "2026-01-11 15:30:00"
  }
]
```

## Supported Image Formats

- JPEG (`.jpg`, `.jpeg`)
- PNG (`.png`)
- GIF (`.gif`)
- WebP (`.webp`)

## Features

- **Recursive folder scanning** - Finds all images in subdirectories
- **Progress tracking** - Shows current image and success/failure
- **Error handling** - Continues processing if individual images fail
- **Rate limiting** - Built-in delays to respect API quotas
- **Relative paths** - Maintains folder structure in output

## Integration with Existing Workflow

The script follows the same patterns as other scripts in `scripts/`:
- Uses parameter validation
- Provides clear error messages
- Outputs structured data for further processing
- Can be combined with other scripts in automation pipelines

## Next Steps

1. Use CSV output to populate Jekyll front matter
2. Create automated workflows for new project images
3. Build a database of analyzed images
4. Generate accessibility documentation automatically

## Best Practices for Effective Analysis

### Model Selection and Compatibility

**Current Working Model:** `claude-3-haiku-20240307`
- Fast and cost-effective
- Good for descriptive analysis
- May not follow strict structured formats perfectly

**If your account has access:**
- `claude-3-5-sonnet-20241022` - Best quality (check availability)
- `claude-3-opus-20240229` - Highest accuracy (premium)

**Testing Model Access:**
```powershell
# Test if a model is available to your account
. .\scripts\config.ps1
$headers = @{"x-api-key" = $env:ANTHROPIC_API_KEY; "anthropic-version" = "2023-06-01"; "content-type" = "application/json"}
$testBody = '{"model":"claude-3-haiku-20240307","max_tokens":50,"messages":[{"role":"user","content":"Hello"}]}'
Invoke-RestMethod -Uri "https://api.anthropic.com/v1/messages" -Method Post -Headers $headers -Body $testBody
```

### Prompting Strategies

#### 1. Start Broad, Then Focus

**First Pass - General Description:**
```powershell
.\scripts\analyze-images.ps1 `
    -SourcePath "path\to\images" `
    -OutputPath "descriptions.csv" `
    -AnalysisType description
```

**Second Pass - Focused Technical Analysis:**
```powershell
# Copy specific images to temp folder for focused analysis
.\scripts\analyze-images.ps1 `
    -SourcePath "path\to\selected\images" `
    -OutputPath "technical-analysis.csv" `
    -AnalysisType custom `
    -CustomPrompt "Your focused question here"
```

#### 2. Use Custom Prompts for Best Results

**Why Custom Prompts Work Better:**
- More flexible than structured formats
- AI can respond naturally without parsing issues
- Better for specific, targeted questions
- Easier to iterate and refine

**Effective Custom Prompt Structure:**
```powershell
-CustomPrompt "Focus ONLY on [specific feature]. 
Answer these questions: 
1) [Specific question with rating if applicable]
2) [Specific question with rating if applicable]
3) [Specific question with rating if applicable]
Be specific and technical."
```

**Example - Waterfall Analysis:**
```powershell
.\scripts\analyze-images.ps1 `
    -SourcePath "falls-images\" `
    -OutputPath "waterfall-analysis.csv" `
    -AnalysisType custom `
    -CustomPrompt "Focus ONLY on the waterfall feature. Answer: 1) What materials are used? 2) How effectively does it show water flow? (rate 1-10) 3) How well does it show the top/source? (rate 1-10) 4) Overall quality? (rate 1-10)"
```

#### 3. Include Rating Scales

**Why Ratings Help:**
- Makes comparisons easier
- Provides quantifiable data
- Helps identify best images quickly

**Good Rating Prompts:**
- "Rate effectiveness 1-10"
- "Overall quality score out of 10"
- "How realistic? (1-10 scale)"

#### 4. Filter and Iterate

**Workflow for Finding Best Images:**

1. **Initial broad scan:**
```powershell
.\scripts\analyze-images.ps1 -SourcePath "all-images" -OutputPath "scan.csv" -AnalysisType description
```

2. **Filter in PowerShell:**
```powershell
$csv = Import-Csv "scan.csv"
$waterfall = $csv | Where-Object {$_.Caption -like "*waterfall*"}
$waterfall | Select-Object FileName, Caption
```

3. **Copy filtered images:**
```powershell
$selected = @("image-001.jpg", "image-005.jpg", "image-012.jpg")
$tempFolder = "temp-analysis"
New-Item -ItemType Directory -Path $tempFolder -Force
foreach ($img in $selected) {
    Copy-Item "source\$img" -Destination $tempFolder
}
```

4. **Deep analysis:**
```powershell
.\scripts\analyze-images.ps1 -SourcePath $tempFolder -OutputPath "detailed.csv" -AnalysisType custom -CustomPrompt "your detailed prompt"
```

### Handling Analysis Results

#### CSV Analysis in PowerShell

**Display formatted results:**
```powershell
$csv = Import-Csv "results.csv"
foreach ($row in $csv) {
    Write-Host "`nIMAGE: $($row.FileName)" -ForegroundColor Yellow
    Write-Host $row.Response
}
```

**Find highest-rated images:**
```powershell
# Assuming ratings in Response field
$csv | Where-Object {$_.Response -like "*10 out of 10*"} | Select-Object FileName
```

**Compare multiple analyses:**
```powershell
$desc = Import-Csv "descriptions.csv"
$tech = Import-Csv "technical.csv"
$combined = $desc | Select-Object FileName, Caption, @{N='TechAnalysis';E={($tech | Where-Object {$_.FileName -eq $_.FileName}).Response}}
```

### Common Issues and Solutions

#### Issue: "overloaded_error"
**Cause:** API rate limiting or temporary overload
**Solution:** 
- Add longer delay in script (increase `Start-Sleep` value)
- Retry failed images separately
- Process smaller batches

#### Issue: Empty fields in structured analysis
**Cause:** AI not following exact format
**Solution:**
- Use `-AnalysisType custom` instead
- Simplify prompt structure
- Ask direct questions without format requirements

#### Issue: Inconsistent quality
**Cause:** Prompt ambiguity or model limitations
**Solution:**
- Be more specific in prompts
- Use rating scales (1-10)
- Focus on one aspect per analysis pass
- Try different model if available

### Cost Management

**Typical Costs (Claude Haiku):**
- ~$0.25 per 1,000 input tokens
- ~$1.25 per 1,000 output tokens
- Average: $0.10-0.15 per image (depends on prompt length)

**Cost Optimization:**
- Process only images that need analysis
- Use shorter prompts when possible
- Filter broadly first, then analyze deeply
- Archive analysis results to avoid re-processing

## Security Notes

- Never commit `config.ps1` to version control
- Keep your API key secure
- `.gitignore` in `scripts/` folder protects the config file
- Review API usage on Anthropic console to monitor costs

## Session Summary (2026-01-11)

**Objective:** Enable AI-powered batch analysis of project images

**What was created:**
1. `scripts/config.template.ps1` - Template for API key storage
2. `scripts/.gitignore` - Protects actual config from version control
3. `scripts/analyze-images.ps1` - Main analysis script with 5 analysis modes
4. This documentation file

**Key decisions:**
- Use Anthropic Claude API (3.5 Sonnet) for image analysis
- PowerShell script for integration with existing workflow
- Secure API key storage via environment variables
- Multiple analysis modes for different use cases
- Structured output (CSV/JSON) for downstream processing

---

*Last updated: 2026-01-11*
