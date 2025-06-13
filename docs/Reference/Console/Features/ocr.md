--8<-- "References/abbreviations.md"

Intel® One-Click Recovery (OCR) allows IT administrators to remotely trigger a secure and reliable boot to a recovery application, ensuring recovery from system failures, bare-metal scenarios, or connectivity issues using Intel AMT's out-of-band (OOB) connection.

Console now supports triggering HTTPS Boot, allowing IT administrators to initiate recovery via a secure network boot from a specified URL.

### Supported Recovery Options

OCR supports three recovery modes:

- **UEFI HTTPS Network Boot**: Perform a network-based recovery using encrypted HTTPS.

- **Microsoft Windows Recovery Environment (WinRE)**: Boot into Windows Recovery for troubleshooting and repair.

- **Local Pre-Boot Application (PBA)**: Launch a locally installed recovery or diagnostic tool.


!!! info "Future Enhancements"

    - Console currently only supports HTTPS Network Boot feature.
    - HTTPS Boot feature only works when the device is connected via a wired network.

    We plan to include **Wireless support** and add additional **One Click Recovery features** in future updates.  


### Prerequisites for HTTPS Boot

Before using HTTPS Network Boot, ensure the following prerequisites are met:

1. Enable HTTP(S) Boot in BIOS settings. This may be disabled by default on some devices.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_HTTPSBOOT_BIOS.png" alt="Figure 1: Enable HTTP(S) Boot in BIOS">
    </figure>

2. Set up an HTTPS server to host the ISO.

    !!! info "HTTPS Server" 
        - In this guide, the HTTPS server is running on the same machine as the Console, serving a full Ubuntu LTS image at https://192.168.88.250:5443/ubuntu.iso.
        - Instructions for setting up an HTTPS server are not included here, so please ensure you have one ready. If you haven’t set it up yet, there are many helpful resources available online to guide you.

### Triggering HTTPS Boot via Console

1. Connect to the Intel AMT device using Console over TLS.
    
    !!! danger "TLS Connection Required"

        Console must be connected to the AMT device over TLS for this feature to work.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_Connect_With_TLS.png" alt="Figure 2: Connect to a Device using TLS">
    </figure>

2. Enable `HTTPS Network boot` feature in `General AMT Info` Section.
   
    !!! question "Is HTTPS Network Boot supported?"

        If the **HTTPS Network boot** checkbox is greyed out, this feature is not supported on your device. 
    
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_Enable_HTTPS_BOOT.png" alt="Figure 3: Enable HTTPS Network Boot">
    </figure>

3. Upload the Root Certificate of the HTTPS server hosting the ISO via the `Add New` certificates option.
    
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_ADD_TRUSTEDROOTCERT.png" alt="Figure 4: Add Root Certificate of HTTPS Server">
    </figure>

4. Click on the three-dot menu and select **Reset to HTTPS Boot (OCR)**.
    
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_Reset_to_HTTPS_Boot.png" alt="Figure 5: Reset to HTTPS Boot (OCR)">
    </figure>

5. Enter the ISO URL (e.g., https://192.168.88.250:5443/ubuntu.iso).
    
    !!! Tip "Check ISO URL"

        Ensure the HTTPS Server ISO URL is accessible to the device.
    
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_HTTPSBOOT_URL.png" alt="Figure 6: URL to the .iso hosted on HTTPS Server">
    </figure>

6. Optionally, enable `Enforce Secure Boot` to boot only a secure `.iso` file.
   
    !!! warning "Secure Boot"

        If Secure Boot is enabled, the UEFI BIOS must have the Root Certificate used to sign the ISO's bootloader in its trusted database (DB) to allow execution.

7. Click `OK` to start the recovery process. The device will restart and boot from the ISO.

8. Optionally, Connect to KVM and verify that the device loads the ISO.
    
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_HTTPSBoot_Recovery_Start.png" alt="Figure 7: View KVM screen while the ISO boots">
    </figure>

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_HTTPS_BOOT_UbuntuOS.png" alt="Figure 8: Full Ubuntu LTS Boot">
    </figure>
    
    !!! bug "KVM Keyboard Issue"

        If KVM is connected before initiating OCR via HTTPS Boot, the keyboard may not work when entering the URL.
 