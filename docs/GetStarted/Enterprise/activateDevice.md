

Developed in Go* programming language, the Remote Provisioning Client (RPC) application runs on the managed device. RPC-Go activates and configures Intel® AMT on the managed device. Once properly configured, the device can be added to Console.

## Download RPC

On the AMT device, download the latest RPC-Go version from the [RPC-Go GitHub Repo Releases Page](https://github.com/device-management-toolkit/rpc-go/releases) for the Operating System of the AMT device (Windows or Linux).

## Activate Device

1. On the AMT device, open a Terminal (Linux) or Powershell/Command Prompt **as Administrator** (Windows).

2. Navigate to the directory containing the RPC application.

3. Run RPC with the local **activate** command to activate and configure Intel® AMT using the `profile.yaml` and `configencryptionkey` generated in the export profile step:

    ```
    rpc activate -local -configv2 profileName.yaml -configencryptionkey w31W6548+eDZYziC97DnmkzaA4V4r4nC
    ```

4. After finishing successfully, the device can now be added and connected to using Console. 

!!! success
    <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\Console_DeviceActivation.png" alt="Figure 3: Example Successful Activation and Configuration">
        <figcaption>Figure 3: Example Successful Activation and Configuration</figcaption>
    </figure>

## Next up

[**Add a Device**](addDevice.md)