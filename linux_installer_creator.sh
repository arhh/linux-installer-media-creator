#!/usr/bin/env bash

TEMP_IMG="output.img"
OS_TYPE=$(uname)

if [[ "$OS_TYPE" = "Darwin" ]]; then
    IS_MACOS=1
fi

if [[ "$1" = "--help" ]]; then
    printf "\\nWrite Linux ISO images to removable drives.\\n"
    printf "\\nUSAGE:\\n"
    printf "\\t%s ISO_IMAGE TARGET_PATH\\n" "$0"
    printf "\\nNOTES:\\n"
    printf "\\tThe image passed to this script should be in \"ISO\" format.\\n"
    printf "\\tThis script uses the unbuffered \"raw\" disk write (i.e. rdiskN) when run in macOS.\\n"
    printf "\\tRoot privileges required.\\n"
    printf "\\tA temporary file equal to the source iso will be created in the current directory called \"output.img.dmg\" in macOS.\\n"
    exit 0
fi

if [[ $# -ne 2 ]]; then
    printf "%s: Incorrect number of arguments passed.\\n" "$0"
    printf "usage: %s ISO_IMAGE TARGET_PATH\\n" "$0"
    exit 1
fi

ISO_IMAGE=$1
TARGET_PATH=$2

SOURCE=$ISO_IMAGE
TARGET_RAW=$TARGET_PATH

if [[ -z "$IS_MACOS" ]]; then
    umount "${TARGET_PATH}"?
else
    TARGET_RAW="${TARGET_PATH:0:5}r${TARGET_PATH:5}"
    hdiutil convert "$ISO_IMAGE" -format UDRW -o "$TEMP_IMG"
    SOURCE="${TEMP_IMG}.dmg"
    diskutil unmountDisk "$TARGET_PATH"
fi

if [[ -z "$IS_MACOS" ]]; then
    DD_COMMAND="sudo dd if=\"$ISO_IMAGE\" of=\"$TARGET_RAW\" bs=32M status=progress conv=fsync"
else
    DD_COMMAND="sudo dd if=\"$SOURCE\" of=\"$TARGET_RAW\" bs=32m && sync"
fi

eval "$DD_COMMAND"

# Remove temporary img file in macOS
if [[ -f "${TEMP_IMG}.dmg" ]]; then
    rm "${TEMP_IMG}.dmg"
fi

exit 0
