--8<-- "References/abbreviations.md"

<div style="text-align:center;">
  <iframe width="600" height="337" src="https://www.youtube.com/embed/NyOO3QrD7_c" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  <figcaption><b>Getting Started Part 4</b>: Follow along to learn about the different Out-of-Band capabilities of Intel AMT. <b>Next Steps: </b><a href="../../../Tutorials/apiTutorial">Using REST APIs</a> and <a href="../../../Tutorials/Scaling/overview">Deploying with Kubernetes</a></figcaption>
</div>

## Try out Intel AMT Capabilities

1. Go back to the Sample Web UI on your development system.
	
2. Click the Devices tab from the menu on the left.
     <figure class="figure-image">
     <img src="..\..\..\assets\images\screenshots\MPS_ConnectedDevice.png" alt="Figure 1: Devices tab">
     <figcaption>Figure 1: Devices tab</figcaption>
     </figure>

    !!! troubleshooting
        If the activated device is not listed or if it is listed as unconnected, try restarting the AMT device. After successfully restarting the device, refresh the Sample Web UI to see if the *Status* changes to *connected*.

        [Additional troubleshooting steps.](../../Reference/troubleshooting.md)

3. Click on your connected device.

4. Select an action to perform from the Power Actions in the center screen or Redirection options in the top-right.

    !!! warning "Warning - Power Actions in KVM"
        Turn off active redirection sessions, such as KVM or SOL, before specific power state transitions. Power Cycle (Code 5) and Unconditional Power Down (Power Off, Code 8) will be rejected as invalid if there is an active redirection session. Reset (Code 10) **will function** in KVM along with the [other unmentioned Power Actions](../../Reference/powerstates.md#out-of-band).

     <figure class="figure-image">
     <img src="..\..\..\assets\images\screenshots\MPS_ManageDevice.png" alt="Figure 2: Action options">
     <figcaption>Figure 2: Action options</figcaption>
     </figure>

### User Consent

  If activated in Client Control Mode(CCM), the keyboard, video, mouse (KVM), serial-over-LAN (SOL), and IDE-Redirect (IDER) features require entering a user consent code, which will be displayed on the managed device.
        
  To use KVM/SOL without user consent, follow the [ACM Activation Path](createProfileACM.md) for how to configure a device into Admin Control Mode.

  1. When performing a KVM action for a device activated in CCM or ACM with user consent enabled, input the user consent code displayed on the client device.

    <figure class="figure-image">
    <img src="..\..\..\assets\images\screenshots\MPS_UserConsent.png" alt="Figure 2: User    Consent">
    <figcaption>Figure 3: User Consent</figcaption>
    </figure>

<br>

## Next steps

After successfully deploying the Device Management Toolkit microservices and client, explore other tools and topics in the Device Management Toolkit architecture:

### REST API Calls
Learn how to send commands to AMT devices with the curl-based REST API tutorial. Generate a JWT token for Authorization and construct an API call to get a list of devices. 

[Get Started with REST API Calls](../../Tutorials/apiTutorial.md){: .md-button .md-button--primary }

### UI Toolkit
Explore how to add redirection features, such as Keyboard, Video, and Mouse (KVM) and IDE-Redirect (IDER), with prebuilt React components.

[Get Started with the UI Toolkit](../../Tutorials/uitoolkitReact.md){: .md-button .md-button--primary }

### Security
Learn how to use the Device Management Toolkit architecture to secure ..\assets. Topics include credentials, allowlisting, best known security methods, and more.

[Learn More about Security and Hardening](../../Reference/MPS/securityMPS.md){: .md-button .md-button--primary }


