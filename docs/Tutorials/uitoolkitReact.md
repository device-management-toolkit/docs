
# Add MPS UI Toolkit Controls to a WebUI

The UI Toolkit allows developers to add manageability features to a console with prebuilt React components. The code snippets simplify the task of adding complex manageability UI controls, such as Keyboard, Video, Mouse (KVM), Serial Over LAN (SOL), and IDE Redirection (IDER). An example web application is provided for testing.

The tutorial outlines how to test the UI Toolkit controls using the included example application and how to integrate them into your own React application.

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

Follow the steps in these sections sequentially:

- Test the React library with the included example application
- Add UI Toolkit controls to your own React application

<figure class="figure-image">
<img src="..\..\assets\images\diagrams\UIToolkit.svg" style="height:800px" alt="Figure 1: UI Toolkit">
<figcaption>Figure 1: UI toolkit</figcaption>
</figure>

## Test the React Library with the Example App

An example application is included within the library for quick testing and development. Use it to verify your setup and explore the available controls before integrating them into your own application.

1. Clone the repository:

    ``` bash
    git clone https://github.com/device-management-toolkit/ui-toolkit-react.git --branch v{{ repoVersion.ui_toolkit_react }}
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

4. Open a Chromium-based browser and navigate to the local dev server URL (default: `http://localhost:5173`).

5. Enter the following details in the configuration panel:

    | Field       | Value   |
    | :---------- | :------ |
    | MPS Server  | Your MPS server URL (e.g. `http://localhost:8181` or `https://your-server`) |
    | Device GUID | GUID of the Intel® AMT device connected to MPS |
    | Username    | MPS username |
    | Password    | MPS password |

6. Click **Authenticate** to connect. The example app handles the authentication flow automatically — it obtains an access token from the MPS `/authorize` API and then fetches a redirection token for the device.

7. Once authenticated, use the tabs to test each control:

    - **KVM (Remote Desktop)** — View and control the remote device's screen using keyboard and mouse.
    - **SOL (Serial Over LAN)** — Interact with the device via a serial terminal.
    - **IDER (IDE Redirection)** — Attach and mount a disk image (ISO/IMG) to the remote device.

    !!! success
        <figure class="figure-image">
        <img src="../../assets/images/screenshots/UI_Toolkit_React_Test_Application.png" alt="Figure 3: UI Toolkit React Test Application">
        <figcaption>Figure 3: UI Toolkit React Test Application</figcaption>
        </figure>

## Add UI Toolkit to Your Application

To integrate the UI Toolkit controls into your own React application, add the package as a dependency:

``` bash
npm install @device-management-toolkit/ui-toolkit-react@{{ repoVersion.ui_toolkit_react }}
```

### Add KVM Control

Import the KVM component and add it to your application:

!!! note
    Replace `deviceId` with your device GUID, `mpsServer` with your MPS server relay URL, and `authToken` with a valid redirection JWT. [See the `/authorize/redirection/{guid}` GET API.](../APIs/indexMPS.md){target=_blank}

``` typescript
import { KVM } from '@device-management-toolkit/ui-toolkit-react'

<KVM
  deviceId="4c4c4544-005a-3510-8047-b4c04f564433"
  mpsServer="https://localhost/mps/ws/relay"
  authToken=""
  autoConnect
  mouseDebounceTime={200}
  canvasHeight='480px'
  canvasWidth='100%'
/>
```

For the full list of KVM props and styling options, see the [KVM Control Reference](../Reference/UIToolkit/Controls/kvmControl.md).

### Add Other Controls

- **Serial Over LAN (SOL)** — See the [SOL Control Reference](../Reference/UIToolkit/Controls/serialOverLANControl.md)
- **IDE Redirection (IDER)** — See the [IDER Control Reference](../Reference/UIToolkit/Controls/ideRedirectionControl.md)

## Troubleshooting

### Page will not load

- Ensure using a Chromium-based browser (Chrome, Microsoft Edge, Firefox)
- Compilation errors: verify that the ui-toolkit-react npm package was downloaded and installed to the `my-app` directory, not another directory.


### `Connect KVM` Button does not Work

- Is MPS running?
- Is the AMT device connected to MPS?
- Was the self-signed certificate accepted? Navigate to the Sample Web UI in a new tab in the same browser and accept the self-signed certificate. Then, return to the React tab and refresh.
- Verify the redirection JWT token is still valid and not expired. Update if needed. Default expiration time is 5 minutes.
- Incorrect or invalid JWT for authToken, see [MPS API Documentation for `/authorize/redirection` API](../APIs/indexMPS.md){target=_blank}. **This is a different token and API call from the login token `/authorize` API.**

    !!! example "Example authToken Format from `/authorize/redirection` API Call"

        ```json
        {
            "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI5RW1SSlRiSWlJYjRiSWVTc21nY1dJanJSNkh5RVRxYyIsImV4cCI6MTYyMDE2OTg2NH0.GUib9sq0RWRLqJ7JpNNlj2AluuROLICCfdZaQzyWy90"
        }
        ```

## Migration from v4

If you are upgrading from UI Toolkit React v4, see the [Migration Guide](../Reference/UIToolkit/migration.md) for a complete list of breaking changes including import paths, styling, build system, i18n, and removed dependencies.

## v4 (Legacy)

??? note "v4 Documentation (click to expand)"

    ### Create a New React App (v4)

    ``` bash
    npx create-react-app my-app
    cd my-app
    ```

    ### Install UI Toolkit (v4)

    ``` bash
    npm install @device-management-toolkit/ui-toolkit-react@4
    npm start
    ```

    ### Add KVM and IDER Controls (v4)

    1. Open `./my-app/src/App.js` in a text editor or IDE of choice, such as Visual Studio Code or Notepad.

    2. Delete the existing code and replace it with the code snippet below.

    3. Change the following values:

        | Field       |  Value   |
        | :----------- | :-------------- |
        | `deviceId` | **Replace the example deviceId** value with the GUID of the Intel® AMT device.  See [How to Find GUIDs in Intel® AMT](../Reference/guids.md). |
        | `mpsServer` | **Replace the localhost** with the IP Address or FQDN of your MPS Server. <br><br> **When using Kong**, `/mps/ws/relay` must be appended to the IP or FQDN. |
        | `authToken` | **Provide a redirection-specific JWT authentication token. This is different from the `/authorize` login token.** [See the `/authorize/redirection/{guid}` GET API in the Auth section.](../APIs/indexMPS.md){target=_blank} |

        ``` javascript
        import React from "react"
        import "./App.css"
        import { KVM } from "@device-management-toolkit/ui-toolkit-react/reactjs/src/kvm.bundle";
        import { AttachDiskImage } from "@device-management-toolkit/ui-toolkit-react/reactjs/src/ider.bundle";

        function App() {
          const deviceGUID = '4c4c4544-005a-3510-8047-b4c04f564433' //Replace with AMT Device GUID
          const mpsAddress = 'https://localhost/mps/ws/relay' //Replace 'localhost' with MPS Server IP Address or FQDN
          const auth = '' // Replace with a valid JWT token from 'Authorize Redirection' GET API Method
          return (
            <div className="App">
              <React.Fragment>
                <AttachDiskImage deviceId={deviceGUID}
                  mpsServer={mpsAddress}
                  authToken={auth}
                />
                <KVM autoConnect={false}
                  deviceId={deviceGUID}
                  mpsServer={mpsAddress}
                  authToken={auth}
                  mouseDebounceTime={200}
                  canvasHeight={'100%'} canvasWidth={'100%'} />
              </React.Fragment>
            </div>
          );
        }

        export default App
        ```

    4. Save and close the file.

    5. If the React app hasn't updated automatically, refresh the page.

        !!! success
            <figure class="figure-image">
            <img src="..\..\assets\images\screenshots\UIToolkit_react_success.png" alt="Successful KVM Connection">
            <figcaption>Successful KVM Connection</figcaption>
            </figure>

    ### Add SOL Control (v4)

    ``` javascript
    import React from "react";
    import { Sol } from "@device-management-toolkit/ui-toolkit-react/reactjs/src/sol.bundle";

    function App() {
      return (
        <div>
          <Sol deviceId="038d0240-045c-05f4-7706-980700080009"
            mpsServer="https://localhost/mps/ws"
            authToken="">
          </Sol>
        </div>
      );
    }

    export default App;
    ```

    ### Webpack Configuration (v4)

    For custom Webpack bundling instructions, see the [Webpack Configuration Guide](../Reference/UIToolkit/webpackConfig.md).

    ### License Note (v4)

    If you are distributing the FortAwesome Icons, please provide attribution to the source per the [CC-by 4.0](https://creativecommons.org/licenses/by/4.0/deed.ast) license obligations.

<br>

## Next Steps

### Try Other Controls

Try out other React controls such as [Serial Over LAN](../Reference/UIToolkit/Controls/serialOverLANControl.md).

### Customize and Create Bundles

Try out creating and customizing React bundles for things such as Serial Over LAN or KVM [here](../Reference/UIToolkit/Bundles/kvmReact.md).
