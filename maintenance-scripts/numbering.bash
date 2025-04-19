#!/bin/bash

# Each line contains: <filename> <number>
FILES_WITH_NUMBERS=(
"introduction 1"
"Part_I/about-part1 2"
"Part_I/fixing-syntax-errors 3"
"Part_I/writing-algorithms 4"
"Part_I/explaining-code 5"
"Part_I/commenting-code 6"
"Part_I/bug-fixing-and-code-reviews 7"
"Part_II/about-part2 8"
"Part_II/data-structures 9"
"Part_II/divide-and-conquer 10"
"Part_II/design-patterns 11"
"Part_II/testing 12"
"Part_II/mutation-testing 13"
"Part_II/refactoring 14"
"Part_III/about-part3 15"
"Part_III/api 16"
"Part_III/guis 17"
"Part_III/code-reviews 18"
"Part_III/language-translation-with-AI 19"
"conclusion 20"
)

# Loop through each entry
for ENTRY in "${FILES_WITH_NUMBERS[@]}"
do
  # Split the line into filename and number
  FILE_PATH="../"$(echo "$ENTRY" | awk '{print $1}')
  NUMBER=$(echo "$ENTRY" | awk '{print $2}')
  
  FILE_NAME=$(basename "$FILE_PATH")  # e.g., "test"

  echo "Processing ${FILE_PATH}.ipynb with number $NUMBER"

  python -m nbconvert \
    --to=ipynb \
    --NumberedHeadingsPreprocessor.enabled=true \
    --output="${FILE_NAME}.ipynb" \
    "${FILE_PATH}.ipynb" "$NUMBER"
done