#!/usr/local/bin/bash

# Run the "uuidgen -hdr" n times and save the results to a CSV
echo Enter how many UUIDs you want using 1..n range format:
read range1
echo Output CSV filename without an extension or spaces:
read pathToCSV
for run in $(eval echo {$range1}); do uuidgen -hdr; done > $pathToCSV".csv"

# Remove extraneous lines that uuidgen writes to file by default
for i in warning, define
do
  sed -i '' '/i/d' $pathToCSV".csv"
done

# Truncate the first three non-alphanumeric characters that uuidgen writes to file by default
sed -i '' 's:^\/\/ ::' $pathToCSV".csv"

# Truncate UUID to your desired number of characters, or leave as is by entering 1-36
echo Enter desired length of UUIDs using 1-36 range format:
read range2
cut -c $range2 $pathToCSV".csv" > $pathToCSV"_final.csv"

# Delete the first CSV
rm $pathToCSV".csv"
