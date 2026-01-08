--8<-- "References/abbreviations.md"

Developed in Go* programming language, the Remote Provisioning Client (RPC) application runs on the managed device and communicates with the Remote Provisioning Server (RPS) microservice on the development system. The RPC and RPS configure and activate Intel® AMT on the managed device. Once properly configured, the remote managed device can call home to the Management Presence Server (MPS) by establishing a Client Initiated Remote Access (CIRA) connection with the MPS. See Figure 1.

!!! tip "Production Environment"
    In a production environment, RPC can be deployed with an in-band manageability agent to distribute it to the fleet of AMT devices. The in-band manageability agent can invoke RPC to run and activate the AMT devices.

<figure class="figure-image">
<img src="..\..\..\assets\images\diagrams\RPC_Overview.svg" style="height:800px" alt="Figure 1: RPC Configuration">
<figcaption>Figure 1: RPC Configuration</figcaption>
</figure>

!!! note "Figure 1 Details"
    The RPC on a managed device communicates with the Intel® Management Engine Interface (Intel® MEI, previously known as HECI) Driver and the Remote Provisioning Server (RPS) interfaces. The Driver uses the Intel® MEI to talk to Intel® AMT. The RPC activates Intel® AMT with an AMT profile, which is associated with a CIRA configuration (Step 3). The profile, which also distinguishes between Client Control Mode (CCM) or Admin Control Mode (ACM), and configuration were created in [Create a CIRA Config](../../GetStarted/Cloud/createCIRAConfig.md) or [Create an AMT Profile](../../GetStarted/Cloud/createProfileACM.md). After running RPC with a profile, Intel® AMT will establish a CIRA connection with the MPS (Step 4) allowing MPS to manage the remote device and issue AMT commands (Step 5).

## Overview

This guide details how to manually build the RPC-Go binary for development or testing purposes.

!!! tip "Important - RPC-Go Prebuilt Binaries"
    Just need the binary and don't want to build it manually? Download the latest RPC-Go binary version from the [RPC-Go GitHub Repo Releases Page](https://github.com/device-management-toolkit/rpc-go/releases) for the Operating System of the AMT device (Windows or Linux).

## Prerequisites

* [Git](https://git-scm.com/downloads)
* [Go* Programming Language](https://golang.org/doc/install)

## Clone the RPC-Go Repository

1. Open a Terminal or Command Prompt and navigate to a directory of your choice for development:
   ``` bash
   git clone https://github.com/device-management-toolkit/rpc-go --branch v{{ repoVersion.rpc_go }}
   ```
  
2. Change to the cloned `rpc-go` directory:
   ``` bash
   cd rpc-go
   ```

## Build RPC

!!! tip "Flexible Deployment - RPC as a Library"  
    The RPC can be built as an executable file or as a library, which offers the flexibility of deploying in your management agent or client. [Read more about building RPC as a library here](./v2/libraryRPC.md).

1. Open a Terminal (Linux) or Powershell/Command Prompt **as Administrator** (Windows):

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

2. Confirm a successful build.

    RPC must run with elevated privileges. Commands require `sudo` on Linux or an Administrator Command Prompt on Windows.

    === "Linux"
        ``` bash
        sudo ./rpc version
        ```
    === "Windows"
        ``` bash
        .\rpc version
        ```        
    === "Docker (On Linux Host Only)"
        ``` bash
        sudo docker run --rm -it --device=/dev/mei0 rpc-go:latest version
        ```