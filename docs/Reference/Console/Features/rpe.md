# Remote Platform Erase (RPE) Tutorial

This tutorial provides step-by-step instructions on how to use the **Remote Platform Erase (RPE)** feature in the Device Management Console. RPE is a powerful capability used to securely reset and sanitize supported Intel vPro® systems remotely.

---

## Overview

Remote Platform Erase (RPE) allows administrators to securely sanitize and restore systems to a known manufacturer baseline ("golden state"). This capability is essential for decommissioning systems, preparing devices for reuse, or recovering from a compromised state.

The platform provides multiple remote erase actions:

| Erase Capability | Description |
|:---|:---|
| **Secure Erase SSDs** | Wipes all SSD drives securely |
| **Clear TPM** | Clears TPM data and persistent keys |
| **Restore BIOS** | Restores BIOS settings to OEM golden state |
| **Fourth Capability** | Reserved/Firmware-specific action |

---

## Prerequisites

Before using RPE, ensure the target system meets the following requirements:
* **Intel AMT Version:** Intel AMT 16.0 or above.
* **Hardware Support:** Both BIOS and firmware must explicitly support RPE.
* **Enabled Feature:** The RPE feature must be enabled under the device settings in the Console.

---

## Step 1: Verify and Enable RPE Support

1. In the **Device Management Console**, select your target device from the list.
   
   ![01_device_list.png](./images/01_device_list.png)  
   *Caption: Device Management Console listing registered vPro devices.*

2. Select a device (e.g., ASUS NUC) and under the **AMT Enabled Features** panel on the right, verify that **Remote Platform Erase** is supported and listed.
   
   ![02_verify_rpe_support.png](./images/02_verify_rpe_support.png)  
   *Caption: Verifying RPE capability support under AMT Enabled Features on the right side panel.*

3. Toggle the option to **Enable** if it is currently disabled. This action syncs the capability with the platform UI and displays the **Remote Platform Erase** tab on the left navigation panel.
   
   ![03_rpe_tab_visible.png](./images/03_rpe_tab_visible.png)  
   *Caption: Enabling RPE to reveal the Remote Platform Erase tab in the left-hand navigation.*

> **Note on Unsupported Devices:** If a device does not support RPE, the toggle will display "Remote Platform Erase is not supported" and the options will remain unavailable. The tab on the left navigation will still appear but will clearly state that the feature is unsupported.
> 
> ![04_unsupported_device.png](./images/04_unsupported_device.png)  
> *Caption: View of the RPE tab on an unsupported system.*

---

## Step 2: Prepare and Modify System State (Testing/Demo Setup)

To demonstrate or test the capabilities of RPE, you can manually modify the target system's state before running the erase operation:

### A. Verify TPM Initial State
1. Open a terminal on the target system (or connect via SSH/KVM).
2. Run the following command to check if there are any persistent handles or keys currently stored in the TPM:
   ```bash
   sudo tpm2_getcap handles-persistent
   ```
3. Confirm that the TPM returns active persistent handle addresses (indicating existing data).

   ![05_tpm_before_erase.png](./images/05_tpm_before_erase.png)  
   *Caption: Command terminal showing active persistent TPM handles prior to initiating the clear action.*

### B. Manually Modify BIOS Settings
1. Boot the device into BIOS (accessible via **KVM** or manual reboot).
2. Navigate to the power and thermal settings and make the following changes to demonstrate restoration:
   * **Ambient Temperature Tolerance:** Change from the default `35°C` to `40°C`.
   * **Dynamic Support Options:** Disable/uncheck specific dynamic support options.
   * **After Power Failure:** Under *Secondary Power Settings*, change the configuration from the default `Always Power Off` to `Power On`.

   ![06_modify_bios_thermal.png](./images/06_modify_bios_thermal.png)  
   *Caption: Modifying BIOS thermal thresholds and unchecking dynamic support in KVM.*

   ![07_modify_bios_power.png](./images/07_modify_bios_power.png)  
   *Caption: Changing the After Power Failure setting from Always Power Off to Power On.*

3. Save the changes and exit.

---

## Step 3: Execute Remote Platform Erase

Once the system state has been prepared, you can initiate the erase process:

1. In the device detail view, navigate to the **Remote Platform Erase** tab on the left navigation menu.
2. Select the erase options you wish to execute:
   * [x] **Clear TPM**
   * [x] **Restore BIOS to OEM Config**
   * [ ] **Secure Erase SSDs** *(Optional)*
3. Click the **Initiate Erase** button at the top right.

   ![08_select_erase_capabilities.png](./images/08_select_erase_capabilities.png)  
   *Caption: Selecting Clear TPM and Restore BIOS options in the Remote Platform Erase panel.*

4. A warning modal will pop up to prevent accidental execution:
   > **Did you want?**
   > Erase and restart the vPro system. Please click YES to run. This will perform the TPM clear and the restore BIOS to OEM state. This action is irreversible.
   
   ![09_erase_warning_dialog.png](./images/09_erase_warning_dialog.png)  
   *Caption: Confirmation warning dialog explaining that the operation is irreversible.*

5. Click **YES** to confirm.
6. The target system will automatically reboot and start the secure erasure and restoration processes.

   ![10_system_rebooting.png](./images/10_system_rebooting.png)  
   *Caption: KVM screen showing the system rebooting automatically to apply the RPE commands.*

---

## Step 4: Post-Execution Verification

After the system completes the reboot cycle, verify that RPE was executed successfully:

### A. Confirm TPM is Cleared
1. Log back into the target system.
2. Open a terminal and run the TPM status command again:
   ```bash
   sudo tpm2_getcap handles-persistent
   ```
3. Confirm that the command returns no persistent handles, showing that the TPM has been fully cleared.

   ![11_tpm_after_erase.png](./images/11_tpm_after_erase.png)  
   *Caption: Terminal output confirming that no persistent TPM handles remain after RPE execution.*

### B. Confirm BIOS Settings are Restored
1. Access the BIOS configuration on the target system via KVM.
2. Verify that the settings have been restored to default manufacturer defaults:
   * **Ambient Temperature Tolerance:** Restored back to the default `35°C`.
   * **Dynamic Support Options:** Re-enabled/checked.
   * **After Power Failure:** Restored back to the default `Always Power Off`.

   ![12_verified_bios_thermal.png](./images/12_verified_bios_thermal.png)  
   *Caption: KVM view of BIOS thermal settings restored to default manufacturer configurations.*

   ![13_verified_bios_power.png](./images/13_verified_bios_power.png)  
   *Caption: KVM view of Secondary Power Settings showing the power recovery option successfully reset to default.*

---