#!/bin/bash
set -e

# Check if user requested help and display help:
if [[ "$1" = "--help" ]]; then
    printf "\nWrite Linux ISO images to removable drives using macOS.\n"
    printf "\nUSAGE:\n"
    printf "\t%s ISO_IMAGE TARGET_DRIVE\n" $0
    printf "\nNOTES:\n"
    printf "\tThe image passed to this script should be in ISO format.\n"
    printf "\tThis script uses the unbuffered 'raw' disk write (i.e. rdiskN).\n"
    printf "\tRoot privileges required.\n"
    exit 0
fi

# Display an error if incorrect number of arguments passed:
if [[ $# -ne 2 ]]; then
    printf "%s: Incorrect number of arguments passed.\n" $0
    printf "usage: %s ISO_IMAGE TARGET_DRIVE\n" $0
    exit 1
fi

# Get user-specified ISO image and target drive to write the image to:
ISO_FILE=$1
TARGET_DRIVE=$2

# Create "raw" path to target drive for faster write:
RAW_TARGET_DRIVE="${TARGET_DRIVE:0:5}r${TARGET_DRIVE:5}"

# Convert the ISO image to a "UDIF R/W image" for writing to target drive:
hdiutil convert $ISO_FILE -format UDRW -o output.img

# Unmount the target drive:
diskutil unmountDisk $TARGET_DRIVE

# Write the image to the unmounted drive:
sudo dd if=output.img.dmg of=$RAW_TARGET_DRIVE bs=4m && sync

# Clean up by removing the IMG file:
rm output.img.dmg

exit 0
