# Plant Displays Image Rename Script
# Renames all images from verbose naming to simple sequential naming

param(
    [switch]$WhatIf = $false,
    [switch]$SiteOnly = $false,
    [switch]$SourceOnly = $false
)

$ErrorActionPreference = "Stop"

Write-Host "=== Plant Displays Image Rename Script ===" -ForegroundColor Cyan
Write-Host "Mode: $(if ($WhatIf) { 'DRY RUN (no changes)' } else { 'LIVE (will rename files)' })`n" -ForegroundColor $(if ($WhatIf) { 'Yellow' } else { 'Red' })

# Load inventory
$inventoryPath = "RENAME-INVENTORY.csv"
if (-not (Test-Path $inventoryPath)) {
    Write-Error "Inventory file not found: $inventoryPath"
    exit 1
}

$inventory = Import-Csv $inventoryPath
Write-Host "Loaded inventory: $($inventory.Count) files`n"

# Site renaming
if (-not $SourceOnly) {
    Write-Host "=== RENAMING SITE FILES ===" -ForegroundColor Green
    $siteBase = "assets\images\projects\plant-displays"
    $renamed = 0
    $skipped = 0
    
    foreach ($item in $inventory) {
        $oldPath = Join-Path $siteBase "$($item.Plant)\$($item.Category)\$($item.Subfolder)$($item.OldName)"
        $newPath = Join-Path $siteBase "$($item.Plant)\$($item.Category)\$($item.Subfolder)$($item.NewName)"
        
        if ($item.OldName -eq $item.NewName) {
            $skipped++
            continue
        }
        
        if (Test-Path $oldPath) {
            if ($WhatIf) {
                Write-Host "  [DRY RUN] $($item.Plant)/$($item.Category): $($item.OldName) -> $($item.NewName)"
            } else {
                Rename-Item -Path $oldPath -NewName $item.NewName
                Write-Host "  ✓ $($item.Plant)/$($item.Category): $($item.NewName)" -ForegroundColor Gray
                $renamed++
            }
        } else {
            Write-Host "  ✗ NOT FOUND: $oldPath" -ForegroundColor Red
        }
    }
    
    Write-Host "`nSite Summary: $renamed renamed, $skipped unchanged`n" -ForegroundColor Green
}

# Source renaming
if (-not $SiteOnly) {
    Write-Host "=== RENAMING SOURCE FILES ===" -ForegroundColor Green
    $sourceBase = "\\LSUK-SYNRACK\HomeMedia\hobbies\model building\plant displays"
    $plantMapping = @{
        'bluebells' = 'Bluebells'
        'daffodil' = 'Daffodil'
        'ranunculus' = 'Ranunculus'
        'snowdrops' = 'Snowdrops'
        'poinsettia' = 'Poinsettia'
        'hibiscus' = 'Hibiscus'
        'protea' = 'Protea'
        'strelitzia' = 'Strelitzia'
    }
    
    $renamed = 0
    $skipped = 0
    $notFound = 0
    
    foreach ($item in $inventory) {
        $sourcePlant = $plantMapping[$item.Plant.ToLower()]
        if (-not $sourcePlant) { continue }
        
        $sourcePlantPath = Join-Path $sourceBase $sourcePlant
        if (-not (Test-Path $sourcePlantPath)) {
            $notFound++
            continue
        }
        
        $oldPath = Join-Path "$sourcePlantPath\web-optimized" "$($item.Category)\$($item.Subfolder)$($item.OldName)"
        $newPath = Join-Path "$sourcePlantPath\web-optimized" "$($item.Category)\$($item.Subfolder)$($item.NewName)"
        
        if ($item.OldName -eq $item.NewName) {
            $skipped++
            continue
        }
        
        if (Test-Path $oldPath) {
            if ($WhatIf) {
                Write-Host "  [DRY RUN] $sourcePlant/$($item.Category): $($item.OldName) -> $($item.NewName)"
            } else {
                Rename-Item -Path $oldPath -NewName $item.NewName
                Write-Host "  ✓ $sourcePlant/$($item.Category): $($item.NewName)" -ForegroundColor Gray
                $renamed++
            }
        } else {
            # Not an error - some files may not exist in source
            $notFound++
        }
    }
    
    Write-Host "`nSource Summary: $renamed renamed, $skipped unchanged, $notFound not found`n" -ForegroundColor Green
}

Write-Host "=== COMPLETE ===" -ForegroundColor Cyan
if ($WhatIf) {
    Write-Host "This was a DRY RUN. Run without -WhatIf to apply changes." -ForegroundColor Yellow
}
