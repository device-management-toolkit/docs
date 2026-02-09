

# Local IEEE 802.1x Configuration with RPC-Go

!!! warning "802.1x Configuration is a Preview Feature"
    802.1x Configuration feature is a Preview Feature and is subject to change. This means it has not been fully validated and cannot be guaranteed to work. There are still potential bugs and tweaks needed for a production-level feature standard. Interested in this feature and helping us test it? Reach out via GitHub.

## Overview

IEEE 802.1X is an IEEE Standard for port-based network access control (PNAC). It provides an authentication mechanism to devices wishing to attach to a LAN or WLAN.

It typically consists of three parts:

1. Supplicant (Client-end User, AMT Device)
2. Authenticator (Access Point or Switch)
3. Authentication Server (RADIUS Server)

<br>

The following steps highlight how to:

- Configure the connection of EA and RPC-Go
- Run 802.1x configuration using RPC-Go

## Prerequisites

The following are requirements to configure and connect an AMT device using TLS.

- [Enterprise Assistant configured for RPC-Go](rpcgoConfiguration.md)
- [RPC-Go](../../../GetStarted/Cloud/buildRPC.md)

### Services

The following services are assumed to be configured and running in your enterprise environment.

- Microsoft* Certificate Authority (CA)
    - An AMT TLS Certificate template is required. See [TLS Certificate Template](../tlsCertTemplate.md) for additional steps on creating a template.

- Microsoft* Active Directory (AD)

## Wired 802.1x Configuration

These steps will show how to configure a device for DHCP and 802.1x (EAP-TLS). See the [RPC CLI Configure Wired Documentation](../../RPC/v2/commandsRPC.md#wired) for all configuration options.

1. Create and open a new file named `config.yaml`.

2. Copy and paste the following template.

    ```yaml title="config.yaml"
    password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in the command line
    wiredConfig:
      dhcp: true
      ipsync: true
      ieee8021xProfileName: 'exampleIeee8021xEAP-TLS'
    enterpriseAssistant:
      eaAddress: 'http://<YOUR-IPADDRESS-OR-FQDN>:8000'
      eaUsername: 'myUsername'
      eaPassword: 'myPassword'
    ieee8021xConfigs:
      - profileName: 'exampleIeee8021xEAP-TLS'
        authenticationProtocol: 0
    ```

3. Update the `password` with your AMT Password.

4. Update the `enterpriseAssistant:` section with the configured settings of your EA instance.

    The following are the supported wired authentication protocols.

    |Auth Protocol          | API Value | Description                              |
    | --------------------- | --------- | ---------------------------------------- |
    |EAP-TLS                | 0         | Indicates that the desired EAP type is the Transport Layer Security EAP type specified in [RFC 2716](https://www.rfc-editor.org/rfc/rfc2716).                |
    |PEAPv0/EAP-MSCHAPv2    | 2         | Indicates that the desired EAP type is the Protected Extensible Authentication Protocol (PEAP) Version 0 EAP type specified in [draft-kamath-pppext-peapv0](https://tools.ietf.org/html/draft-kamath-pppext-peapv0-00), with Microsoft PPP CHAP Extensions, Version 2 (MSCHAPv2) as the inner authentication method.     |

5. Save and close the file.

6. On an activated AMT device, run the following RPC-Go command to configure wired 802.1x settings.

    ```
    rpc configure wired -config config.yaml
    ```

<br><br>

## Wireless 802.1x Configuration

These steps will show how to configure a device for DHCP and 802.1x (EAP-TLS). See the [RPC CLI Configure Wireless Documentation](../../RPC/v2/commandsRPC.md#wireless) for all configuration options.

1. Create and open a new file named `config.yaml`.

2. Copy and paste the following template.

    ```yaml title="config.yaml"
    password: 'AMTPassword' # alternatively, you can provide the AMT password of the device in  the command line
    enterpriseAssistant:
      eaAddress: 'http://<YOUR-IPADDRESS-OR-FQDN>:8000'
      eaUsername: 'myUsername'
      eaPassword: 'myPassword'
    wifiConfigs:
      - profileName: 'exampleWifi8021x' # friendly name (ex. Profile name)
        ssid: 'ssid'
        priority: 1
        authenticationMethod: 7
        encryptionMethod: 4
        ieee8021xProfileName: 'exampleIeee8021xEAP-TLS'
    ieee8021xConfigs:
      - profileName: 'exampleIeee8021xEAP-TLS'
        authenticationProtocol: 0 #8021x profile (ex. EAP-TLS(0))
    ```

3. Update the `password` with your AMT Password.

4. Update the `enterpriseAssistant:` section with the configured settings of your EA instance.

    The following are the supported wireless authentication protocols.

    |Auth Protocol          | API Value | Description                              |
    | --------------------- | --------- | ---------------------------------------- |
    |EAP-TLS                | 0         | Indicates that the desired EAP type is the Transport Layer Security EAP type specified in [RFC 2716](https://www.rfc-editor.org/rfc/rfc2716).                |
    |PEAPv0/EAP-MSCHAPv2    | 2         | Indicates that the desired EAP type is the Protected Extensible Authentication Protocol (PEAP) Version 0 EAP type specified in [draft-kamath-pppext-peapv0](https://tools.ietf.org/html/draft-kamath-pppext-peapv0-00), with Microsoft PPP CHAP Extensions, Version 2 (MSCHAPv2) as the inner authentication method.     |

5. Update the `ssid` with your network SSID.

6. Save and close the file.

7. On an activated AMT device, run the following RPC-Go command to configure wireless 802.1x settings.

    ```
    rpc configure wireless -config config.yaml
    ```

<br><br>