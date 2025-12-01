param(
    [Parameter(Mandatory=$true)]
    [string]$SourcePath,
    
    [Parameter(Mandatory=$false)]
    [string]$ProjectName = "ss-great-britain",
    
    [Parameter(Mandatory=$false)]
    [switch]$WhatIf
)

<#
.SYNOPSIS
    Renames image files with consistent naming convention for web projects
    
.DESCRIPTION
    Renames files in subfolders with pattern: projectname-foldername-###.jpg
    Preserves original file dates and sorts by original filename
    
.EXAMPLE
    .\scripts\rename-project-images.ps1 -SourcePath "\\server\path\project\web-optimized"
    
.EXAMPLE
    .\scripts\rename-project-images.ps1 -SourcePath "\\server\path\project\web-optimized" -WhatIf
#>

Write-Host "`n=== Image Renaming Script ===" -ForegroundColor Cyan
Write-Host "Project: $ProjectName" -ForegroundColor Yellow
Write-Host "Source: $SourcePath`n" -ForegroundColor Yellow

if ($WhatIf) {
    Write-Host ">>> WHATIF MODE - No files will be renamed <<<`n" -ForegroundColor Magenta
}

# Verify path exists
if (-not (Test-Path $SourcePath)) {
    Write-Host "ERROR: Source path not found: $SourcePath" -ForegroundColor Red
    exit 1
}

# Get all subfolders
$folders = Get-ChildItem -Path $SourcePath -Directory

if ($folders.Count -eq 0) {
    Write-Host "No subfolders found in: $SourcePath" -ForegroundColor Yellow
    exit 0
}

$totalRenamed = 0
$summary = @()

foreach ($folder in $folders) {
    $folderName = $folder.Name.ToLower()
    
    # Map folder names to category names
    $category = switch ($folderName) {
        "build" { "build" }
        "galery" { "gallery" }
        "gallery" { "gallery" }
        "design-examples" { "reference" }
        "reference" { "reference" }
        "details" { "details" }
        "overview" { "overview" }
        default { $folderName }
    }
    
    Write-Host "Processing folder: $($folder.Name) -> Category: $category" -ForegroundColor Green
    
    # Get all image files, sorted by name
    $files = Get-ChildItem -Path $folder.FullName -File |
             Where-Object { $_.Extension -match '\.(jpg|jpeg|png|heic|gif)$' } |
             Sort-Object Name
    
    if ($files.Count -eq 0) {
        Write-Host "  No image files found" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "  Found $($files.Count) files" -ForegroundColor Gray
    
    $counter = 1
    $renamedInFolder = 0
    
    foreach ($file in $files) {
        $extension = $file.Extension.ToLower()
        $newName = "{0}-{1}-{2:D3}{3}" -f $ProjectName, $category, $counter, $extension
        $newPath = Join-Path $folder.FullName $newName
        
        # Skip if already properly named
        if ($file.Name -eq $newName) {
            Write-Host "  ✓ $($file.Name) - already correct" -ForegroundColor DarkGray
            $counter++
            continue
        }
        
        # Check if target name already exists
        if ((Test-Path $newPath) -and ($file.FullName -ne $newPath)) {
            Write-Host "  ⚠ SKIP: Target exists - $newName" -ForegroundColor Yellow
            $counter++
            continue
        }
        
        if ($WhatIf) {
            Write-Host "  → WOULD RENAME: $($file.Name) -> $newName" -ForegroundColor Cyan
        } else {
            try {
                Rename-Item -Path $file.FullName -NewName $newName -ErrorAction Stop
                Write-Host "  ✓ $($file.Name) -> $newName" -ForegroundColor Green
                $renamedInFolder++
                $totalRenamed++
            } catch {
                Write-Host "  ✗ ERROR: $($file.Name) - $($_.Exception.Message)" -ForegroundColor Red
            }
        }
        
        $counter++
    }
    
    $summary += [PSCustomObject]@{
        Folder = $folder.Name
        Category = $category
        TotalFiles = $files.Count
        Renamed = $renamedInFolder
    }
    
    Write-Host ""
}

# Print summary
Write-Host "`n=== Summary ===" -ForegroundColor Cyan
$summary | Format-Table -AutoSize

if (-not $WhatIf) {
    Write-Host "Total files renamed: $totalRenamed" -ForegroundColor Green
} else {
    Write-Host "WhatIf mode - run without -WhatIf to actually rename files" -ForegroundColor Magenta
}

Write-Host "`nNaming convention: $ProjectName-[category]-###.jpg" -ForegroundColor Yellow
Write-Host "Done!`n" -ForegroundColor Cyan
