#!/usr/bin/env bash
set -e

# Initialise constants
TEMP_IMG="output.img"

# Check if user requested help and display help
if [[ "$1" = "--help" ]]; then
    printf "\\nWrite Linux ISO images to removable drives using macOS.\\n"
    printf "\\nUSAGE:\\n"
    printf "\\t%s ISO_IMAGE TARGET_PATH\\n" "$0"
    printf "\\nNOTES:\\n"
    printf "\\tThe image passed to this script should be in ISO format.\\n"
    printf "\\tThis script uses the unbuffered 'raw' disk write (i.e. rdiskN).\\n"
    printf "\\tRoot privileges required.\\n"
    exit 0
fi

# Display an error if incorrect number of arguments passed
if [[ $# -ne 2 ]]; then
    printf "%s: Incorrect number of arguments passed.\\n" "$0"
    printf "usage: %s ISO_IMAGE TARGET_PATH\\n" "$0"
    exit 1
fi

# Get user-specified ISO image and target drive to write the image to
SOURCE_PATH=$1
TARGET_PATH=$2

TARGET_RAW=$TARGET_PATH
if [[ $OSTYPE = "darwin" ]]; then
    # If macOS then use "raw" path to target to improve write speed:
    TARGET_RAW="${TARGET_PATH:0:5}r${TARGET_PATH:5}"
    # Convert the ISO image to a "UDIF R/W image" for writing to target drive
    hdiutil convert "$SOURCE_PATH" -format UDRW -o "$TEMP_IMG"
    # Unmount the target drive
    diskutil unmountDisk "$TARGET_PATH"
fi

if [[ $OSTYPE = "darwin" ]]; then
    # Write the image to the unmounted drive
    sudo dd if="${TEMP_IMG}.dmg" of="$TARGET_RAW" bs=4m && sync
elif [[ $OSTYPE = "linux-gnu" ]]; then
    sudo dd if="$SOURCE_PATH" of="$TARGET_RAW" bs=4M status=progress && sync
else
    printf "Error: Unrecognised operating system \"%s\"\\n" "$OSTYPE"
    exit 1
fi



# Clean up by removing the IMG file
rm output.img.dmg

exit 0
