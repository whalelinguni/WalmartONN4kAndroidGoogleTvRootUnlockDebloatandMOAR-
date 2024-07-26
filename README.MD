# WIP: I Bricked My Device
## This is messy informations. 

- I did not notice that it had updated after a wipe.
- Flashed the bootloader; now it is bricked.
- Device initially was bootlooping. I tried holding the button to see if that would allow me to recover or do anything.
- Now it boots to the 'onn' boot screen logo and is not detected by the computer via USB.

## Rooting/Unlocking Information
- **Rooting**:
  - Use a mcrousb cable from the Onn Android box to the computer.
  - Enable Developer Options and Debugging (may need to restart to work).
  - .... root and things I didn't write this out yet. 
  
- **Input Issues**: You might encounter random issues with inputs, such as buttons not clicking or selections not visible. For troubleshooting, consider using a reliable OTG cable or ADBAppControl ([link](https://adbappcontrol.com/en/)).

- **Script Status**: The scripts provided are incomplete. However, you might find some useful elements in them.

- **OEM Unlock**:
  - If the OEM unlock option is greyed out, try the following steps:
    - Reboot into fastboot mode: `adb reboot fastboot`
    - Execute the OEM flashing unlock command (if I recall correctly).

- **Magisk Issues**:
  - Magisk v27 had compatibility issues. If you encounter problems, reverting to Magisk v26.1, as suggested by many write-ups, might resolve them. As of July 2024, Magisk v27 is known to have issues. Avoid using it or upgrading from v26.1 to v27.

- **Debloat Caution**:
  - Be cautious when debloating. Testing scripts might inadvertently cause system issues. If this happens, a reset and fresh start might be necessary.

- **USB Debugging**:
  - Enabling USB debugging might require a specific sequence to function properly. If it doesn’t work initially, try restarting the device.

- **ADB over Wi-Fi**:
  - ADB can operate over Wi-Fi. Use the command: `adb connect <ip>:5555`.

- **Firmware**:
  - I have downloaded various firmwares, including an unofficial Lineage 21 version and an OTA.zip of a different version. No additional modifications have been made.

- **Original Resources**:
  - [Onn 4K 2023 Streaming Box Rooting and Remote Button Remapping](https://github.com/whitewolf101/Onn.-4k-2023-Streaming-Box-Rooting-and-Remote-Button-Remapping)

- **Additional Resources**:
  - For button mapping and OTA.zip details beyond LineageOS:
    - [XDA Forums - Official/Unofficial LineageOS 19.1 for Amlogic G12-SM1 Family Devices](https://xdaforums.com/t/official-unofficial-lineageos-19-1-for-amlogic-g12-sm1-family-devices.4313743/page-6)
  - Other information sources:
    - [Walmart Onn Google TV 4K Guide](https://xdaforums.com/t/guides-2023-walmart-onn-google-tv-4k-yoc.4610749/)
    - [Stakeout5 Epic TV - Walmart Onn 4K Streaming Box Root/Unlock](https://www.stakeout5epictv.cyou/2022/05/01/walmart-onn-4k-streaming-box-root-unlock-bootloader-remote-remap-and-more/)
    - [XDA Forums - Official LineageOS 21 for Amlogic GXL/GXM/G12-SM1-NE Family Devices](https://xdaforums.com/t/official-lineageos-21-for-amlogic-gxl-gxm-g12-sm1-ne-family-devices.4649881/)
    - Firmware: `dopinder-qt.20210519-factory.zip`

- **Additional Links**:
  - [Onn 4K 2023 Streaming Box Rooting and Remote Button Remapping](https://github.com/whitewolf101/Onn.-4k-2023-Streaming-Box-Rooting-and-Remote-Button-Remapping)
  - [Universal Android Debloater](https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation)
  - [Awesome Android TV FOSS Apps](https://github.com/Generator/Awesome-Android-TV-FOSS-Apps?tab=readme-ov-file)
  - [AppManager](https://github.com/MuntashirAkon/AppManager)

# Random Links and Information Bookmarked or Looked Into

## WIP Recovery Attempts

This section will be a collection of information for now.

- **eMMC Information**: Samsung KLM8G1GETF BGA Package.
  - I could not find a reset pin on the board.

- **Resources**:
  - [Amlogic USB Burning Tool](https://androidmtk.com/download-amlogic-usb-burning-tool)
  - [FCC ID Report](https://device.report/fccid/2ayys-8822k4vtg)
  - [Entering Mask Mode/Device Firmware Upgrade Mode](https://xdaforums.com/t/entering-mask-mode-device-firmware-upgrade-mode-recovery-with-2-tiny88.4528955/)
  - [Firmware Upgrade Guide for Amlogic S805/S905 Devices](https://xdaforums.com/t/firmware-upgrade-guide-for-amlogic-s805-s905-devices.3323358/)
  - [Amlogic S912/S905 FAQ](https://xdaforums.com/t/amlogic-s912-s905-faq-fix-root-hide-su-backup-restore-media-player-tv-box.3752897/)
  - [Firmware for TV Box Q8 Amlogic S905Y4](https://androidpctv.com/firmware-tv-box-q8-amlogic-s905y4-android/)


