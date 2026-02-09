

For production deployments, we highly recommend purchasing a 3rd party provisioning certificate. [See all available vendors here.](../../Concepts/remoteProvisioning.md#purchase) 

!!! warning "Warning - Custom Provisioning Certificates in Production Deployments"
    The hash of custom provisioning certificates must be manually added to all devices that will be configured into ACM. This can be done through MEBx or USB Configuration. Both options require manual, hands-on configuration of each AMT device. **Adding the hash to AMT's trusted list is a mandatory requirement for the device to successfully activate.**

However, some developers opt to use a custom provisioning certificate for testing and validation purposes.
    
The steps below outline how to generate a custom certificate based on the requirements within the [Intel® AMT SDK](https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/WordDocuments/acquiringanintelvprocertificate.htm).

!!! note "Note - Unprovisioning will Delete Custom Hashes"
    When a device is unprovisioned, AMT will delete and remove all hashes inserted. If you want to then activate the device again, you will have to reinsert the certificate hash again.

## Generate Custom Provisioning Certificate

These steps create a certificate for a domain `example.com` and walk through how to successfully activate a device using the `example.com` DNS suffix.

### What You'll Need

**Software** 

- [OpenSSL](https://www.openssl.org/)

### Configuration Files

First, we need to prepare two files:

- **cert.conf** - Certificate configuration file. It is used to define the specific settings for the certificate.
- **csr.conf** - Certificate signing request configuration file. 

#### Create `cert.conf`

1. Create a new file named `cert.conf`.

2. Copy and paste the below example into the file.

    **Do not remove the OID 2.16.840.1.113741.1.2.3 from the *extendedKeyUsage*.** This is an AMT requirement.

    **Optionally**, update the **[alt_names]** section with your own server DNS  information.

    ``` title="cert.conf"
    basicConstraints = CA:FALSE
    subjectKeyIdentifier = hash
    authorityKeyIdentifier = keyid,issuer:always
    keyUsage = digitalSignature, keyEncipherment
    extendedKeyUsage = serverAuth, 2.16.840.1.113741.1.2.3 
    subjectAltName = @alt_names
    
    [alt_names]
    DNS.1 = test.example.com
    DNS.2 = example.com
    IP.1 = 192.168.1.1
    ```

3. Save and close.

#### Create `csr.conf`

1. Create a new file named `csr.conf`.

2. Copy and paste the below example into the file.

    **Optionally**, update the **[dn]** section and **CN** field with your own server FQDN and information.

    ``` title="csr.conf"
    [ req ]
    default_bits = 2048
    prompt = no
    default_md = sha256
    distinguished_name = dn

    [ dn ]
    C = US
    ST = Arizona
    L = Chandler 
    O = Organization
    OU = Department
    CN = test.example.com
    ```

3. Save and close.

### Create the Certificate and Hash 

1. Open a terminal and verify OpenSSL is installed.

    ``` bash
    openssl version
    ```

2. Create a self-signed CA root certificate file named `rootCA.crt` with a key file named `rootCA.key`.

    ``` bash
    openssl req -x509 -sha256 -days 3560 -nodes -newkey rsa:2048 -subj "//SKIP=skip/CN=CA Custom Root Certificate/C=US/ST=Arizona/L=Chandler" -keyout rootCA.key -out rootCA.crt
    ```

3. Generate a RSA private key named **server.key**.

    ``` bash
    openssl genrsa -out server.key 2048
    ```

4. Generate a Certificate Signing Request using the private key and `cert.conf` file.

    ``` bash
    openssl req -new -key server.key -out server.csr -config csr.conf
    ```

5. Sign the Certificate Signing Request with the CA certificate and `cert.conf` file.

    ``` bash
    openssl x509 -req -in server.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out server.crt -days 3650 -sha256 -extfile cert.conf
    ```

6. Create a `.pfx` file using the private key, server certificate, and CA root certificate. It will prompt to create a password. This password will be used when creating a Domain profile.

    ``` bash
    openssl pkcs12 -export -out vprodemo_custom.pfx -inkey server.key -in server.crt -certfile rootCA.crt
    ```

7. Get the SHA1 hash of the root certificate. 

    ``` bash
    openssl x509 -noout -fingerprint -sha1 -inform pem -in rootCA.crt
    ```

    !!! success "Success - SHA1 Output"
        ```
        SHA1 Fingerprint=51:45:E3:A4:AE:66:88:E0:AF:85:EC:EB:06:74:6B:8D:C3:07:C1:9D
        ```
        

## Upload Provisioning Certificate

### Create Domain Profile

1. Open the Sample Web UI and Login.

2. Create a domain profile. Upload the `.pfx` file and enter the password set for it. See [Create a Domain Profile](../../GetStarted/Cloud/createProfileACM.md#create-a-domain-profile) for more details. 

### Insert the Hash using MEBx

!!! warning "Warning - Adding Hash for AMT 16 or Newer"
    These steps may not be exact or available within MEBx on AMT 16 or newer devices due to OEM restrictions. USB Configuration may be required. 

1. Switch to the AMT device.

2. Restart the device. While the device is booting up, press **Ctrl+P** to reach the MEBX login screen.

    ??? note "Note - Other Keybinds to Enter MEBx"
        The keystroke combination **Ctrl+P** typically invokes the BIOS to display the MEBX login screen. If this does not work, check the manufacturer's instructions or try function keys (e.g., F2, F12).

3. Enter the MEBx password.

    ??? note "Note - Default MEBx Password for First Time Use"
        If it is the first time entering MEBX and the device has not been provisioned previously, the default password is `admin`. Create a new password when prompted.

4. Select **Intel(r) AMT Configuration**.

5. Verify that the device is in **pre-provisioning** mode. If not, perform a full unprovision under **Unconfigure Network Access**.

6. Select **Remote Setup and Configuration**.

7. Select **TLS PKI**.

8. Set the **PKI DNS suffix** to `example.com`.
    
    Or, if using a different DNS suffix, set it to that instead. See [DNS Suffix](../../GetStarted/Cloud/createProfileACM.md#dns-suffix) for more details.

9. Select **Manage Hashes**.
    
    <figure class="figure-image">
    <img src="..\..\..\assets\images\Manage_Hashes.jpg" alt="Figure 1: Manage Hashes">
    <figcaption>Figure 1: Manage Hashes</figcaption>
    </figure>

10. Press the `Insert` key.

11. Provide a name for the new hash and press Enter.

12. Insert the new SHA1 hash using the fingerprint obtained from Step 7 in [Create the Certificate and Hash](#create-the-certificate-and-hash). **The hash must be formatted as shown in example.**

    <figure class="figure-image">
    <img src="..\..\..\assets\images\MEBXHASH.jpg" alt="Figure 2: Hash Input">
    <figcaption>Figure 2: Hash Input</figcaption>
    </figure>

13. Press the `Y` key to set the hash as active.

14. Press the `esc` key repeatedly to exit MEBx and reboot the device.

### Verify the Hash

1. After the device reboots, open Terminal or Command Prompt as Administrator.

2. Verify the certificate hash was inserted correctly.

    The new hash should be listed.

    ```
    rpc amtinfo -cert
    ```

    !!! success "Success - Hash Inserted Correctly"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\HASH_OUTPUT.png" alt="Figure 4: Hash Output">
        <figcaption>Figure 4: Hash Output</figcaption>
        </figure>

3. Activate the AMT device with an ACM Profile. See [Create a Profile with ACM](../../GetStarted/Cloud/createProfileACM.md#create-a-profile) and [Build & Run RPC](../../GetStarted/Cloud/buildRPC.md#run-rpc-to-activate-configure-and-connect-the-amt-device) for more details.

    ??? warning "Troubleshoot - Error During Activation"
    
        The following error may occur during the first attempt at activation.

        ``` hl_lines="5"
        time="2023-08-17T11:38:57-07:00" level=trace msg="HTTP/1.1 200 OK\r\nDate: Thu, 17 Aug 2023 18:38:57 GMT\r\nServer: Intel(R) Active Management Technology 15.0.35.2039\r\nX-Frame-Options: DENY\r\nContent-Type: application/soap+xml; charset=UTF-8\r\nTransfer-Encoding: chunked\r\n\r\n043E\r\n<?xml version=\"1.0\" encoding=\"UTF-8\"?><a:Envelope xmlns:a=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:b=\"http://schemas.xmlsoap.org/ws/2004/08/addressing\" xmlns:c=\"http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd\" xmlns:d=\"http://schemas.xmlsoap.org/ws/2005/02/trust\" xmlns:e=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\" xmlns:f=\"http://schemas.dmtf.org/wbem/wsman/1/cimbinding.xsd\" xmlns:g=\"http://intel.com/wbem/wscim/1/ips-schema/1/IPS_HostBasedSetupService\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><a:Header><b:To>http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous</b:To><b:RelatesTo>3</b:RelatesTo><b:Action a:mustUnderstand=\"true\">http://intel.com/wbem/wscim/1/ips-schema/1/IPS_HostBasedSetupService/AdminSetupResponse</b:Acti"
        time="2023-08-17T11:38:57-07:00" level=debug msg="sending message to RPS"
        time="2023-08-17T11:38:57-07:00" level=debug msg="closing connection to lms"
        time="2023-08-17T11:38:57-07:00" level=debug msg="received messages from RPS"
        time="2023-08-17T11:38:57-07:00" level=error msg="Unknown error has occured"
        time="2023-08-17T11:38:57-07:00" level=debug msg="closing connection to lms"
        ```

        <br>

        1. If this error occurs, verify the device was activated successfully.

            ```
            rpc amtinfo
            ```

        2. If the device shows it was activated into **admin control mode**, rerun the activate command to successfully finish AMT configuration.

4. During device unprovisioning, AMT will delete any inserted hashes and will have to be manually reinserted.

<br><br>