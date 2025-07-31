--8<-- "References/abbreviations.md"

1. In the Console UI, navigate to the **Devices** page in the left-hand menu sidebar.

2. In the upper-right, select **Add a Device**.

    <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\Console_AddDevices.png" alt="Figure 1: Add a New Device">
        <figcaption>Figure 1: Add a New Device</figcaption>
    </figure>

3. Enter the **Hostname** of the device.

4. Choose a **Friendly Name** of your choice. This provides a more user-friendly way to refer to the device.

5. Enter **admin** as the **Username**.

6. Enter the **AMT Password** of the device set during activation.

7. For AMT devices configured to use TLS, select the **Use TLS** checkbox and **Allow Self-Signed Certificates** checkbox.

    ??? tip "Important - TLS Requirement for AMT 16.1 and newer devices"
        Starting with AMT 16.1, TLS is required. By default, the AMT device will come with a self-signed TLS certificate as part of the firmware. By selecting both the **Use TLS** and **Allow Self-Signed Certificates** checkboxes, AMT will utilize the built-in TLS certificate. *This is the recommended path for Getting Started as it requires less initial setup*.

        To use a different TLS certificate, such as a 3rd party CA signed certificate, Enterprise Assistant is required. See the [Enterprise Assistant Overview](../../Reference/EA/overview.md) and [Enterprise Assistant TLS Configuration with RPC-Go](../../Reference/EA/RPCConfiguration/localtlsconfig.md) documentation for additional details.

    !!! note "Note - Not Sure of the AMT Version?"
        If the AMT version is not known, the RPC-Go `amtinfo` command can be used. This will print out the device's AMT version as part of the response.

        ```
        rpc amtinfo
        ```

8. Click **Submit**.

    !!! example "Example - Add a New Device"
        <figure class="figure-image">
            <img width=600 src="..\..\..\assets\images\screenshots\Console_AddDevice_Full.png" alt="Figure 2: Add a New Device Example">
            <figcaption>Figure 2: Add a New Device Example</figcaption>
        </figure>

## Next up

[**Manage a Device**](manageDevice.md)