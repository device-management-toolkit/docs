
# Out-of-Band Management (OOB Management)

## What is OOB Management?

Device Management Toolkit uses remote management technology, also known as OOB Management, to allow administrators to perform actions on network assets or devices using a secure alternative to LAN-based communication protocols. Actions include reboot, power up, power down, system updates, and more. As long as the network device or asset is connected to power, Device Management Toolkit software can perform remote management, including powering up a system that is currently powered down.

Remote management can offer potential cost-savings by decreasing the need for in-person technician visits to remote IT sites and reducing downtime.

## In-Band vs Out-of-Band Management

Remote monitoring and management software solutions often require the managed devices to be in the powered on state. The IT administrator connects to and updates the managed device while it is in the powered on state. This is known as **in-band management**.

With **out-of-band management**, the administrator can connect to the device when it has been powered down or it is unresponsive.

| | In-Band Management | Out-of-Band Management |
|:--|:--|:--|
| **Device State** | Must be powered on with OS running | Can be powered off or unresponsive |
| **Connection** | Through the OS network stack | Through Intel® AMT firmware |
| **Use Cases** | Routine updates, monitoring | Recovery, BIOS updates, power control |

## Power Control

Once a connection is established — whether through a CIRA tunnel (Cloud path) or a direct connection (Enterprise path) — Device Management Toolkit enables the administrator to manage remote devices and trigger power actions to:

- power up
- power down
- power up to BIOS
- reset
- reset to BIOS

For more information about [power states](../Reference/powerstates.md) supported by the REST APIs, see [Intel® AMT Implementation and Reference Guide](https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/default.htm?turl=WordDocuments%2Fchangesystempowerstate.htm) for more details.

## Keyboard, Video, Mouse (KVM) Control

Intel® AMT enables remote management of a device, even when the OS isn't running, through KVM over IP support. No additional equipment is needed for this feature. With KVM control, IT administrators can access and update PCs and devices as if they were onsite. It eliminates the need for remote KVM switches and other hardware.

## Learn More

- [Architecture & Components](./architecture.md) — How the toolkit microservices work together
- [Control Modes](./controlModes.md) — ACM vs CCM and their implications
- [Get Started](../GetStarted/overview.md) — Set up the toolkit
