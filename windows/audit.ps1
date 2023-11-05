
# Download log file from Google Drive
$filename = "access.log"
$fileid = "1Wuko3rkpL9TtOXTSIVmZ3tFHYFQs2sxf"

Write-Host
Write-Host "Downloading $filename from Google Drive..."

$WebClient = New-Object System.Net.WebClient
$Url = "https://drive.google.com/uc?export=download&id=$fileid&confirm=t"
$WebClient.DownloadFile($Url, ".\$filename")

Write-Host "Downloaded $filename from Google Drive"
Write-Host
