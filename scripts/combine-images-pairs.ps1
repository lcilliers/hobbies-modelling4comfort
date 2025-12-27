# Combine images into a grid layout with pairs
# Creates rows of 2 images each from a list of image files
# Images are normalized to consistent height with borders and background

param(
    [Parameter(Mandatory=$true)]
    [string[]]$FileList,
    
    [Parameter(Mandatory=$true)]
    [string]$InputFolder,
    
    [Parameter(Mandatory=$true)]
    [string]$OutputFile,
    
    [Parameter(Mandatory=$false)]
    [int]$ImageHeight = 800,
    
    [Parameter(Mandatory=$false)]
    [string]$BackgroundColor = "#f5f0e8",
    
    [Parameter(Mandatory=$false)]
    [int]$ImageBorder = 10,
    
    [Parameter(Mandatory=$false)]
    [int]$OuterBorder = 20
)

# Build the full paths for input images
$fullPaths = $FileList | ForEach-Object {
    Join-Path $InputFolder $_
}

# Check if we have images
if ($fullPaths.Count -eq 0) {
    Write-Error "No files provided"
    exit 1
}

# Build rows: if odd number, first image is full width, rest are pairs
$imagePaths = @()

$resizeParams = "-auto-orient -resize x$ImageHeight -bordercolor white -border $ImageBorder"

if ($fullPaths.Count % 2 -eq 1) {
    # Odd number: first image gets its own row
    $imagePaths += "`"$($fullPaths[0])`" $resizeParams -background `"$BackgroundColor`""
    $startIndex = 1
} else {
    # Even number: start pairing from beginning
    $startIndex = 0
}

# Create pairs for remaining images
for ($i = $startIndex; $i -lt $fullPaths.Count; $i += 2) {
    $pair = @()
    $pair += "`"$($fullPaths[$i])`" $resizeParams"
    
    if ($i + 1 -lt $fullPaths.Count) {
        $pair += "`"$($fullPaths[$i + 1])`" $resizeParams"
    }
    
    $imagePaths += "``( $($pair -join ' ') +append ``)"
}

# Build the magick command
$command = "magick $($imagePaths -join ' ') -gravity center -background `"$BackgroundColor`" -append -bordercolor `"$BackgroundColor`" -border $OuterBorder `"$OutputFile`""

Write-Host "Creating paired image grid..."
Write-Host "Command: $command"

# Execute the command
Invoke-Expression $command

if (Test-Path $OutputFile) {
    Write-Host "Success! Created: $OutputFile" -ForegroundColor Green
    $fileInfo = Get-Item $OutputFile
    Write-Host "Size: $([math]::Round($fileInfo.Length / 1MB, 2)) MB"
} else {
    Write-Error "Failed to create output file"
}
