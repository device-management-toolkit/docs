--8<-- "References/abbreviations.md"

Console is an open-source management application that enables IT administrators to manage Intel® AMT devices within on-premises environments (or private networks). Once an AMT device is activated, it can be added to Console, allowing administrators to establish a secure 1:1 direct connection for performing out-of-band management operations.

With Console, IT administrators can access detailed system information and perform essential management tasks, including power control, hardware inventory, and KVM-based remote access.

<figure class="figure-image">
  <img src="..\..\..\assets\images\Device_Management_Toolkit_Console.png" alt="Figure 1: Console Overview">
  <figcaption>Figure 1: Console Overview</figcaption>
</figure>

## Get Started

Set up Console quickly and get a device connected.

[Get Started Now](../../GetStarted/Enterprise/setup.md){: .md-button .md-button--primary }
<br>

## Features

Console supports a wide range of features to simplify device management, including, but not limited to:

- *Power Actions* – Remotely power on, off, or reset and more.
- *Hardware Inventory *– Query Intel AMT for detailed hardware information like BIOS features, CPUs, memory, add-in cards, media, and more.
- *KVM (Keyboard, Video, Mouse)* – KVM allows remote control of a platform using a remote keyboard and mouse, while also viewing the managed platform’s screen output on a remote monitor. This feature enables full control over the device, even if the operating system is not running.
- *Event and Audit Logs* – Manage internal alerts from both the host platform and Intel AMT device, regardless of their power state. Review logs to detect break-in attempts, damaging commands, and trace events for root cause analysis.
- *SOL (Serial Over LAN)* – Intel AMT enables the redirection of serial and data storage communications from a managed client to a management console. Console handles this functionality for remote management.
- *[One Click Recovery](./Features/ocr.md)* – Perform secure recovery from failures using One Click Recovery feature.
- *[WSMAN Explorer Feature](./Features/wsmanExplorer.md)* – View WSMAN input sent to AMT and its response.

## Additional Resources

For more details on configuring, securing, or upgrading Console, refer to the following sections:

- *[Configuration options](./configuration.md)* – Learn how to configure Console using `config.yml` or environment variables. 
- *[Security Considerations](./securityConsole.md)* – Understand key security aspects and best practices to protect critical assets.
- *[Upgrading from Beta to v1.x](./upgrade.md)* – Follow upgrade instructions from Beta to v1.x and future versions.
- *[802.1x Configuration using Enterprise Assistant](../EA/overview.md)* – Learn how to setup and use Enterprise Assistant to help with configuring devices for 802.1x and TLS environments using existing Microsoft services such as Microsoft Certificate Authority and Microsoft Active Directory.
- *[Known issues & Issue Reporting](https://github.com/device-management-toolkit/console/issues)* – View known issues or report new ones to help us improve Console. **We welcome contributions for faster resolution!**
- *[What’s Coming Next?](https://github.com/orgs/device-management-toolkit/projects/10/views/2)* – Follow our backlog to see what the team is working on and upcoming features.
<br>