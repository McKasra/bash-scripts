#!/bin/bash

# Prompt for input: 1. enter file name or path that you want searched; 2. enter the literal or regex string
echo File name or path to find matches in:
read file
echo Literal or regex string to find:
read string

# Define variable and test if any matches are to be found; if not, notification is sent to terminal, but if matches exist, their row numbers (as summary rows) and individual column numbers will be output to a .txt file in the home directory. NB: you need to escape minus symbol with brackets, [-], so that it's not confused with an invalid grep option!
matchesFound=$(cat $file | grep -E -c "$string")
if [ $matchesFound -eq 0 ];
then
    echo "No matches exist."
else
    printf "Summary Row No: \n`awk -v awkvar="$string" '$0 ~ awkvar{print NR}' $file`" > results_for_$string.txt
    printf "\nInstance Column No: \n`awk -v awkvar="$string" -F"," '{for(i=1;i<=NF;i++){if ($i ~ awkvar){print i}}}' $file`" >> results_for_$string.txt
fi
