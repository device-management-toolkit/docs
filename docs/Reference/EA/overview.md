

Enterprise Assistant (EA) is a Windows application that can run as a normal application or as a background Windows service. Once setup to connect to RPS (hosted in either the cloud or enterprise) or RPC-Go, EA can assist with configuring 802.1x and TLS settings on AMT devices. Enterprise Assistant will handle certificate signing requests (CSRs) to Microsoft CA.

Enterprise Assistant must run on a computer that is joined to your domain and with sufficient rights that it can create LDAP computer objects. It must have access to the Domain Certificate Authority so it can request that certificates be signed.

Enterprise Assistant is based off the open-source project [MeshCentral Satellite](https://github.com/Ylianst/MeshCentralSatellite).

## Prerequisites

### Software

- [git](https://git-scm.com/downloads)
- [Microsoft* Visual Studio 2022 Community or better](https://visualstudio.microsoft.com/downloads/)

    Requires installation of the **.NET Desktop Development** Workload under the Desktop & Mobile section at time of installation.

## Build the Executable

The Enterprise Assistant source code must be compiled into a Windows executable before it can be run.

1. Clone the Enterprise Assistant Repository.
    ```
    git clone https://github.com/device-management-toolkit/enterprise-assistant.git
    ```

2. Open the project file `OpenAMTEnterpriseAssistant.csproj` in Visual Studio.

3. From the menus, choose `Build > Build OpenAMTEnterpriseAssistant`.

4. By default after compiling, the `.exe` will be saved in `.\enterprise-assistant\bin\Debug\OpenAMTEnterpriseAssistant.exe`.

    !!! note "Note - Running as a Windows Application versus a Windows Service"
        It is suggested to run Enterprise Assistant as a normal Windows application at first to make sure everything works correctly before running it as a background Windows service. You can start by going in the "Settings" option in the menus. Settings are also saved in a local `.config` file that can be referenced when running as a background Windows service.

    <figure class="figure-image">
        <img width="400" src="..\..\..\assets\images\screenshots\EA_Startup.png" alt="Figure 1: Enterprise Assistant Startup">
        <figcaption>Figure 1: Enterprise Assistant Startup</figcaption>
    </figure>

## Configuration

There are two ways to configure 802.1x and TLS in an enterprise environment using Enterprise Assistant:

### [**EA Configuration using RPC-Go**](./RPCConfiguration/rpcgoConfiguration.md)

The RPC-Go local configuration option does not communicate with a remote server (RPS). RPC-Go will establish a communication channel to Enterprise Assistant (EA) directly and handle the CSR process. The wanted configuration options will be passed via command line flags or a config `.yaml`/`.json` file using RPC-Go. Configuration of AMT is handled entirely locally by RPC-Go.

[Configure EA using RPC-Go](./RPCConfiguration/rpcgoConfiguration.md){: .md-button .md-button--primary }

<figure class="figure-image">
    <img src="..\..\..\assets\images\diagrams\EA_RPC_Architecture.png" width=75% alt="Figure 2: Enterprise Assistant Architecture using RPC-Go">
    <figcaption>Figure 2: Enterprise Assistant Architecture using RPC-Go</figcaption>
</figure>

### [**EA Configuration using RPS**](./RPSConfiguration/rpsConfiguration.md)

RPS will handle communication with Enterprise Assistant (EA). Desired configuration options will be provided via the AMT profile, Wireless Config, and IEEE802.1x Config. RPS will communicate with EA at the time of provisioning to configure 802.1x and/or TLS configuration options based on the profiles.

[Configure EA using RPS](./RPSConfiguration/rpsConfiguration.md){: .md-button .md-button--primary }

<figure class="figure-image">
    <img src="..\..\..\assets\images\diagrams\EA_RPS_Architecture.png" alt="Figure 3: Enterprise Assistant Architecture using RPS">
    <figcaption>Figure 3: Enterprise Assistant Architecture using RPS</figcaption>
</figure>

<br>