

Admin Control Mode (ACM) provides full access to Intel® Active Management Technology (Intel® AMT) functionality. User consent is optional for supported redirection features:

- **Keyboard, Video, Mouse (KVM):** Control multiple devices with one keyboard, monitor, and mouse.
- **Serial-over-LAN (SOL):** Manage devices with a command line interface (CLI) through SOL.
- **IDE Redirection:** Share and mount images remotely with a specified storage media (e.g., USB flash drive). 

### What You'll Need

#### Provisioning Certificate

By purchasing a certificate, you'll be able to remotely activate an Intel® AMT device in ACM. This feature enables you to disable User Consent. Provisioning Certificates are available from four different Certificate Authorities. [Find more information about Provisioning Certificates](../../Concepts/remoteProvisioning.md).

- [DigiCert](https://www.intel.com/content/www/us/en/support/articles/000055009/technologies.html)
- [Entrust](https://www.intel.com/content/www/us/en/support/articles/000055010/technologies/intel-active-management-technology-intel-amt.html)
- [GoDaddy](https://www.intel.com/content/www/us/en/support/articles/000020785/software.html)

!!! Important "Important - Intel AMT and using CAs"
    For ACM in Device Management Toolkit, **use only** certificate vendors that support Intel® AMT.

Alternatively, for development, custom provisioning certificates can be generated. See [Custom Provisioning Certificate](../../Reference/Certificates/generateProvisioningCert.md) for additional details.

#### DNS Suffix
The DNS suffix encompasses the domain suffix (e.g., .com) and follows the hostname. Consider the following DNS Name example:

!!! example "Example - DNS"
    DNS Name: cb-vending1.burgerbusiness.com

In this example, the hostname is **cb-vending1** and the DNS suffix is **burgerbusiness.com.**

**To set the DNS suffix:**

1. Manually set it using MEBX on the managed device. See [MEBx DNS Suffix](../../Reference/MEBX/dnsSuffix.md).

2. Alternately, change the DHCP Option 15 to DNS suffix within the Router settings.

**To find the DNS suffix, use the following command:**

=== "Linux"
    ``` bash
    ifconfig
    ```

=== "Windows"
    ```
    ipconfig /all
    ```

<br>

### Create a Domain Profile

ACM requires the creation of a Domain profile.

Intel® AMT checks the network DNS suffix against the provisioning certificate as a security check. During provisioning, the trusted certificate chain is injected into the AMT firmware.  AMT verifies that the certificate chain is complete and is signed by a trusted certificate authority.

**To create a domain:**

1. Select the **Domains** tab from the left-hand menu.

2. In the top-right corner, click **Add New.**
    <figure class="figure-image">
    <img src="..\..\..\assets\images\screenshots\Console_NewDomain.png" alt="Figure 4: Create a new Domain profile">
    <figcaption>Figure 4: Create a new Domain profile</figcaption>
    </figure>

3. Specify a name of your choice for the Domain Profile for the **Name** field. This does not have to be the actual network Domain Name/Suffix.

4. Provide your **DNS suffix** as the **Domain Name**. This is the actual DNS suffix of the network domain that is set in DHCP Option 15 or manually on the AMT device through MEBX.

5. Click **Choose File** and select your purchased Provisioning Certificate.  This certificate must contain the private key.

6. Provide the **Provisioning Certificate Password** used to encrypt the `.pfx` file.

7. Click **Save.**

    !!! example "Example Domain"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\RPS_CreateDomain.png" alt="Figure 5: Example Domain profile">
        <figcaption>Figure 5: Example Domain profile</figcaption>
        </figure>


### Create a Profile

A Profile provides configuration information to the AMT Firmware during the activation process with the Remote Provisioning Client (RPC).

??? note "Note - More Information about Passwords"
    Device Management Toolkit increases security with multiple passwords. Find an explanation of toolkit passwords in [Security Overview](../../Concepts/security.md).

**To create an ACM profile:**

1. Select the **Profiles** tab from the menu on the left.

1. Under the **Profiles** tab, click **Add New** in the top-right corner to create a profile.

    <figure class="figure-image">
    <img src="..\..\..\assets\images\screenshots\Console_NewProfile.png" alt="Figure 2: Create a new profile">
    <figcaption>Figure 2: Create a new profile</figcaption>
    </figure>

1. Specify a **Profile Name** of your choice.

1. Under **Activation**, select **Admin Control Mode** from the dropdown menu.

1. Enable desired redirection features for the profile under **AMT Features - Enable/Disable features**.

1. Choose level of **User Consent**. By default for ACM, **None** is selected. This will disable all User Consent for ACM.

1. Provide or generate a strong **AMT Password**. AMT will verify this password when receiving a command from Console. This password is also required for device deactivation.
   
1. Provide or generate a strong **MEBX Password**. This password can be used to access Intel® Manageability Engine BIOS Extensions (Intel® MEBX) on the AMT device.

1. Choose DHCP or Static based on environment for the **Network Configuration**.

1. This express setup assumes the managed device (i.e. AMT device) is on a wired connection for quickest setup.  To learn more about a Wireless Setup, see the [Wireless Activation Tutorial](../../Tutorials/createWiFiConfig.md).

1. For quickest setup, select **Non TLS** under **Provisioned Connection Configuration**.

1. Optionally, add **Tags** to help in organizing and querying devices as your list of managed devices grow.

1. Click **Save.**

    !!! example "Example ACM Profile"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\Console_NewACMProfile.png" alt="Figure 3: Example ACM profile">
        <figcaption>Figure 3: Example ACM profile</figcaption>
        </figure>


## Next Up

**[Export Profile](exportProfile.md)**