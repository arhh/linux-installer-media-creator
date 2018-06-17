# linux-installer-media-creator
A script which executes a number of commands, often used in macOS, for creating bootable Linux installer media.

## Important:
I am not responsible for any loss/corruption of data/devices when this program is used, use at your own risk. To this end, make sure you **pass the correct device** as the "target-device" argument.

## Notes:
  * The script has been tested on macOS 10.12 Sierra, however the commands used by this script are present in all recent macOS revisions, so it should work on those too.
  * The block size used by the _dd_ command in this script is 1m.
  * There is no need to convert the ISO image to IMG as this is created by the script itself in the current working directory, and is deleted when the script completes.
  * Currently, if an error occurs while inside the script (cannot unmount target disk, etc.) the script will quick "ungracefully". This means the IMG file that is automatically created will not be deleted as normal.

## Usage:
linux\_installer\_creator.sh "iso-image" "target-disk"
