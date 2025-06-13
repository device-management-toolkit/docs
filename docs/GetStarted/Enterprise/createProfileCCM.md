--8<-- "References/abbreviations.md"

Client Control Mode (CCM) provides full access to features of Intel® Active Management Technology (Intel® AMT), but it does require user consent for all redirection features.

These features require user consent in CCM:

- **Keyboard, Video, Mouse (KVM):** Control multiple devices with one keyboard, monitor, and mouse.
- **Serial-over-LAN (SOL):** Manage devices with a command line interface (CLI) through SOL.
- **IDE Redirection:** Share and mount images remotely with a specified storage media (e.g., USB flash drive).

## Create a Profile

Profiles provide configuration information to the firmware on platforms featuring Intel® AMT during the activation process with the Remote Provisioning Client (RPC).

??? note "Note - More Information about Passwords"

    Device Management Toolkit increases security with multiple passwords. Find an explanation of toolkit passwords in [Reference -> Architecture Overview](../../Reference/architectureOverview.md#passwords).

**To create a CCM profile:**

1. Select the **Profiles** tab from the menu on the left.

2. Under the **Profiles** tab, click **New** in the top-right corner to create a profile.
   <figure class="figure-image">
   <img src="..\..\..\assets\images\screenshots\Console_NewProfile.png" alt="Figure 2: Create a new profile">
   <figcaption>Figure 2: Create a new profile</figcaption>
   </figure>

3. Specify a **Profile Name** of your choice.

4. Under **Activation Mode**, select **Client Control Mode** from the dropdown menu.

5. Enable desired redirection features for the profile under **AMT Features - Enable/Disable features**.

6. Provide or generate a strong **AMT Password**. AMT will verify this password when receiving a command from Console. This password is also required for device deactivation.
     
7. The **MEBX Password** field is disabled. The password for Intel® Manageability Engine BIOS Extensions (Intel® MEBX) cannot be set when activating in CCM due to the lower level of trust when compared to ACM.

8. Choose DHCP or Static based on environment for the **Network Configuration**.

9. This express setup assumes the managed device (i.e. AMT device) is on a wired connection for quickest setup.  To learn more about a Wireless Setup, see the [Wireless Activation Tutorial](../../Tutorials/createWiFiConfig.md).

10. For quickest setup, select **Non TLS** under **Provisioned Connection Configuration**.

11. Optionally, add **Tags** to help in organizing and querying devices as your list of managed devices grow.

12. Click **Save.**

    !!! example "Example CCM Profile"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\Console_NewCCMProfile.png" alt="Figure 3: Example CCM profile">
        <figcaption>Figure 3: Example CCM profile</figcaption>
        </figure>


## Next up
**[Export Profile](exportProfile.md)**

