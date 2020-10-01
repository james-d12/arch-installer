# Overview
The 'resources/packages' contains a list of packages for the following areas:
    - Packages within the standard repositories.
    - Packages within the AUR.
    - Python-PIP package libraries.
    - Visual Studio Code Extensions.
If you do not want to install pip packages for example you can simply remove all the items within the list.

# STEPS:
1. Connect to the internet.
2. Partition drive in one of the supported layouts.
3. Run 'bash arch-install-00.sh'
4. Answer any prompts.
5. After script has finished, reboot machine.
6. Login to new user account.
7. A folder 'arch-linux-scripts/' should've been created in the home folder of the new user.
8. Run the 'arch-install-03.sh' script to install the desktop environment specified in the config
file and to install the packages in the 'resources/packages' files.
9. Reboot machine. 
10. If all goes well, you should be greeted with the login manager of your choice. NOTE if no 
login manager appears it may mean that the login manager you wanted to install did not get 
it's specific systemd service enabled, for example gdm (gnome's login manager) requires 
'systemctl enable gdm.service' to be run to enable it to start automatically. Read the appropriate
arch wiki page concerning your chosen login manager about enabling the service. 

This installation script currently is quite specific in the setup for the parititions. This aims to 
be fixed by allowing users to specify in the config file the SWAP, EFI, ROOT, ETC partitions.

# Supported DRIVE Layouts

WHERE DRIVE NAME = SDA (SUBSTITUTE SDA FOR YOUR DRIVE NAME)

## UEFI: 

/dev/sda1 = EFI Partition       TYPE: EFI FILESYSTEM
/dev/sda2 = SWAP Partition      TYPE: LINUX SWAP 
/dev/sda3 = ROOT Partition      TYPE: LINUX FILESYSTEM

## UEFI ENCRYPTED:

/dev/sda1 = EFI Partition       TYPE: EFI FILESYSTEM 
/dev/sda2 = BOOT Partition      TYPE: LINUX FILESYSTEM
/dev/sda3 = ROOT Partition      TYPE: LINUX FILESYSTEM

SWAP is created within the ROOT partition so that it's contents are encrypted

## BIOS: 

/dev/sda1 = SWAP Partition      TYPE: LINUX SWAP / SOLARIS
/dev/sda2 = ROOT Partition      TYPE: LINUX 

## BIOS ENCRYPTED: 

/dev/sda1 = BOOT Partition      TYPE: LINUX | MARK AS *BOOTABLE*
/dev/sda2 = ROOT Partition      TYPE: LINUX

SWAP is created within the ROOT partition so that it's contents are encrypted