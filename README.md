# linux-installer-media-creator
A number of popular commands used by macOS for creating bootable Linux installer media, gathered together into one Bash script.

## Notes:
  * The script has been tested on macOS 10.12 Sierra, however the commands used by this script are present in all recent macOS revisions, so it should work in those too.
  * The block size used by the _dd_ command in this script is 1m.
  * There is no need to convert the ISO image to IMG as this is done by the script itself.

## Usage:
linux\_installer\_creator.sh "iso-image" "target-disk"
