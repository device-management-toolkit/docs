

Intel® One-Click Recovery (OCR) allows IT administrators to remotely trigger a secure and reliable boot to a recovery application, ensuring recovery from system failures, bare-metal scenarios, or connectivity issues using Intel AMT's out-of-band (OOB) connection.

## Supported Recovery Options

OCR supports three recovery modes:

- **UEFI HTTPS Network Boot**: Perform a network-based recovery using encrypted HTTPS.

- **Windows Recovery Environment (WinRE)**: Boot into Windows Recovery for troubleshooting and repair.

- **Local Pre-Boot Application (PBA)**: Launch a locally installed recovery or diagnostic tool.

## Where to Start

Depending on your recovery scenario, follow the appropriate section below:

- To recover using a **network-hosted ISO**, start with [HTTPS Boot](#https-boot).  
- To boot into **Windows Recovery Environment**, go to [Boot to Windows Recovery Environment](#boot-to-windows-recovery-environment).  
- To launch a **locally installed Pre-Boot Application**, continue with [Boot to Local PBA](#boot-to-local-pba).

---

## HTTPS Boot

### Prerequisites for HTTPS Boot

Before using HTTPS Network Boot, ensure the following prerequisites are met:

1. Enable HTTP(S) Boot in BIOS settings. This may be disabled by default on some devices.
    
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_HTTPSBOOT_BIOS.png" alt="Figure 1: Enable HTTP(S) Boot in BIOS">
    </figure>


2. When recovering a device using an ISO that isn’t signed by a trusted certificate authority, you’ll need to disable Secure Boot in the BIOS settings.
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\OCR_Disable_Secure_Boot.jpg" alt="Figure 2: Disable Secure Boot in BIOS">
    </figure>

3. Set up an HTTPS server to host the ISO.

    !!! info "HTTPS Server" 
        - For this guide, the HTTPS server is assumed to be running on the same host as the Console and is serving a full Ubuntu LTS image from: `https://192.168.88.250:5443/ubuntu.iso`.
        - Instructions for setting up an HTTPS server are not included here, so please ensure you have one ready. If you haven’t set it up yet, there are many helpful resources available online to guide you.

### Triggering HTTPS Boot

1. Connect to the Intel AMT device using Console over TLS.
    
    !!! danger "TLS Connection Required"

        Console must be connected to the AMT device over TLS for this feature to work.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_Connect_With_TLS.png" alt="Figure 3: Connect to a Device using TLS">
    </figure>

2. Enable `One Click Recovery (OCR)` feature in `General AMT Info` Section.
   
    !!! question "Is HTTPS Network Boot supported?"

        See the snapshot below — if the **HTTPS Network Boot** field shows **Supported**, the feature is available on the device.
    
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_HTTPS_Boot_Supported.png" alt="Figure 4: Enable HTTPS Network Boot">
    </figure>

3. Upload the Root Certificate of the HTTPS server hosting the ISO via the `Add New` certificates option.
    
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_ADD_TRUSTEDROOTCERT.png" alt="Figure 5: Add Root Certificate of HTTPS Server">
    </figure>

4. Click on the three-dot menu and select **Reset to HTTPS Boot (OCR)**.
    
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_Reset_to_HTTPS_Boot.png" alt="Figure 6: Reset to HTTPS Boot (OCR)">
    </figure>

5. Enter the ISO URL (e.g., https://192.168.88.250:5443/ubuntu.iso).
    
    !!! Tip "Check ISO URL"

        Ensure the HTTPS Server ISO URL is accessible to the device.
    
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_HTTPSBOOT_URL.png" alt="Figure 7: URL to the .iso hosted on HTTPS Server">
    </figure>

6. Optionally, enable `Enforce Secure Boot` to boot only a secure `.iso` file.

    !!! important "ACM vs CCM behavior"
        
        - For UEFI HTTPS Boot, AMT allows the Console to control the **Enforce Secure Boot** setting only when the device is provisioned in **Admin Control Mode (ACM)**.  
      
        - When operating in **Client Control Mode (CCM)**, **Secure Boot is always enforced** by AMT.
   
    !!! warning "Secure Boot"

        If Secure Boot is enabled, the UEFI BIOS must have the Root Certificate used to sign the ISO's bootloader in its trusted database (DB) to allow execution.

7. Click `OK` to start the recovery process. The device will restart and boot from the ISO.

8. Optionally, Connect to KVM and verify that the device loads the ISO.
    
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_HTTPSBoot_Recovery_Start.png" alt="Figure 8: View KVM screen while the ISO boots">
    </figure>

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\OCR_HTTPS_BOOT_UbuntuOS.png" alt="Figure 9: Full Ubuntu LTS Boot">
    </figure>
    
    !!! bug "KVM Keyboard Issue"

        If KVM is connected before initiating OCR via HTTPS Boot, the keyboard may not work when entering the URL.
 
---

## Boot to Windows Recovery Environment

### Prerequisites for Boot to WinRE

Before triggering a Boot to Windows Recovery Environment (WinRE), ensure that the AMT device meets the following prerequisites:

1. The device must have a **Windows operating system** installed with **Windows Recovery Environment (WinRE)** available and properly configured.

2. WinRE is typically included by default in most modern Windows installations (Windows 11, and Windows Server 2016 or later).

    !!! info "WinRE Configuration and Support"

        Please refer to the official Windows documentation to confirm which operating systems include WinRE support and for additional details on configuring or enabling WinRE.

### Triggering Boot to WinRE

1. Connect to the Intel AMT device using **Console** over **TLS**.

    !!! danger "TLS Connection Required"

        Console must be connected to the AMT device over TLS for this feature to work.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\OCR_Connect_With_TLS.png" alt="Figure 2: Connect to a Device using TLS">
    </figure>

2. Enable `One Click Recovery (OCR)` feature in `General AMT Info` Section.
   
    !!! question "Is Boot to Windows Recovery Environment supported?"

        See the snapshot below — if the **Windows Recovery Boot** field shows **Supported**, the feature is available on this device.
    
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\OCR_Boot_To_WinRE_Supported.png" alt="Figure 3: Enable OCR">
    </figure>

3. Optionally, start a **KVM session** if you want to observe the full recovery process.  

4. Click the **⋯ (three-dot)** menu and select **Reset to WinRE (OCR)**.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\OCR_Reset_to_WinRE.png" alt="Figure 1: Reset to WinRE (OCR)">
    </figure>

5. The device will immediately restart and boot into Windows Recovery Environment.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\OCR_Win_Recovery_Screen.png" alt="Figure 2: Windows Recovery Screen">
    </figure>

--- 

## Boot to Local PBA

### Prerequisites for Local PBA Boot

Before triggering a Local PBA boot, ensure that the EFI environment is properly prepared.

1. A signed `.efi` binary (for example, `OemPba.efi`) must be present on the EFI System Partition (ESP) of the AMT device.  

2. The EFI file path and name must **exactly match** the entry registered in BIOS so that it appears in the OCR dropdown list.  
   
    Connect to the device over **TLS** using Console, select **Reset to OCR**, and view the available PBA options to confirm the exact EFI path registered with AMT.

      <figure class="figure-image">
       <img src="..\..\..\..\assets\images\OCR_Reset_to_PBA_EFIPATH.png" alt="Figure 10: PBA Path registered with AMT">
      </figure>

3. The signing certificate of the PBA must be enrolled in the BIOS **Authorized Signatures (db)**.  

!!! info "Need help setting up the EFI?"

    This is just a reference example — there are multiple ways to achieve the same result.
    
    Follow the detailed [OCR PBA EFI Setup and Signing Guide](https://github.com/device-management-toolkit/console/wiki/OCR-PBA-EFI-Setup-and-Signing-Guide) for one example of how to sign the EFI, enroll its certificate, and place it on the EFI System Partition (ESP).
      

### Triggering Local PBA Boot

1. Connect to the Intel AMT device using **Console** over **TLS**.

    !!! danger "TLS Connection Required"

        Console must be connected to the AMT device over TLS for this feature to work.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\OCR_Connect_With_TLS.png" alt="Figure 11: Connect to a Device using TLS">
    </figure>

2. Enable `One Click Recovery (OCR)` feature in `General AMT Info` Section.
   
    !!! question "Is Boot to PBA supported?"

        See the snapshot below — if the **PBA Boot** field shows **Supported**, the feature is available on this device.
    
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\OCR_Boot_To_PBA_Supported.png" alt="Figure 12: Enable OCR">
    </figure>

3. Optionally, start a **KVM session** if you want to observe the full recovery process.

4. Click the **⋯ (three-dot)** menu and select **Reset to PBA (OCR)**.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\OCR_Reset_to_PBA.png" alt="Figure 13: Reset to PBA (OCR)">
    </figure>

5. From the dropdown, select the local recovery option corresponding to your EFI entry (for example, `\OemPba.efi`).

    !!! danger "Secure Boot Mandatory"

        Ensure the **Enforce Secure Boot** checkbox is enabled before initiating the PBA boot.

        For Boot to Local PBA, Secure Boot is always enforced by Intel® AMT, as AMT does not control the origin or integrity of locally installed PBAs.

   
    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\OCR_Reset_to_PBA_SelectPBA_Dropdown.png" alt="Figure 14: Select PBA">
    </figure>

6. Click **OK** to confirm.

7. The device will immediately restart and boot into the selected PBA EFI application.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\OCR_PBA_Boot_Netboot_EFI.png" alt="Figure 15: Booting into Local PBA EFI">
    </figure>

---

If you see any issues, please log them on our [GitHub Issues page](https://github.com/device-management-toolkit/console/issues) or reach out to us on our **Discord channel**.