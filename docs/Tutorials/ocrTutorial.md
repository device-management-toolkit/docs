

Intel® One-Click Recovery (OCR) allows IT administrators to remotely trigger a secure and reliable boot to a recovery application, ensuring recovery from system failures, bare-metal scenarios, or connectivity issues using Intel AMT's out-of-band (OOB) connection.

The Management Presence Server (MPS) in Cloud deployment now supports issuing a reset to HTTPS Boot power action, allowing IT administrators to initiate recovery via secure network boot from a specified URL.

## Supported Recovery Options

OCR supports three recovery modes:

- **UEFI HTTPS Network Boot**: Perform a network-based recovery using encrypted HTTPS.

- **Microsoft Windows Recovery Environment (WinRE)**: Boot into Windows Recovery for troubleshooting and repair.

- **Local Pre-Boot Application (PBA)**: Launch a locally installed recovery or diagnostic tool.

!!! info "Future Enhancements"

    - MPS currently only supports HTTPS Network Boot feature.
    - HTTPS Boot feature only works when the device is connected via a wired network.

    We plan to include **Wireless support** and add additional **One Click Recovery features** in future updates.  

## Prerequisites for HTTPS Boot

Before using HTTPS Network Boot, ensure the following prerequisites are met:

1. Enable HTTP(S) Boot in BIOS settings. This may be disabled by default on some devices.

    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_HTTPSBOOT_BIOS.png" alt="Figure 1: Enable HTTP(S) Boot in BIOS">
    </figure>

2. Set up an HTTPS server to host the ISO.

    !!! info "HTTPS Server" 
        - In this guide, the HTTPS server is running on the same machine as the containers, serving a full Ubuntu LTS image at https://192.168.88.250:8500/ubuntu.iso.
        - Instructions for setting up an HTTPS server are not included here, so please ensure you have one ready. If you haven’t set it up yet, there are many helpful resources available online to guide you.

3. Make sure that the device shows as connected in the Sample UI or through get device MPS API 


## HTTPS Boot using Cloud Deployment
You can use our [MPS APIs](#triggering-https-boot-via-mps-apis) to perform recovery using HTTPS boot, but for quick demos and to understand how you can first test it, we've also implemented it in the [Sample UI](#triggering-https-boot-using-sample-ui).

### Triggering HTTPS Boot using Sample UI

1. Make sure that the target device shows as connected
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_Device_Connected.png" alt="Figure 2: Device connected to MPS">
    </figure>

2. Enable `OCR` feature in `General AMT Info` Section.
   
    !!! question "Is HTTPS Network Boot supported?"

        If the **OCR** checkbox is greyed out, this feature is not supported on your device. 
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_Enable_HTTPS_BOOT.png" alt="Figure 3: Enable HTTPS Network Boot">
    </figure>

3. Upload the Root Certificate of the HTTPS server hosting the ISO via the `Add New` certificates option.
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_ADD_TRUSTEDROOTCERT.png" alt="Figure 4: Add Root Certificate of HTTPS Server">
    </figure>

4. Click on the three-dot menu and select **Reset to HTTPS Boot (OCR)**.
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_Reset_to_HTTPS_Boot.png" alt="Figure 5: Reset to HTTPS Boot (OCR)">
    </figure>

5. Enter the ISO URL (e.g., https://192.168.88.250:8500/ubuntu.iso).
    
    !!! Tip "Check ISO URL"

        Ensure the HTTPS Server ISO URL is accessible to the device.
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_HTTPSBOOT_URL.png" alt="Figure 6: URL to the .iso hosted on HTTPS Server">
    </figure>

6. Optionally, enable `Enforce Secure Boot` to boot only a secure `.iso` file.
   
    !!! warning "Secure Boot"

        If Secure Boot is enabled, the UEFI BIOS must have the Root Certificate used to sign the ISO's bootloader in its trusted database (DB) to allow execution.

7. Click `OK` to start the recovery process. The device will restart and boot from the ISO.

8. Optionally, Connect to KVM and verify that the device loads the ISO.
    
    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_HTTPSBoot_Recovery_Start.png" alt="Figure 7: View KVM screen while the ISO boots">
    </figure>

    <figure class="figure-image">
      <img src="..\..\assets\images\OCR_MPS_HTTPS_BOOT_UbuntuOS.png" alt="Figure 8: Full Ubuntu LTS Boot">
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
      <img src="..\..\assets\images\OCR_HTTPSBoot_Recovery_Start_MPS.png" alt="Figure 7: View KVM screen while the ISO boots">
    </figure>

#### API Reference

| Endpoint | Method | Purpose | JSON Structure |
|----------|---------|---------|----------------|
| `/mps/login/api/v1/authorize` | POST | Authenticate and get JWT token | `{"username":"<MPS_WEB_ADMIN_USER>", "password":"<MPS_WEB_ADMIN_PASSWORD>"}` |
| `/mps/api/v1/devices` | GET | List connected devices | N/A |
| `/mps/api/v1/amt/features/<GUID>` | GET | Check device AMT features | N/A |
| `/mps/api/v1/amt/features/<GUID>` | POST | Enable/disable AMT features | `{"enableIDER":true,"enableKVM":true,"enableSOL":true,"userConsent":"none","redirection":true,"ocr":true}` |
| `/mps/api/v1/amt/certificates/<GUID>` | POST | Upload trusted certificates | `{"cert":"<BASE64_ENCODED_CERT>","isTrusted":true}` |
| `/mps/api/v1/amt/power/bootoptions/<GUID>` | POST | Trigger OCR boot options | `{"action":105,"useSOL":false,"bootDetails":{"url":"<ISO_URL>","username":"","password":"","enforceSecureBoot":true}}` |