

Possible power actions are listed in the tables below. Power actions are specified by number. 

To obtain information about power actions, use the following methods:

* **[PowerCapabilities](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/{{ repoVersion.mpsAPI }}#/AMT/get_api_v1_amt_power_capabilities__guid_):** returns the power actions available for a specific device.
* **[PowerState](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/{{ repoVersion.mpsAPI }}#/AMT/get_api_v1_amt_power_state__guid_):** returns current power state.

!!! Info "Start State or Current Power State"
    Consider the current state of the system when implementing a possible action, for example: 

    * **Reset to BIOS** implies that the current system state is on or powered up.
    * **Power up to BIOS** implies that current system state is off or powered down.
    * **Hibernate** implies that the current system state is powered up. 

    If the system is already powered up, choosing to **Power Up to BIOS** will not have any effect on the system. A better choice is **Reset to BIOS**.

## Remote Power Actions

The following power actions can be executed remotely without requiring Intel LMS to be installed. 

Commands 100 and above use a combination of HW level power controls (i.e., 2, 5, 8, 10) and some boot options, such as **Boot to BIOS**.

   | Action #       | Power Action | Start State | Transition Description | ACPI State(s) | 
   | :----------- | :------------------------ |   :------------------------ | :------------------------ | :------------------------ |
   | **2** | Power up/on | Powered down/off, Asleep, Hibernating | Power up/on fully | G0/S0 |
   | **5** | Power cycle | Powered up/on | Transition to minimal power state and then power up/on fully | G2/S5 > G0/S0 |  
   | **8** | Power down/off (hard) | Powered up/on | Transition to a fully powered down state | G2/S5 |
   | **10** | Reset | Powered up/on | Perform hardware reset on the bus | N/A | 
   | **100** | Power up to BIOS settings | Powered down/off | Power to BIOS to verify or modify system configuration | G2/S5 | 
   | **101** | Reset to BIOS settings | Powered up/on | Perform hardware reset on the bus to BIOS to verify or modify system configuration | G2/S5 |
   | **400** | Reset to PXE | Powered up/on | Reset to pre-boot execution environment (PXE)(i.e., a network boot | N/A | 
   | **401** | Power on to PXE | Powered down/off | Power up/on fully to pre-boot execution environment (PXE) (i.e., a network boot) | N/A | 

## Local Power Actions

The following power actions require Intel Local Manageability Service (LMS) to be installed and running.

LMS is a service that runs locally on an Intel AMT device and enables local management applications to send requests and receive responses to and from the device. The LMS listens for and intercepts requests directed to the Intel AMT local host and routes them to the Management Engine via the Intel Management Engine Interface (MEI) driver.

!!! Info "Installing LMS and Drivers"
    **Windows:** LMS is typically included in OEM Intel CSME driver packages available from your system manufacturer's support site. After reinstalling the OS, ensure you install the complete CSME driver package (not just the MEI driver).

    **Linux:** Build LMS from source using the [Intel LMS repository](https://github.com/intel/lms). Ensure the MEI driver is installed first. See the repository's build instructions for dependencies and compilation steps.

   | Action #       | Power Action | Start State | Transition Description | ACPI State(s) | 
   | :----------- | :------------------------ |   :------------------------ | :------------------------ | :------------------------ | 
   | **4** | Sleep (deep) | Powered up/on | Transition to a standby state of low-power usage and store system context (e.g., open applications) in memory | G1/S3 |
   | **7** | Hibernate | Powered up/on | Transition to zero power usage and store system context in non-volatile storage | G1/S4 | 
   | **12** | Power down/off (soft) | Powered up/on | Transition to a very minimal power state | G2/S5 | 
   | **14** | Soft reset | Powered up/on | Perform a shutdown and then a hardware reset | N/A |

## Alternative Power Actions

### Supported Alternative Power Actions

The following alternative power actions are supported for IDE-R CD-ROM operations:

| Action #       | Power Action | Start State | Transition Description | 
| :----------- | :------------------------ |   :------------------------ |:------------------------ |
| **202** | Reset to IDE-R CD-ROM | Powered up/on | Perform hardware reset on the bus to a peripheral IDE-R CD-ROM drive, usually reserved for a remote ISO boot | 
| **203** | Power on to IDE-R CD-ROM | Powered down/off | Power up/on to the bus to a peripheral IDE-R CD-ROM drive, usually reserved for a remote ISO boot |

### Unsupported Alternative Power Actions

The Toolkit does not support the following alternative power actions:

| Action #       | Power Action | Start State | Transition Description | 
| :----------- | :------------------------ |   :------------------------ |:------------------------ |
| **104** | Reset to secure erase | Powered up/on | Perform hardware reset on the bus to secure erase, a process of completely erasing a solid state drive (SSD)|
| **200** | Reset to IDE-R floppy disk | Powered up/on | Perform hardware reset on the bus to a peripheral IDE-R drive, usually reserved for a remote ISO boot |
| **201** | Power on to IDE-R floppy disk| Powered down/off | Power up/on fully to a peripheral IDE-R drive, usually reserved for a remote ISO boot |



