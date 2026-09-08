

Remote Platform Erase (RPE) lets IT administrators remotely sanitize a supported Intel vPro® system and restore it to a known manufacturer baseline (its "golden state") using Intel AMT's out-of-band (OOB) connection. It is used when decommissioning systems, preparing devices for reuse, or recovering a machine from a compromised state.

## Supported Erase Options

RPE supports three erase actions, which can be selected individually or together:

- **Secure Erase SSDs**: Securely wipes the attached SSDs.

- **Clear TPM**: Clears TPM data and persistent keys.

- **Restore BIOS**: Restores BIOS settings to the OEM golden state.

!!! danger "This Operation Is Irreversible"

    RPE permanently destroys data on the target system. Erased drives, cleared TPM keys, and overwritten BIOS settings cannot be recovered. Confirm you have selected the correct device before initiating an erase.

## Where to Start

- To confirm the device can run RPE and expose the feature in Console, start with [Verify and Enable RPE Support](#verify-and-enable-rpe-support).
- To run an erase on a device that is already enabled, go to [Triggering a Remote Platform Erase](#triggering-a-remote-platform-erase).
- To confirm the erase completed as expected, continue with [Verifying the Erase](#verifying-the-erase).

---

## Prerequisites

Before using RPE, ensure the target system meets the following requirements:

1. The device must be running **Intel AMT 16.0 or above**.

2. Both the **BIOS and firmware** must explicitly support Remote Platform Erase. Support is per-capability — a device may support Clear TPM but not Secure Erase SSDs, for example.

3. The **Remote Platform Erase** feature must be enabled for the device in Console. See [Verify and Enable RPE Support](#verify-and-enable-rpe-support) below.

    !!! info "Checking Capability Support"

        Console reads the supported erase capabilities directly from AMT. If a capability is not listed under **AMT Enabled Features**, the platform does not support it and no Console setting will make it available.

---

## Verify and Enable RPE Support

1. Open Console and navigate to the **Devices** tab on the left-hand menu, then select your target device.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\RPE_Device_List.png" alt="Figure 1: Device list in Console">
    </figure>

2. In the **General AMT Info** section, check the **AMT Enabled Features** panel and confirm **Remote Platform Erase** is listed.

    !!! question "Is Remote Platform Erase supported?"

        See the snapshot below — if the **Remote Platform Erase** field shows **Supported**, the feature is available on this device.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\RPE_Supported_Features.png" alt="Figure 2: Verify Remote Platform Erase support under AMT Enabled Features">
    </figure>

3. Toggle **Remote Platform Erase** to **Enabled**. Console syncs the capability and adds the **Remote Platform Erase** tab to the left-hand navigation for that device.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\RPE_Tab_Enabled.png" alt="Figure 3: Remote Platform Erase tab in the left-hand navigation">
    </figure>

    !!! note "Unsupported Devices"

        On a device that does not support RPE, the toggle reads *Remote Platform Erase is not supported* and the options stay unavailable. The tab still appears in the left-hand navigation, but states that the feature is unsupported.

        <figure class="figure-image">
          <img src="..\..\..\..\assets\images\screenshots\RPE_Not_Supported.png" alt="Figure 4: Remote Platform Erase tab on an unsupported device">
        </figure>

---

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
      <img src="..\..\..\..\assets\images\screenshots\RPE_TPM_Before.png" alt="Figure 5: Persistent TPM handles before the erase">
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
      <img src="..\..\..\..\assets\images\screenshots\RPE_BIOS_Thermal_Modified.png" alt="Figure 6: Modified BIOS thermal thresholds and dynamic support options">
    </figure>

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\RPE_BIOS_Power_Modified.png" alt="Figure 7: After Power Failure changed from Always Power Off to Power On">
    </figure>

3. Save the changes and exit BIOS.

---

## Triggering a Remote Platform Erase

1. In the device detail view, select the **Remote Platform Erase** tab in the left-hand navigation.

2. Select the erase capabilities to run. Any combination of the supported options can be selected:

    - **Clear TPM**
    - **Restore BIOS to OEM Config**
    - **Secure Erase SSDs**

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\RPE_Select_Options.png" alt="Figure 8: Selecting erase capabilities in the Remote Platform Erase panel">
    </figure>

3. Optionally, start a **KVM session** if you want to observe the reboot and erase process.

4. Click **Initiate Erase** in the top right.

5. Review the confirmation dialog, which describes exactly which actions will run, and click **YES** to confirm.

    !!! warning "Point of No Return"

        Clicking **YES** immediately restarts the device and applies the selected erase actions. There is no cancel or undo once the operation begins.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\RPE_Confirm_Dialog.png" alt="Figure 9: Confirmation dialog warning that the operation is irreversible">
    </figure>

6. The device restarts automatically and performs the selected erase and restore actions during boot.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\RPE_System_Reboot.png" alt="Figure 10: KVM view of the system rebooting to apply the RPE commands">
    </figure>

---

## Verifying the Erase

Once the device has finished its reboot cycle, confirm each selected capability was applied.

### Confirm the TPM Was Cleared

1. Log back into the target system and open a terminal.

2. Run the TPM capability command again:

    ```bash
    sudo tpm2_getcap handles-persistent
    ```

3. Confirm the command returns no persistent handles, showing the TPM has been fully cleared.

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\RPE_TPM_After.png" alt="Figure 11: No persistent TPM handles remain after the erase">
    </figure>

### Confirm the BIOS Was Restored

1. Boot into BIOS on the target system through KVM.

2. Confirm the settings changed earlier are back at their manufacturer defaults:

    | Setting | Restored Value |
    |:---|:---|
    | Ambient Temperature Tolerance | `35°C` |
    | Dynamic Support Options | Enabled |
    | After Power Failure *(Secondary Power Settings)* | `Always Power Off` |

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\RPE_BIOS_Thermal_Restored.png" alt="Figure 12: BIOS thermal settings restored to manufacturer defaults">
    </figure>

    <figure class="figure-image">
      <img src="..\..\..\..\assets\images\screenshots\RPE_BIOS_Power_Restored.png" alt="Figure 13: Secondary Power Settings reset to the default power recovery option">
    </figure>

---

If you see any issues, please log them on our [GitHub Issues page](https://github.com/device-management-toolkit/console/issues) or reach out to us on our **Discord channel**.
