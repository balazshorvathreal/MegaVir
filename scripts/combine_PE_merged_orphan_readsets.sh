#!/bin/bash
ls | awk -F '-' '!x[$1]++{print $1}' | while read -r line
do
    cat $line* > combined_$line\.fa
done      
