#!/bin/bash

# Download log file
file_name="access.log"
file_id="1Wuko3rkpL9TtOXTSIVmZ3tFHYFQs2sxf"

curl -L -o $file_name "https://drive.google.com/uc?export=download&id={$file_id}"

# Read blacklisted IPs from file
blacklist_file="./blacklist.txt"
readarray -t blacklisted < $blacklist_file

echo "Blacklisted IPs: ${blacklisted[@]}"
