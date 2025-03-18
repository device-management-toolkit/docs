--8<-- "References/abbreviations.md"

## Try out Intel® AMT Capabilities

1. Select the newly added AMT device.

    <figure class="figure-image">
        <img src="..\..\..\assets\images\Console_Devices.png" alt="Figure 1: Devices Tab">
        <figcaption>Figure 1: Devices Tab</figcaption>
    </figure>

2. Select an action to perform from the Power Actions or Redirection options in the top-right.

    The right-hand navigation menu can be used to find additional device information, such as logs and hardware info, and out-of-band capabilities, such as KVM and Serial-Over-LAN.

    !!! warning "Warning - Power Actions in KVM"
        Turn off active redirection sessions, such as KVM or SOL, before specific power state transitions. Power Cycle (Code 5) and Unconditional Power Down (Power Off, Code 8) will be rejected as invalid if there is an active redirection session. Reset (Code 10) **will function** in KVM along with the [other unmentioned Power Actions](../../Reference/powerstates.md#out-of-band).
        

    <figure class="figure-image">
        <img src="..\..\..\assets\images\Console_DeviceInfo.png" alt="Figure 2: Device Page and Options">
        <figcaption>Figure 2: Device Page and Options</figcaption>
    </figure>

## Next steps

After successfully adding and managing devices using Console, explore other tools and next-level topics related to Console:

[Additional Resources](../../Reference/Console/overview.md#additional-resources){: .md-button .md-button--primary }