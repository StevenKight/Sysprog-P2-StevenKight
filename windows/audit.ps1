
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

# Load list of blacklisted IPs
$blacklist = Get-Content "./blacklist.txt"

# Load SQL injection patterns
$sqlInjection = @(
    "UNION",
    "SELECT",
    "' OR 1=1",
    "DROP TABLE"
)

# Read log file line by line
$lines = Get-Content ${FILENAME}

Write-Host "Processing $filename..."

# Loop through the lines using a while loop
$line_number = 0
while ($line_number -lt $lines.Length) {
    $line = $lines[$line_number]

    # Check if the line contains a blacklisted IP
    foreach ($ip in $blacklist) {
        if ($line.Contains($ip)) {
            Write-Host "Found blacklisted IP: $ip"
        }
    }

    # Check if the line contains a SQL injection string
    foreach ($pattern in $sqlInjection) {
        if ($line.Contains($pattern)) {
            Write-Host "Found SQL injection: $pattern"
        }
    }

    $line_number++
}

Write-Host "Processing complete"
