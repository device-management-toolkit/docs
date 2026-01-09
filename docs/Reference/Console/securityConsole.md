

# Console Security Considerations

The Console service provides a key communication interface between the UI and and Intel&reg; AMT device.  When deploying and operating this service, there are a few key factors that should be considered in order to maintain asset security.  This document will cover those factors and the critical assets that must be protected.  The following are the assets that must be protected:

* Remote admin password for Intel&reg; AMT
* MEBX password for Intel&reg; AMT
* Provisioning Certificate
* Password used to encrypt Provisioning Certificate
* Device configuration information sent to Intel&reg; AMT device
* Database file that stores Intel&reg; AMT device connection information

In addition to the above assets, there are best practices that are recommended to help secure these assets as they are used within the system.  The following sections will cover each asset and the recommended practices to use to protect the assets.

---
## Security Assets

### Remote Admin Password for Intel&reg; AMT
This password is what is configured in the Intel&reg; AMT firmware that allows a remote user to remotely control the Intel&reg; AMT device (power actions, remote desktop, remote terminal, etc).  When a user adds a device to Console, the Intel&reg; AMT remote admin password is provided to Console and Console saves this in the database for future use.  It is highly recommended to use randomly generated passwords for the Intel&reg; AMT remote admin password so that if the password is exposed, only a single device is impacted.

### MEBX Password for Intel&reg; AMT
The Management Engine BIOS Extension (MEBX) password is the password that protects the pre-boot menu option that provides access to Intel® AMT settings.  To use this password a user needs to have physical access to the device.  It is highly recommended to change this password from the factory default settings upon receiving a new Intel® AMT device.  A Console profile provides an option for either specifying a static password that is used for all devices configured with a given profile or a randomly generated password can be assigned uniquely per device.  Console does not save the per device MEBX password in its database.
While a randomly generated password is more secure, in this case there is risk that if the assigned password is lost, access to the MEBX for the Intel® AMT device could be very difficult to recover.  It is recommended to securely store and backup the Console database that holds the profiles containing the MEBX password. 

### Provisioning Certificate
This certificate is unique per owned domain profile in Console where RPC-Go needs to provision Intel® AMT devices.  This certificate must be derived from a root certificate whose hash matches one of the trusted provisioning root certificate hashes that is listed in the Intel® AMT device firmware.  Generally, the provisioning certificate is purchased from a trusted certificate authority (VeriSign, GoDaddy, Comodo, etc).  The full list of supported CAs based on Intel® AMT version are listed [here](https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/WordDocuments/rootcertificatehashes.htm).  This certificate must contain the leaf certificate, root certificate, and all of the intermediate certificates to form a complete certificate chain.  Additionally, the certificate file must also include the private key for the certificate (.pfx format).  The leaf certificate for the provisioning certificate must match the domain suffix that the Intel® AMT device is connected as specified by DHCP option 15 or the Trusted DNS suffix in the Management Engine BIOS Extensions (MEBX).  Matching this is one of the ways in which the Intel® AMT firmware establishes trust with the configuration server or application. 
The provisioning certificate is provided by the user when defining an Intel® AMT profile.  Console includes the provisioning certificate information in the configuration yaml file when exporting the profile.  If users have multiple provisioning certificates, they will need to understand which profile to use when configuring an Intel® AMT device based on the network to which the device is currently connected.

### Password used to encrypt Provisioning Certificate
This is the password that is used to encrypt the provisioning certificate .pfx file that is discussed above.  RPC-Go uses this password to decrypt the provisioning certificate so that it can use the certificate components and the private key to activate Intel® AMT devices.  
Console can provide this information as part of the configuration yaml file that RPC-Go will use to activate Intel&reg; AMT devices.

### Device configuration information sent to Intel® AMT device
Intel&reg; AMT firmware uses configuration information to establish trust and then activate and configure the Intel&reg; AMT device. The information contains the hashed remote admin password, MEBX password, WiFi SSIDs and passwords, provisioning certificate information, etc. In order to protect this data when in transit to RPC-G, Console provides an option to encrypt the data when exporting to a configuration yaml file.  This password can then be passed into RPC-Go along with the configuration file so that RPC-Go can decrypt the file and use the information to activate and configure Intel&reg; AMT devices.

### Database file that stores Intel&reg; AMT device connection information
By default, when Console is first launched, it configures an SQLite DB file in the logged in user's personal directory (ex. C:/Users/<<i>username</i>>/AppData/Roaming/device-management-toolkit on Windows).  Protection for this file relies on OS level user permissions.  For more robust security, it is recommended to deploy Console as an enterprise service backed with an enterprise grade database and proper access controls to Console's APIs.

---
## Best Known Security Methods

### 1 Enable TLS when configuring Intel&reg; AMT device
Intel&reg; AMT supports using TLS for remote connections.  There are two options to enable TLS when configuring Intel&reg; AMT.
* Self-signed TLS certificate.  When creating the Intel&reg; AMT Profile, if you select self-signed certificate, when RPC-Go sees this in the configuration yaml file it will create a self-signed certificate and provide that to Intel&reg; AMT when configuring TLS.
* Signed TLS certificate from Enterprise Assistant.  When creating the Intel&reg; AMT Profile, if you provide the Enterprise Assistant location and credentials, RPC-Go will get a Certificate Signing Request (CSR) from Intel&reg; AMT and have Enterprise Assistant request a signed certificate from the enterprise CA.  See [Enterprise Assistant](../EA/overview.md) documentation for more information.

### 2 Secure Console Deployment
By default, Console creates an SQLite database file in the protected user's directory of the OS in which Console is running.  This provides a minimal level of protection for the data stored in the database.  For production deployments, it is recommended to deploy Console as a centralized service backed up by an enterprise DB with proper data protections.  Console running as a service should have access controls enabled for the APIs.  The UI should be deployed in an enterprise web server with enterprise access controls, limiting the users who have access to the Console UI and service functionality.