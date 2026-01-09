--8<-- "References/abbreviations.md"

!!! note "Note - Support for User Consent"
    Currently, the implementation of IDER in Device Management Toolkit does not support User Consent. In order to use IDER, the device must be activated in ACM. To see when support for User Consent will be added, [follow our Github Backlog](https://github.com/orgs/device-management-toolkit/projects/10).

IDE-Redirection (IDER) allows a trusted administrator to remotely mount disk images on an Intel AMT computer over the network. The device can then reboot using this image to perform tasks such as:

- Computer Recovery
- OS Re-installation
- Virus Scanning and more

To have the best performance, it is recommended to perform a Two-Stage recovery process.

- Stage 1: Load a minimal OS kernel initially through IDER
- Stage 2: Retrieve full OS from Windows Share, HTTP, iSCSI, etc

<div style="text-align:center;">
  <iframe width="600" height="337" src="https://www.youtube.com/embed/N_1koCmZKbw?si=GPukyEFgUfKOxSLK" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  <figcaption><b>IDE Redirection Tutorial Video</b>: Follow along to learn more about IDER, its use cases, and how to use it.</figcaption>
</div>

## What You'll Need

**Hardware**

A minimum network configuration must include:

-  A Development system with Windows® 10 or Ubuntu 22.04 or newer
-  An Activated and Configured Intel® vPro device as the managed device

**Software on the Development System** 

- MPS and Sample Web UI
- An `.iso` File ([netboot.xyz](https://netboot.xyz/downloads/#x86_64-combined-legacy-and-uefi-ipxe-bootloaders) is used in this guide as a demonstration. Custom images can be used.)

    !!! Note
        For instructions to setup the MPS and RPS servers to connect a managed device, see the [Get Started Guide](../GetStarted/Cloud/prerequisites.md)
  
## What You'll Do
The following sections describe how to:

- Start an IDER session
- Remote Mount an ISO
- Reimage the AMT Device


## Start an IDER Session

1. In the Sample Web UI, navigate to the Devices page.

2. Select the device to reimage.

3. Start a KVM session.

4. Click **Attach Disk Image (.iso)** button in the upper-right corner.

    <figure class="figure-image">
    <img src="..\..\assets\images\screenshots\SampleUI_StartIDER.png" alt="Figure 1: Start IDER Session">
    <figcaption>Figure 1: Start IDER Session</figcaption>
    </figure>

## Remote Mount an ISO

1. Select the `.iso` file to mount to the AMT device.

    <figure class="figure-image">
    <img src="..\..\assets\images\screenshots\SampleUI_IDER_ChooseFile.png" alt="Figure 2: Choose .iso File">
    <figcaption>Figure 2: Choose .iso File</figcaption>
    </figure>

2. After uploading the `.iso` file, MPS will start to transfer and mount the image to the AMT device. 

3. To verify the image was successfully mounted, view the available mounted drives on the AMT device. When the mount is listed, it is ready.

    <figure class="figure-image">
    <img src="..\..\assets\images\screenshots\SampleUI_IDER_Drives.png" alt="Figure 3: View Mounted Drives">
    <figcaption>Figure 3: View Mounted Drives</figcaption>
    </figure>

## Reimage the Device

1. Reset the device to IDE-R (CD-ROM).

    <figure class="figure-image">
    <img src="..\..\assets\images\screenshots\SampleUI_IDER_Reset.png" alt="Figure 4: Reset to IDE-R">
    <figcaption>Figure 4: Reset to IDE-R</figcaption>
    </figure>

2. After the device has finished POST, a menu or process will begin. This will vary based on the `.iso` file used. In this example, *netboot.xyz* is used and its menu can be seen.

    !!! success
        <figure class="figure-image">
        <img src="..\..\assets\images\screenshots\SampleUI_IDER_netboot.png" alt="Figure 5: IDER Session">
        <figcaption>Figure 5: IDER Session</figcaption>
        </figure>

<br>

## Learn How to Integrate into a Custom UI

Explore how to add redirection features, such as Keyboard, Video, and Mouse (KVM) and IDE-Redirect (IDER), with prebuilt React components.

[Get Started with the UI Toolkit](../Tutorials/uitoolkitReact.md){: .md-button .md-button--primary }

<br>