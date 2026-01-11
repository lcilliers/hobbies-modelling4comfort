<#
.SYNOPSIS
    Validates a source-narrative document for completeness and accuracy.

.DESCRIPTION
    This script performs comprehensive validation of source-narrative documents:
    - Checks all referenced images exist
    - Verifies no placeholder markers remain ([TODO], [TO WRITE])
    - Validates technical data consistency
    - Checks content completeness
    - Reports validation status

.PARAMETER SourceNarrativePath
    Path to the source-narrative markdown file to validate

.PARAMETER ImageBasePath
    Base path where images are stored (will check image references against this)

.PARAMETER Strict
    If set, treats warnings as errors (fails validation if any warnings)

.EXAMPLE
    .\validate-source-narrative.ps1 -SourceNarrativePath ".\projects-working\source-narratives\log-cabin-SOURCE-NARRATIVE-build-01.md" -ImageBasePath "\\server\photos\log-cabin\web-optimized\build1"

.NOTES
    Part of SOURCE-NARRATIVE-WITH-AI-ANALYSIS methodology Phase 5: Validation
    Created: 2026-01-11
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$SourceNarrativePath,
    
    [Parameter(Mandatory=$false)]
    [string]$ImageBasePath,
    
    [Parameter(Mandatory=$false)]
    [switch]$Strict
)

# Initialize validation results
$validationErrors = @()
$validationWarnings = @()
$validationPassed = @()

Write-Host "`n═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "SOURCE-NARRATIVE VALIDATION" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════`n" -ForegroundColor Cyan

# Check file exists
if (-not (Test-Path $SourceNarrativePath)) {
    Write-Error "Source-narrative file not found: $SourceNarrativePath"
    exit 1
}

Write-Host "Validating: $SourceNarrativePath`n" -ForegroundColor Yellow

# Read file content
$content = Get-Content -Path $SourceNarrativePath -Raw

# ═══════════════════════════════════════════════════════════════
# 1. IMAGE PATH VALIDATION
# ═══════════════════════════════════════════════════════════════

Write-Host "1. Validating Image References..." -ForegroundColor Magenta

$imageRefs = [regex]::Matches($content, '\[IMAGE:\s*(.+?)\]')

if ($imageRefs.Count -eq 0) {
    $validationWarnings += "No image references found in document"
    Write-Host "   ⚠️  No image references found" -ForegroundColor Yellow
} else {
    Write-Host "   Found $($imageRefs.Count) image reference(s)" -ForegroundColor Gray
    
    $missingImages = 0
    $foundImages = 0
    
    foreach ($match in $imageRefs) {
        $imageFile = $match.Groups[1].Value.Trim()
        
        if ($ImageBasePath) {
            $imagePath = Join-Path $ImageBasePath $imageFile
            
            if (-not (Test-Path $imagePath)) {
                $validationErrors += "Image not found: $imageFile (Expected: $imagePath)"
                Write-Host "   ❌ MISSING: $imageFile" -ForegroundColor Red
                $missingImages++
            } else {
                $foundImages++
            }
        }
    }
    
    if ($ImageBasePath) {
        if ($missingImages -eq 0) {
            $validationPassed += "All $foundImages image(s) found"
            Write-Host "   ✅ All images exist ($foundImages found)" -ForegroundColor Green
        } else {
            Write-Host "   ❌ $missingImages missing image(s), $foundImages found" -ForegroundColor Red
        }
    } else {
        $validationWarnings += "ImageBasePath not provided - skipped existence check"
        Write-Host "   ⚠️  Image existence not verified (no ImageBasePath provided)" -ForegroundColor Yellow
    }
}

# ═══════════════════════════════════════════════════════════════
# 2. PLACEHOLDER MARKER VALIDATION
# ═══════════════════════════════════════════════════════════════

Write-Host "`n2. Checking for Placeholder Markers..." -ForegroundColor Magenta

$todoMarkers = [regex]::Matches($content, '\[TODO:?([^\]]*)\]')
$toWriteMarkers = [regex]::Matches($content, '\[TO WRITE([^\]]*)\]')
$aiCheckMarkers = [regex]::Matches($content, '\[AI-CHECK\]')
$needsMoreMarkers = [regex]::Matches($content, '\[NEEDS MORE\]')

$totalPlaceholders = $todoMarkers.Count + $toWriteMarkers.Count + $aiCheckMarkers.Count

if ($totalPlaceholders -eq 0) {
    $validationPassed += "No placeholder markers found"
    Write-Host "   ✅ No [TODO] or [TO WRITE] markers" -ForegroundColor Green
} else {
    if ($todoMarkers.Count -gt 0) {
        $validationErrors += "$($todoMarkers.Count) [TODO] marker(s) remaining"
        Write-Host "   ❌ $($todoMarkers.Count) [TODO] marker(s) found" -ForegroundColor Red
        
        # Show first few
        $todoMarkers | Select-Object -First 3 | ForEach-Object {
            $lineNumber = ($content.Substring(0, $_.Index) -split "`n").Count
            Write-Host "      Line ~$lineNumber : $($_.Value)" -ForegroundColor Gray
        }
        if ($todoMarkers.Count -gt 3) {
            Write-Host "      ... and $($todoMarkers.Count - 3) more" -ForegroundColor Gray
        }
    }
    
    if ($toWriteMarkers.Count -gt 0) {
        $validationErrors += "$($toWriteMarkers.Count) [TO WRITE] marker(s) remaining"
        Write-Host "   ❌ $($toWriteMarkers.Count) [TO WRITE] marker(s) found" -ForegroundColor Red
    }
    
    if ($aiCheckMarkers.Count -gt 0) {
        $validationWarnings += "$($aiCheckMarkers.Count) [AI-CHECK] marker(s) not validated"
        Write-Host "   ⚠️  $($aiCheckMarkers.Count) [AI-CHECK] marker(s) found" -ForegroundColor Yellow
    }
}

if ($needsMoreMarkers.Count -gt 0) {
    $validationWarnings += "Document marked as [NEEDS MORE]"
    Write-Host "   ⚠️  Document validation status: [NEEDS MORE]" -ForegroundColor Yellow
}

# ═══════════════════════════════════════════════════════════════
# 3. CAPTION VALIDATION
# ═══════════════════════════════════════════════════════════════

Write-Host "`n3. Validating Image Captions..." -ForegroundColor Magenta

# Find all captions after image markers
$imageCaptionPattern = '\[IMAGE:[^\]]+\]\s*(?:\[[^\]]+\]\s*)*\*Caption:\s*(.+?)\*'
$captionMatches = [regex]::Matches($content, $imageCaptionPattern)

$emptyCaptions = 0
$todoInCaptions = 0

foreach ($match in $captionMatches) {
    $caption = $match.Groups[1].Value.Trim()
    
    if ($caption -match '\[TODO' -or $caption -match '\[TO WRITE') {
        $todoInCaptions++
    } elseif ($caption.Length -lt 10) {
        $emptyCaptions++
    }
}

if ($todoInCaptions -gt 0) {
    $validationErrors += "$todoInCaptions caption(s) contain [TODO] or [TO WRITE]"
    Write-Host "   ❌ $todoInCaptions caption(s) not completed" -ForegroundColor Red
}

if ($emptyCaptions -gt 0) {
    $validationWarnings += "$emptyCaptions caption(s) are very short (< 10 characters)"
    Write-Host "   ⚠️  $emptyCaptions caption(s) seem too short" -ForegroundColor Yellow
}

if ($todoInCaptions -eq 0 -and $emptyCaptions -eq 0 -and $captionMatches.Count -gt 0) {
    $validationPassed += "All $($captionMatches.Count) caption(s) completed"
    Write-Host "   ✅ All $($captionMatches.Count) caption(s) completed" -ForegroundColor Green
} elseif ($captionMatches.Count -eq 0) {
    $validationWarnings += "No captions found (check caption format: *Caption: text*)"
    Write-Host "   ⚠️  No captions found" -ForegroundColor Yellow
}

# ═══════════════════════════════════════════════════════════════
# 4. METADATA VALIDATION
# ═══════════════════════════════════════════════════════════════

Write-Host "`n4. Validating Metadata Fields..." -ForegroundColor Magenta

$metadataIssues = 0

# Check for common metadata fields that should be filled
$metadataChecks = @(
    @{ Pattern = '\*\*Project Name:\*\*\s*\['; Issue = "Project Name not filled" },
    @{ Pattern = '\*\*Scale:\*\*\s*\['; Issue = "Scale not filled" },
    @{ Pattern = '\*\*Timeline:\*\*\s*\['; Issue = "Timeline not filled" },
    @{ Pattern = '\*\*Hours Spent:\*\*\s*\['; Issue = "Hours Spent not filled" },
    @{ Pattern = '\*\*Primary Focus:\*\*\s*\['; Issue = "Primary Focus not filled" },
    @{ Pattern = '\*\*Build Number:\*\*\s*\['; Issue = "Build Number not filled" },
    @{ Pattern = '\*\*Phase:\*\*\s*\['; Issue = "Phase not filled" }
)

foreach ($check in $metadataChecks) {
    if ($content -match $check.Pattern) {
        $validationWarnings += $check.Issue
        Write-Host "   ⚠️  $($check.Issue)" -ForegroundColor Yellow
        $metadataIssues++
    }
}

if ($metadataIssues -eq 0) {
    $validationPassed += "All found metadata fields completed"
    Write-Host "   ✅ Metadata fields completed" -ForegroundColor Green
}

# ═══════════════════════════════════════════════════════════════
# 5. CONTENT COMPLETENESS
# ═══════════════════════════════════════════════════════════════

Write-Host "`n5. Checking Content Completeness..." -ForegroundColor Magenta

# Check for common sections
$sections = @{
    "Narrative" = $content -match '## Narrative'
    "Challenges" = $content -match '(## Challenges|### Challenges)'
    "Learned/Learning" = $content -match '(## What I Learned|## Key Learnings)'
    "Results" = $content -match '(## Results|### Results)'
}

$missingSections = $sections.GetEnumerator() | Where-Object { -not $_.Value }

if ($missingSections.Count -gt 0) {
    foreach ($section in $missingSections) {
        $validationWarnings += "Section not found: $($section.Key)"
        Write-Host "   ⚠️  Missing section: $($section.Key)" -ForegroundColor Yellow
    }
} else {
    $validationPassed += "All key sections present"
    Write-Host "   ✅ All key sections present" -ForegroundColor Green
}

# Check word count (should have substantial content)
$wordCount = ($content -split '\s+').Count

if ($wordCount -lt 500) {
    $validationWarnings += "Document seems short ($wordCount words) - ensure content is complete"
    Write-Host "   ⚠️  Document is short ($wordCount words)" -ForegroundColor Yellow
} else {
    $validationPassed += "Document has substantial content ($wordCount words)"
    Write-Host "   ✅ Substantial content ($wordCount words)" -ForegroundColor Green
}

# ═══════════════════════════════════════════════════════════════
# 6. VALIDATION STATUS MARKER
# ═══════════════════════════════════════════════════════════════

Write-Host "`n6. Checking Validation Status..." -ForegroundColor Magenta

if ($content -match 'Validation Status:\s*\[NEEDS MORE\]') {
    $validationWarnings += "Document marked as [NEEDS MORE] - not ready for publication"
    Write-Host "   ⚠️  Document status: [NEEDS MORE]" -ForegroundColor Yellow
} elseif ($content -match 'Validation Status:\s*\[COMPLETE\]') {
    $validationPassed += "Document marked as [COMPLETE]"
    Write-Host "   ✅ Document status: [COMPLETE]" -ForegroundColor Green
} elseif ($content -match 'Validation Status:\s*\[PARTIALLY VALIDATED\]') {
    $validationWarnings += "Document status: [PARTIALLY VALIDATED]"
    Write-Host "   ⚠️  Document status: [PARTIALLY VALIDATED]" -ForegroundColor Yellow
} else {
    $validationWarnings += "No validation status found in document header"
    Write-Host "   ⚠️  No validation status marker found" -ForegroundColor Yellow
}

# ═══════════════════════════════════════════════════════════════
# SUMMARY
# ═══════════════════════════════════════════════════════════════

Write-Host "`n═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "VALIDATION SUMMARY" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════`n" -ForegroundColor Cyan

Write-Host "✅ Passed Checks: $($validationPassed.Count)" -ForegroundColor Green
foreach ($pass in $validationPassed) {
    Write-Host "   • $pass" -ForegroundColor Gray
}

if ($validationWarnings.Count -gt 0) {
    Write-Host "`n⚠️  Warnings: $($validationWarnings.Count)" -ForegroundColor Yellow
    foreach ($warning in $validationWarnings) {
        Write-Host "   • $warning" -ForegroundColor Gray
    }
}

if ($validationErrors.Count -gt 0) {
    Write-Host "`n❌ Errors: $($validationErrors.Count)" -ForegroundColor Red
    foreach ($error in $validationErrors) {
        Write-Host "   • $error" -ForegroundColor Gray
    }
}

# Final determination
Write-Host "`n───────────────────────────────────────────────────────────────" -ForegroundColor Gray

if ($validationErrors.Count -eq 0 -and $validationWarnings.Count -eq 0) {
    Write-Host "`n✅ VALIDATION PASSED - Ready for Phase 6 (Page Construction)" -ForegroundColor Green -BackgroundColor DarkGreen
    Write-Host "`nSource-narrative is complete and accurate.`n" -ForegroundColor Green
    exit 0
} elseif ($validationErrors.Count -eq 0 -and -not $Strict) {
    Write-Host "`n⚠️  VALIDATION PASSED WITH WARNINGS" -ForegroundColor Yellow -BackgroundColor DarkYellow
    Write-Host "`nSource-narrative is usable but has minor issues to address.`n" -ForegroundColor Yellow
    Write-Host "Re-run with -Strict flag to treat warnings as errors.`n" -ForegroundColor Gray
    exit 0
} else {
    Write-Host "`n❌ VALIDATION FAILED - NOT ready for Phase 6" -ForegroundColor Red -BackgroundColor DarkRed
    Write-Host "`nPlease address the errors above before proceeding.`n" -ForegroundColor Red
    
    if ($Strict -and $validationWarnings.Count -gt 0) {
        Write-Host "Note: Running in STRICT mode - warnings treated as errors.`n" -ForegroundColor Yellow
    }
    
    exit 1
}
