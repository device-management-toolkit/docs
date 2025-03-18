--8<-- "References/abbreviations.md"

!!! important "Important - Windows 10 or Newer Supported Only"
    This feature is currently only supported for systems on Windows 10 or newer (including Windows 11) operating systems. **Wireless on Linux is not currently supported by Intel AMT.**

!!! warning "Warning - Support for Cellular"
    While Device Management Toolkit supports wireless and wired profiles, it does not currently offer support for managing devices through cellular connections. Products like [Cradlepoint*](https://cradlepoint.com/) offer a workaround for cellular connections.

After activation and configuration of an AMT device with a wireless profile, remote devices can be managed wirelessly.

**For devices to be activated in Client Control Mode (CCM)**: The managed AMT device can be activated and configured on a wireless connection.

**For devices to be activated in Admin Control Mode (ACM)**: The managed AMT device **MUST have a wired connection** during the activation of AMT. After activation, devices are then able to be managed over the wireless network rather than a wired connection.

Use RPC's `amtinfo` feature to determine if your current device supports wireless functionality. For steps to obtain the RPC binary, see [Build RPC](../Reference/RPC/buildRPC_Manual.md).

1. Run RPC with the `amtinfo` argument.

```
rpc amtinfo
```

2. Look at the output for the LAN Interface section as highlighted below. **If RPC does NOT return a section for wireless**, the AMT device does not support wireless functionality. 

    ``` hl_lines="19-24"
    Version                : 15.0.10
    Build Number           : 1447
    SKU                    : 16392
    UUID                   : 4c4b4568-195a-4260-8097-a4c14f566733
    Control Mode           : pre-provisioning state
    DNS Suffix             : vprodemo.com
    DNS Suffix (OS)        :
    Hostname (OS)          : DESKTOP-3YM6MPN
    RAS Network            : outside enterprise
    RAS Remote Status      : not connected
    RAS Trigger            : user initiated
    RAS MPS Hostname       :
    ---Wired Adapter---
    DHCP Enabled           : true
    DHCP Mode              : passive
    Link Status            : up
    AMT IP Address         : 0.0.0.0
    OS IP Address          : 192.168.1.90
    MAC Address            : 80:c4:a8:58:df:e9
    ---Wireless Adapter---
    DHCP Enabled           : true
    DHCP Mode              : passive
    Link Status            : down
    AMT IP Address         : 0.0.0.0
    OS IP Address          : 192.168.1.90
    MAC Address            : 00:00:00:00:00:00
    Certificate Hashes     : 
    ...
    ```

## Create a WiFi Config

1. Select the **Wireless** tab from the left-hand menu.

2. In the top-right corner, click **Add New.**

    <figure class="figure-image">
    <img src="..\..\assets\images\RPS_NewWireless.png" alt="Figure 1: Create a new WiFi Config">
    <figcaption>Figure 1: Create a new WiFi Config</figcaption>
    </figure>

3. Specify a **Wireless Profile Name** of your choice.

4. Under **Authentication Method**, select **WPA PSK** or **WPA2 PSK**.

5. Provide the **PSK Passphrase**. This is the password to the WiFi Network.

6. Under **Encryption Method**, select **TKIP** or **CCMP**.

7. Specify the **SSID**. This is the name of your wireless network.

8. Click **Save.**

    !!! example "Example Wireless Profile"
        <figure class="figure-image">
        <img src="..\..\assets\images\RPS_WirelessCreate.png" alt="Figure 1: Example Wireless Profile">
        <figcaption>Figure 1: Example wireless profile</figcaption>
        </figure>

9. **Important**: After saving, continue on to create either a CCM or ACM profile. When prompted, search for and select your new Wireless Profile from the drop-down menu. The selected Wi-Fi Profiles will be shown under **Associated Wireless Profiles** and can be reordered by dragging them to give priority.

    !!! example "Example - Select Wireless Profile"
        <figure class="figure-image">
        <img src="..\..\assets\images\RPS_CreateProfile_withWiFi.png" alt="Figure 3: RPS Bottom of Profile">
        <figcaption>Figure 3: RPS bottom of profile</figcaption>
        </figure>

## Next up

Profiles provide configuration information to the AMT Firmware during the activation process with the Remote Provisioning Client (RPC). Profiles also distinguish between activating in: 

**[Client Control Mode (CCM):](../GetStarted/Cloud/createProfileCCM.md)** This mode offers all manageability features, including but not limited to, power control, audit logs, and hardware info. Redirection features, such as KVM or SOL, **require user consent**. The managed device will display a 6-digit code that **must** be entered by the remote admin to access the remote device via redirection.

[Create a CCM Profile](../GetStarted/Cloud/createProfileCCM.md){: .md-button .md-button--primary }

**[Admin Control Mode (ACM):](../GetStarted/Cloud/createProfileACM.md)** ACM mode supports all manageability features **without requiring user consent**. This means it is **not necessary** to have a person on-site to remote in and manage an edge device. In most IoT use cases, edge devices, such as digital signage or kiosks, may not be easily accessible or have available employees nearby. ACM mode proves immensely helpful in these scenarios.

[Create an ACM Profile](../GetStarted/Cloud/createProfileACM.md){: .md-button .md-button--primary }
