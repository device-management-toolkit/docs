--8<-- "References/abbreviations.md"

On the managed device, a Remote Provisioning Client (RPC) communicates with the Remote Provision Server (RPS) in the process of activating or deactivating the device. In addition to activation and deactivation, the RPC provides informational and maintenance commands.

## List Commands

RPC must run with elevated privileges. Commands require `sudo` on Linux or an Administrator Command Prompt on Windows.

Run the RPC application on the command line with no arguments to see supported commands:

```
rpc
```

| COMMAND                     | DESCRIPTION                                                                                 | EXAMPLE                                                      |
|-----------------------------|---------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| [activate](#activate)       | Activate this device with a specified profile.                                              | ./rpc activate -u wss://server/activate -profile profilename |
| [deactivate](#deactivate)   | Deactivate this device. You will be prompted for the AMT password.                          | ./rpc deactivate -u wss://server/deactivate                  |
| [maintenance](#maintenance) | Execute a maintenance task for the device. You will be prompted for the AMT password.       | ./rpc maintenance syncclock -u wss://server/maintenance      |
| [configure](#configure)     | Local configuration of a feature on this device. You will be prompted for the AMT password. | ./rpc configure addwifisettings ...                          |
| [amtinfo](#amtinfo)         | Display AMT status and configuration.                                                       | ./rpc amtinfo                                                |
| [version](#version)         | Display the current version of RPC and the RPC Protocol version.                            | ./rpc version                                                |

##List Command Options

Run the application with a command to see available options for the command:

```
rpc [COMMAND]
```

### activate

#### Activate and Configure the device using RPS:

Activate the device with a specified profile:

```
rpc activate -u wss://server/activate -profile profilename
```

#### Activate the device locally:

This capability is only supported for activating unprovisioned (e.g. pre-provisioning state) devices. This command **only** activates AMT. It does not do profile-based configuration.

=== "CCM"
    ```
    rpc activate -local -ccm -password NewAMTPassword
    ```

=== "CCM w/ Config File"
    Options can be passed via a config file. This can also be combined into a single config file with [addwifisettings](#addwifisettings) information.

    === "YAML"
        ```yaml title="config.yaml"
        ccmactivate:
          amtPassword: 'P@ssw0rd'
        ```

    Example Commands:

    === "Local Stored Config File"
        ```
        rpc activate -local -ccm -config config.yaml
        ```
    === "Remote Stored Config File"
        Currently, the only supported remote network share is Server Message Block (SMB) based shares.

        ``` title="No Credentials Required"
        rpc activate -local -ccm -config smb://shareName/filePath/config.yaml
        ```

        ``` title="Credentials Required"
        rpc activate -local -ccm -config smb://workgroup;username:password@server/shareName/filePath/config.yaml
        ```

        ``` title="Credentials Required but Prompt for Password"
        rpc activate -local -ccm -config smb://workgroup;username:*@server/shareName/filePath/config.yaml
        ```

=== "ACM"

    === "Local Stored Provisioning Cert"
        ```
        rpc activate -local -acm -amtPassword NewAMTPassword -provisioningCert "{BASE64_PROV_CERT}" -provisioningCertPwd certPassword
        ```
    === "Remote Stored Provisioning Cert"
        Currently, the only supported remote network share is Server Message Block (SMB) based shares. 


        ``` title="No Credentials Required"
        rpc activate -local -acm -config smb://server/shareName/filePath/test.pfx -provisioningCertPwd certPassword -amtPassword amtPass
        ```

        ``` title="Credentials Required"
        rpc activate -local -acm -config smb://workgroup;username:password@server/shareName/filePath/test.pfx -provisioningCertPwd certPassword -amtPassword amtPass
        ```

        ``` title="Credentials Required but Prompt for Password"
        rpc activate -local -acm -config smb://workgroup;username:*@server/shareName/filePath/test.pfx -provisioningCertPwd certPassword -amtPassword amtPass
        ```

=== "ACM w/ Config File"
    Options can be passed via a config file. This can also be combined into a single config file with [addwifisettings](#addwifisettings) information.

    === "YAML"
        ```yaml title="config.yaml"
        acmactivate:
          amtPassword: 'P@ssw0rd'
          provisioningCert: 'BASE64_PROV_CERT'
          provivisioningCertPwd: 'CertP@ssw0rd'
        ```

    Example Commands:

    === "Local Stored Config File"
        ```
        rpc activate -local -acm -config config.yaml
        ```
    === "Remote Stored Config File"
        Currently, the only supported remote network share is Server Message Block (SMB) based shares.

        ``` title="No Credentials Required"
        rpc activate -local -acm -config smb://shareName/filePath/config.yaml
        ```

        ``` title="Credentials Required"
        rpc activate -local -acm -config smb://workgroup;username:password@server/shareName/filePath/config.yaml
        ```

        ``` title="Credentials Required but Prompt for Password"
        rpc activate -local -acm -config smb://workgroup;username:*@server/shareName/filePath/config.yaml
        ```


<br>

#### `activate` General Options

| OPTION             | DESCRIPTION                                                                                                                                                                              |
|--------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| --echo-password    | Show AMT Password input in terminal. By default, password user input is hidden.                                                                                                          |
| -json              | JSON output                                                                                                                                                                              |
| -l string          | Log level (panic,fatal,error,warn,info,debug,trace) (default "info") <br>**Caution**: Do not run log level `trace` in production as sensitive information may be logged to the console.  |
| -lmsaddress string | LMS address (default "localhost"). Can be used to change location of LMS for debugging.                                                                                                  |
| -lmsport string    | LMS port (default "16992")                                                                                                                                                               |
| -n                 | Skip WebSocket server certificate verification                                                                                                                                           |
| -skipIPRenew       | Skip DHCP renewal of the IP address if AMT becomes enabled. Only applicable for 13th Gen Raptor Lake (AMT 16.1) or newer devices.                                                        |
| -t duration        | Time to wait until AMT is ready (e.g. `2m` or `30s`), the default is `2m0s`                                                                                                              |
| -v                 | Verbose output <br>**Caution**: Do not run in production as sensitive information may be logged to the console.                                                                          |

#### `activate` Remote-Specific Options

| OPTION             | DESCRIPTION                                                                                                                     |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------|
| -d string          | DNS suffix override                                                                                                             |
| -h string          | Hostname override                                                                                                               |
| -n                 | Skip WebSocket server certificate verification                                                                                  |
| -name string       | Friendly name to associate with this device                                                                                     |
| -p string          | Proxy address and port                                                                                                          |
| -password          | Existing set AMT password                                                                                                       |
| -profile string    | Name of the profile to use                                                                                                      |
| -tenant string     | TenantID of profile. If not provided, then assumed empty string (i.e. [no Multitenancy enabled](../../middlewareExtensibility.md)) |
| -token string      | JWT Token for Authorization                                                                                                     |
| -u string          | WebSocket address of server to activate against                                                                                 |
| -uuid string       | Override AMT device UUID for use with **non-CIRA** workflow and deployments. This is for specific use cases where the hardware does not have a correctly assigned or formatted UUID. This is **NOT recommended** in other situations and could potentially break features. <br><br> Input must match standard UUID alphanumeric, hyphenated format (e.g. 4c4c4544-005a-3510-8047-b4c04f564433). |

#### `activate` Local-Specific Options

| OPTION                            | DESCRIPTION                                                                                              |
|-----------------------------------|----------------------------------------------------------------------------------------------------------|
| -acm                              | Flag for ACM Local Activation.                                                                           |
| -amtPassword string               | New AMT Password to set on device.                                                                       |
| -ccm                              | Flag for CCM Local Activation.                                                                           |
| -config                           | Remote `smb://` or local file path of a `.yaml` file with desired ACM configuration.                     |
| -configv2                         | Remote `smb://` or local file path of an encrypted `.yaml` file exported from Console.                   |
| -configencryptionkey              | Encryption Key provided by Console during Profile export used by RPC-Go to decode the exported Profile. |
| -local                            | Execute command to AMT directly without cloud interaction.                                               |
| -provisioningCert Base64 string   | Base64 Encoded String of the `.pfx` provisioning certificate.                                            |
| -provisioningCertPwd string       | Password of provisioning certificate.                                                                    |

<br>

### deactivate

!!! warning "Warning - Future Deprecation: Changing of Kong Routes"
    **We have now enabled the `/deactivate` Kong route.** The previous `/activate` route will still function for deactivate commands to avoid breaking changes. However, the `/activate` route's use with deactivate will be deprecated in the future and it is recommended to utilize the new, `/deactivate` route for new development.

#### Deactivate the device using RPS:

```
rpc deactivate -u wss://server/deactivate
```

#### Deactivate the device locally:

```
rpc deactivate -local -password AMTPassword
```

<br>

#### `deactivate` Options

| OPTION             | DESCRIPTION                                                                                                                                                                              |
|--------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| --echo-password    | Show AMT Password input in terminal. By default, password user input is hidden.                                                                                                          |
| -json              | JSON output                                                                                                                                                                              |
| -l string          | Log level (panic,fatal,error,warn,info,debug,trace) (default "info") <br>**Caution**: Do not run log level `trace` in production as sensitive information may be logged to the console.  |
| -lmsaddress string | LMS address (default "localhost"). Can be used to change location of LMS for debugging.                                                                                                  |
| -lmsport string    | LMS port (default "16992")                                                                                                                                                               |
| -local             | Execute command to AMT directly without cloud interaction.                                                                                                                               |
| -password string   | AMT password                                                                                                                                                                             |
| -t duration        | Time to wait until AMT is ready (e.g. `2m` or `30s`), the default is `2m0s`                                                                                                              |
| -v                 | Verbose output. <br>**Caution**: Do not run in production as sensitive information may be logged to the console.                                                                         |

#### `deactivate` Remote-Specific Options

| OPTION             | DESCRIPTION                                                                             |
|--------------------|-----------------------------------------------------------------------------------------|
| -f                 | Force deactivate even if device is not registered with the RPS server                   |
| -n                 | Skip WebSocket server certificate verification                                          |
| -p string          | Proxy address and port                                                                  |
| -token string      | JWT Token for Authorization                                                             |
| -u string          | WebSocket address of server to activate against                                         |

<br>

### maintenance

!!! warning "Warning - Future Deprecation: Changing of Kong Routes"
    **We have now enabled the `/maintenance` Kong route.** The previous `/activate` route will still function for maintenance commands to avoid breaking changes. However, the `/activate` route's use with maintenance will be deprecated in the future and it is recommended to utilize the new, `/maintenance` route for new development.

Execute a maintenance command for the managed device:

| SUBCOMMAND                            | DESCRIPTION                                                                                           |
|---------------------------------------|-------------------------------------------------------------------------------------------------------|
| [changepassword](#changepassword)     | Change the AMT password. <br> A random password is generated by default if `-static` is not provided. |
| [syncclock](#syncclock-maintenance)   | Sync the host OS clock to AMT.                                                                        |
| [syncdeviceinfo](#syncdeviceinfo)     | Sync the device info stored in the MPS database with the current local AMT device info.               |
| [synchostname](#synchostname)         | Sync the OS hostname to AMT Network Settings.                                                         |
| [syncip](#syncip)                     | Sync the static IP of host OS to AMT Network Settings.                                                |

<br>

#### Common `maintenance` Options

| OPTION             | DESCRIPTION                                                                                                                                                                             |
|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| --echo-password    | Show AMT Password input in terminal. By default, password user input is hidden.                                                                                                         |
| -f                 | Force maintenance commands even if device is not registered with a server                                                                                                               |
| -json              | JSON output                                                                                                                                                                             |
| -l string          | Log level (panic,fatal,error,warn,info,debug,trace) (default "info") <br>**Caution**: Do not run log level `trace` in production as sensitive information may be logged to the console. |
| -lmsaddress string | LMS address (default "localhost"). Can be used to change location of LMS for debugging.                                                                                                 |
| -lmsport string    | LMS port (default "16992")                                                                                                                                                              |
| -n                 | Skip WebSocket server certificate verification                                                                                                                                          |
| -p string          | Proxy address and port                                                                                                                                                                  |
| -password string   | AMT password                                                                                                                                                                            |
| -t duration        | Time to wait until AMT is ready (e.g. `2m` or `30s`), the default is `2m0s`                                                                                                             |
| -tenant string     | TenantID of profile. If not provided, then assumed empty string (i.e. [no Multitenancy enabled](../../middlewareExtensibility.md))                                                         |
| -token string      | JWT Token for Authorization                                                                                                                                                             |
| -u string          | WebSocket address of server to activate against                                                                                                                                         |
| -uuid string       | Override AMT device UUID for use with **non-CIRA** workflow and deployments. This is for specific use cases where the hardware does not have a correctly assigned or formatted UUID. This is **NOT recommended** in other situations and could potentially break features. <br><br> Input must match standard UUID alphanumeric, hyphenated format (e.g. 4c4c4544-005a-3510-8047-b4c04f564433). |
| -v                 | Verbose output <br>**Caution**: Do not run in production as sensitive information may be logged to the console.                                                                         |

<br>

#### changepassword

Change the AMT password. A random password is generated by default if `static` option is not passed.

```
rpc maintenance changepassword -u wss://server/maintenance
```

| OPTION  | DESCRIPTION             |
|---------|-------------------------|
| -static | New password to be used |

<br>

#### syncclock (maintenance)

Syncs the host OS clock to AMT.

```
rpc maintenance syncclock -u wss://server/maintenance
```

<br>

#### syncdeviceinfo

Sync stored device info within the MPS database to the current, local device info. On device activation, MPS will store some device information as a JSON object. Some of this data may change over time like the firmware versions, activation modes, or IP address and could be outdated.

```
rpc maintenance syncdeviceinfo -u wss://server/maintenance
```

<br>

#### synchostname

Sync the OS hostname to AMT Network Settings.

```
rpc maintenance synchostname -u wss://server/maintenance
```

<br>

#### syncip

Sync the static IP of host OS to AMT Network Settings.

```
rpc maintenance syncip -staticip 192.168.1.7 -netmask 255.255.255.0 -gateway 192.168.1.1 -primarydns 8.8.8.8 -secondarydns 4.4.4.4 -u wss://server/maintenance
```

| OPTION        | DESCRIPTION                                                                                                         |
|---------------|---------------------------------------------------------------------------------------------------------------------|
| -staticip     | IP address to be assigned to AMT<br>If not specified, the IP address of the active OS newtork interface is used     |
| -netmask      | Network mask to be assigned to AMT<br>If not specified, the network mask of the active OS newtork interface is used |
| -gateway      | Gateway address to be assigned to AMT                                                                               |
| -primarydns   | Primary DNS address to be assigned to AMT                                                                           |
| -secondarydns | Secondary DNS address to be assigned to AMT                                                                         |

<br>

### configure

Execute a configuration command for the managed device:

| SUBCOMMAND                                              | DESCRIPTION                                                                                                |
|---------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| [amtfeatures](#amtfeatures)                             | Enable/disable redirection features (KVM, IDER, SOL) and configure user consent.                           |
| [amtpassword](#amtpassword)                             | Update the AMT Password. If no flags are provided, the current and new AMT passwords will be prompted for. |
| [enablewifiport](#enablewifiport)                       | Enables WiFi port and local profile synchronization settings in AMT. AMT password is required.             |
| [mebx](#mebx)                                           | Configure MEBx Password. AMT password is required.                                                         |
| [syncclock](#syncclock-configure)                       | Sync the host OS clock to AMT. AMT password is required.                                                   |
| [tls](#tls)                                             | Configure TLS in AMT. AMT password is required.                                                            |
| [wired](#wired) <br> wiredsettings (Deprecated)         | Configure wired settings (DHCP or Static IP) locally with RPC (no communication with RPS and EA)           |
| [wireless](#wireless) <br> addwifisettings (Deprecated) | Configure wireless 802.1x locally with RPC (no communication with RPS and EA)                              |

<br>

#### Common `configure` Options

| OPTION             | DESCRIPTION                                                                                                                                                                              |
|--------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| --echo-password    | Show AMT Password input in terminal. By default, password user input is hidden.                                                                                                          |
| -json              | JSON output                                                                                                                                                                              |
| -l string          | Log level (panic,fatal,error,warn,info,debug,trace) (default "info") <br>**Caution**: Do not run log level `trace` in production as sensitive information may be logged to the console.  |
| -password string   | AMT password                                                                                                                                                                             |
| -v                 | Verbose output <br>**Caution**: Do not run in production as sensitive information may be logged to the console.                                                                          |

<br>

#### amtfeatures

Enable or disable redirection features (KVM, IDER, SOL) and set the user consent type (none, kvm, all). AMT password is required.

!!! note "Control Mode and User Consent"
    User consent can only be configured if the device is activated in ACM mode. In CCM, User Consent is set to `all` and cannot be changed.

```
rpc configure amtfeatures -kvm -sol -ider -userConsent none
```

| OPTION               | DESCRIPTION                                    |
|----------------------|------------------------------------------------|
| -ider                | Enable/disable IDER (IDE Redirection).         |
| -kvm                 | Enable/disable KVM (Keyboard, Video, Mouse).   |
| -sol                 | Enable/disable SOL (Serial-over-LAN).          |
| -userConsent string  | Configure user consent. Valid Values = {none, kvm, all} <br> **Only configurable for devices activated in ACM.**    |

<br>

#### amtpassword

Change or update the AMT password of the device. If the `-password` flag, `-newamtpassword` flag, or neither flag are provided, then the user will be prompted to input the password or passwords.

!!! warning "`configure amtpassword` versus `maintenance changepassword`"
    `configure amtpassword` is a local command. This does not communicate with a centralized database storing the new AMT passwords so make sure to take note of any changes made! To ensure the database is updated with the new passwords for deployments utilizing RPS and MPS, [see the `rpc maintenance changepassword` command.](#changepassword)

```
rpc configure amtpassword -password CurrentAMTPassword -newamtpassword NewAMTPassword   
```

| OPTION           | DESCRIPTION                   |
|------------------|-------------------------------|
| -newamtpassword  | New AMT password to set.      |

<br>

#### enablewifiport

Enables WiFi port and local profile synchronization settings in AMT. This feature synchronizes the wireless profile set in the OS with the wireless profile set in AMT. AMT Password is required.

```
rpc configure enablewifiport -password AMTPassword
```

<br>

#### mebx

Configure the MEBx password. The MEBx password can only be configured if the device is activated in ACM mode. AMT password is required.

!!! warning "`configure mebx` Storing Passwords"
    `configure mebx` is a local command. This does not communicate with a centralized database storing the new MEBx passwords so make sure to take note of any changes made!
```
rpc configure mebx -mebxpassword newMEBxPassword -password AMTPassword
```

| OPTION         | DESCRIPTION                   |
|----------------|-------------------------------|
| -mebxpassword  | New MEBx password to set.     |

!!! important "Important - Using Strong Passwords"
    The MEBx password must meet standard, **strong** password requirements:

    - 8 to 32 characters

    - At least one of each: Uppercase letter, lowercase letter, numerical digit, and special character

<br>

#### syncclock (configure)

Syncs the host OS clock to AMT. AMT password is required.

```
rpc configure syncclock -password AMTPassword
```

<br>

#### tls

Configures TLS in AMT. AMT password is required.

=== "Config File"

    Use the `-config` flag to pass either a `.yaml` or `.json` file. 

    ```
    rpc configure tls -config config.yaml
    ```

    === "Using Enterprise Assistant"

        See the [TLS Configuration using Enterprise Assistant and RPC-Go](../../EA/RPCConfiguration/localtlsconfig.md) documentation for more details.

        === "YAML"
        
            ```yaml title="config.yaml"
            password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in  the command line
            tlsConfig:
              mode: 'Server'
            enterpriseAssistant:
              eaAddress: 'http://<YOUR-IPADDRESS-OR-FQDN>:8000'
              eaUsername: 'eaUser'
              eaPassword: 'eaPass'
            ```

        === "JSON"

            ```json title="config.json"
            {
              "password": "AMTPassword",
              "tlsConfig": {
                "mode": "Server"
              },
              "enterpriseAssistant": {
                "eaAddress": "http://<YOUR-IPADDRESS-OR-FQDN>:8000",
                "eaUsername": "eaUser",
                "eaPassword": "eaPass"
              }
            }
            ```

    === "Without Enterprise Assistant"

        If Enterprise Assistant is not used, a self-signed TLS certificate will be generated and used by AMT.

        === "YAML"

            ```yaml title="config.yaml"
            password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in  the command line
            tlsConfig:
              mode: 'Server'
            ```

        === "JSON"

            ```json title="config.json"
            {
              "password": "AMTPassword",
              "tlsConfig": {
                "mode": "Server"
              }
            }
            ```

=== "Individual Options"

    Alternatively, provide all options directly in the command line. 

    === "Using Enterprise Assistant"

        Provide the EA Address and configured RPC-Go Credentials. See the [TLS Configuration using Enterprise Assistant and RPC-Go](../../EA/RPCConfiguration/localtlsconfig.md) documentation for more details.

        ```
        rpc configure tls -mode Server -password AMTPassword -eaAddress http://<YOUR-IPADDRESS-OR-FQDN>:8000 -eaUsername eaUser -eaPassword eaPass
        ```

    === "Without Enterprise Assistant"

        If Enterprise Assistant is not used, a self-signed TLS certificate will be generated and used by AMT.

        ```
        rpc configure tls -mode Server -password AMTPassword
        ```

<br>

| OPTION             | DESCRIPTION                                                                                                                                  |
|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| -config string     | File path of a `.yaml` or `.json` file with desired TLS configuration.                                                                       |
| -delay int         | Delay time in seconds after putting remote TLS settings. Default value is 3 seconds if not provided.                                         |
| -eaAddress string  | IP Address or FQDN of Enterprise Assistant                                                                                                   |
| -eaPassword string | Configured Enterprise Assistant Password                                                                                                     |
| -eaUsername        | Configured Enterprise Assistant Username                                                                                                     |
| -mode value        | TLS authentication usage model. Valid Values = {Server, ServerAndNonTLS}. Default value is `Server` if not provided.                         |

<br>

#### wired

!!! warning "Warning - Deprecation: `wiredsettings` subcommand"
    **`rpc configure wired` is the recommended subcommand.** The previous `rpc configure wiredsettings` subcommand is deprecated will be removed in the future. It is recommended to utilize the new, `rpc configure wired` subcommand for new development.

Configure AMT wired settings for DHCP or Static IP locally using RPC-Go (no communication with RPS and EA). AMT password is required.

Configure wired 802.1x settings of an existing, activated AMT device by passing credentials and certificates directly to AMT or using Enterprise Assistant. More information on configuring AMT to use 802.1x can be found in [RPC-Go 802.1x Configuration](../../EA/RPCConfiguration/localIEEE8021xConfig.md) or [RPS 802.1x Configuration](../../EA/RPSConfiguration/remoteIEEE8021xConfig.md).

=== "Config File"
    ##### via Config file

    1. Create a new file called `config.yaml` or `config.json`. Copy and paste the corresponding template below.

        These templates show how to create a simple Wired profile for configuring a device for either DHCP or a Static IP Address.

        === "DHCP"

            The config file can be passed as either a `YAML` or `JSON` formatted file.

            === "YAML"
                ```yaml title="config.yaml"
                password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in the command line
                wiredConfig:
                  dhcp: true
                  ipsync: true
                ```
            === "JSON"
                ```json title="config.json"
                {
                "password": "AMTPassword",
                "wiredConfig": {
                  "dhcp": true,
                  "ipsync": true
                  }
                }
                ```

        === "Static"

            The config file can be passed as either a `YAML` or `JSON` formatted file.

            === "YAML"
                ```yaml title="config.yaml"
                password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in the command line
                wiredConfig:
                  static: true
                  ipaddress: 192.168.1.50
                  subnetmask: 255.255.255.0
                  gateway: 192.168.1.1
                  primarydns: 8.8.8.8
                  secondarydns: 4.4.4.4
                ```        
            === "JSON"
                ```json title="config.json"
                {
                "password": "AMTPassword",
                "wiredConfig": {
                  "static": true,
                  "ipaddress": "192.168.1.50",
                  "subnetmask": "255.255.255.0",
                  "gateway": "192.168.1.1",
                  "primarydns": "8.8.8.8",
                  "secondarydns": "4.4.4.4"
                  }
                }
                ```

    2. Change the fields with your desired values.

    3. Provide the `config.yaml` or `config.json` file using the `-config` flag. 

        ```
        rpc configure wired -config config.yaml
        ```

    ###### with 802.1x

    === "Using Enterprise Assistant"

        Using Enterprise Assistant for 802.1x configuration offers the most secure path. See [Enterprise Assistant RPC-Go 802.1x Configuration](../../EA/RPCConfiguration/localIEEE8021xConfig.md) for more information.

        === "YAML"
            ```yaml title="config.yaml with 802.1x"
            password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in  the command line
            wiredConfig:
              dhcp: true
              ipsync: true
              ieee8021xProfileName: 'exampleIeee8021xEAP-TLS'
            enterpriseAssistant:
              eaAddress: 'http://<YOUR-IPADDRESS-OR-FQDN>:8000'
              eaUsername: 'eaUser'
              eaPassword: 'eaPass'
            ieee8021xConfigs:
              - profileName: 'exampleIeee8021xEAP-TLS'
                authenticationProtocol: 0
                # ieee8021xPassword: ''  # 8021x password if authenticationProtocol is 2 (PEAPv0/EAP-MSCHAPv2)
            ```
        === "JSON"
            ```json title="config.json with 802.1x"
            {
              "password": "AMTPassword",
              "wiredConfig": {
                "dhcp": true,
                "ipsync": true,
                "ieee8021xProfileName": "exampleIeee8021xEAP-TLS"
              },
              "enterpriseAssistant": {
                "eaAddress": "http://<YOUR-IPADDRESS-OR-FQDN>:8000",
                "eaUsername": "admin",
                "eaPassword": "P@ssw0rd"
              },
              "ieee8021xConfigs": [
                {
                  "profileName": "exampleIeee8021xEAP-TLS",
                  "authenticationProtocol": 0
                }
              ]
            }
            ```

    === "Without Enterprise Assistant"

        === "YAML"
            ```yaml title="config.yaml with 802.1x"
            password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in the command line
            wiredConfig:
              dhcp: true
              ipsync: true
              ieee8021xProfileName: 'exampleIeee8021xEAP-TLS'
            ieee8021xConfigs:
              - profileName: 'exampleIeee8021xEAP-TLS'
                username: 'exampleUserName'
                authenticationProtocol: 0
                # ieee8021xPassword: ''  # 8021x password if authenticationProtocol is 2 (PEAPv0/EAP-MSCHAPv2)
                clientCert: ''
                caCert: ''
                privateKey: ''
            ```
        
        === "JSON"
            ```json title="config.json with 802.1x"
            {
              "password": "AMTPassword",
              "wiredConfig": {
                "dhcp": true,
                "ipsync": true,
                "ieee8021xProfileName": "exampleIeee8021xEAP-TLS"
              },
              "ieee8021xConfigs": [
                {
                  "profileName": "exampleIeee8021xEAP-TLS",
                  "username": "exampleUserName",
                  "authenticationProtocol": 0,
                  "clientCert": "",
                  "caCert": "",
                  "privateKey": ""
                }
              ]
            }
            ```

=== "Config w/ Secrets File"
    ##### via Config with Secrets file

    If a secrets file is included with the configuration file, those secrets will be used in the matching `ieee8021xProfileName` configuration. These templates show how to create a simple Wired profile utilizing 802.1x.

    1. Create a new file called `config.yaml`. Copy and paste the corresponding template below.

        This `config.yaml` is slightly different from the standard one as we either delete or leave blank the secret fields `ieee8021xPassword` and `privateKey`.

        === "YAML"
            ```yaml title="config.yaml"
            wiredConfig:
              dhcp: true
              ipsync: true
              ieee8021xProfileName: 'exampleIeee8021xEAP-TLS'
            ieee8021xConfigs:
              - profileName: 'exampleIeee8021xEAP-TLS'
                username: "exampleUserName"
                authenticationProtocol: 0 #8021x profile (ex. EAP-TLS(0))
                clientCert: ''
                caCert: ''
            ```

        === "JSON"
            ```json title="config.json"

            ```

    2. Create a new file called `secrets.yaml`. Copy and paste the template below.

        === "YAML"
            ```yaml title="secrets.yaml"
            secrets:
            - profileName: 'exampleIeee8021xEAP-TLS'
              privateKey: ''
            - profileName: 'ieee8021xPEAPv0'
              password: ''
            ```
        === "JSON"
            ```json title="secrets.json"
            {
            "secrets": [
                {
                "profileName": "exampleIeee8021xEAP-TLS",
                "privateKey": ""
                },
                {
                "profileName": "ieee8021xPEAPv0",
                "password": ""
                }
            ]
            }
            ```

    3. Fill in fields with the secrets. The `profileName` given in the secrets file must match the corresponding 802.1x configuration `iee8021xProfileName`.
    
    4. Provide the `secrets.yaml` file using the `-secrets` flag. 

        ```
        rpc configure wired -config config.yaml -secrets secrets.yaml
        ```

=== "Individual Options"
    ##### via Individual Options
    
    Alternatively, provide all options directly in the command line.

    !!! warning "Warning - Use Case and Security"
        The CLI option is intended for use as part of an integration of RPC as a shared library. The passing of secrets directly via command line is highly insecure and **NOT** recommended.
    
    === "DHCP"
        ```
        rpc configure wired -dhcp -ipsync -password AMTPassword
        ```

    === "Static"
        ```
        rpc configure wired -static -ipaddress 192.168.1.50 -subnetmask 255.255.255.0 -gateway 192.168.1.1 -primarydns 8.8.8.8 -secondarydns 4.4.4.4 -password AMTPassword
        ```

    ###### with 802.1x

    === "Using Enterprise Assistant"

        Using Enterprise Assistant for 802.1x configuration offers the most secure path. See [Enterprise Assistant RPC-Go 802.1x Configuration](../../EA/RPCConfiguration/localIEEE8021xConfig.md) for more information.

        ```
        rpc configure wired -dhcp -ipsync -password AMTPassword -ieee8021xProfileName example8021xProfile -eaAddress http://<YOUR-IPADDRESS-OR-FQDN>:8000 -eaUsername eaUser -eaPassword eaPass -authenticationProtocol 0
        ```

    === "Without Enterprise Assistant"

        ```
        rpc configure wired -dhcp -ipsync -password AMTPassword -ieee8021xProfileName example8021xProfile -authenticationProtocol 0 -clientCert "" -caCert "" -privateKey ""
        ```

=== "-configJson String Option"
    ##### via -configJson Option
    
    Or, provide the JSON string directly in the command line.

    !!! warning "Warning - Use Case and Security"
        The CLI option is intended for use as part of an integration of RPC as a shared library. The passing of secrets directly via command line is highly insecure and **NOT** recommended.

    === "DHCP"
        ```
        rpc configure wired -configJson "{ "password": "AMTPassword", "wiredConfig": { "dhcp": true, "ipsync": true } }"
        ```

    === "Static"
        ```
        rpc configure wired -configJson "{ "password": "AMTPassword", "wiredConfig": { "static": true, "ipaddress": "192.168.1.50", "subnetmask": "255.255.255.0", "gateway": "192.168.1.1", "primarydns": "8.8.8.8", "secondarydns": "4.4.4.4" } }"
        ```

    ###### with 802.1x

    === "Using Enterprise Assistant"

        Using Enterprise Assistant for 802.1x configuration offers the most secure path. See [Enterprise Assistant RPC-Go 802.1x Configuration](../../EA/RPCConfiguration/localIEEE8021xConfig.md) for more information.

        ```
        rpc configure wired -configJson "{ "password": "AMTPassword", "wiredConfig": { "dhcp": true, "ipsync": true, "ieee8021xProfileName": "exampleIeee8021xEAP-TLS" }, "enterpriseAssistant": { "eaAddress": "http://<YOUR-IPADDRESS-OR-FQDN>:8000", "eaUsername": "eaUser", "eaPassword": "eaPass" }, "ieee8021xConfigs": [ { "profileName": "exampleIeee8021xEAP-TLS", "authenticationProtocol": 0 } ] }"
        ```

    === "Without Enterprise Assistant"

        ```
        rpc configure wired -configJson "{ "password": "AMTPassword", "wiredConfig": { "dhcp": true, "ipsync": true, "ieee8021xProfileName": "exampleIeee8021xEAP-TLS" }, "ieee8021xConfigs": [ { "profileName": "exampleIeee8021xEAP-TLS", "username": "exampleUserName", "authenticationProtocol": 0, "clientCert": "", "caCert": "", "privateKey": "" } ] }"
        ```

<br>

| OPTION                  | DESCRIPTION                                                                                  |
|-------------------------|----------------------------------------------------------------------------------------------|
| -authenticationProtocol | 802.1x profile protocol. Valid Values = {0, 2} where `0` = EAP-TLS, `2` = EAP/MSCHAPv2       |
| -caCert                 | Trusted Microsoft root CA or 3rd-party root CA in Active Directory domain.                   |
| -clientCert             | Client certificate chained to the `caCert`. Issued by enterprise CA or mapped to computer account in Active Directory. <br>AMT provides this certificate to authenticate itself with the Radius Server. |
| -config string          | File path of a `.yaml` or `.json` file with desired wired DHCP or Static IP configuration.   |
| -configJson string      | Configuration as a JSON string                                                               |
| -dhcp                   | Configure AMT wired settings to use DHCP.                                                    |
| -eaAddress string       | IP Address or FQDN of Enterprise Assistant.                                                  |
| -eaPassword string      | Configured Enterprise Assistant Password.                                                    |
| -eaUsername             | Configured Enterprise Assistant Username.                                                    |
| -gateway value          | Gateway address to assign to AMT. For use with `-static` only.                               |
| -ieee8021xPassword      | 802.1x profile password if authenticationProtocol is PEAPv0/EAP-MSCHAPv2(2).                 |
| -ieee8021xProfileName   | IEEE 802.1x Profile name (Friendly name), must be alphanumeric.                              |
| -ipaddress value        | IP Address to assign to AMT. For use with `-static` only.                                    |
| -ipsync                 | Sync the IP configuration of the host OS to AMT network settings.                            |
| -primarydns value       | Primary DNS to assign to AMT. For use with `-static` only.                                   |
| -secondarydns value     | Secondary DNS to assign to AMT. For use with `-static` only.                                 |
| -secrets string          | File path of a `.yaml` or `.json` file with required secrets.                                |
| -static                 | Configure AMT wired settings to use Static IP.                                               |
| -subnetmask value       | Subnetwork mask to assign to AMT. For use with `-static` only.                               |
| -username               | 802.1x username, must match the Common Name of the `clientCert`.                             |

<br>

#### wireless

!!! warning "Warning - Deprecation: `addwifisettings` subcommand"
    **`rpc configure wireless` is the recommended subcommand.** The previous `rpc configure addwifisettings` subcommand is deprecated will be removed in the future. It is recommended to utilize the new, `rpc configure wireless` subcommand for new development.

Configure wireless 802.1x settings of an existing, activated AMT device by passing credentials and certificates directly to AMT or using Enterprise Assistant. More information on configuring AMT to use 802.1x can be found in [RPC-Go 802.1x Configuration](../../EA/RPCConfiguration/localIEEE8021xConfig.md) or [RPS 802.1x Configuration](../../EA/RPSConfiguration/remoteIEEE8021xConfig.md). AMT password is required.

On failure, the `wireless` configure command will rollback any certificates added before the error occurred.


=== "Config File"
    ##### via Config file

    The Config file can be formatted as either YAML or JSON. This example shows YAML but a JSON template is provided as well.

    1. Create a new file called `config.yaml`. Copy and paste the corresponding template below.

        These templates show how to create a simple Wireless profile called **exampleWifiWPA2**.

        === "YAML"
            ```yaml title="config.yaml"
            password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in the command line
            wifiConfigs:
              - profileName: 'exampleWifiWPA2' # friendly name (ex. Profile name)
                ssid: 'exampleSSID'
                priority: 1
                authenticationMethod: 6
                encryptionMethod: 4
                pskPassphrase: ''
            ```

        === "JSON"
            ```json title="config.json"
            {
            "password": "AMTPassword",
            "wifiConfigs": [
                {
                "profileName": "exampleWifiWPA2",
                "ssid": "exampleSSID",
                "priority": 1,
                "authenticationMethod": 6,
                "encryptionMethod": 4,
                "pskPassphrase": ""
                }
            ]
            }
            ```

    2. Fill in fields with desired options and secrets.  If the secrets are **not** provided (e.g. secret field is an empty string or not given), the secrets will be prompted for as user input in the command line.

        Alternatively, secrets can be stored and referenced in a separate file. See **Config w/ Secrets File** tab for more information.

    3. Provide the `config.yaml` file using the `-config` flag. 

        ```
        rpc configure wireless -config config.yaml
        ```

    ###### with 802.1x

    === "Using Enterprise Assistant"

        Using Enterprise Assistant for 802.1x configuration offers the most secure path. See [Enterprise Assistant RPC-Go 802.1x Configuration](../../EA/RPCConfiguration/localIEEE8021xConfig.md) for more information.

        === "YAML"
            ```yaml title="config.yaml with 802.1x"
            password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in  the command line
            enterpriseAssistant:
              eaAddress: 'http://<YOUR-IPADDRESS-OR-FQDN>:8000'
              eaUsername: 'eaUser'
              eaPassword: 'eaPass'
            wifiConfigs:
              - profileName: 'exampleWifi8021x' # friendly name (ex. Profile name)
                ssid: 'ssid'
                priority: 1
                authenticationMethod: 7
                encryptionMethod: 4
                ieee8021xProfileName: 'exampleIeee8021xEAP-TLS'
            ieee8021xConfigs:
              - profileName: 'exampleIeee8021xEAP-TLS'
                # password: "" # 8021x password if authenticationProtocol is PEAPv0/EAP-MSCHAPv2(2)
                authenticationProtocol: 0 #8021x profile (ex. EAP-TLS(0))
            ```
        === "JSON"
            ```json title="config.json with 802.1x"
            {
              "password": "AMTPassword",
              "enterpriseAssistant": {
                "eaAddress": "http://<YOUR-IPADDRESS-OR-FQDN>:8000",
                "eaUsername": "admin",
                "eaPassword": "P@ssw0rd"
              },
              "wifiConfigs": [
                {
                  "profileName": "exampleWifi8021x",
                  "ssid": "ssid",
                  "priority": 1,
                  "authenticationMethod": 7,
                  "encryptionMethod": 4,
                  "ieee8021xProfileName": "exampleIeee8021xEAP-TLS"
                }
              ],
              "ieee8021xConfigs": [
                {
                  "profileName": "exampleIeee8021xEAP-TLS",
                  "authenticationProtocol": 0
                }
              ]
            }
            ```

    === "Without Enterprise Assistant"

        === "YAML"
            ```yaml title="config.yaml with 802.1x"
            password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in the command line
            wifiConfigs:
              - profileName: 'exampleWifi8021x' # friendly name (ex. Profile name)
                ssid: 'ssid'
                priority: 1
                authenticationMethod: 7
                encryptionMethod: 4
                ieee8021xProfileName: 'exampleIeee8021xEAP-TLS'
            ieee8021xConfigs:
              - profileName: 'exampleIeee8021xEAP-TLS'
                username: "exampleUserName"
                # password: "" # 8021x password if authenticationProtocol is PEAPv0/EAP-MSCHAPv2(2)
                authenticationProtocol: 0 #8021x profile (ex. EAP-TLS(0))
                clientCert: ''
                caCert: ''
                privateKey: ''
            ```
        
        === "JSON"
            ```json title="config.json with 802.1x"
            {
              "password": "AMTPassword",
              "wifiConfigs": [
                {
                  "profileName": "exampleWifi8021x",
                  "ssid": "ssid",
                  "priority": 1,
                  "authenticationMethod": 7,
                  "encryptionMethod": 4,
                  "ieee8021xProfileName": "exampleIeee8021xEAP-TLS"
                }
              ],
              "ieee8021xConfigs": [
                {
                  "profileName": "exampleIeee8021xEAP-TLS",
                  "username": "exampleUserName",
                  "authenticationProtocol": 0,
                  "clientCert": "",
                  "caCert": "",
                  "privateKey": ""
                }
              ]
            }
            ```

=== "Config w/ Secrets File"
    ##### via Config with Secrets file

    If a secrets file is included with the configuration file, those secrets will be used in the matching `profileName` configuration. These templates show how to create a simple Wireless profile called **exampleWifiWPA2** and a Wireless profile utilizing 802.1x called **exampleWifi8021x**.

    1. Create a new file called `config.yaml`. Copy and paste the corresponding template below.

        This `config.yaml` is slightly different from the standard one as we either delete or leave blank the secret fields `pskPassphrase`, `password`, and `privateKey`.

        === "YAML"
            ```yaml title="config.yaml"
            wifiConfigs:
              - profileName: 'exampleWifiWPA2' # friendly name (ex. Profile name)
                ssid: 'exampleSSID'
                priority: 1
                authenticationMethod: 6
                encryptionMethod: 4
              - profileName: 'exampleWifi8021x' # friendly name (ex. Profile name)
                ssid: 'ssid'
                priority: 2
                authenticationMethod: 7
                encryptionMethod: 4
                ieee8021xProfileName: 'exampleIeee8021xEAP-TLS'
            ieee8021xConfigs:
              - profileName: 'exampleIeee8021xEAP-TLS'
                username: "exampleUserName"
                authenticationProtocol: 0 #8021x profile (ex. EAP-TLS(0))
                clientCert: ''
                caCert: ''
            ```

        === "JSON"
            ```json title="config.json"
            {
            "wifiConfigs": [
                {
                "profileName": "exampleWifiWPA2",
                "ssid": "exampleSSID",
                "priority": 1,
                "authenticationMethod": 6,
                "encryptionMethod": 4,
                "pskPassphrase": ""
                },
                {
                "profileName": "exampleWifi8021x",
                "ssid": "ssid",
                "priority": 2,
                "authenticationMethod": 7,
                "encryptionMethod": 4,
                "ieee8021xProfileName": "exampleIeee8021xEAP-TLS"
                }
            ],
            "ieee8021xConfigs": [
                {
                "profileName": "exampleIeee8021xEAP-TLS",
                "username": "exampleUserName",
                "password": "",
                "authenticationProtocol": 0,
                "clientCert": "",
                "caCert": "",
                }
            ]
            }
            ```

    2. Create a new file called `secrets.yaml`. Copy and paste the template below.

        === "YAML"
            ```yaml title="secrets.yaml"
            secrets:
            - profileName: 'exampleWifiWPA2'
              pskPassphrase: ''
            - profileName: 'exampleIeee8021xEAP-TLS'
              privateKey: ''
            - profileName: 'ieee8021xPEAPv0'
              password: ''
            ```
        === "JSON"
            ```json title="secrets.json"
            {
            "secrets": [
                {
                "profileName": "exampleWifiWPA2",
                "pskPassphrase": ""
                },
                {
                "profileName": "exampleIeee8021xEAP-TLS",
                "privateKey": ""
                },
                {
                "profileName": "ieee8021xPEAPv0",
                "password": ""
                }
            ]
            }
            ```

    3. Fill in fields with the secrets. The `profileName` given in the secrets file must match the corresponding Wireless or 802.1x configuration `profileName`.
    
    4. Provide the `secrets.yaml` file using the `-secrets` flag. 

        ```
        rpc configure wireless -config config.yaml -secrets secrets.yaml
        ```


=== "Individual Options"
    ##### via Individual Options
    
    Alternatively, provide all options directly in the command line. The user will be prompted for missing secrets (i.e. password, privateKey, pskPassphrase, ieee8021xPassword), if not provided.

    !!! warning "Warning - Use Case and Security"
        The CLI option is intended for use as part of an integration of RPC as a shared library. The passing of secrets directly via command line is highly insecure and **NOT** recommended.

    ```
    rpc configure wireless -profileName profileName -password AMTPassword -authenticationMethod 6 -encryptionMethod 4 -ssid "networkSSID" -pskPassphrase networkPass -authenticationProtocol 0 -priority 1
    ```

    ###### with 802.1x

    === "Using Enterprise Assistant"

        Using Enterprise Assistant for 802.1x configuration offers the most secure path. See [Enterprise Assistant RPC-Go 802.1x Configuration](../../EA/RPCConfiguration/localIEEE8021xConfig.md) for more information.

        ```
        rpc configure wireless -profileName profileName -password AMTPassword -authenticationMethod 7 -encryptionMethod 4 -ssid "networkSSID" -pskPassphrase networkPass -authenticationProtocol 0 -priority 1 -eaAddress http://<YOUR-IPADDRESS-OR-FQDN>:8000 -eaUsername eaUser -eaPassword eaPass
        ```

    === "Without Enterprise Assistant"

        ```
        rpc configure wireless -profileName profileName -password AMTPassword -authenticationMethod 7 -encryptionMethod 4 -ssid "networkSSID" -pskPassphrase networkPass -username "username" -authenticationProtocol 0 -priority 1 -clientCert "" -caCert "" -privateKey ""
        ```

=== "-configJson String Option"
    ##### via -configJson Option
    
    Or, provide the JSON string directly in the command line. The user will be prompted for missing secrets (i.e. password, privateKey, pskPassphrase, ieee8021xPassword), if not provided.

    !!! warning "Warning - Use Case and Security"
        The CLI option is intended for use as part of an integration of RPC as a shared library. The passing of secrets directly via command line is highly insecure and **NOT** recommended.

    ```
    rpc configure wireless -configJson "{ "wifiConfigs": [ { "profileName": "exampleWifi", "authenticationMethod": 6, "encryptionMethod": 4, "ssid": "networkSSID", "username": "username", "authenticationProtocol": 0, "priority": 1 } ] }"
    ```

    ###### with 802.1x

    === "Using Enterprise Assistant"

        Using Enterprise Assistant for 802.1x configuration offers the most secure path. See [Enterprise Assistant RPC-Go 802.1x Configuration](../../EA/RPCConfiguration/localIEEE8021xConfig.md) for more information.

        ```
        rpc configure wireless -configJson "{ "password": "AMTPassword", "enterpriseAssistant": { "eaAddress": "http://<YOUR-IPADDRESS-OR-FQDN>:8000", "eaUsername": "eaUser", "eaPassword": "eaPass" }, "wifiConfigs": [ { "profileName": "exampleWifi8021x", "ssid": "ssid", "priority": 1, "authenticationMethod": 7, "encryptionMethod": 4, "ieee8021xProfileName": "exampleIeee8021xEAP-TLS" } ], "ieee8021xConfigs": [ { "profileName": "exampleIeee8021xEAP-TLS", "authenticationProtocol": 0 } ] }"
        ```

    === "Without Enterprise Assistant"

        ```
        rpc configure wireless -configJson "{ "wifiConfigs": [ { "profileName": "exampleWifi8021x", "ssid": "networkSSID", "priority": 1, "authenticationMethod": 7, "encryptionMethod": 4, "ieee8021xProfileName": "exampleIeee8021xEAP-TLS" } ], "ieee8021xConfigs": [ { "profileName": "exampleIeee8021xEAP-TLS", "username": "exampleUserName", "password": "", "authenticationProtocol": 0, "clientCert": "", "caCert": "", "privateKey": "" } ] }"
        ```

<br>

| OPTION                  | DESCRIPTION                                                                                                                                                                                             |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| -authenticationMethod   | Wifi authentication method. Valid Values = {4, 5, 6, 7} where `4` = WPA PSK, `5` = WPA_IEEE8021X, `6` = WPA2 PSK, `7` = WPA2_IEEE8021X                                                                  |
| -authenticationProtocol | 802.1x profile protocol. Valid Values = {0, 2} where `0` = EAP-TLS, `2` = EAP/MSCHAPv2                                                                                                                  |
| -caCert                 | Trusted Microsoft root CA or 3rd-party root CA in Active Directory domain.                                                                                                                              |
| -clientCert             | Client certificate chained to the `caCert`. Issued by enterprise CA or mapped to computer account in Active Directory. <br>AMT provides this certificate to authenticate itself with the Radius Server. |
| -config                 | File path of a `.yaml` or `.json` file with desired wireless and/or wireless 802.1x configuration.                                                                                                      |
| -configJson             | Configuration as a JSON string.                                                                                                                                                                         |
| -eaAddress string       | IP Address or FQDN of Enterprise Assistant.                                                                                                                                                             |
| -eaPassword string      | Configured Enterprise Assistant Password.                                                                                                                                                               |
| -eaUsername             | Configured Enterprise Assistant Username.                                                                                                                                                               |
| -encryptionMethod       | Wifi encryption method. Valid Values = {3, 4} where `3` = TKIP, `4` = CCMP                                                                                                                              |
| -ieee8021xPassword      | 802.1x profile password if authenticationProtocol is PEAPv0/EAP-MSCHAPv2(2).                                                                                                                            |
| -profileName            | Profile name (Friendly name), must be alphanumeric.                                                                                                                                                     |
| -priority               | Ranked priority over other profiles.                                                                                                                                                                    |
| -privateKey             | 802.1x profile private key of the `clientCert`.                                                                                                                                                         |
| -pskPassphrase          | Wifi `pskPassphrase`, if `authenticationMethod` is WPA PSK(4) or WPA2 PSK(6).                                                                                                                           |
| -secrets                | File path of a `.yaml` or `.json` file with secrets to be applied to the configurations.                                                                                                                |
| -ssid                   | Wifi SSID.                                                                                                                                                                                              |
| -username               | 802.1x username, must match the Common Name of the `clientCert`.                                                                                                                                        |

<br>

### amtinfo

Display AMT status and configuration:

```
rpc amtinfo [OPTIONS]
```

**Not passing `[OPTIONS]` will print all information.**

| AMT INFO             | OPTION            | DESCRIPTION                                                                                                                                                                           | 
|----------------------|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                      | -json             | JSON Output                                                                                                                                                                           |
| Version              | -ver              | Intel AMT version.                                                                                                                                                                    | 
| Build Number         | -bld              | Intel AMT Build Number.                                                                                                                                                               |
| System Certificates  | -cert             | System Certificate Hashes. If given `-password`, will print both System and User Certificate Hashes.                                                                                  |
| User Certificates    | -userCert         | User Certificate Hashes. Will prompt for AMT password. Or, provide `-password` flag.                                                                                                  |
| SKU                  | -sku              | Product SKU                                                                                                                                                                           | 
| UUID                 | -uuid             | Unique Universal Identifier of the device. Used when creating device-specific MPS API calls as part of the REST API's URL path.                                                       | 
| Control Mode         | -mode             | Control Mode below indicates the managed device's state: <br>(a) pre-provisioning state <br>(b) activated in client control mode <br>(c) activated in admin control mode              | 
| Operational State    | -operationalState | Enabled/Disabled boolean. Returns state of AMT for 13th Gen Raptor Lake (AMT 16.1) or newer devices. N/A for earlier generation devices.                                              |
| DNS Suffix           | -dns              | DNS Suffix set according to PKI DNS Suffix in Intel MEBX or through DHCP Option 15. Required for ACM activation.                                                                      |
| DNS Suffix (OS)      | -dns              |                                                                                                                                                                                       |
| Hostname (OS)        | -hostname         | Device's hostname as set in the Operating System.                                                                                                                                     |
| RAS Network          | -ras              |                                                                                                                                                                                       |
| RAS Remote Status    | -ras              | Unconnected or connected. State of connection to a management server.                                                                                                                 |
| RAS Trigger          | -ras              | User initiated or periodic. When activated, periodic signifies CIRA established. By default, CIRA sends a heartbeat to the server every 30 seconds to verify and maintain connection. |
| RAS MPS Hostname     | -ras              | IP Address or FQDN of the MPS server.                                                                                                                                                 |

**---Wired/Wireless Adapters---**

| WIRED/WIRELESS ADAPTER | OPTION | DESCRIPTION                                                              |
|------------------------|--------|--------------------------------------------------------------------------|
| DHCP Enabled           | -lan   | True/False. Whether or not the network is using DHCP or Static IPs.      |
| DHCP Mode              | -lan   |                                                                          |
| Link Status            | -lan   | Up/Down. Shows whether or not this adapter is being used by Intel AMT.   |
| AMT IP Address         | -lan   | If using CIRA or the device is unactivated, this field will show 0.0.0.0 |
| OS IP Address          | -lan   | IP Address of device set in Operating System                             |
| MAC Address            | -lan   | Device's MAC Address                                                     |

For more information,
see [Wireless Activation](../../../Tutorials/createWiFiConfig.md).

### version

Display the current version of RPC and the RPC Protocol version:

```
rpc version
```
