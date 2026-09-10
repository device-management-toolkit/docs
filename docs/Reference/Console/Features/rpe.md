
Intel® Remote Platform Erase (RPE) allows IT administrators to remotely wipe a supported Intel vPro® system and restore it to a known manufacturer baseline (its "golden state") using Intel AMT's out-of-band (OOB) connection. It is used when decommissioning systems, preparing devices for reuse, or recovering a machine from a compromised state.

## Supported Erase Options

RPE supports three erase actions, which can be selected individually or together:

- **Secure Erase SSDs**: Securely wipes the attached SSDs.

- **Clear Trusted Platform Module (TPM)**: Clears TPM data and persistent keys.

- **Restore BIOS**: Restores BIOS settings to the OEM golden state.

!!! danger "This Operation Is Irreversible"

    RPE permanently destroys data on the target system. Erased drives, cleared TPM keys, and overwritten BIOS settings cannot be recovered. Confirm you have selected the correct device before initiating an erase.

## Where to Start

- To confirm the device can run RPE and exposes the feature, start with [Verify and Enable RPE Support](#verify-and-enable-rpe-support).
- To run an erase on a device that is already enabled, go to [Triggering a Remote Platform Erase](#triggering-a-remote-platform-erase).

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
      <img src="../../../../assets/images/screenshots/RPE_Device_List.png" alt="Figure 1: Device list in Console">
    </figure>

2. In the **General AMT Info** section, check the **AMT Enabled Features** panel and confirm **Remote Platform Erase** is listed.

    !!! question "Is Remote Platform Erase supported?"

        See the snapshot below — if the **Remote Platform Erase** field shows **Supported**, the feature is available on this device.

    <figure class="figure-image">
      <img src="../../../../assets/images/screenshots/RPE_Supported_Features.png" alt="Figure 2: Verify Remote Platform Erase support under AMT Enabled Features">
    </figure>

3. Toggle **Remote Platform Erase** to **Enabled**. Console syncs the capability and adds the **Remote Platform Erase** tab to the left-hand navigation for that device.

    <figure class="figure-image">
      <img src="../../../../assets/images/screenshots/RPE_Tab_Enabled.png" alt="Figure 3: Remote Platform Erase tab in the left-hand navigation">
    </figure>

    !!! note "Unsupported Devices"

        On a device that does not support RPE, the toggle reads *Remote Platform Erase is not supported* and the options stay unavailable. The tab still appears in the left-hand navigation, but states that the feature is unsupported.

---

## Triggering a Remote Platform Erase

1. In the device detail view, select the **Remote Platform Erase** tab in the left-hand navigation.

2. Select the erase capabilities to run. Any combination of the supported options can be selected:

    - **Clear TPM**
    - **Restore BIOS to OEM Config**
    - **Secure Erase SSDs**

    <figure class="figure-image">
      <img src="../../../../assets/images/screenshots/RPE_Select_Options.png" alt="Figure 4: Selecting erase capabilities in the Remote Platform Erase panel">
    </figure>

3. Optionally, start a **KVM session** if you want to observe the reboot and erase process.

4. Click **Initiate Remote Erase** in the top right.

5. Review the confirmation dialog, which describes exactly which actions will run, and click **YES** to confirm.

    !!! warning "Point of No Return"

        Clicking **YES** immediately restarts the device and applies the selected erase actions. There is no cancel or undo once the operation begins.

     <figure class="figure-image">
      <img src="../../../../assets/images/screenshots/RPE_Confirm_Dialog.png" alt="Figure 5: Confirmation dialog warning that the operation is irreversible">
    </figure>

6. The device restarts automatically and performs the selected erase and restore actions during boot.

---

If you see any issues, please log them on our [GitHub Issues page](https://github.com/device-management-toolkit/console/issues) or reach out to us on our **Discord channel**.
