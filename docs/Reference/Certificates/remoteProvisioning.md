
	
## What is remote provisioning?

Provisioning is the process of bringing a remote device under the management of the Management Presence Server (MPS). Ideally, the process activates and configures a remote device without physically touching it. To manage a device remotely, you must provision it, securely configure it using the Remote Provisioning Server (RPS), which communicates with the Management Presence Server (MPS). 

The table below describes the process: 

| Step       | Significance to Provisioning|  
| :------------------------- | :--------------------- | 
| 1. Create a Client Initiated Remote Access (CIRA) configuration | This saved configuration will be used to configure the CIRA protocol for public cloud environments. |
| 2. Set up the AMT Profile and choose an activation type | Choose from two modes, Admin Control Mode (ACM) and Client Control Mode (CCM). If ACM is chosen, add a provisioning certificate in Step 3. CCM does not require a certificate. |
| 3. Add a domain profile and associated signed provisioning certificate | Upload a provisioning certificate. |
| 4. Use the rpc-go client application to activate the remote device | Deploy and run the client as **Administrator** on the desired remote platform. Leverage the profile you created in Step 2.  |

Figure 1 illustrates the steps below. Also, see [Get Started](../../GetStarted/Cloud/prerequisites.md).

The toolkit accomplishes secure provisioning with authentication and a secure tunnel using the Transport Layer Security (TLS) protocol. 

The authentication process involves:

* **A provisioning certificate*:** an electronic document used to establish the identity of the holder
* **CIRA:** a protocol used by the remote device to "call home", initiate remote connectivity, with an MPS.

After a device is provisioned, the administrator can use the management console to perform different control activities, such as [power actions (e.g., Reset)](../powerstates.md) without an onsite visit.

<figure class="figure-image">
<img src="..\..\..\assets\images\diagrams\RemoteProvCert.svg" style="height:800px;" alt="Figure 1: Certificates in the Toolkit: Provisioning and CIRA">
<figcaption>Figure 1: Provisioning and CIRA</figcaption>
</figure>

## What about manual provisioning?

Sometimes it's not possible to deploy the rpc-go client application to activate the device remotely. When remote provisioning is not an option, provision manually in the BIOS.

To provision manually for ACM, see [Set a DNS Suffix through MEBX](../MEBX/dnsSuffix.md).

## What is a remote provisioning certificate?

A remote provisioning certificate is used for the activation of the remote device by the provisioning server. The activation phase of provisioning *turns on* or enables Intel AMT in the remote device. The Intel AMT firmware contains the root certificate hashes, TLS-based thumbprints, of participating vendors, known as certificate authorities (CA). The root certificate hash is compared with that certificate's hash. If they match, the certificate is deemed valid. 

!!! Note
    * The remote provisioning certificate is used only for initial provisioning of the device, bringing it under the management of the provisioning server. 
    * Purchase a separate certificate for website hosting. 

## How do provisioning certificates work in the Toolkit?

### Acquire

#### Purchase

To use a provisioning certificate in the toolkit, purchase the certificate from a CA. 

!!! Note
    * You do not have to purchase a certificate for each device in a fleet. The certificate is purchased for the provisioning server. 
    * Prices vary per vendor.

- [Comodo](https://www.intel.com/content/www/us/en/support/articles/000054981/technologies.html)
- [DigiCert](https://www.intel.com/content/www/us/en/support/articles/000055009/technologies.html)
- [Entrust](https://www.intel.com/content/www/us/en/support/articles/000055010/technologies/intel-active-management-technology-intel-amt.html)
- [GoDaddy](https://www.intel.com/content/www/us/en/support/articles/000020785/software.html)

!!! Important "Important - Intel AMT and using CAs"
    For ACM in Device Management Toolkit Toolkit, **use only** certificate vendors that support Intel® AMT.

#### Generate

Alternatively, for development, custom provisioning certificates can be generated for use using tools like OpenSSL. See [Custom Provisioning Certificate](./generateProvisioningCert.md) for additional details.

### Upload
After purchasing a certificate:

1. Download the personal exchange format (PFX) file. This file contains public and private objects in a single file. It also contains a certificate chain, including the public key of the root certificate, the public key the intermediate certificate, public key of the SSL certificate. 
2. Upload it during the domain profile stage of provisioning. The PFX is saved to Vault. 

This uploaded file is used during the activation stage.

### Activate

After you switch Intel AMT on, or activate it, CIRA is configured. In order to configure CIRA, another certificate is necessary. Currently, the toolkit uses a self-signed certificate generated by MPS and stored in Vault. The certificate generation happens during deployment of the MPS. This certificate cannot be obtained from a vendor. MPS automatically loads the CIRA self-signed certificate into Vault.

Intel AMT checks the common name of the self-signed certificate. It must match the one you've supplied in the CIRA Config Profile on the MPS Address line. 


## Learn More

| Link      | Description |  
| :------------------------- | :--------------------- | 
| [An Introduction To Intel AMT Remote Configuration Selection](https://www.intel.com/content/dam/support/us/en/documents/technologies/remote-configuration-certificate-selection.pdf) | Outlines the provisioning process. |
| [Certificate Setup and Configuration Video](https://www.intel.com/content/www/us/en/support/articles/000026592/technologies.html) | Describes the certificate purchase process. |
| [What is the  vPro® Platform?](https://www.intel.com/content/www/us/en/architecture-and-technology/vpro/what-is-vpro.html) | Describes the certificate purchase process. |


