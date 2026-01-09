

# Enterprise Assistant Configuration for RPC-Go

The RPC-Go local configuration option does not communicate with a remote server (RPS). RPC-Go will establish a communication channel to Enterprise Assistant (EA) directly and handle the CSR process. The wanted configuration options will be passed via command line flags or a config `.yaml`/`.json` file using RPC-Go. Configuration of AMT is handled entirely locally by RPC-Go.

## Prerequisites

### Software

- [Enterprise Assistant](../overview.md)

### Services

The following services are assumed to be configured and running in your enterprise environment.

- Microsoft* Certificate Authority (CA)
    - An AMT TLS Certificate template is required. See [TLS Certificate Template](../tlsCertTemplate.md) for additional steps on creating a template.
- Microsoft* Active Directory (AD)

## Settings Configuration

1. Start Enterprise Assistant.

2. Open the Enterprise Assistant `File > Settings` menu to configure the RPC-Go connection.

    <figure class="figure-image">
        <img src="..\..\..\..\assets\images\screenshots\EA_SettingsEmpty.png" alt="Figure 1: Enterprise Assistant Settings Menu">
        <figcaption>Figure 1: Enterprise Assistant Settings Menu</figcaption>
    </figure>

3. Under **RPC Client** section, for **Address**, choose the IP Address or FQDN of the EA Server.

4. Set a **Username** of your choice.

5. Set a **Password** of your choice.

6. Set a 32 or 64-character **Security Key** of your choice. This key is used when generating JWT tokens for authentication between RPC-Go and EA communication.

7. `Security Groups` will list all of the security groups of the domain controller that have been created within the Computers group. When Enterprise Assistant creates a new Computer account (like a new AMT device), it will join the selected Security Groups.

8. Provide the full name of the Certificate Authority and click the checkmark.

9. It will then list the available Certificate Templates to choose from. This will let you select a template specifically created for AMT. See [TLS Certificate Template](../tlsCertTemplate.md) for additional steps on creating a template.

10. Choose how to issue the certificate. Typically, `SAM Account Name` is most commonly used as the `Common Name`.

    !!! example "Example - Configured Settings"
        <figure class="figure-image">
            <img src="..\..\..\..\assets\images\screenshots\EA_RPCSettingsFull.png" alt="Figure 2: Enterprise Assistant Settings Example">
            <figcaption>Figure 2: Enterprise Assistant Settings Example</figcaption>
        </figure>

11. Press **OK** to save the Settings.

12. Restart Enterprise Assistant by exiting the program and rerunning the executable.

13. The HTTP server should show as started now in the Console output.

    <figure class="figure-image">
        <img width=400px src="..\..\..\..\assets\images\screenshots\EA_RPCHTTPStart.png" alt="Figure 3: Enterprise Assistant Connecting to RPS">
        <figcaption>Figure 3: Enterprise Assistant HTTP Server Started</figcaption>
    </figure>

14. Enterprise Assistant will now wait and listen for RPC-Go to make requests to issue Certificates signed by Microsoft CA.

<br>