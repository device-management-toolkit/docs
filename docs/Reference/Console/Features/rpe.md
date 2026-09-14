
Intel® Remote Platform Erase (RPE) allows IT administrators to remotely wipe a supported Intel vPro® system and restore it to a known manufacturer baseline (its "golden state") using Intel AMT's out-of-band (OOB) connection. It is used when decommissioning systems, preparing devices for reuse, or recovering a machine from a compromised state.

## Supported Erase Options

Console exposes three erase actions, which can be selected individually or together:

- **Secure Erase of All SSDs**: Removes all content from ATA and NVM drives through a combination of media erase and crypto erase.

- **TPM Clear**: Deletes all keys created in the Trusted Platform Module (TPM) and any data protected by those keys, such as a virtual smart card or a login PIN.

- **Restore BIOS to EOM State**: Restores the BIOS to the End of Manufacture (EOM) golden configuration specified by the system designer.

!!! info "A fourth capability is not shown in the UI"

    Intel Remote Platform Erase defines a fourth capability, **Unconfigure Intel CSME Firmware**, which fully unprovisions Intel AMT and returns it to its default state, disabling Intel AMT features. Console's REST API accepts it as `unconfigureCSME`, but the Sample Web UI does not currently display it. A device unconfigured this way is removed from Console and cannot be managed remotely until it is reprovisioned.

!!! danger "This Operation Is Irreversible"

    RPE permanently destroys data on the target system. Erased drives, cleared TPM keys, and overwritten BIOS settings cannot be recovered. Confirm you have selected the correct device before initiating an erase.

## Where to Start

- To confirm the device can run RPE and exposes the feature, start with [Verify and Enable RPE Support](#verify-and-enable-rpe-support).
- To run an erase on a device that is already enabled, go to [Triggering a Remote Platform Erase](#triggering-a-remote-platform-erase).

## Prerequisites

Before using RPE, ensure the target system meets the following requirements:

1. The device must be running **Intel CSME 16.0 or later**, as documented in the [Intel® AMT SDK](https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/WordDocuments/Secure_Remote_Platform_Erase.htm). Intel CSME 16.0 erases ordinary SSDs; Raptor Lake platforms on **Intel CSME 16.1 and later** also erase Pyrite self-encrypting drives.

2. Console must be **connected to the device over TLS**.

3. Both the **BIOS and firmware** must support Remote Platform Erase. Support is reported per capability: Console reads which erase actions the platform allows and disables the rest, so the options offered on one device may differ from another.

4. Remote Platform Erase must be **enabled in the target system's BIOS**. Intel requires the feature to be enabled in two places — in the BIOS and in Intel AMT — and Console can only set the Intel AMT half. Supporting the feature and having it switched on are two different things.

    !!! warning "Enable RPE in BIOS before you start"

        Intel states that the BIOS setting can be changed **only via the BIOS menu**, on the target machine itself. Intel AMT reports it as a read-only value, so no Console setting will turn it on. Reach the BIOS menu over a KVM session or at the machine. If the feature is left disabled there, the erase fails with *Remote Platform Erase is not enabled by the BIOS on this device*, whatever the device's Console settings say. Where a platform's BIOS does not support Remote Platform Erase at all, the option will not be present in the menu.

## Verify and Enable RPE Support

1. Open Console and navigate to the **Devices** tab on the left-hand menu, then select your target device.

    <figure class="figure-image">
      <img src="../../../../assets/images/screenshots/RPE_Device_List.png" alt="Figure 1: Device list in Console">
    </figure>

2. In the **General AMT Info** section, check the **AMT Enabled Features** panel and confirm **Remote Platform Erase** is listed.

    !!! note "Remote Platform Erase availability"

        Confirm the **Remote Platform Erase** checkbox is available and not greyed out, as shown in the snapshot below. A greyed-out checkbox means the platform does not support the feature.

    <figure class="figure-image">
      <img src="../../../../assets/images/screenshots/RPE_Enabled_Features.png" alt="Figure 2: Remote Platform Erase listed under AMT Enabled Features">
    </figure>

3. Select the **Remote Platform Erase** tab in the device navigation on the right.

    <figure class="figure-image">
      <img src="../../../../assets/images/screenshots/RPE_Tab_Location.png" alt="Figure 3: Remote Platform Erase tab in the device navigation on the right">
    </figure>

4. Make sure **Enable Remote Platform Erase on this device** is switched on. This is the same setting as the **Remote Platform Erase** checkbox on the **AMT Enabled Features** panel, so it is already on if you enabled it there. The erase options below it stay inactive until it is on.

## Triggering a Remote Platform Erase

1. Select the erase capabilities to run. Any combination of the supported options can be selected:

    - **Secure Erase of All SSDs**
    - **TPM Clear**
    - **Restore BIOS to EOM State**

    <figure class="figure-image">
      <img src="../../../../assets/images/screenshots/RPE_Select_Options.png" alt="Figure 4: Selecting erase capabilities in the Remote Platform Erase panel">
    </figure>

    !!! note "Important Notes on Erase operations"

        * Secure Erase of All SSDs removes the OS and requires it to be reinstalled.

    !!! warning "Encrypted drives need a drive password - not yet validated"

        When you select **Secure Erase of All SSDs**, a checkbox labelled **SSD requires disk encryption key** appears below it. Tick it if the drive is self-encrypting, and a **Drive Password** field appears. Console passes that password to Intel AMT as the drive password for the erase operation. Leave both controls alone for drives that are not encrypted.

        **Erasing an encrypted drive has not been tested end to end yet.** The controls above are present in Console, but the full flow has not been validated. This section will be updated with detailed steps once it has.

2. Optionally, start a **KVM session** if you want to observe the reboot and erase process.

3. Click **Initiate Remote Erase** in the top right.

4. Review the confirmation dialog, which describes exactly which actions will run, and click **YES** to confirm.

    !!! warning "Point of No Return"

        Clicking **YES** immediately restarts the device and applies the selected erase actions. There is no cancel or undo once the operation begins.

    <figure class="figure-image">
      <img src="../../../../assets/images/screenshots/RPE_Confirm_Dialog.png" alt="Figure 5: Confirmation dialog warning that the operation is irreversible">
    </figure>

5. The device restarts automatically and performs the selected erase and restore actions during boot.

## Additional Resources

The behaviour described on this page is defined by the Intel® AMT SDK. These are the specific pages it draws on:

- *[Intel® Remote Platform Erase](https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/WordDocuments/Secure_Remote_Platform_Erase.htm)* – The feature overview: the four erase capabilities and their definitions, the Intel CSME 16.0 minimum, the requirement to run over TLS, and the rule that the feature must be enabled in both the BIOS and Intel AMT.
- *[AMT_BootCapabilities](https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/HTMLDocuments/WS-Management_Class_Reference/AMT_BootCapabilities.htm)* – The `PlatformErase` bitmask, which defines each erase capability separately and states the firmware versions individual capabilities require.
- *[AMT_BootSettingData](https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/HTMLDocuments/WS-Management_Class_Reference/AMT_BootSettingData.htm)* – The `RPEEnabled` flag that reports the BIOS setting, plus the `PlatformErase` and `RSEPassword` fields used to request an erase.

---

If you see any issues, please log them on our [GitHub Issues page](https://github.com/device-management-toolkit/console/issues) or reach out to us on our **Discord channel**.
