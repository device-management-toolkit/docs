--8<-- "References/abbreviations.md"

If an Intel vPro® Platform has been previously activated, either in the BIOS or with another management solution or tool, it can be brought under Device Management Toolkit control with the RPC-Go application. 

Additionally, use the following instructions to transition from a previously established toolkit stack to a fresh installation on a new development system.

!!! Note "Note - Passwords used in Device Management Toolkit"
    Use the following instructions to transition devices to either ACM or CCM profiles. You will need the AMT password.
    
    Device Management Toolkit increases security with multiple passwords. Find an explanation of toolkit passwords in [Reference -> Architecture Overview](../architectureOverview.md#Passwords).

**To transition the activated device:**

1. Check the activation status with `amtinfo` command:

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

2. Run the rpc-go application with the `activate` command and the `-password` flag:

    === "Linux"
        ``` bash
        sudo ./rpc activate -u wss://[Development-IP-Address]/activate -n -profile [profileName] -password [AMTPassword]
        ```
    === "Windows"
        ```
        .\rpc activate -u wss://[Development-IP-Address]/activate -n -profile [profileName] -password [AMTPassword]
        ```        
    === "Docker (On Linux Host Only)"
        ``` bash
        sudo docker run --rm -it --device=/dev/mei0 rpc-go:latest activate -u wss://[Development-IP-Address]/activate -n -profile [profileName] -password [AMTPassword]
        ```

    !!! success
        To verify the managed devices list after transitioning, log into the [Sample Web UI](../../GetStarted/Cloud/loginToUI.md) on the development system. Go to the Devices tab. Alternatively, learn how to list the managed devices via a [REST API Call](../../Tutorials/apiTutorial.md). 
