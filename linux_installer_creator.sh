#!/bin/bash
set -e

# Check if user supplied correct number of arguments for script to execute correctly:
if [[ "$1" != "--help" ]] && [[ $# -ne 2 ]]; then
    printf "Error: Incorrect number of arguments passed.\n"
    printf "Syntax: bootable_linux_usb.sh 'iso-image' 'target-device'\n"
    exit 1
fi

# # Check if user requested help and display help:
if [[ "$1" = "--help" ]]; then
    printf "\nWrite Linux ISO images to removable drives using macOS.\n"
    printf "\nUSAGE:\n"
    printf "\tbootable_linux_usb.sh 'iso-image' 'target-drive'\n"
    printf "\nNOTES:\n"
    printf "\tThe image passed to this script should be in ISO format, there is no need to convert the image to an IMG file as this script will do that automatically.\n"
    exit 0
fi

# Get user-specified ISO image and target drive to write the image to:
iso_file=$1
target_drive=$2

# Create raw path to target drive for faster write:
raw_target_drive="${target_drive:0:5}r${target_drive:5}"

# Convert the ISO image to an IMG for writing to target drive:
hdiutil convert -format UDRW -o output.img $iso_file

# Unmount the target drive:
diskutil unmountDisk $target_drive

# Write the image to the unmounted drive:
sudo dd if=output.img.dmg of=$raw_target_drive bs=1m

# Clean up by removing the IMG file:
rm output.img.dmg

exit 0
