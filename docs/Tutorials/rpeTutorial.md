
Intel® Remote Platform Erase (RPE) allows IT administrators to remotely wipe a supported Intel vPro® system and restore it to a known manufacturer baseline (its "golden state") using Intel AMT's out-of-band (OOB) connection. It is used when decommissioning systems, preparing devices for reuse, or recovering a machine from a compromised state.

## Supported Erase Options

Console exposes three erase actions, which can be selected individually or together:

- **Secure Erase of All SSDs**: Removes all content from ATA and NVM drives through a combination of media erase and crypto erase.

- **TPM Clear**: Deletes all keys created in the Trusted Platform Module (TPM) and any data protected by those keys, such as a virtual smart card or a login PIN.

- **Restore BIOS to EOM State**: Restores the BIOS to the End of Manufacture (EOM) golden configuration specified by the system designer.

!!! danger "This Operation Is Irreversible"

    RPE permanently destroys data on the target system. Erased drives, cleared TPM keys, and overwritten BIOS settings cannot be recovered. Confirm you have selected the correct device before initiating an erase.

## Where to Start

- To confirm the device can run RPE and expose the feature in Console, start with [Verify and Enable RPE Support](#verify-and-enable-rpe-support).
- To run an erase on a device that is already enabled, go to [Triggering a Remote Platform Erase](#triggering-a-remote-platform-erase).
- To confirm the erase completed as expected, continue with [Verifying the Erase](#verifying-the-erase).

## Prerequisites

Before you start, confirm the target device meets all of these:

- Console is **connected to the device over TLS**.

- Its **BIOS and firmware support** Remote Platform Erase. Console disables any erase action the platform does not report as supported, so the available options can differ between devices.

- **Remote Platform Erase is enabled in the target's BIOS menu.** This cannot be set from Console, and it is the most common reason an erase fails. If you are following [Preparing a Test Device](#preparing-a-test-device-optional) below, check it while you are already in the BIOS menu.

- The **Remote Platform Erase** feature is enabled for the device in Console. See [Verify and Enable RPE Support](#verify-and-enable-rpe-support) below.

Each requirement is explained in full, including the firmware versions Intel requires, in the [Remote Platform Erase reference](../Reference/Console/Features/rpe.md#prerequisites).

## Verify and Enable RPE Support

1. Open Console and navigate to the **Devices** tab on the left-hand menu, then select your target device.

    <figure class="figure-image">
      <img src="../../assets/images/screenshots/RPE_Device_List.png" alt="Figure 1: Device list in Console">
    </figure>

2. In the **General AMT Info** section, check the **AMT Enabled Features** panel and confirm **Remote Platform Erase** is listed.

    !!! note "Remote Platform Erase availability"

        Confirm the **Remote Platform Erase** checkbox is available and not greyed out, as shown in the snapshot below. A greyed-out checkbox means the platform does not support the feature.

    <figure class="figure-image">
      <img src="../../assets/images/screenshots/RPE_Enabled_Features.png" alt="Figure 2: Remote Platform Erase listed under AMT Enabled Features">
    </figure>

3. Select the **Remote Platform Erase** tab in the device navigation on the right.

    <figure class="figure-image">
      <img src="../../assets/images/screenshots/RPE_Tab_Location.png" alt="Figure 3: Remote Platform Erase tab in the device navigation on the right">
    </figure>

4. Make sure **Enable Remote Platform Erase on this device** is switched on. This is the same setting as the **Remote Platform Erase** checkbox on the **AMT Enabled Features** panel, so it is already on if you enabled it there. The erase options below it stay inactive until it is on.

## Preparing a Test Device (Optional)

If you are demonstrating or validating RPE rather than erasing a production machine, change the device's state first so the restoration is visible afterwards. Skip this section for a real erase.

### Record the TPM State

1. Open a terminal on the target system, either locally or over SSH/KVM.

2. List the persistent handles currently stored in the TPM:

    ```bash
    sudo tpm2_getcap handles-persistent
    ```

3. Confirm the command returns active persistent handle addresses, indicating existing TPM data.

    <figure class="figure-image">
      <img src="../../assets/images/screenshots/RPE_TPM_Before.png" alt="Figure 4: Persistent TPM handles before the erase">
    </figure>

### Change BIOS Settings

1. Boot the device into BIOS, either through **KVM** or a manual reboot.

2. Under the power and thermal settings, change the following values away from their defaults:

    | Setting | Default | Change To |
    |:---|:---|:---|
    | Ambient Temperature Tolerance | `35°C` | `40°C` |
    | Dynamic Support Options | Enabled | Disabled |
    | After Power Failure *(Secondary Power Settings)* | `Always Power Off` | `Power On` |

    <figure class="figure-image">
      <img src="../../assets/images/screenshots/RPE_BIOS_Thermal_Modified.png" alt="Figure 5: Modified BIOS thermal thresholds and dynamic support options">
    </figure>

    <figure class="figure-image">
      <img src="../../assets/images/screenshots/RPE_BIOS_Power_Modified.png" alt="Figure 6: After Power Failure changed from Always Power Off to Power On">
    </figure>

3. Save the changes and exit BIOS.

## Triggering a Remote Platform Erase

1. Select the erase capabilities to run. Any combination of the supported options can be selected:

    - **Secure Erase of All SSDs**
    - **TPM Clear**
    - **Restore BIOS to EOM State**

    <figure class="figure-image">
      <img src="../../assets/images/screenshots/RPE_Select_Options.png" alt="Figure 7: Selecting erase capabilities in the Remote Platform Erase panel">
    </figure>

    !!! warning "Secure Erase of All SSDs removes the operating system"

        This option erases every attached SSD, including the drive the operating system is installed on. After it completes, the device cannot boot and an operating system must be reinstalled before the machine can be used again. Console reports this on success with the message *OS drive erased successfully. Please reinstall an operating system before using this device.*

    !!! warning "Encrypted drives need a drive password - not yet validated"

        When you select **Secure Erase of All SSDs**, a checkbox labelled **SSD requires disk encryption key** appears below it. Tick it if the drive is self-encrypting, and a **Drive Password** field appears. Console passes that password to Intel AMT as the drive password for the erase operation. Leave both controls alone for drives that are not encrypted.

        **Erasing an encrypted drive has not been tested end to end yet.** The controls above are present in Console, but the full flow has not been validated. This section will be updated with detailed steps once it has.

2. Optionally, start a **KVM session** if you want to observe the reboot and erase process.

3. Click **Initiate Remote Erase** in the top right.

4. Review the confirmation dialog, which describes exactly which actions will run, and click **YES** to confirm.

    !!! warning "Point of No Return"

        Clicking **YES** immediately restarts the device and applies the selected erase actions. There is no cancel or undo once the operation begins.

    <figure class="figure-image">
      <img src="../../assets/images/screenshots/RPE_Confirm_Dialog.png" alt="Figure 8: Confirmation dialog warning that the operation is irreversible">
    </figure>

5. The device restarts automatically and performs the selected erase and restore actions during boot.

## Verifying the Erase

Once the device has finished its reboot cycle, confirm each selected capability was applied.

!!! note "These checks need a working operating system"

    The TPM check below runs from a terminal on the target system. If you selected **Secure Erase of All SSDs**, the operating system has been erased and the device will not boot, so you cannot run it until an operating system has been reinstalled. The BIOS check does not need an operating system and can be done on any erased device.

### Confirm the TPM Was Cleared

1. Log back into the target system and open a terminal. If the OS drive was erased, reinstall an operating system first.

2. Run the TPM capability command again:

    ```bash
    sudo tpm2_getcap handles-persistent
    ```

3. Confirm the command returns no persistent handles, showing the TPM has been fully cleared.

### Confirm the BIOS Was Restored

1. Boot into BIOS on the target system through KVM.

2. Confirm the settings changed earlier are back at their manufacturer defaults:

    | Setting | Restored Value |
    |:---|:---|
    | Ambient Temperature Tolerance | `35°C` |
    | Dynamic Support Options | Enabled |
    | After Power Failure *(Secondary Power Settings)* | `Always Power Off` |

    <figure class="figure-image">
      <img src="../../assets/images/screenshots/RPE_BIOS_Thermal_Restored.png" alt="Figure 9: BIOS thermal settings restored to manufacturer defaults">
    </figure>

    <figure class="figure-image">
      <img src="../../assets/images/screenshots/RPE_BIOS_Power_Restored.png" alt="Figure 10: Secondary Power Settings reset to the default power recovery option">
    </figure>

---

If you see any issues, please log them on our [GitHub Issues page](https://github.com/device-management-toolkit/console/issues) or reach out to us on our **Discord channel**.
