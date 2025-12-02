--8<-- "References/abbreviations.md"

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