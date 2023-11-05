#!/bin/bash

# Download log file
file_name="access.log"
file_id="1Wuko3rkpL9TtOXTSIVmZ3tFHYFQs2sxf"

curl -L -o $file_name "https://drive.google.com/uc?export=download&id={$file_id}"
echo -e "Downloaded log file: $file_name\n"

# Read blacklisted IPs from file
blacklist_file="./blacklist.txt"
readarray -t blacklisted < $blacklist_file
echo -e "Blacklisted IPs loaded from file: $blacklist_file\n"

# Load SQL injection patterns
sql_injection_patterns=(
    "UNION"
    "SELECT"
    "' OR 1=1"
    "DROP TABLE"
)

# Setup output file
output_file="audit_rpt.txt"
if [ -f "audit_rpt.txt" ]; then # TODO: Should file be cleared?
    > "$output_file"
else
    touch "audit_rpt.txt"
fi
echo -e "Output file prepared: $output_file\n"

# Read log file line by line and audit
line_number=1
while read -r line; 
do
    for ip in "${blacklisted[@]}"
    do
        if [[ $line == *"$ip"* ]]; then
            echo "$line_number, Found blacklisted IP: $ip" >> "$output_file"
        fi
    done

    for pattern in "${sql_injection_patterns[@]}"
    do
        if [[ $line == *"$pattern"* ]]; then
            echo "$line_number, Found SQL injection pattern: $pattern" >> "$output_file"
        fi
    done

    ((line_number++))
done < "$file_name"
echo -e "Audit completed. Output written to $output_file\n"