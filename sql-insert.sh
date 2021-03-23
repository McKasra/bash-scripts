#!/bin/bash

# Prompt for input and: 1. enter CSV path to be imported into DB; 2. its equivalent table name in the DB 
echo Path to CSV:
read CSV_file
echo DB table name to import into:
read DB_table

# Create .txt file that will contain SQL INSERT STATEMENT and enter DB table name
echo "INSERT INTO $DB_table (" > SQL_INSERT_$DB_table.txt

# List out CSV header as INSERT STATEMENT column names and append to .txt file
echo "`head -n 1 $CSV_file`)" >> SQL_INSERT_$DB_table.txt

# Auto-quote string columns in the .txt file, leaving other columns intact
awk -F, 'OFS=FS {for (i=1;i<=NF;i++) {if (match($i, /^[0-9.-]+$/)==0) {printf "\"" $i "\""} else {printf $i}; if (i<NF) printf OFS}; printf "\n"}' $CSV_file > temp.txt
echo "VALUES" >> SQL_INSERT_$DB_table.txt

# read-while loop to populate INSERT STATEMENT row values from CSV (2nd row to the end) and replace final comma with semicolon for those RDBMS's that require a concluding semicolon at the end of SQL STATEMENT
while read line
do
 echo "($line),"
done < <(tail -n +2 temp.txt) >> SQL_INSERT_$DB_table.txt && sed -i '' '$ s/.$/;/' SQL_INSERT_$DB_table.txt

# Delete temporary .txt file that contained auto-quoted string values
rm temp.txt
