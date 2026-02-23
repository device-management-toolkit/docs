
# Add MPS UI Toolkit Controls to a WebUI

The UI Toolkit allows developers to add manageability features to a console with prebuilt React components. The code snippets simplify the task of adding complex manageability UI controls, such as Keyboard, Video, Mouse (KVM), Serial Over LAN (SOL), and IDE Redirection (IDER). An example web application is provided for testing.

The tutorial outlines how to run and test the UI Toolkit controls using the included example application. 

??? note "Note - Other Framework Technologies"
    This guide shows a basic example implementation using React. Other frameworks can be used using the UI-Toolkit like Angular and Vue.js.

    For an example implementation of Angular, see our [Sample Web UI codebase](https://github.com/device-management-toolkit/sample-web-ui/).

## What You'll Need

### Hardware

**Configure a network that includes:**

- A development system running Windows® 10 or Ubuntu* 22.04 or newer
- An Activated and Configured Intel® vPro device as the managed device

### Software

- [MPS](https://github.com/device-management-toolkit/MPS), the Management Presence Server
- [RPS](https://github.com/device-management-toolkit/RPS), the Remote Provisioning Server
- Intel&reg; vPro device, configured and connected to MPS

    !!! Note
        For instructions to setup the MPS and RPS servers to connect a managed device, see the [Get Started Guide](../GetStarted/Cloud/prerequisites.md)

- The **development system** requires the following software:
    - [git](https://git-scm.com/)
    - [Visual Studio Code](https://code.visualstudio.com/) or any other IDE
    - [Node.js](https://nodejs.org/)

## What You'll Do

- Clone and run the example application
- Authenticate with an MPS server
- Test KVM, SOL, and IDER controls

<figure class="figure-image">
<img src="..\..\assets\images\diagrams\UIToolkit.svg" style="height:800px" alt="Figure 1: UI Toolkit">
<figcaption>Figure 1: UI toolkit</figcaption>
</figure>

## Test the React Library with the Example App

An example application is included within the library for quick testing and development. Use it to verify your setup and explore the available controls before integrating them into your own application.

!!! note "Note"
    The steps below walk through setting up the example app, authenticating with MPS, and testing each control (KVM, SOL, IDER). Complete each step in order before proceeding to the next.

### Clone and Run the Example App

1. Clone the repository:

    ``` bash
    git clone https://github.com/device-management-toolkit/ui-toolkit-react.git
    cd ui-toolkit-react
    ```

2. Navigate to the example directory and install dependencies:

    ``` bash
    cd example
    npm install
    ```

3. Start the development server:

    ``` bash
    npm run dev
    ```

    By default, Vite runs on port `5173`. If port `5173` is already in use, Vite will automatically use the next available port.

    !!! success
        <figure class="figure-image">
        <img src="..\..\assets\images\screenshots\UIToolkit_vite_dev.png" alt="Figure 2: Vite dev server running successfully">
        <figcaption>Figure 2: Vite dev server running successfully</figcaption>
        </figure>

    !!! Note "Note - Live Reloading"
        When you make changes to the example app, you do not need to stop and restart. Vite will update and refresh automatically as you make code changes.

### Authenticate with MPS

1. Open a Chromium-based browser and navigate to the local dev server URL (default: `http://localhost:5173`).

2. Enter the following details in the configuration panel:

    | Field       | Value   |
    | :---------- | :------ |
    | MPS Server  | Your MPS server URL (e.g. `http://localhost:8181` or `https://your-server`) |
    | Device GUID | GUID of the Intel® AMT device connected to MPS |
    | Username    | MPS username |
    | Password    | MPS password |

3. Click **Authenticate** to connect. The example app handles the authentication flow automatically — it obtains an access token from the MPS `/authorize` API and then fetches a redirection token for the device.

### Test the Controls

Once authenticated, use the tabs to test each control:

#### KVM (Keyboard, Video, Mouse)

View and control the remote device's screen using keyboard and mouse.

1. Select the **KVM** tab.
2. Choose an encoding from the dropdown — **RLE8** or **RLE16**.
3. Click **Connect**. The button changes to *Connecting...* while the WebSocket session is established.
4. Once connected, the remote desktop appears on the canvas. Keyboard and mouse input is forwarded directly to the device.
5. To end the session, click **Disconnect**.

<figure class="figure-image">
<img src="../../assets/images/screenshots/UI_Toolkit_React_KVM.png" alt="Figure 3: KVM Control">
<figcaption>Figure 3: KVM Control</figcaption>
</figure>

#### SOL (Serial Over LAN)

Interact with the device via a serial terminal.

1. Select the **SOL** tab.
2. Click **Connect**. The button changes to *Connecting...* while the WebSocket session is established.
3. Once connected, reset the device to BIOS with SOL enabled by sending a Power Action via the MPS API:

    ```
    POST /api/v1/amt/power/bootOptions/{guid}
    ```

    ```json
    {
      "method": "PowerAction",
      "action": 101,
      "useSOL": true,
      "bootDetails": {}
    }
    ```

4. The terminal window displays the serial console output. All keyboard input is sent directly to the remote device.
5. To end the session, click **Disconnect**.

<figure class="figure-image">
<img src="../../assets/images/screenshots/UI_Toolkit_React_SOL.png" alt="Figure 4: SOL Control">
<figcaption>Figure 4: SOL Control</figcaption>
</figure>

#### IDER (IDE Redirection)

Attach and mount a disk image (ISO/IMG) to the remote device. The selected image is streamed over the network and virtually mounted as a CD/DVD drive on the remote device.

1. Select the **IDER** tab.
2. Click **Browse ISO/IMG** to open the file picker and select an `.iso` or `.img` disk image from your local machine.
3. The selected file name appears next to the button and the **Start** button becomes enabled.
4. Click **Start** to begin the redirection session. The image is streamed and mounted as a virtual CD/DVD drive on the remote device.
5. To end the session, click **Stop**. The virtual drive is unmounted and the connection is closed.

<figure class="figure-image">
<img src="../../assets/images/screenshots/UI_Toolkit_React_IDER.png" alt="Figure 5: IDER Control">
<figcaption>Figure 5: IDER session with netboot.xyz.iso attached</figcaption>
</figure>

Once mounted, the image appears as a drive on the remote device (e.g. `CD Drive (D:)`). The device can then boot from this image for tasks such as OS recovery or re-installation.

<figure class="figure-image">
<img src="../../assets/images/screenshots/UI_Toolkit_React_IDER_Mounted.png" alt="Figure 6: Mounted drive on remote device">
<figcaption>Figure 6: ISO mounted as CD Drive on the remote device</figcaption>
</figure>

## Troubleshooting

### Page will not load

- Ensure using a Chromium-based browser (Chrome, Microsoft Edge)
- Compilation errors: verify that dependencies were installed correctly by running `npm install` in the `example` directory.


### `Connect KVM` Button does not Work

- Is MPS running?
- Is the AMT device connected to MPS?
- Was the self-signed certificate accepted? Navigate to the Sample Web UI in a new tab in the same browser and accept the self-signed certificate. Then, return to the React tab and refresh.

## Next Steps

- [Getting Started](../Reference/UIToolkit/gettingStarted.md) — Add UI Toolkit controls to your own React application
- [Migration from v4 to v5](../Reference/UIToolkit/migration.md) — Breaking changes and upgrade guide
