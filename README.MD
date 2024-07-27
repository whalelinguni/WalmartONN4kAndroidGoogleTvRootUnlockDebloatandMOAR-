# WIP: I Bricked My Device
## Overview

**Device Status**:
- After a wipe, the device updated.
- Flashing the bootloader resulted in bricking.
- Initially in a bootloop; now it boots to the 'onn' boot screen logo but isn't detected by the computer via USB.

## Rooting and Unlocking Information

### Rooting
- **Cable**: Use a micro-USB cable from the Onn Android box to the computer.
- **Developer Options and Debugging**:
  - Enable Developer Options.
  - Enable USB Debugging (may need a restart to take effect).
  - Detailed rooting steps to be added.

### Input Issues
- You might encounter random issues with inputs, such as buttons not clicking or selections not visible. For troubleshooting, consider using a reliable OTG cable or ADBAppControl ([link](https://adbappcontrol.com/en/)).

### Script Status
- The scripts provided are incomplete. However, you might find some useful elements in them.

### OEM Unlock
- If the OEM unlock option is greyed out, try the following steps:
  - Reboot into fastboot mode: `adb reboot fastboot`
  - Execute the OEM flashing unlock command.

### Magisk Issues
- Magisk v27 had compatibility issues. If you encounter problems, reverting to Magisk v26.1, as suggested by many write-ups, might resolve them. As of July 2024, Magisk v27 is known to have issues. Avoid using it or upgrading from v26.1 to v27.

### Debloat Caution
- Be cautious when debloating. Testing scripts might inadvertently cause system issues. If this happens, a reset and fresh start might be necessary.

### USB Debugging
- Enabling USB debugging might require a specific sequence to function properly. If it doesn’t work initially, try restarting the device.

### ADB over Wi-Fi
- ADB can operate over Wi-Fi. Use the command: `adb connect <ip>:5555`.

### Firmware
- I have downloaded various firmwares, including an unofficial Lineage 21 version and an OTA.zip of a different version. No additional modifications have been made.

### Original Resources
- [Onn 4K 2023 Streaming Box Rooting and Remote Button Remapping](https://github.com/whitewolf101/Onn.-4k-2023-Streaming-Box-Rooting-and-Remote-Button-Remapping)

### Additional Resources
- For button mapping and OTA.zip details beyond LineageOS:
  - [XDA Forums - Official/Unofficial LineageOS 19.1 for Amlogic G12-SM1 Family Devices](https://xdaforums.com/t/official-unofficial-lineageos-19-1-for-amlogic-g12-sm1-family-devices.4313743/page-6)
- Other information sources:
  - [Walmart Onn Google TV 4K Guide](https://xdaforums.com/t/guides-2023-walmart-onn-google-tv-4k-yoc.4610749/)
  - [Stakeout5 Epic TV - Walmart Onn 4K Streaming Box Root/Unlock](https://www.stakeout5epictv.cyou/2022/05/01/walmart-onn-4k-streaming-box-root-unlock-bootloader-remote-remap-and-more/)
  - [XDA Forums - Official LineageOS 21 for Amlogic GXL/GXM/G12-SM1-NE Family Devices](https://xdaforums.com/t/official-lineageos-21-for-amlogic-gxl-gxm-g12-sm1-ne-family-devices.4649881/)
  - Firmware: `dopinder-qt.20210519-factory.zip`

### Additional Links
- [Onn 4K 2023 Streaming Box Rooting and Remote Button Remapping](https://github.com/whitewolf101/Onn.-4k-2023-Streaming-Box-Rooting-and-Remote-Button-Remapping)
- [Universal Android Debloater](https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation)
- [Awesome Android TV FOSS Apps](https://github.com/Generator/Awesome-Android-TV-FOSS-Apps?tab=readme-ov-file)
- [AppManager](https://github.com/MuntashirAkon/AppManager)

## WIP Recovery Attempts

### eMMC Information
- **Samsung KLM8G1GETF BGA Package**: Could not find a reset pin on the board.

### Resources
- [Amlogic USB Burning Tool](https://androidmtk.com/download-amlogic-usb-burning-tool)
- [FCC ID Report](https://device.report/fccid/2ayys-8822k4vtg)
- [Entering Mask Mode/Device Firmware Upgrade Mode](https://xdaforums.com/t/entering-mask-mode-device-firmware-upgrade-mode-recovery-with-2-tiny88.4528955/)
- [Firmware Upgrade Guide for Amlogic S805/S905 Devices](https://xdaforums.com/t/firmware-upgrade-guide-for-amlogic-s805-s905-devices.3323358/)
- [Amlogic S912/S905 FAQ](https://xdaforums.com/t/amlogic-s912-s905-faq-fix-root-hide-su-backup-restore-media-player-tv-box.3752897/)
- [Firmware for TV Box Q8 Amlogic S905Y4](https://androidpctv.com/firmware-tv-box-q8-amlogic-s905y4-android/)

## FW Version & Issues

- As of now (July 2024) only the older FW revisions can be unlocked and rooted. Once upgraded, you cannot downgrade.
- Unlockable and rootable versions can be identified by the number on the bottom of the box under the serial number.
  - Versions 23xx can be unlocked & rooted; versions 24xx are updated and cannot.
- The Amlogic chip does not work with previous tools such as USB burn. Instead, they are based on ADNL, which has little documentation and only a small number of people working on it.
- Shorting a test point to the shield during boot will get the device into the bootloader, but a password is required to do anything, which is currently a dead end.

- For more information, read the thread here (page 11 onwards has most info on FW revisions): https://xdaforums.com/t/guides-2023-walmart-onn-google-tv-4k-yoc.4610749/page-11
