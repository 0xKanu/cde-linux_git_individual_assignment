#!/bin/bash

export URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

mkdir -p raw

filepath="raw/$(basename "$URL")"

curl -L -o "$filepath" "$URL"

if [ -f "$filepath" ]; then
	echo "File successfully saved in $filepath"
else
	echo "File not saved correctly."
fi
