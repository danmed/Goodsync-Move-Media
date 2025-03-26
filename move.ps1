# Set paths
$source = "C:\Source\Media"
$destination = "C:\Destination\Media"

# Move media files
Get-ChildItem -Path $source -Recurse -Include *.mkv, *.mp4, *.avi, *.nfo | Move-Item -Destination $destination

# Delete folders older than one week and smaller than 1 MB
Get-ChildItem -Path $source -Recurse -Directory | Where-Object {
    ($_.LastWriteTime -lt (Get-Date).AddDays(-7)) -and ((Get-ChildItem -Path $_.FullName -Recurse -File | Measure-Object -Property Length -Sum).Sum / 1MB) -lt 1
} | Remove-Item -Recurse -Force
