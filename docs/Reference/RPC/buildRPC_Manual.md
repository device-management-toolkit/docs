--8<-- "References/abbreviations.md"

Developed in Go* programming language, the Remote Provisioning Client (RPC) application runs on the managed device and communicates with the Remote Provisioning Server (RPS) microservice on the development system. The RPC and RPS configure and activate Intel® AMT on the managed device. Once properly configured, the remote managed device can call home to the Management Presence Server (MPS) by establishing a Client Initiated Remote Access (CIRA) connection with the MPS. See Figure 1.

!!! tip "Production Environment"
        In a production environment, RPC can be deployed with an in-band manageability agent to distribute it to the fleet of AMT devices. The in-band manageability agent can invoke RPC to run and activate the AMT devices.

<figure class="figure-image">
<img src="..\..\..\assets\images\RPC_Overview.png" alt="Figure 1: RPC Configuration">
<figcaption>Figure 1: RPC Configuration</figcaption>
</figure>

!!! note "Figure 1 Details"
    The RPC on a managed device communicates with the Intel® Management Engine Interface (Intel® MEI, previously known as HECI) Driver and the Remote Provisioning Server (RPS) interfaces. The Driver uses the Intel® MEI to talk to Intel® AMT. The RPC activates Intel® AMT with an AMT profile, which is associated with a CIRA configuration (Step 3). The profile, which also distinguishes between Client Control Mode (CCM) or Admin Control Mode (ACM), and configuration were created in [Create a CIRA Config](../../GetStarted/createCIRAConfig.md) or [Create an AMT Profile](../../GetStarted/createProfileACM.md). After running RPC with a profile, Intel® AMT will establish a CIRA connection with the MPS (Step 4) allowing MPS to manage the remote device and issue AMT commands (Step 5).

## Prerequisites
**Before installing and building the RPC, install:**

* [Go* Programming Language](https://golang.org/doc/install)

## Get RPC

**To clone the repository:**

1. Open a Terminal or Command Prompt and navigate to a directory of your choice for development:
   ``` bash
   git clone https://github.com/open-amt-cloud-toolkit/rpc-go --branch v{{ repoVersion.rpc_go }}
   ```
  
2. Change to the cloned `rpc-go` directory:
   ``` bash
   cd rpc-go
   ```

## Build RPC

!!! tip "Flexible Deployment - RPC as a Library"  
        The RPC can be built as an executable file or as a library, which offers the flexibility of deploying in your management agent or client. [Read more about building RPC as a library here](./libraryRPC.md).

**To build the executable:**

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

2. Confirm a successful build:

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

## Run RPC to Activate and Connect the AMT Device

The toolkit provides a reference implementation called the Sample Web UI to manage the device. After running device activation instructions below, your device will be listed on the **Devices** tab in the Sample Web UI. 

**To run the application and connect the managed device:**

1. After building the RPC, copy the executable to the managed device.
   
2. On the managed device, open a Terminal (Linux) or Powershell/Command Prompt **as Administrator** (Windows).

3. Navigate to the directory containing the RPC application. 

4. Running RPC with the **activate** command configures or *provisions* Intel® AMT. It will take 1-2 minutes to finish provisioning the device. 
     In the instruction below:

    - Replace **[Development-IP-Address]** with the development system's IP address, where the MPS and RPS servers are running.
    - Replace **[profile-name]** with your created profile in the Sample Web UI. The RPC application command line parameters are case-sensitive.

    === "Linux"
        ``` bash
        sudo ./rpc activate -u wss://[Development-IP-Address]/activate -n --profile [profilename]
        ```
    === "Windows"
        ```
        .\rpc activate -u wss://[Development-IP-Address]/activate -n --profile [profilename]
        ```        
    === "Docker (On Linux Host Only)"
        ``` bash
        sudo docker run --rm -it --device=/dev/mei0 rpc-go:latest activate -u wss://[Development-IP-Address]/activate -n --profile [profilename]
        ```

    !!! note "Note - RPC Arguments"
        Find out more information about the [flag and other arguments](./commandsRPC.md).


    !!! success
        Example Output after Activating and Configuring a device into ACM:
        <figure class="figure-image">
        <img src="..\..\..\assets\images\RPC_Success.png" alt="Figure 1: RPC Success">
        <figcaption>Figure 1: RPC Success</figcaption>
        </figure>

    !!! error "Troubleshooting"
        Run into an issue? Try these [troubleshooting steps](../troubleshooting.md).
         
## Transition Activated Device

If an Intel vPro® Platform has been previously activated, either in the BIOS or with another management solution or tool, it can be brought under Open AMT Cloud Toolkit control with the rpc-go application. 

Additionally, use the following instructions to transition from a previously established toolkit stack to a fresh installation on a new development system.

!!! Note
    Use the following instructions to transition devices to either ACM or CCM profiles. You will need the AMT password.
    
    Open AMT Cloud Toolkit increases security with multiple passwords. Find an explanation of toolkit passwords in [Reference -> Architecture Overview](../architectureOverview.md#Passwords).

**To transition the activated device:**

1. Check the activation status with **amtinfo** flag:

    === "Linux"
        ``` bash
        sudo ./rpc amtinfo
        ```
    === "Windows"
        ```
        .\rpc amtinfo
        ```        
    === "Docker (On Linux Host Only)"
        ``` bash
        sudo docker run --rm -it --device=/dev/mei0 rpc-go:latest amtinfo
        ```
    
    The **control mode** indicates the managed device's state:

    - pre-provisioning or deactivated
    - activated in client control mode (CCM)
    - activated in admin control mode (ACM)

2. Run the rpc-go application with the **activate** command and the **password** flag:

    === "Linux"
        ``` bash
        sudo ./rpc activate -u wss://[Development-IP-Address]/activate -n -profile [profilename] -password [AMT password]
        ```
    === "Windows"
        ```
        .\rpc activate -u wss://[Development-IP-Address]/activate -n -profile [profilename] -password [AMT password]
        ```        
    === "Docker (On Linux Host Only)"
        ``` bash
        sudo docker run --rm -it --device=/dev/mei0 rpc-go:latest activate -u wss://[Development-IP-Address]/activate -n -profile [profilename] -password [AMT password]
        ```

    !!! success
        To verify the managed devices list after transitioning, log into the [Sample Web UI](../../GetStarted/loginToUI.md) on the development system. Go to the Devices tab. Alternatively, learn how to list the managed devices via a [REST API Call](../../Tutorials/apiTutorial.md). 
