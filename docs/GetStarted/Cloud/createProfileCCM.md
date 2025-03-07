--8<-- "References/abbreviations.md"

Client Control Mode (CCM) provides full access to features of Intel® Active Management Technology (Intel® AMT), but it does require user consent for all redirection features.

These features require user consent in CCM:

- **Keyboard, Video, Mouse (KVM):** Control multiple devices with one keyboard, monitor, and mouse.
- **Serial-over-LAN (SOL):** Manage devices with a command line interface (CLI) through SOL.
- **IDE Redirection:** Share and mount images remotely with a specified storage media (e.g., USB flash drive).

!!! Important "Important - IDE Redirection"
    While AMT supports this feature, the toolkit doesn't natively support it. 

<figure class="figure-image">
<img src="..\..\..\assets\images\Profiles.png" alt="Figure 1: Set up configuration and profiles for N number of clients">
<figcaption>Figure 1: Set up configuration and profiles for n number of clients</figcaption>
</figure>

## Create a Profile

Profiles provide configuration information to the firmware on platforms featuring Intel® AMT during the activation process with the Remote Provisioning Client (RPC).

??? note "Note - More Information about Passwords"

    Device Management Toolkit increases security with multiple passwords. Find an explanation of toolkit passwords in [Reference -> Architecture Overview](../../Reference/architectureOverview.md#passwords).

**To create a CCM profile:**

1. Select the **Profiles** tab from the menu on the left.

2. Under the **Profiles** tab, click **New** in the top-right corner to create a profile.
   <figure class="figure-image">
   <img src="..\..\..\assets\images\RPS_NewProfile.png" alt="Figure 2: Create a new profile">
   <figcaption>Figure 2: Create a new profile</figcaption>
   </figure>

3. Specify a **Profile Name** of your choice.

4. Under **Activation Mode**, select **Client Control Mode** from the dropdown menu.

5. Enable desired redirection features for the profile under **AMT Features - Enable/Disable features**.

6. Provide or generate a strong **AMT Password**. AMT will verify this password when receiving a command from a MPS server. This password is also required for device deactivation.
   
    ??? warning "Warning - Viewing and Losing Random Passwords"
        The two buttons next to the password input are for toggling visibility and/or generating a new random password. Please note that **if the Vault database is lost or corrupted (or container stopped), all credentials that aren't also stored somewhere else will be lost.** There will be no way to login. The administrator will have to clear the CMOS battery on the managed devices!
   
7. The **MEBX Password** field is disabled. The password for Intel® Manageability Engine BIOS Extensions (Intel® MEBX) cannot be set when activating in CCM due to the lower level of trust when compared to ACM.

8. Leave DHCP as the default for **Network Configuration**.

9. This express setup assumes the managed device (i.e. AMT device) is on a wired connection for quickest setup.  To learn more about a Wireless Setup, see the [Wireless Activation Tutorial](../../Tutorials/createWiFiConfig.md).

10. Select **CIRA (Cloud)** for **Connection Configuration**.

11. Select the name of the **CIRA Configuration** you created previously from the drop-down menu.

12. Optionally, add **Tags** to help in organizing and querying devices as your list of managed devices grow.

13. Click **Save.**

    !!! example "Example CCM Profile"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\RPS_CreateProfile.png" alt="Figure 3: Example CCM profile">
        <figcaption>Figure 3: Example CCM profile</figcaption>
        </figure>


## Next up
**[Build & Run RPC](buildRPC.md)**

