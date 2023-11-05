
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

# Read log file line by line
$lines = Get-Content ${FILENAME}

Write-Host "Processing $filename..."

# Loop through the lines using a while loop
$line_number = 0
while ($line_number -lt $lines.Length) {
    $line = $lines[$line_number]

    Write-Host "Line $line_number: $line"

    $line_number++
}

Write-Host "Processing complete"
