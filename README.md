# linux-installer-media-creator
A script which executes a number of commands typically used in macOS for creating bootable Linux installer media.

## Important:
I am not responsible for any loss/corruption of data/devices when this program is used, use at your own risk. To this end, make sure you **pass the correct device** as the "target-device" argument.

## Notes:
  * The script has been tested on macOS 10.12 and 10.13, however the commands used in this script are present in all recent macOS revisions, so it should work on those too.
  * The block size used by the _dd_ command in this script is 1m. This can changed to suit your requirements.
  * There is no need to convert the ISO image to IMG as this is created by the script itself in the current working directory, and is deleted when the script completes.
  * Currently, the script will quit "ungracefully" if an error occurs (cannot unmount target disk, etc.), meaning the IMG file that the script creates will not be deleted automatically.

## Usage:
```
linux_installer_creator.sh "iso-image" "target-disk"
```

## Motivation for Writing This
Executing the same set of commands to get Linux ISOs on USB drives was getting repetitive. I didn't want to install third-party GUIs so I just wrote this bash script.
