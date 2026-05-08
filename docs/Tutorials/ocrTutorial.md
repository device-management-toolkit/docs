

Intel® One-Click Recovery (OCR) enables IT administrators to remotely and securely boot a device into a recovery environment using Intel AMT's out-of-band (OOB) connection. This ensures reliable recovery from system failures, bare-metal states, or connectivity issues.

In cloud deployments, the Management Presence Server (MPS) now supports a secure power action to initiate HTTPS Boot, allowing recovery from a specified network URL.

## Supported Recovery Options in OCR

- **UEFI HTTPS Network Boot**: Securely boot a recovery image over HTTPS.

- **Windows Recovery Environment (WinRE)**: Access Windows tools for repair and troubleshooting.

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
      <img src="..\..\assets\images\OCR_HTTPSBOOT_BIOS.png" alt="Figure 1: Enable HTTP(S) Boot in BIOS">
    </figure>

2. When recovering a device using an ISO that isn’t signed by a trusted certificate authority, you’ll need to disable Secure Boot in the BIOS settings.
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_Disable_Secure_Boot.jpg" alt="Figure 2: Disable Secure Boot in BIOS">
    </figure>

3. Set up an HTTPS server to host the ISO.

    !!! info "HTTPS Server"      
        - For this guide, the HTTPS server is assumed to be running on the same host as the containers and is serving a full Ubuntu LTS image from: `https://192.168.88.216:5443/ubuntu.iso`.
        - Setup instructions for the HTTPS server are not included here. Please ensure you have a functional HTTPS server configured beforehand. If needed, numerous online resources are available to help you get started.

4. Make sure that the device shows as connected in the Sample UI or via the Get Device MPS API 

### HTTPS Boot using Cloud Deployment

You can use our [MPS APIs](#triggering-https-boot-via-mps-apis) to perform recovery using HTTPS boot, but for quick demos and to understand how you can first test it, we've also implemented it in the [Sample UI](#triggering-https-boot-using-sample-ui).

### Triggering HTTPS Boot using Sample UI

1. Make sure that the target device shows as connected
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_Device_Connected.png" alt="Figure 3: Device connected to MPS">
    </figure>

2. Enable `One Click Recovery (OCR)` feature in `General AMT Info` Section.
   
    !!! question "Is HTTPS Network Boot supported?"

        See the snapshot below — if the **HTTPS Network Boot** field shows **Supported**, the feature is available on the device.
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_HTTPS_Boot_Supported.png" alt="Figure 4: Enable HTTPS Network Boot">
    </figure>

3. Upload the Root Certificate of the HTTPS server hosting the ISO via the `Add New` certificates option.
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_ADD_TRUSTEDROOTCERT.png" alt="Figure 5: Add Root Certificate of HTTPS Server">
    </figure>

4. Click on the three-dot menu and select **Reset to HTTPS Boot (OCR)**.
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_Reset_to_HTTPS_Boot.png" alt="Figure 6: Reset to HTTPS Boot (OCR)">
    </figure>

5. Enter the ISO URL (e.g., https://192.168.88.216:5443/ubuntu.iso).
    
    !!! Tip "Check ISO URL"

        Ensure the HTTPS Server ISO URL is accessible to the device.
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_HTTPSBOOT_URL.png" alt="Figure 7: URL to the .iso hosted on HTTPS Server">
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
      <img src="..\..\assets\images\OCR_MPS_HTTPSBoot_Recovery_Start.png" alt="Figure 8: View KVM screen while the ISO boots">
    </figure>

    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_HTTPS_BOOT_UbuntuOS.png" alt="Figure 9: Full Ubuntu LTS Boot">
    </figure>
    
    !!! bug "KVM Keyboard Issue"

        If KVM is connected before initiating OCR via HTTPS Boot, the keyboard may not work when entering the URL.


### Triggering HTTPS Boot via MPS APIs

1. **Authenticate and Get Login Token:**
    
    First, authenticate with MPS and retrieve a token to use for all subsequent API calls. Save this token to use in the `Authorization` header for the next steps.

    ```bash
    curl --insecure -X POST https://<IP_ADDRESS_OR_FQDN_OF_SERVER>/mps/login/api/v1/authorize -H "Content-Type:application/json" -d "{\"username\":\"<MPS_WEB_ADMIN_USER>\", \"password\":\"<MPS_WEB_ADMIN_PASSWORD>\"}"
    ```

    **Expected Response:**

    ```json
    {"token":"<YOUR_JWT_TOKEN>"}
    ```


2. **Get Connected Devices:**

    Fetch the list of connected devices.

    ```bash
    curl --insecure https://<IP_ADDRESS_OR_FQDN_OF_SERVER>/mps/api/v1/devices -H "Authorization: Bearer <YOUR_JWT_TOKEN>"
    ```

    *Example Response:*

    ```json
    [
      {
        "guid": "5d52da54-199c-cc3c-3e96-88aedd668dff",
        "hostname": "DESKTOP-VDGKNB5"
        "....."
      }
    ]
    ```

    !!! tip "Next Steps"
        Select the GUID of your target device (e.g., 5d52da54-199c-cc3c-3e96-88aedd668dff) for use in subsequent steps.


3. **Check AMT Features and OCR Support:**

    Verify that the target device supports OCR and HTTPS Boot. If "ocr": false, proceed to Step 4 to enable it.

    ```bash
    curl --insecure https://<IP_ADDRESS_OR_FQDN_OF_SERVER>/mps/api/v1/amt/features/<DEVICE_GUID> -H "Authorization: Bearer <YOUR_JWT_TOKEN>"
    ```

    **Look for:**

    ```json
    "ocr": true,
    "httpsBootSupported": true
    ```
    
    !!! question "Is HTTPS Network Boot supported?"

        If the `httpsBootSupported` property is `false`, the device does not support HTTPS Boot using Intel AMT. This is a read-only value reported by Intel AMT and cannot be modified.


4. **Enable OCR (if not already enabled):**

    If OCR is not enabled from Step 3, use this command to enable it:

    ```bash
    curl --insecure -X POST https://<IP_ADDRESS_OR_FQDN_OF_SERVER>/mps/api/v1/amt/features/<DEVICE_GUID> -H "Content-Type: application/json" -H "Authorization: Bearer <YOUR_JWT_TOKEN>" -d "{\"enableIDER\":true,\"enableKVM\":true,\"enableSOL\":true,\"userConsent\":\"none\",\"redirection\":true,\"ocr\":true}"
    ```

    **Expected Response:**

    ```json
    {"status":"AMT Features updated"}
    ```


5. **Upload Trusted Root Certificate:**

    This is the HTTPS server certificate hosting the .iso.
    
    First, generate the base64-encoded string of your certificate. Use this PowerShell command as an example:

    === "PowerShell"
        ```powershell
        [Convert]::ToBase64String([IO.File]::ReadAllBytes("<PATH_TO_CERTIFICATE_FILE>"))
        ```

    === "Linux/macOS"
        ```bash
        base64 -i <PATH_TO_CERTIFICATE_FILE>
        ```

    Then, to upload the certificate use the curl command:

    ```bash
    curl --insecure -X POST https://<IP_ADDRESS_OR_FQDN_OF_SERVER>/mps/api/v1/amt/certificates/<DEVICE_GUID> -H "Content-Type: application/json" -H "Authorization: Bearer <YOUR_JWT_TOKEN>" -d "{\"cert\":\"<BASE64_ENCODED_CERT>\",\"isTrusted\":true}"
    ```

    **Expected Response:**

    ```json
    {"handle":"Intel(r) AMT Certificate: Handle: 2"}
    ```


6. **Trigger OCR via HTTPS Boot:**

    Send the power action to initiate OCR with the HTTPS ISO:

    ```bash
    curl --insecure -X POST https://<IP_ADDRESS_OR_FQDN_OF_SERVER>/mps/api/v1/amt/power/bootoptions/<DEVICE_GUID> -H "Content-Type: application/json" -H "Authorization: Bearer <YOUR_JWT_TOKEN>" -d "{\"action\":105,\"useSOL\":false,\"bootDetails\":{\"url\":\"<ISO_URL>\",\"username\":\"\",\"password\":\"\",\"enforceSecureBoot\":true}}"
    ```

    **Expected Response:**

    ```json
    {"Body":{"ReturnValue":0,"ReturnValueStr":"SUCCESS"}}
    ```

7. Optionally, Connect to KVM and verify that the device loads the ISO.
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_HTTPSBoot_Recovery_Start_MPS.png" alt="Figure 10: View KVM screen while the ISO boots">
    </figure>

#### API Reference

| Action Code | Description |
|--------------|--------------|
| **105** | Reset to HTTPS Boot |
| **106** | Power on to HTTPS Boot |

| Endpoint | Method | Purpose | JSON Structure |
|----------|---------|----------|----------------|
| `/mps/login/api/v1/authorize` | POST | Authenticate and get JWT token | `{"username":"<MPS_WEB_ADMIN_USER>", "password":"<MPS_WEB_ADMIN_PASSWORD>"}` |
| `/mps/api/v1/devices` | GET | List connected devices | N/A |
| `/mps/api/v1/amt/features/<GUID>` | GET | Check device AMT features | N/A |
| `/mps/api/v1/amt/features/<GUID>` | POST | Enable/disable AMT features | `{"enableIDER":true,"enableKVM":true,"enableSOL":true,"userConsent":"none","redirection":true,"ocr":true}` |
| `/mps/api/v1/amt/certificates/<GUID>` | POST | Upload trusted certificates | `{"cert":"<BASE64_ENCODED_CERT>","isTrusted":true}` |
| `/mps/api/v1/amt/power/bootOptions/<GUID>` | POST | Trigger OCR HTTPS Boot | `{"action":105,"useSOL":false,"bootDetails":{"url":"<ISO_URL>","username":"","password":"","enforceSecureBoot":true}}` |

---

## Boot to Windows Recovery Environment

### Prerequisites for Boot to WinRE

Before triggering a Boot to Windows Recovery Environment (WinRE), ensure that the AMT device meets the following prerequisites:

1. The device must have a **Windows operating system** installed with **Windows Recovery Environment (WinRE)** available and properly configured.

2. WinRE is typically included by default in most modern Windows installations (Windows 11, and Windows Server 2016 or later).

    !!! info "WinRE Configuration and Support"

        Please refer to the official Windows documentation to confirm which operating systems include WinRE support and for additional details on configuring or enabling WinRE.

### Triggering Boot to WinRE

1. Make sure that the target device shows as connected
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_Device_Connected.png" alt="Figure 11: Device connected to MPS">
    </figure>

2. Enable `One Click Recovery (OCR)` feature in `General AMT Info` Section.
   
    !!! question "Is Boot to Windows Recovery Environment supported?"

        See the snapshot below — if the **Windows Recovery Boot** field shows **Supported**, the feature is available on this device.
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_Boot_To_WinRE_Supported.png" alt="Figure 12: Enable OCR feature">
    </figure>

3. Optionally, start a **KVM session** if you want to observe the full recovery process.  

4. Click the **⋯ (three-dot)** menu and select **Reset to WinRE (OCR)**.

    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_Reset_to_WinRE.png" alt="Figure 13: Select Reset to WinRE (OCR)">
    </figure>

5. The device will immediately restart and boot into Windows Recovery Environment.

    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_Win_Recovery_Screen.png" alt="Figure 14: Windows Recovery Screen">
    </figure>

#### API Reference

| Action Code | Description |
|--------------|--------------|
| **109** | Reset to WinRE Boot |
| **110** | Power on to WinRE Boot |

| Endpoint | Method | Purpose | JSON Structure |
|----------|---------|----------|----------------|
| `/mps/login/api/v1/authorize` | POST | Authenticate and get JWT token | `{"username":"<MPS_WEB_ADMIN_USER>", "password":"<MPS_WEB_ADMIN_PASSWORD>"}` |
| `/mps/api/v1/devices` | GET | List connected devices | N/A |
| `/mps/api/v1/amt/features/<GUID>` | GET | Check device AMT features | N/A |
| `/mps/api/v1/amt/features/<GUID>` | POST | Enable/disable AMT features | `{"enableIDER":true,"enableKVM":true,"enableSOL":true,"userConsent":"none","redirection":true,"ocr":true}` |
| `/mps/api/v1/amt/power/bootOptions/<GUID>` | POST | Trigger OCR WinRE Boot | `{"method":"PowerAction","action":109,"useSOL":false,"bootDetails":{"enforceSecureBoot":true}}` |

--- 

## Boot to Local PBA

### Prerequisites for Local PBA Boot

Before triggering a Local PBA boot, ensure that the EFI environment is properly prepared.

1. A signed `.efi` binary (for example, `OemPba.efi`) must be present on the EFI System Partition (ESP) of the AMT device.  

2. The EFI file path and name must **exactly match** the entry registered in BIOS so that it appears in the OCR dropdown list.  
   
    Connect to the device over **TLS** using Console, select **Reset to OCR**, and view the available PBA options to confirm the exact EFI path registered with AMT.

      <figure class="figure-image">
       <img src="..\..\assets\images\OCR_MPS_Reset_to_PBA_EFIPATH.png" alt="Figure 15: PBA Path registered with AMT">
      </figure>

3. The signing certificate of the PBA must be enrolled in the BIOS **Authorized Signatures (db)**.  

!!! info "Need help setting up the EFI?"

    This is just a reference example — there are multiple ways to achieve the same result.
    
    Follow the detailed [OCR PBA EFI Setup and Signing Guide](https://github.com/device-management-toolkit/console/wiki/OCR-PBA-EFI-Setup-and-Signing-Guide) for one example of how to sign the EFI, enroll its certificate, and place it on the EFI System Partition (ESP).
      

### Triggering Local PBA Boot

1. Make sure that the target device shows as connected
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_Device_Connected.png" alt="Figure 16: Device connected to MPS">
    </figure>

2. Enable `One Click Recovery (OCR)` feature in `General AMT Info` Section.
   
    !!! question "Is Boot to PBA supported?"

        See the snapshot below — if the **PBA Boot** field shows **Supported**, the feature is available on this device.
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_Boot_To_PBA_Supported.png" alt="Figure 17: Enable OCR">
    </figure>

3. Optionally, start a **KVM session** if you want to observe the full recovery process.

4. Click the **⋯ (three-dot)** menu and select **Reset to PBA (OCR)**.

    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_Reset_to_PBA.png" alt="Figure 18: Reset to PBA (OCR)">
    </figure>

5. From the dropdown, select the local recovery option corresponding to your EFI entry (for example, `\OemPba.efi`).

    !!! danger "Secure Boot Mandatory"

        Ensure the **Enforce Secure Boot** checkbox is enabled before initiating the PBA boot.

        For Boot to Local PBA, Secure Boot is always enforced by Intel® AMT, as AMT does not control the origin or integrity of locally installed PBAs.

   
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_Reset_to_PBA_SelectPBA_Dropdown.png" alt="Figure 19: Select PBA">
    </figure>

6. Click **OK** to confirm.

7. The device will immediately restart and boot into the selected PBA EFI application.

    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_PBA_Boot_Netboot_EFI.png" alt="Figure 20: Booting into Local PBA (.efi)">
    </figure>


#### API Reference

| Action Code | Description |
|--------------|--------------|
| **107** | Reset to Local PBA Boot |
| **108** | Power on to Local PBA Boot |

| Endpoint | Method | Purpose | JSON Structure |
|----------|---------|----------|----------------|
| `/mps/login/api/v1/authorize` | POST | Authenticate and get JWT token | `{"username":"<MPS_WEB_ADMIN_USER>", "password":"<MPS_WEB_ADMIN_PASSWORD>"}` |
| `/mps/api/v1/devices` | GET | List connected devices | N/A |
| `/mps/api/v1/amt/features/<GUID>` | GET | Check device AMT features | N/A |
| `/mps/api/v1/amt/features/<GUID>` | POST | Enable/disable AMT features | `{"enableIDER":true,"enableKVM":true,"enableSOL":true,"userConsent":"none","redirection":true,"ocr":true}` |
| `/mps/api/v1/amt/power/bootSources/<GUID>` | GET | Retrieve available AMT boot sources and extract `bootString` of available PBAs| N/A |
| `/mps/api/v1/amt/power/bootOptions/<GUID>` | POST | Trigger Local PBA Boot | `{"method":"PowerAction","action":108,"useSOL":false,"bootDetails":{"bootPath":"\OemPba.efi","enforceSecureBoot":true}}` |

---

If you see any issues, please log them on our [GitHub Issues page](https://github.com/device-management-toolkit/mps/issues) or reach out to us on our **Discord channel**.