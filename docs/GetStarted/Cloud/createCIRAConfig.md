

Client Initiated Remote Access (CIRA) enables a CIRA-capable edge device to initiate and establish a persistent connection to the MPS. As long as the managed device is connected to the network and to a power source, it can maintain a persistent connection.

!!! note "Note - Wireless Activations"
    This express setup assumes the managed device (i.e. AMT device) is on a wired connection for quickest setup.  To learn more about a Wireless Setup, see the [Wireless Activation Tutorial](../../Tutorials/createWiFiConfig.md).

**To create a CIRA Config:**

1. Select the **CIRA Configs** tab from the left-hand menu.

2. In the top-right corner, click **Add New.**
     <figure class="figure-image">
     <img src="..\..\..\assets\images\screenshots\RPS_NewCIRAConfig.png" alt="Figure 1: Create a new CIRA Config">
     <figcaption>Figure 1: Create a new CIRA Config</figcaption>
     </figure>


3. Specify a **Config Name** of your choice.

4. Select **IPv4**.

5. For **MPS Address**, provide your development system's IP Address.

6. **Cert Common Name (CN=)** should auto-populate. If not, provide your development system's IP Address.

7. Leave **Port** as the default, 4433.

8. Leave the **Username** as *admin* or choose your own.

9. Click **Save.**
    
    !!! example "Example CIRA Config"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\RPS_CreateCIRAConfig.png" alt="Figure 2: Example CIRA Config">
        <figcaption>Figure 2: Example CIRA Config</figcaption>
        </figure>
            
## Next up

Profiles provide configuration information to the AMT Firmware during the activation process with the Remote Provisioning Client (RPC). Profiles also distinguish between activating in: 

**[Client Control Mode (CCM):](createProfileCCM.md)** This mode offers all manageability features including, but not limited to, power control, audit logs, and hardware info. Redirection features, such as KVM or SOL, **require user consent**. The managed device will display a 6-digit code that **must** be entered by the remote admin to access the remote device via redirection.

[Create a CCM Profile](createProfileCCM.md){: .md-button .md-button--primary }

**[Admin Control Mode (ACM):](createProfileACM.md)** ACM mode supports all manageability features **without requiring user consent**. This means it is **not necessary** to have a person on-site to remote in and manage an edge device. In most IoT use cases, edge devices such as digital signage or kiosks may not be easily accessible or have available employees nearby. ACM mode proves immensely helpful in these scenarios.

[Create an ACM Profile](createProfileACM.md){: .md-button .md-button--primary }