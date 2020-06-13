# linux-installer-media-creator
A script developed for macOS systems to create a bootable Linux installer on a removable drive.

## Important:
I am not responsible for any loss/corruption of data/devices when this program is used, use at your own risk.

## Notes:
  * The script has been tested on macOS 10.12 and subsequent versions.
  * The script creates an IMG file from the passed ISO file using the `hdiutil` command. The generated image file will be deleted on a successful exit of the script.
  * Currently, the script will quit "ungracefully" if an error occurs (cannot unmount target disk, etc.), the created IMG file is not automatically deleted in this case.

## Usage:
```
linux_installer_creator.sh <path-to-iso-image> <path-to-target-disk>
```
1. Insert the disk on which you will add the Linux installer.
2. Open Terminal and run `diskutil list` to find the path to the disk mounted above (e.g. "/dev/disk1")
3. Change to the directory where you have this script downloaded.
4. Run the command as above, with `<path-to-iso-image>` set to the path to your Linux .ISO image file, and `<path-to-target-disk>` set to the disk path you noted in step 2 above.
5. Type root user password when prompted.
6. When script completes, run `diskutil eject <path-to-target-disk>` before removing the drive from your computer.

## Motivation for Writing This
Executing the same set of commands to get Linux ISOs on USB drives was getting repetitive. I didn't want to install third-party GUIs so I just wrote this bash script.
