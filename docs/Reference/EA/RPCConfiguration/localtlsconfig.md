--8<-- "References/abbreviations.md"

# Local TLS Configuration with RPC-Go

!!! warning "Local TLS Configuration using RPC-Go is a Preview Feature"
    Local TLS Configuration using RPC-Go is a Preview Feature and is subject to change. This means it has not been fully validated and cannot be guaranteed to work. There are still potential bugs and tweaks needed for a production-level feature standard. Interested in this feature and helping us test it? Reach out via GitHub.

In Device Management Toolkit, the TLS protocol supports the following types of authentication today:

- Server Authentication – Only the server is authenticated (i.e., its identity is ensured) while the client remains unauthenticated. This means that the end user (whether an individual or an application, such as a Web browser) can be sure with whom they are communicating.

<!-- - Mutual Authentication – The next level of security in which both ends of the “conversation” are sure with whom they are communicating.

When Intel AMT is configured for mutual authentication, it validates incoming client certificates based on the root of trust configured. -->

## Overview

AMT can be configured to use TLS without the need for a remote server (i.e. RPS). RPC-Go can configure TLS settings in AMT using Enterprise Assistant, or it can configure TLS in AMT using a self-signed certificate.

This document explains how to perform the configuration using a certificate signed by the Microsoft CA with the help of Enterprise Assistant.

The following steps highlight how to:

- Configure the connection of EA and RPC-Go
- Run TLS configuration using RPC-Go

## Prerequisites

The following are requirements to configure and connect an AMT device using TLS.

- [Enterprise Assistant configured for RPC-Go](rpcgoConfiguration.md)
- [RPC-Go](../../../GetStarted/Cloud/buildRPC.md)
- Management Tool supporting TLS (ex: [Meshcommander](https://www.meshcommander.com/meshcommander))

    This is not required for configuration and therefore not needed for this guide. However, a management tool will be needed if you want to manage the device post-configuration.

### Services

The following services are assumed to be configured and running in your enterprise environment.

- Microsoft* Certificate Authority (CA)
    - An AMT TLS Certificate template is required. See [TLS Certificate Template](../tlsCertTemplate.md) for additional steps on creating a template.

- Microsoft* Active Directory (AD)

## Configure Enterprise Assistant for RPC-Go

See [EA Configuration for RPC-Go](rpcgoConfiguration.md) for steps on how to setup EA to accept a connection and request from RPC-Go.

## Configure the AMT Device

1. Open Command Prompt as Administrator.

2. Navigate to the directory with RPC-Go.

3. Run the `rpc configure tls` command. Replace the [bracketed] values with your own.

    !!! note "Alternative Option - Using a Config File"
        Rather than passing in individual flag options, a `.yaml` or `.json` config file can be passed. See [`rpc configure tls` Command Documentation](../../RPC/commandsRPC.md#tls) for more details and examples.

    ```
    rpc configure tls -mode [configurationMode] -password [AMTPassword] -eaAddress http://[IP-Address-or-FQDN]:8000 -eaUsername [myUsername] -eaPassword [myPassword]
    ```

    !!! example "Example Command"

        ```
        rpc configure tls -mode Server -password AMTpassword123! -eaAddress http://192.168.2.50:8000 -eaUsername admin -eaPassword P@ssw0rd
        ```

    The toolkit offers two configuration modes: 

    | CONFIGURATION MODE    | DESCRIPTION                                                                                            |
    | :---------------------| :----------------------------------------------------------------------------------------------------- |
    | Server                | The client authenticates the server request and accepts only those servers with a digital certificate. |
    | ServerAndNonTLS       | **Used primarily for testing.** The client authenticates the server request and accepts legitimate digital certificates from TLS-enabled servers. However, if the server is not TLS-enabled, the client defaults to a CIRA connection.|

    <!-- | Mutual                | Both client and server **must** have certs. The client cert is signed by the server cert.              |
    | MutualAndNonTLS       | **Used primarily for testing.** Both client and server certs are expected. The client authenticates the server request and accepts legitimate digital certificates from TLS-enabled servers. However, if the server is not TLS-enabled, the client defaults to a CIRA connection.   | -->

    !!! success "Success - TLS Configured"
        <figure class="figure-image">
            <img src="..\..\..\..\assets\images\RPC_EALocalTLSSuccess.png" alt="Figure 1: TLS Configured Example">
            <figcaption>Figure 1: TLS Configured Example</figcaption>
        </figure>

4. Now, the device is manageable via a TLS connection using the management tool of your choice!

<br><br>