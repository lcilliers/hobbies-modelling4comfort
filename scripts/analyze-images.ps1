# analyze-images.ps1
# Analyzes images using Claude API to generate descriptions, alt text, and captions
# 
# Usage: .\analyze-images.ps1 -SourcePath "path\to\images" -OutputPath "path\to\output.csv"

param(
    [Parameter(Mandatory=$true)]
    [string]$SourcePath,
    
    [Parameter(Mandatory=$true)]
    [string]$OutputPath,
    
    [Parameter(Mandatory=$false)]
    [string]$ProjectName = "",
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("csv", "json")]
    [string]$OutputFormat = "csv",
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("description", "technical-critique", "technique-analysis", "improvement-suggestions", "custom")]
    [string]$AnalysisType = "description",
    
    [Parameter(Mandatory=$false)]
    [string]$CustomPrompt = ""
)

# Load API configuration
$configPath = Join-Path $PSScriptRoot "config.ps1"
if (-not (Test-Path $configPath)) {
    Write-Error "Config file not found at $configPath. Please create it from config.template.ps1"
    exit 1
}
. $configPath

if (-not $env:ANTHROPIC_API_KEY) {
    Write-Error "ANTHROPIC_API_KEY not set in config.ps1"
    exit 1
}

# Validate source path
if (-not (Test-Path $SourcePath)) {
    Write-Error "Source path not found: $SourcePath"
    exit 1
}

# Create output directory if needed
$outputDir = Split-Path $OutputPath -Parent
if ($outputDir -and -not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

# API endpoint
$apiUrl = "https://api.anthropic.com/v1/messages"
$headers = @{
    "x-api-key" = $env:ANTHROPIC_API_KEY
    "anthropic-version" = "2023-06-01"
    "content-type" = "application/json"
}

# Function to encode image as base64
function Get-ImageBase64 {
    param([string]$ImagePath)
    
    $bytes = [System.IO.File]::ReadAllBytes($ImagePath)
    return [Convert]::ToBase64String($bytes)
}

# Function to get media type from extension
function Get-MediaType {
    param([string]$Extension)
    
    switch ($Extension.ToLower()) {
        ".jpg"  { return "image/jpeg" }
        ".jpeg" { return "image/jpeg" }
        ".png"  { return "image/png" }
        ".gif"  { return "image/gif" }
        ".webp" { return "image/webp" }
        default { return "image/jpeg" }
    }
}

# Function to get analysis prompt based on type
function Get-AnalysisPrompt {
    param([string]$Type, [string]$Custom)
    
    switch ($Type) {
        "description" {
            return @"
Analyze this model-making/diorama image and provide:

1. A detailed description (2-3 sentences) of what is shown
2. Concise alt text for accessibility (1 sentence, max 125 characters)
3. A suggested caption for the image

Format your response as:
DESCRIPTION: [your description]
ALT_TEXT: [your alt text]
CAPTION: [your caption]
"@
        }
        "technical-critique" {
            return @"
Critically evaluate this model-making/diorama image focusing on technique and craftsmanship:

1. A summary of what techniques are visible
2. Technical strengths and what works well
3. Areas for improvement or technical issues
4. Overall assessment

Format your response as:
TECHNIQUES: [techniques identified]
STRENGTHS: [what works well]
IMPROVEMENTS: [areas to improve]
ASSESSMENT: [overall evaluation]
"@
        }
        "technique-analysis" {
            return @"
Analyze the model-making techniques shown in this image:

1. What specific techniques are being demonstrated (weathering, texturing, painting, etc.)
2. Materials that appear to be used
3. Skill level demonstrated
4. How the technique contributes to realism
P
Format your response as:
TECHNIQUES: [specific techniques]
MATERIALS: [materials identified]
SKILL_LEVEL: [beginner/intermediate/advanced]
EFFECTIVENESS: [how well it works]
"@
        }
        "improvement-suggestions" {
            return @"
Analyze this model-making/diorama image and provide constructive feedback:

1. Brief description of what's shown
2. What's working well
3. Specific suggestions for improvement
4. Recommended next steps or techniques to try

Format your response as:
SUMMARY: [brief description]
WORKING_WELL: [positive aspects]
SUGGESTIONS: [improvement ideas]
NEXT_STEPS: [recommendations]
"@
        }
        "custom" {
            if ($Custom) {
                return $Custom
            }
            else {
                Write-Error "Custom prompt text required when using -AnalysisType custom"
                exit 1
            }
        }
    }
}

# Function to analyze image with Claude
function Invoke-ImageAnalysis {
    param(
        [string]$ImagePath,
        [string]$FileName,
        [string]$Prompt
    )
    
    Write-Host "Analyzing: $FileName" -ForegroundColor Cyan
    
    $extension = [System.IO.Path]::GetExtension($ImagePath)
    $mediaType = Get-MediaType $extension
    $base64Image = Get-ImageBase64 $ImagePath

    $body = @{
        model = "claude-3-haiku-20240307"
        max_tokens = 2048
        messages = @(
            @{
                role = "user"
                content = @(
                    @{
                        type = "image"
                        source = @{
                            type = "base64"
                            media_type = $mediaType
                            data = $base64Image
                        }
                    }
                    @{
                        type = "text"
                        text = $prompt
                    }
                )
            }
        )
    } | ConvertTo-Json -Depth 10
    
    try {
        $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
        return $response.content[0].text
    }
    catch {
        Write-Warning "Failed to analyze $FileName : $_"
        return $null
    }
}

# Function to parse Claude's response
function Parse-AnalysisResponse {
    param(
        [string]$Response,
        [string]$AnalysisType
    )
    
    $result = @{}
    
    switch ($AnalysisType) {
        "description" {
            $result = @{
                Description = ""
                AltText = ""
                Caption = ""
            }
            if ($Response -match "DESCRIPTION:\s*(.+?)(?=ALT_TEXT:|$)") {
                $result.Description = $matches[1].Trim()
            }
            if ($Response -match "ALT_TEXT:\s*(.+?)(?=CAPTION:|$)") {
                $result.AltText = $matches[1].Trim()
            }
            if ($Response -match "CAPTION:\s*(.+?)$") {
                $result.Caption = $matches[1].Trim()
            }
        }
        "technical-critique" {
            $result = @{
                Techniques = ""
                Strengths = ""
                Improvements = ""
                Assessment = ""
            }
            if ($Response -match "TECHNIQUES:\s*(.+?)(?=STRENGTHS:|$)") {
                $result.Techniques = $matches[1].Trim()
            }
            if ($Response -match "STRENGTHS:\s*(.+?)(?=IMPROVEMENTS:|$)") {
                $result.Strengths = $matches[1].Trim()
            }
            if ($Response -match "IMPROVEMENTS:\s*(.+?)(?=ASSESSMENT:|$)") {
                $result.Improvements = $matches[1].Trim()
            }
            if ($Response -match "ASSESSMENT:\s*(.+?)$") {
                $result.Assessment = $matches[1].Trim()
            }
        }
        "technique-analysis" {
            $result = @{
                Techniques = ""
                Materials = ""
                SkillLevel = ""
                Effectiveness = ""
            }
            if ($Response -match "TECHNIQUES:\s*(.+?)(?=MATERIALS:|$)") {
                $result.Techniques = $matches[1].Trim()
            }
            if ($Response -match "MATERIALS:\s*(.+?)(?=SKILL_LEVEL:|$)") {
                $result.Materials = $matches[1].Trim()
            }
            if ($Response -match "SKILL_LEVEL:\s*(.+?)(?=EFFECTIVENESS:|$)") {
                $result.SkillLevel = $matches[1].Trim()
            }
            if ($Response -match "EFFECTIVENESS:\s*(.+?)$") {
                $result.Effectiveness = $matches[1].Trim()
            }
        }
        "improvement-suggestions" {
            $result = @{
                Summary = ""
                WorkingWell = ""
                Suggestions = ""
                NextSteps = ""
            }
            if ($Response -match "SUMMARY:\s*(.+?)(?=WORKING_WELL:|$)") {
                $result.Summary = $matches[1].Trim()
            }
            if ($Response -match "WORKING_WELL:\s*(.+?)(?=SUGGESTIONS:|$)") {
                $result.WorkingWell = $matches[1].Trim()
            }
            if ($Response -match "SUGGESTIONS:\s*(.+?)(?=NEXT_STEPS:|$)") {
                $result.Suggestions = $matches[1].Trim()
            }
            if ($Response -match "NEXT_STEPS:\s*(.+?)$") {
                $result.NextSteps = $matches[1].Trim()
            }
        }
        "custom" {
            $result = @{
                Response = $Response
            }
        }
    }
    
    return $result
}

# Get all image files
$imageExtensions = @("*.jpg", "*.jpeg", "*.png", "*.gif", "*.webp")
$images = Get-ChildItem -Path $SourcePath -Include $imageExtensions -Recurse

if ($images.Count -eq 0) {
    Write-Warning "No images found in $SourcePath"
    exit 0
}

Write-Host "`nFound $($images.Count) images to analyze" -ForegroundColor Green
Write-Host "Analysis Type: $AnalysisType" -ForegroundColor Green
Write-Host "Output will be saved to: $OutputPath`n" -ForegroundColor Green

# Get the analysis prompt
$analysisPrompt = Get-AnalysisPrompt -Type $AnalysisType -Custom $CustomPrompt

# Analyze each image
$results = @()
$counter = 0

foreach ($image in $images) {
    $counter++
    Write-Host "[$counter/$($images.Count)] " -NoNewline
    
    $response = Invoke-ImageAnalysis -ImagePath $image.FullName -FileName $image.Name -Prompt $analysisPrompt
    
    if ($response) {
        $parsed = Parse-AnalysisResponse -Response $response -AnalysisType $AnalysisType
        
        # Build result object dynamically based on parsed keys
        $resultObject = @{
            FileName = $image.Name
            FilePath = $image.FullName
            RelativePath = $image.FullName.Replace($SourcePath, "").TrimStart("\")
            Project = $ProjectName
            AnalyzedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        }
        
        # Add all parsed fields to result
        foreach ($key in $parsed.Keys) {
            $resultObject[$key] = $parsed[$key]
        }
        
        $results += [PSCustomObject]$resultObject
        
        Write-Host "  ✓ Complete" -ForegroundColor Green
    }
    else {
        Write-Host "  ✗ Failed" -ForegroundColor Red
    }
    
    # Small delay to respect rate limits
    Start-Sleep -Milliseconds 500
}

# Output results
if ($results.Count -gt 0) {
    if ($OutputFormat -eq "csv") {
        $results | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    }
    else {
        $results | ConvertTo-Json -Depth 3 | Out-File -FilePath $OutputPath -Encoding UTF8
    }
    
    Write-Host "`n✓ Analysis complete!" -ForegroundColor Green
    Write-Host "  Analyzed: $($results.Count) images" -ForegroundColor Cyan
    Write-Host "  Saved to: $OutputPath" -ForegroundColor Cyan
}
else {
    Write-Warning "No images were successfully analyzed"
}
