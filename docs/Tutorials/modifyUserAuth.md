--8<-- "References/abbreviations.md"


As part of the Device Management Toolkit reference implementation, MPS and the Kong service issue and authenticate a JSON Web Token (JWT) for user authentication. The default configuration offers authentication functionality, but it does not support many common configuration options, such as user groups. In a production environment, alternative authentication is available in 0Auth 2*, Lightweight Directory Access Protocol (LDAP), Kerberos*, and more.

The instructions below explain how to add an LDAP plugin to Kong.

## User Authentication Flow

The following diagrams help illustrate the typical user authentication flow. Learn more about the `authorize` API call in the [REST API Call Tutorial](./apiTutorial.md) or directly in our [API Documentation](../APIs/indexMPS.md).

### REST API User Authentication Flow

<figure class="figure-image">
<img src="..\..\assets\images\UserAuth_API_Diagram.png" alt="Figure 1: User Authentication Flow for REST APIs">
</figure>

#### To authenticate for REST APIs:

1. Call the MPS REST API `/api/v1/authorize` to receive an authentication token from the User Auth Service.

2. Perform other desired API calls (e.g. Power Actions, Hardware Info, etc) using the new auth token **from Step 1**.

<br>

### Redirection (KVM/SOL) User Authentication Flow

<figure class="figure-image">
<img src="..\..\assets\images\UserAuth_Redir_Diagram.png" alt="Figure 1: User Authentication Flow for Redirection">
</figure>

#### To authenticate for Websocket connections:

1. Call the MPS REST API `/api/v1/authorize` to receive an authentication token from the User Auth Service.

2. Call the MPS REST API `/api/v1/authorize/redirection/{guid}` using the auth token **from Step 1** to receive a short-lived token directly from MPS for redirection sessions.

3. Pass the short-lived token **from Step 2** and the device's GUID to the UI Toolkit module implementation to start a redirection (KVM/SOL) session.

!!! note "Note - Additional Information"

    When using a 3rd party auth service (e.g. Cognito, LDAP, etc), the token issued by the auth service is used to make calls to the MPS. For non-HTTP calls like redirection, a call must be made to the `/api/v1/authorize/redirection/{guid}` API to get a separate MPS-specific token required to be passed into the KVM/SOL UI-Toolkit module.

    API Gateways are only able to verify tokens on HTTP requests.  Device Management Toolkit's redirection implementation uses WebSockets for KVM and SOL. Therefore, the API Gateway cannot verify tokens passed in over the WebSocket connections. Because of this, MPS must perform the verification of the token and it can only do that with tokens that it issues.

<br>

## Prerequisites

Install and start a local LDAP server on the development system. For this tutorial, Go-lang LDAP Authentication* (GLAuth) is referenced. [Find more info in the GLAuth Readme.](https://github.com/glauth/glauth) 
    
1. To install, see steps 1 - 3 of the **Quickstart** section of the [GLAuth Readme](https://github.com/glauth/glauth#quickstart). We do not need to alter the sample-simple.cfg file.

2. Allow the Terminal or Powershell to remain open to see LDAP activity as you proceed with the tutorial below.

3. Optionally, [download curl](https://curl.se/) for testing the authentication with APIs at the end of this tutorial.


## Edit the kong.yaml File

**Reconfigure the Kong* API Gateway to use a different user authentication service:**

1. Open the `kong.yaml` file and comment out the `plugins` and `consumer` sections of the code by adding a `#` character at the beginning of each line. This disables the JWT authentication.

2. Paste the new `plugins` section into the file. 

3. Modify the `ldap_host` to that of your development system or cloud instance. 
    
    ``` yaml hl_lines="7 20"
    plugins:
    - name: cors
    - name: ldap-auth
      route: mps-route
      config: 
        hide_credentials: true
        ldap_host: <Server IP-Address or FQDN> # Replace
        ldap_port: 3893
        start_tls: false
        ldaps: false
        base_dn: dc=glauth,dc=com
        verify_ldap_host: false
        attribute: cn
        cache_ttl: 60
        header_type: ldap
    - name: ldap-auth
      route: rps-route
      config: 
        hide_credentials: true
        ldap_host: <Server IP-Address or FQDN> # Replace
        ldap_port: 3893
        start_tls: false
        ldaps: false
        base_dn: dc=glauth,dc=com
        verify_ldap_host: false
        attribute: cn
        cache_ttl: 60
        header_type: ldap
    ```

    !!! Note
        The following code was adapted for the toolkit. For the default configuration details, see **Enable the plugin on a route**, on the tab **Declarative YAML**, in [Kong documentation](https://docs.konghq.com/hub/kong-inc/ldap-auth/#main)

## Restart the Kong Gateway Container

1. Open a Terminal or Powershell/Command Prompt and run the command to list the containers:

```
docker ps
```

2. Restart the Kong container:

```
docker restart <container ID>
```


## Test the Configuration

Authenticate a user to test the configuration by using an API of your choice. You will need to set the Authorization header to `ldap base64encode(user:pass)`.

**Test the configuration with curl:**

In the following examples, we use the base64 encoding of `johndoe:TestAppPw1` as our encoded `user:pass`. This value is `am9obmRvZTpUZXN0QXBwUHcx`. These credentials are one of the default credentials in the `sample-simple.cfg` file provided by GLAuth*.

=== "Get Devices (MPS Route)"     

    ``` bash
    curl --insecure https://[IP-Address or FQDN]/mps/api/v1/devices \
        -H "Authorization: ldap am9obmRvZTpUZXN0QXBwUHcx"
    ```
    See [Devices API Docs](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/{{ repoVersion.mpsAPI }}#/Devices/get_api_v1_devices) for more information and expected responses.
=== "Get Profiles (RPS Route)"

    ``` bash
    curl --insecure https://[IP-Address or FQDN]/rps/api/v1/admin/profiles \
        -H "Authorization: ldap am9obmRvZTpUZXN0QXBwUHcx"
    ```
    See [Get Profiles API Docs](https://app.swaggerhub.com/apis-docs/rbheopenamt/rps/{{ repoVersion.rpsAPI }}#/Profiles/GetAllProfiles) for more information and expected responses.


Other APIs to test can be found in the [MPS API Documentation](../APIs/indexMPS.md) and [RPS API Documentation](../APIs/indexRPS.md).

<br>
<br>