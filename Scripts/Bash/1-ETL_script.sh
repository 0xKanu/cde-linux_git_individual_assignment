#!/bin/bash

# EXTRACT
export URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

mkdir -p raw

rawfilepath="raw/$(basename "$URL")"

curl -L -o "$rawfilepath" "$URL"

if [ -f "$rawfilepath" ]; then
	echo "File successfully saved in $rawfilepath"
else
	echo "File not saved correctly."
	exit 1
fi


# TRANSFORM

mkdir -p Transformed
transformed_file="Transformed/2023_year_finance.csv"

header=$(head -n 1 "$rawfilepath")
new_header=${header/Variable_code/variable_code}

year_pos=$(echo "$new_header" | tr ',' '\n' | grep -nx "Year" | cut -d':' -f1)
value_pos=$(echo "$new_header" | tr ',' '\n' | grep -nx "Value" | cut -d':' -f1)
units_pos=$(echo "$new_header" | tr ',' '\n' | grep -nx "Units" | cut -d':' -f1)
var_pos=$(echo "$new_header" | tr ',' '\n' | grep -nx "variable_code" | cut -d':' -f1)


echo $new_header | cut -d ',' -f ${year_pos},${value_pos},${units_pos},${var_pos} > "$transformed_file"
tail -n +2 "$rawfilepath" | cut -d ',' -f ${year_pos},${value_pos},${units_pos},${var_pos} >> "$transformed_file"


if [[ -f "$transformed_file" ]]; then
	echo "Transformed file saved correctly in $transformed_file"
else
	echo "Transformation failed."
	exit 1
fi

# LOAD

mkdir -p Gold

cp $transformed_file Gold

loaded_file="./Gold/2023_year_finance.csv"

if [[ -f "$loaded_file" ]]; then
	echo "Loaded successfully to $loaded_file ."
else
	echo "Loading Unsuccessful."
	exit 1
fi
