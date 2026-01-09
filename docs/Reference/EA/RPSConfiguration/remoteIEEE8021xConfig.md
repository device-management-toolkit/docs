

!!! warning "802.1x Configuration is a Preview Feature"
    802.1x Configuration feature is a Preview Feature and is subject to change. This means it has not been fully validated and cannot be guaranteed to work. There are still potential bugs and tweaks needed for a production-level feature standard. Interested in this feature and helping us test it? Reach out via GitHub.

IEEE 802.1X is an IEEE Standard for port-based network access control (PNAC). It provides an authentication mechanism to devices wishing to attach to a LAN or WLAN.

It typically consists of three parts:

1. Supplicant (Client-end User, AMT Device)
2. Authenticator (Access Point or Switch)
3. Authentication Server (RADIUS Server)

## Prerequisites

The following are requirements to configure and connect an AMT device within an 802.1x environment. However, these are not required for the RPS profile creation steps below.

- [Enterprise Assistant configured, running, and connected to an RPS server.](rpsConfiguration.md)
- Updated to latest AMT Firmware version

!!! note "Note - System Name Length"
    **The System Names of the AMT devices must be 15 characters or less.** If the name is greater than 15 characters long, it will exceed the system name length allowed by Active Directory and Enterprise Assistant will fail to add the device.

## Wired 802.1x Configuration

**Only one** wired IEEE8021x Config can be created (per tenant). The following steps walk through how to create the required configs and profiles.

### Create Wired IEEE802.1x Config

1. Select the **IEEE 802.1x** tab from the left-hand menu.

2. In the top-right corner, click **Add New.**
     <figure class="figure-image">
     <img src="..\..\..\..\assets\images\screenshots\RPS_New8021xConfig.png" alt="Figure 1: Create a new IEEE802.1x Config">
     <figcaption>Figure 1: Create a new IEEE802.1x Config</figcaption>
     </figure>

3. Select the Wired option.

4. Specify a **Profile Name** of your choice.

5. Select an **Authentication Protocol**.

    The following are the supported wired authentication protocols.

    |Auth Protocol          | API Value | Description                              |
    | --------------------- | --------- | ---------------------------------------- |
    |EAP-TLS                | 0         | Indicates that the desired EAP type is the Transport Layer Security EAP type specified in [RFC 2716](https://www.rfc-editor.org/rfc/rfc2716).                |
    |PEAPv0/EAP-MSCHAPv2    | 2         | Indicates that the desired EAP type is the Protected Extensible Authentication Protocol (PEAP) Version 0 EAP type specified in [draft-kamath-pppext-peapv0](https://tools.ietf.org/html/draft-kamath-pppext-peapv0-00), with Microsoft PPP CHAP Extensions, Version 2 (MSCHAPv2) as the inner authentication method.     |

6. Optionally, change the **PXE Timeout**.

    PXE Timeout is the number of seconds in which the Intel(R) AMT will hold an authenticated 802.1X session. During the defined period, Intel(R) AMT manages the 802.1X negotiation while a PXE boot takes place. After the timeout, control of the negotiation passes to the host.

7. Click **Save.**
    
    !!! example "Example Wired IEEE802.1x Config"
        <figure class="figure-image">
        <img src="..\..\..\..\assets\images\screenshots\RPS_Create8021xConfig.png" alt="Figure 2: Example Wired IEEE802.1x Config">
        <figcaption>Figure 2: Example Wired IEEE802.1x Config</figcaption>
        </figure>

### Link AMT Profile

1. Select the **Profiles** tab from the left-hand menu.

2. Choose an existing profile or create a new one.

3. Under Network Configuration, select the Wired 802.1x Config from the **Wired 802.1x Configuration** dropdown.

4. Click **Save**.

    After creating the profile and configs, AMT can now be configured for wired 802.1x.

    !!! example "Example ACM Profile with IEEE802.1x"
        <figure class="figure-image">
        <img src="..\..\..\..\assets\images\screenshots\RPS_CreateProfile_8021x.png" alt="Figure 3: Example ACM profile with IEEE802.1x">
        <figcaption>Figure 3: Example ACM profile with IEEE802.1x</figcaption>
        </figure>

<br><br>

## Wireless 802.1x Configuration

There can be a **maximum of 8** wireless IEEE8021x Config created (per tenant). 8 profiles is the maximum AMT can accept. The following steps walk through how to create the required configs and profiles.

### Create Wireless IEEE802.1x Config

1. Select the **IEEE 802.1x** tab from the left-hand menu.

2. In the top-right corner, click **Add New.**
     <figure class="figure-image">
     <img src="..\..\..\..\assets\images\screenshots\RPS_New8021xConfig.png" alt="Figure 1: Create a new IEEE802.1x Config">
     <figcaption>Figure 4: Create a new IEEE802.1x Config</figcaption>
     </figure>

3. Select the Wireless option.

4. Specify a **Profile Name** of your choice.

5. Select an **Authentication Protocol**.

    The following are the supported wireless authentication protocols.

    |Auth Protocol          | API Value | Description                              |
    | --------------------- | --------- | ---------------------------------------- |
    |EAP-TLS                | 0         | Indicates that the desired EAP type is the Transport Layer Security EAP type specified in [RFC 2716](https://www.rfc-editor.org/rfc/rfc2716).                |
    |PEAPv0/EAP-MSCHAPv2    | 2         | Indicates that the desired EAP type is the Protected Extensible Authentication Protocol (PEAP) Version 0 EAP type specified in [draft-kamath-pppext-peapv0](https://tools.ietf.org/html/draft-kamath-pppext-peapv0-00), with Microsoft PPP CHAP Extensions, Version 2 (MSCHAPv2) as the inner authentication method.    |

6. Click **Save.**
    
    !!! example "Example Wireless IEEE802.1x Config"
        <figure class="figure-image">
        <img src="..\..\..\..\assets\images\screenshots\RPS_Create8021xWireless.png" alt="Figure 2: Example Wireless IEEE802.1x Config">
        <figcaption>Figure 5: Example Wireless IEEE802.1x Config</figcaption>
        </figure>

### Link Wifi Config Profile

1. Select the **Wireless** tab from the left-hand menu.

2. Choose an existing profile or create a new one.

3. Under **Authentication Method**, there should now be two new options. Select either **WPA IEEE 802.1x** or **WPA2 IEEE 802.1x**.

4. Click **Save**. The new wireless config can now be included in an AMT profile.

    After creating the profile and configs, AMT can now be configured for wireless 802.1x.

    !!! example "Example Wireless Config with IEEE802.1x"
        <figure class="figure-image">
        <img src="..\..\..\..\assets\images\screenshots\RPS_CreateWireless_8021xconfig.png" alt="Figure 3: Example Wireless Config with IEEE802.1x">
        <figcaption>Figure 6: Example Wireless Config with IEEE802.1x</figcaption>
        </figure>
