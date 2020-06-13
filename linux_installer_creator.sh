#!/bin/bash
set -e

# Check if user requested help and display help:
if [[ "$1" = "--help" ]]; then
    printf "\nWrite Linux ISO images to removable drives using macOS.\n"
    printf "\nUSAGE:\n"
    printf "\tbootable_linux_usb.sh 'iso-image' 'target-drive'\n"
    printf "\nNOTES:\n"
    printf "\tThe image passed to this script should be in ISO format.\n"
    exit 0
fi

# Display an error if incorrect number of arguments passed:
if [[ $# -ne 2 ]]; then
    printf "Error: Incorrect number of arguments passed.\n"
    printf "Syntax: bootable_linux_usb.sh 'iso-image' 'target-device'\n"
    exit 1
fi

# Get user-specified ISO image and target drive to write the image to:
ISO_FILE=$1
TARGET_DRIVE=$2

# Create "raw" path to target drive for faster write:
RAW_TARGET_DRIVE="${TARGET_DRIVE:0:5}r${TARGET_DRIVE:5}"

# Convert the ISO image to an IMG for writing to target drive:
hdiutil convert -format UDRW -o output.img $ISO_FILE

# Unmount the target drive:
diskutil unmountDisk $TARGET_DRIVE

# Write the image to the unmounted drive:
sudo dd if=output.img.dmg of=$RAW_TARGET_DRIVE bs=1m

# Clean up by removing the IMG file:
rm output.img.dmg

exit 0
