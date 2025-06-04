--8<-- "References/abbreviations.md"

# Enterprise Assistant Configuration for RPS

RPS will handle communication with Enterprise Assistant (EA). Desired configuration options will be provided via the AMT profile, Wireless Config, and IEEE802.1x Config. RPS will communicate with EA at the time of provisioning to configure 802.1x and/or TLS configuration options based on the profiles.

## Prerequisites

### Software

- [Enterprise Assistant](../overview.md)
- Device Management Toolkit Local or Cloud Deployment running. [See Get Started for a basic deployment option.](../../../GetStarted/Cloud/prerequisites.md)

### Services

The following services are assumed to be configured and running in your enterprise environment.

- Microsoft* Certificate Authority (CA)
    - An AMT TLS Certificate template is required. See [TLS Certificate Template](../tlsCertTemplate.md) for additional steps on creating a template.
- Microsoft* Active Directory (AD)

## Kong Configuration

To use Enterprise Assistant with Kong API Gateway, we need to configure a new route.

2. Open the `kong.yaml` file in the `./cloud-deployment/` directory.

3. Uncomment the `rps-ea` block to enable the `/ea` route.

    ```
    # uncomment to use with enterprise assistant
    # - name: rps-ea
    #   host: rps
    #   port: 8082
    #   tags:
    #   - rps
    #   routes:
    #   - name: rps-ea-route
    #     strip_path: true
    #     paths:
    #     - /ea
    ```

4. Restart the Kong service.

## Settings Configuration

1. Open the Enterprise Assistant `File > Settings` menu to configure the RPS connection.

    <figure class="figure-image">
        <img src="..\..\..\..\assets\images\EA_SettingsEmpty.png" alt="Figure 1: Enterprise Assistant Settings Menu">
        <figcaption>Figure 1: Enterprise Assistant Settings Menu</figcaption>
    </figure>

2. Provide the RPS Server Hostname. Enterprise Assistant communicates via Websocket. 

    Make sure to include the route `/ea` (e.g. `wss://192.168.1.34/ea`).

3. The `Device Name` is the name used to configure the domain controller for each device account. Using `Node Identifier` is more secure due to the inability to be tampered with but is less friendly to maintain as a user.

4. `Security Groups` will list all of the security groups of the domain controller that have been created within the Computers group. When Enterprise Assistant creates a new Computer account (like a new AMT device), it will join the selected Security Groups.

5. Provide the full name of the Certificate Authority and click the checkmark.

6. It will then list the available Certificate Templates to choose from. This will let you select a template specifically created for AMT. See [TLS Certificate Template](../tlsCertTemplate.md) for additional steps.

7. Choose how to issue the certificate. Typically, `SAM Account Name` is most commonly used as the `Common Name`.

    !!! example "Example - Configured Settings"
        <figure class="figure-image">
            <img src="..\..\..\..\assets\images\EA_SettingsFull.png" alt="Figure 2: Enterprise Assistant Settings Example">
            <figcaption>Figure 2: Enterprise Assistant Settings Example</figcaption>
        </figure>

8. Press **OK** to save the Settings.

9. Start the connection by going to `File > Local Connect`.

    <figure class="figure-image">
        <img src="..\..\..\..\assets\images\EA_Connected.png" alt="Figure 3: Enterprise Assistant Connecting to RPS">
        <figcaption>Figure 3: Enterprise Assistant Connecting to RPS</figcaption>
    </figure>

10. After connecting, Enterprise Assistant will wait and listen for RPS to make requests to either add/revoke Computers or issue/revoke Certificates.

<br>