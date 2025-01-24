#!/bin/bash

# Source and destination directories
SOURCE_DIR="/path/to/source/folder"
DEST_DIR="/path/to/destination/folder"

# List of specific files to be copied
FILES_TO_COPY=("file1.txt" "file2.jpg" "file3.pdf")

# Loop through each file and copy it to the destination
for FILE in "${FILES_TO_COPY[@]}"
do
  # Check if the file exists in the source folder
  if [ -f "$SOURCE_DIR/$FILE" ]; then
    # Copy the file to the destination folder
    cp "$SOURCE_DIR/$FILE" "$DEST_DIR"
    echo "Copied $FILE to $DEST_DIR"
  else
    echo "File $FILE does not exist in $SOURCE_DIR"
  fi
done
