<#
.SYNOPSIS
    Creates a new build log from the template.

.DESCRIPTION
    This script copies the TEMPLATE-build-log.md file to create a new build log entry.
    It automatically:
    - Creates the project folder if it doesn't exist
    - Copies the template to the new location
    - Optionally opens the file in VS Code for editing
    - Updates the front matter with provided values

.PARAMETER ProjectName
    The project slug (e.g., "ss-great-britain", "gorch-fock")
    This will be used as the folder name under _builds/

.PARAMETER BuildNumber
    The build log number (e.g., 1, 2, 3, etc.)
    Will be formatted as 001, 002, 003 in the filename

.PARAMETER Title
    A short descriptive title for this build log (e.g., "hull-construction", "rigging-begins")
    Use hyphens instead of spaces

.PARAMETER Date
    The date for the build log in YYYY-MM-DD format
    Defaults to today's date if not specified

.PARAMETER OpenInEditor
    If specified, opens the new file in VS Code after creation

.EXAMPLE
    .\scripts\new-build-log.ps1 -ProjectName "ss-great-britain" -BuildNumber 2 -Title "hull-construction"
    Creates _builds/ss-great-britain/002-hull-construction.md

.EXAMPLE
    .\scripts\new-build-log.ps1 -ProjectName "gorch-fock" -BuildNumber 1 -Title "kit-review" -Date "2025-12-01" -OpenInEditor
    Creates the file with a specific date and opens it in VS Code

.EXAMPLE
    .\scripts\new-build-log.ps1 -ProjectName "new-project" -BuildNumber 1 -Title "planning"
    Creates _builds/new-project/ folder and the first build log
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, HelpMessage="Project slug (e.g., 'ss-great-britain')")]
    [ValidatePattern('^[a-z0-9-]+$')]
    [string]$ProjectName,
    
    [Parameter(Mandatory=$true, HelpMessage="Build log number (e.g., 1, 2, 3)")]
    [ValidateRange(1, 999)]
    [int]$BuildNumber,
    
    [Parameter(Mandatory=$true, HelpMessage="Short title with hyphens (e.g., 'hull-construction')")]
    [ValidatePattern('^[a-z0-9-]+$')]
    [string]$Title,
    
    [Parameter(Mandatory=$false, HelpMessage="Date in YYYY-MM-DD format")]
    [ValidatePattern('^\d{4}-\d{2}-\d{2}$')]
    [string]$Date = (Get-Date -Format "yyyy-MM-dd"),
    
    [Parameter(Mandatory=$false)]
    [switch]$OpenInEditor
)

# Script configuration
$ErrorActionPreference = "Stop"
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptPath

# Paths
$templatePath = Join-Path $repoRoot "_builds\TEMPLATE-build-log.md"
$buildsRoot = Join-Path $repoRoot "_builds"
$projectFolder = Join-Path $buildsRoot $ProjectName

# Format the build number with leading zeros
$buildNumberFormatted = "{0:D3}" -f $BuildNumber

# Create the filename
$filename = "$buildNumberFormatted-$Title.md"
$newFilePath = Join-Path $projectFolder $filename

# Validate template exists
if (-not (Test-Path $templatePath)) {
    Write-Error "Template file not found at: $templatePath"
    Write-Error "Make sure you're running this script from the repository root or scripts folder."
    exit 1
}

# Check if file already exists
if (Test-Path $newFilePath) {
    Write-Warning "File already exists: $newFilePath"
    $overwrite = Read-Host "Do you want to overwrite it? (y/N)"
    if ($overwrite -ne 'y' -and $overwrite -ne 'Y') {
        Write-Host "Operation cancelled." -ForegroundColor Yellow
        exit 0
    }
}

# Create project folder if it doesn't exist
if (-not (Test-Path $projectFolder)) {
    Write-Host "Creating project folder: $projectFolder" -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $projectFolder -Force | Out-Null
    Write-Host "✓ Folder created" -ForegroundColor Green
}

# Copy template to new location
Write-Host "`nCreating new build log..." -ForegroundColor Cyan
Write-Host "  Project: $ProjectName" -ForegroundColor Gray
Write-Host "  Number:  #$BuildNumber ($buildNumberFormatted)" -ForegroundColor Gray
Write-Host "  Title:   $Title" -ForegroundColor Gray
Write-Host "  Date:    $Date" -ForegroundColor Gray
Write-Host "  File:    $filename" -ForegroundColor Gray

Copy-Item -Path $templatePath -Destination $newFilePath -Force

# Update the front matter in the new file
$content = Get-Content $newFilePath -Raw

# Generate a proper title from the parts
$titleWords = $Title -split '-' | ForEach-Object { 
    $_.Substring(0,1).ToUpper() + $_.Substring(1) 
}
$projectDisplayName = ($ProjectName -split '-' | ForEach-Object { 
    $_.Substring(0,1).ToUpper() + $_.Substring(1) 
}) -join ' '
$properTitle = "$projectDisplayName - Build Log #$BuildNumber`: $($titleWords -join ' ')"

# Replace placeholders in front matter (escape special regex characters)
$content = $content -replace 'title: "Project Name - Build Log #XXX: Stage Title"', "title: `"$properTitle`""
$content = $content -replace 'date: YYYY-MM-DD', "date: $Date"
$content = $content -replace 'project: project-slug', "project: $ProjectName"
$content = $content -replace 'build_number: XXX', "build_number: $BuildNumber"

# Save the updated content
Set-Content -Path $newFilePath -Value $content -NoNewline

Write-Host "`n✓ Build log created successfully!" -ForegroundColor Green
Write-Host "`nFile location:" -ForegroundColor Cyan
Write-Host "  $newFilePath" -ForegroundColor White

# Show next steps
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "  1. Edit the file and replace XXX placeholders with your content" -ForegroundColor Gray
Write-Host "  2. Add photos to: assets/images/builds/$ProjectName/" -ForegroundColor Gray
Write-Host "  3. Commit and push:" -ForegroundColor Gray
Write-Host "     git add ." -ForegroundColor DarkGray
Write-Host "     git commit -m `"Add build log #$BuildNumber for $ProjectName`"" -ForegroundColor DarkGray
Write-Host "     git push" -ForegroundColor DarkGray

# Open in editor if requested
if ($OpenInEditor) {
    Write-Host "`nOpening in VS Code..." -ForegroundColor Cyan
    try {
        & code $newFilePath
        Write-Host "✓ File opened in VS Code" -ForegroundColor Green
    }
    catch {
        Write-Warning "Could not open VS Code. Please open the file manually."
        Write-Host "File path: $newFilePath" -ForegroundColor Yellow
    }
}

# Summary
Write-Host "`n" -NoNewline
Write-Host "=" * 60 -ForegroundColor DarkGray
Write-Host "Build log ready for editing!" -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor DarkGray
