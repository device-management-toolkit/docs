--8<-- "References/abbreviations.md"
Developed in Go* programming language, the Remote Provisioning Client (RPC) application runs on the managed device and communicates with the Remote Provisioning Server (RPS) microservice on the development system. The RPC and RPS configure and activate Intel® AMT on the managed device. Once properly configured, the remote managed device can call home to the Management Presence Server (MPS) by establishing a Client Initiated Remote Access (CIRA) connection with the MPS. See Figure 1.

<div style="text-align:center;">
  <iframe width="600" height="337" src="https://www.youtube.com/embed/z9Ia317L0Kk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  <figcaption><b>Getting Started Part 3</b>: Follow along to learn about how to build RPC, some of the information it can provide, and how to activate an AMT device. <b>Additional Resources: </b><a href="../../../Reference/RPC/libraryRPC">RPC as a Library</a> and <a href="../../../Reference/RPC/commandsRPC">RPC Commands and Flags</a></figcaption>
</div>

!!! important "Important - Production Environment"
    In a production environment, RPC can be deployed with an in-band manageability agent to distribute it to the fleet of AMT devices. The in-band manageability agent can invoke RPC to run and activate the AMT devices.


<figure class="figure-image">
<img width="800" height="450" src="..\..\..\assets\images\RPC_Overview.png" alt="Figure 1: RPC Configuration">
<figcaption>Figure 1: RPC configuration</figcaption>
</figure>

!!! note "Figure 1 Details"
    The RPC on a managed device communicates with the Intel® Management Engine Interface (Intel® MEI, previously known as HECI) Driver and the Remote Provisioning Server (RPS) interfaces. The Driver uses the Intel® MEI to talk to Intel® AMT. The RPC activates Intel® AMT with an AMT profile, which is associated with a CIRA configuration (Step 3). The profile, which also distinguishes between Client Control Mode (CCM) or Admin Control Mode (ACM), and configuration were created in [Create a CIRA Config](createCIRAConfig.md) or [Create an AMT Profile](createProfileACM.md). After running RPC with a profile, Intel® AMT will establish a CIRA connection with the MPS (Step 4) allowing MPS to manage the remote device and issue AMT commands (Step 5).

##  Get RPC

There are two ways to get the RPC-Go binary:

- [Download from the RPC-Go GitHub Repo Releases](#download-rpc)
- [Build the RPC-Go binary using Go](#build-rpc)

See steps below for both options.

<br>

### Download RPC

Download the latest RPC-Go version from the [RPC-Go GitHub Repo Releases Page](https://github.com/device-management-toolkit/rpc-go/releases) for the Operating System of the AMT device (Windows or Linux).

After downloading, continue on to [Run RPC to Activate, Configure, and Connect the AMT Device](#run-rpc-to-activate-configure-and-connect-the-amt-device).

<br>

### Build RPC

Alternatively, the RPC-Go binaries can be manually built using Go for development purposes or personal preference.

??? tip "Flexible Deployment - RPC as a Library"  
    The RPC can be built as an executable file or as a library, which offers the flexibility of deploying in your management agent or client. [Read more about building RPC as a library here](../../Reference/RPC/libraryRPC.md).

If you are building an executable on a development system, you will copy the executable to the AMT device afterwards. 

1. Change to the `rpc-go` directory of the cloned `cloud-deployment` repository.
   
    ``` bash
    cd rpc-go
    ```
    ??? note "Haven't Cloned the `cloud-deployment` Repository?"

        * Only clone the `rpc-go` repository:
            ``` bash
            git clone https://github.com/device-management-toolkit/rpc-go --branch v{{ repoVersion.rpc_go }}
            ```

        * Alternatively, clone the whole toolkit repository:
            ``` bash
            git clone https://github.com/device-management-toolkit/cloud-deployment --branch v{{ repoVersion.oamtct }} --recursive
            ```

2. Open a Terminal (Linux) or Powershell/Command Prompt **as Administrator** (Windows):

    === "Linux"
        ``` bash
        go build -o rpc ./cmd/main.go
        ```
    === "Windows"
        ``` bash
        go build -o rpc.exe ./cmd/main.go
        ```
    === "Docker (On Linux Host Only)"
        ``` bash
        docker build -f "Dockerfile" -t rpc-go:latest .
        ```
        !!! note
            The image created with the Docker instruction above is only suitable for Docker on a Linux host. 

3. Confirm a successful build:

    RPC must run with elevated privileges. Commands require `sudo` on Linux or an Administrator Command Prompt on Windows.

    === "Linux"
        ``` bash
        sudo ./rpc version
        ```
    === "Windows"
        ```
        .\rpc version
        ```        
    === "Docker (On Linux Host Only)"
        ``` bash
        sudo docker run --rm -it --device=/dev/mei0 rpc-go:latest version
        ```

<br>

## Run RPC to Activate, Configure, and Connect the AMT Device

1. After downloading or building RPC, copy the executable to the AMT device.
   
2. On the AMT device, open a Terminal (Linux) or Powershell/Command Prompt **as Administrator** (Windows).

3. Navigate to the directory containing the RPC application. 

4. Run RPC with the **activate** command to activate, configure, and connect Intel® AMT to the MPS Server. It will take 1-2 minutes to finish provisioning the device. 

    | REPLACE                 | WITH                                                                                  |
    |-------------------------|---------------------------------------------------------------------------------------|
    | Development-IP-Address  | Development system's IP address or FQDN, where the MPS and RPS servers are running.   |
    | profileName             | THe name of the profile created using the Sample Web UI.                        |

    === "Linux"
        ``` bash
        sudo ./rpc activate -u wss://[Development-IP-Address]/activate -n -profile [profileName]
        ```
    === "Windows"
        ```
        .\rpc activate -u wss://[Development-IP-Address]/activate -n -profile [profileName]
        ```        
    === "Docker (On Linux Host Only)"
        ``` bash
        sudo docker run --rm -it --device=/dev/mei0 rpc-go:latest activate -u wss://[Development-IP-Address]/activate -n -profile [profileName]
        ```

    ??? note "Note - Other RPC Flags and Commands"
        See more about the [flags used here and the other available commands of RPC-Go](../../Reference/RPC/commandsRPC.md).

    !!! success
        <figure class="figure-image">
        <img src="..\..\..\assets\images\RPC_Success.png" alt="Figure 2: Example output after configuration">
        <figcaption>Figure 2: Example output after configuration</figcaption>
        </figure>

    !!! error "Troubleshooting"
        Run into an issue? Try these [troubleshooting steps](../../Reference/troubleshooting.md).
         

## Next up
**[Manage AMT Device](manageDevice.md)**
