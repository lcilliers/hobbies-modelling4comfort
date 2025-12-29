# Analyze Conflicts Between Site Renames and Source Structure

$mdRefs = Import-Csv "MARKDOWN-IMAGE-REFERENCES.csv"
$sourceRefs = Import-Csv "SOURCE-STRUCTURE-ANALYSIS.csv"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "CONFLICT ANALYSIS - DAFFODIL" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# The three conflicting files that failed to rename
$conflicts = @(
    'daffodil-planning-bulbs-01.jpg',
    'daffodil-planning-templates-01.jpg',
    'daffodil-planning-scenes-01.jpg'
)

Write-Host "`n--- FILE 1: daf-planning-001.jpg (currently exists in site) ---" -ForegroundColor Yellow
Write-Host "`nSITE - What was renamed TO daf-planning-001.jpg:" -ForegroundColor White
$mdMatch = $mdRefs | Where-Object { $_.NewFilename -eq 'daf-planning-001.jpg' -and $_.PlantName -eq 'daffodil' }
if ($mdMatch) {
    Write-Host "  RefID: $($mdMatch.RefID)" -ForegroundColor Gray
    Write-Host "  Original site name: $($mdMatch.CurrentFilename)" -ForegroundColor Gray
    Write-Host "  Markdown file: $($mdMatch.MarkdownFile)" -ForegroundColor Gray
} else {
    Write-Host "  NOT FOUND IN MARKDOWN CSV" -ForegroundColor Red
}

Write-Host "`nSOURCE - What SHOULD be daf-planning-001.jpg:" -ForegroundColor White
$srcMatch = $sourceRefs | Where-Object { $_.SuggestedNewName -eq 'daf-planning-001.jpg' -and $_.PlantName -eq 'Daffoldil' }
if ($srcMatch) {
    Write-Host "  EntryID: $($srcMatch.EntryID)" -ForegroundColor Gray
    Write-Host "  Source original name: $($srcMatch.CurrentFileName)" -ForegroundColor Gray
    Write-Host "  Subfolder: '$($srcMatch.Subfolder)'" -ForegroundColor Gray
    Write-Host "  Category: $($srcMatch.Category)" -ForegroundColor Gray
} else {
    Write-Host "  NOT FOUND IN SOURCE CSV" -ForegroundColor Red
}

foreach ($conflict in $conflicts) {
    Write-Host "`n--- CONFLICT: $conflict (failed to rename) ---" -ForegroundColor Yellow
    
    Write-Host "`nSITE - What this file wanted to become:" -ForegroundColor White
    $mdMatch = $mdRefs | Where-Object { $_.CurrentFilename -eq $conflict }
    if ($mdMatch) {
        Write-Host "  RefID: $($mdMatch.RefID)" -ForegroundColor Gray
        Write-Host "  Target new name: $($mdMatch.NewFilename)" -ForegroundColor Gray
        Write-Host "  Current full path: $($mdMatch.CurrentFullPath)" -ForegroundColor Gray
        Write-Host "  Markdown file: $($mdMatch.MarkdownFile)" -ForegroundColor Gray
    } else {
        Write-Host "  NOT FOUND IN MARKDOWN CSV" -ForegroundColor Red
    }
    
    Write-Host "`nSOURCE - Corresponding file:" -ForegroundColor White
    # Extract theme from filename (bulbs, templates, scenes)
    if ($conflict -match 'daffodil-planning-([^-]+)-') {
        $theme = $matches[1]
        Write-Host "  Theme extracted: $theme" -ForegroundColor Gray
        
        # Look for this in source (should be in subfolder with that theme)
        $srcMatches = $sourceRefs | Where-Object { 
            $_.PlantName -eq 'Daffoldil' -and 
            $_.Category -eq 'planning' -and
            $_.Subfolder -like "*$theme*"
        }
        
        if ($srcMatches) {
            Write-Host "  Found $($srcMatches.Count) files in source subfolder '$theme'" -ForegroundColor Gray
            $srcMatches | Select-Object -First 3 | ForEach-Object {
                Write-Host "    - $($_.CurrentFileName) → $($_.SuggestedNewName)" -ForegroundColor DarkGray
            }
        } else {
            Write-Host "  NO MATCHING FILES IN SOURCE for subfolder '$theme'" -ForegroundColor Red
        }
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SUMMARY" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "`nThe site has 'combined' themed images in root planning folder" -ForegroundColor White
Write-Host "The source has files organized in subfolders (bulbs/, flowers/, scenes/, templates/)" -ForegroundColor White
Write-Host "`nThese represent DIFFERENT file sets with DIFFERENT numbering" -ForegroundColor Red
Write-Host "`n========================================" -ForegroundColor Cyan
