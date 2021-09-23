--8<-- "References/abbreviations.md"

This tutorial demonstrates how to generate a JWT token for Authorization and construct a API call for [Getting Devices](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/{{ mpsAPI.version }}#/Devices/get_api_v1_devices) using [curl](https://curl.se/). This method will retrieve information about all devices, including device GUIDs.

[![ConnectedDevices](../assets/images/ConnectedDevicesAPI.png)](../assets/images/ConnectedDevicesAPI.png)

**Figure 1: API Call to Get All Devices**

!!! important
    Successfully deploy the Management Presence Server (MPS) and Remote Provisioning Server (RPS) and connect an Intel® vPro device to MPS before constructing the API call. Start [here](../GetStarted/prerequisites.md)** to install microservices locally with Docker*.

## What You'll Need

**Hardware**

A minimum network configuration must include:

-  A Development system with Windows® 10 or Ubuntu 18.04 or newer
-  An Activated and Configured Intel® vPro device as the managed device

**Software on the Development System** 

- MPS
- [curl](https://curl.se/download.html)
- Any Text Editor
    
  
## What You'll Do
The following sections describe how to:

- Generate a new JWT for Authorization
- Run an API Call to MPS for Devices
- See Other Example GET/POST Commands

## Generate a Token for Authorization

See the [Authorize Method in the API Documentation](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/{{ mpsAPI.version }}#/Auth/post_api_v1_authorize){target=_blank} for more information.

1. Open a Terminal or Command Prompt.
2. Copy and paste the example code below into a text editor.
3. Update the values of the `[IP-Address or FQDN]`, `[MPS_WEB_ADMIN_USER]`, and `[MPS_WEB_ADMIN_PASSWORD]` fields.

    === "Linux"
        ```bash
        curl --insecure -X POST https://[IP-Address or FQDN]/mps/login/api/v1/authorize \
            -H "Content-Type:application/json" \
            -d "{\"username\":\"[MPS_WEB_ADMIN_USER]\", \"password\":\" [MPS_WEB_ADMIN_PASSWORD]\"}"
        ```
    === "Windows"
        ```bash
        curl --insecure -X POST https://[IP-Address or FQDN]/mps/login/api/v1/authorize ^
            -H "Content-Type:application/json" ^
            -d "{\"username\":\"[MPS_WEB_ADMIN_USER]\", \"password\":\" [MPS_WEB_ADMIN_PASSWORD]\"}"
        ```

    !!!info "Info - Using the --insecure Flag"
        Because we are using self-signed certificates for MPS for development and testing purposes, we must supply this flag to bypass SSL certificate verification.

4. Run the command.

    !!! example "Example - Response of Authorize Method"

        ```json
        {"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI5RW1SSlRiSWlJYjRiSWVTc21nY1dJanJSNkh5RVRxYyIsImV4cCI6MTYyMDE2OTg2NH0.GUib9sq0RWRLqJ7JpNNlj2AluuROLICCfdZaQzyWy90"}
        ```

5. This token will be used when making any other API call as part of the Authorization header. 

## Run API Call for Get Devices

See the [GetDevices Method in the API Documentation](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/{{ mpsAPI.version }}#/Devices/get_api_v1_devices){target=_blank} for more information.

1. Open a Terminal or Command Prompt.
2. Copy and paste the example code below into a text editor.
3. Update the values of the `[IP-Address or FQDN]` and `[JWT-Token]` fields.

    === "Linux"
        ```bash
        curl --insecure https://[IP-Address or FQDN]/mps/api/v1/devices \
            -H "Authorization: Bearer [JWT-Token]"
        ```
    === "Windows"
        ```bash
        curl --insecure https://[IP-Address or FQDN]/mps/api/v1/devices ^
            -H "Authorization: Bearer [JWT-Token]"
        ```

4. Run the command.

    !!! example "Example - Response of Devices Method"
        Example Terminal Output:

        ```json
        [{"guid":"3beae094-34f8-11ea-b6f5-ffed08129200","hostname":"vpro3-NUC8v5PNK","tags":[],"mpsInstance":"mps","connectionStatus":true,"mpsusername":"admin"}]
        ```
        Example JSON Pretty Print:

        ```json
        [
            {
                "guid": "3beae094-34f8-11ea-b6f5-ffed08129200",
                "hostname": "vpro3-NUC8v5PNK",
                "tags": [],
                "mpsInstance": "mps",
                "connectionStatus": true,
                "mpsusername": "admin"
            }
        ]
        ```
    
        !!! important
            This is one way to retrieve a device's GUID in the *host* field.  **For *amt* path methods (i.e., [Power Actions](../Reference/powerstates.md), Audit Logs, etc), the device GUID is *required* as part of the GET path.** Save this value if you want to try other MPS methods. Other ways to retrieve a GUID can be found [here](../Reference/guids.md).



## Example GET/POST Templates

The sample GET and POST curl commands below can be adapted for other MPS and RPS methods **by changing the URL path and modifying the request body data, if applicable**.

=== "Power Capabilities (GET Template)"     
    === "Linux"
        ``` bash
        curl --insecure https://[IP-Address or FQDN]/mps/api/v1/amt/powercapabilities/[AMT-Device-GUID] \
            -H "Authorization: Bearer [JWT-Token]"
        ```
    === "Windows"
        ``` bash
        curl --insecure https://[IP-Address or FQDN]/mps/api/v1/amt/powercapabilities/[AMT-Device-GUID] ^
            -H "Authorization: Bearer [JWT-Token]"
        ```  
    See [Power Capabilities API Docs](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/{{ mpsAPI.version }}#/AMT/get_api_v1_amt_power_capabilities__guid_) for more information and expected responses.
=== "Power Action (POST Template)"
    === "Linux"
        ``` bash
        curl --insecure -X POST https://[IP-Address or FQDN]/mps/api/v1/amt/power/action/[AMT-Device-GUID] \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer [JWT-Token]" \
            -d "{\"action\": [Power-Action], \"useSOL\": false}"
        ```
    === "Windows"
        ``` bash
        curl --insecure -X POST https://[IP-Address or FQDN]/mps/api/v1/amt/power/action/[AMT-Device-GUID] ^
            -H "Content-Type: application/json" ^
            -H "Authorization: Bearer [JWT-Token]" ^
            -d "{\"action\": [Power-Action], \"useSOL\": false}"
        ```
    See [Power Action API Docs](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/{{ mpsAPI.version }}#/AMT/post_api_v1_amt_power_action__guid_) for more information and expected responses.

## Other Methods

For all available methods, see: 

- [MPS Methods to manage a device:](./../APIs/indexMPS.md){target=_blank}

    [MPS API Docs](./../APIs/indexMPS.md){: .md-button .md-button--primary target=_blank }

- [RPS Methods for server configuration and provisioning:](./../APIs/indexRPS.md){target=_blank}

    [RPS API Docs](./../APIs/indexRPS.md){: .md-button .md-button--primary target=_blank }

## Explore the UI Toolkit
In addition to REST API calls, the Open AMT Cloud Toolkit provides a reference implementation console. Add manageability features to the console with prebuilt React components, such as Keyboard, Video, and Mouse (KVM).

[Get Started with the UI Toolkit](../Tutorials/uitoolkitReact.md){: .md-button .md-button--primary }
