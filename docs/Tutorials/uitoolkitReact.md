--8<-- "References/abbreviations.md"
# Add MPS UI Toolkit Controls to a WebUI

The UI Toolkit allows developers to add manageability features to a console with prebuilt React components. The code snippets simplify the task of adding complex manageability UI controls, such as Keyboard, Video, Mouse (KVM). A sample web application, based on React.js, is provided for test and development. 

The tutorial outlines how to add various controls to the sample React web application provided. Developers can use the sample code below as a springboard for developing their own consoles.

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
- [RPS](https://github.com/device-management-toolkit/RCS), the Remote Provisioning Server
- Intel&reg; vPro device, configured and connected to MPS

    !!! Note
        For instructions to setup the MPS and RPS servers to connect a managed device, see the [Get Started Guide](../GetStarted/Cloud/prerequisites.md)

- The **development system** requires the following software:
    - [git](https://git-scm.com/)
    - [Visual Studio Code](https://code.visualstudio.com/) or any other IDE
    - [Node.js](https://nodejs.org/)

## What You'll Do

Follow the steps in these sections sequentially: 

- Create a new React app
- Add UI controls to the React app

<figure class="figure-image">
<img src="..\..\assets\images\HelloWorld.png" alt="Figure 1: UI Toolkit">
<figcaption>Figure 1: UI toolkit</figcaption>
</figure>

## Create a New React App

The React app can be created in any preferred development directory.

1. In a Terminal or Command Prompt, go to your preferred development directory. 

2. Create a sample React app named `my-app`.

    ``` bash
    npx create-react-app my-app
    ```

3. Change to the `my-app` directory:

    ``` bash
    cd my-app
    ```

## Install UI Toolkit

1. Install the UI Toolkit and required dependencies.

    ``` bash
    npm install @device-management-toolkit/ui-toolkit-react@{{ repoVersion.ui_toolkit_react }}
    ```

2. Start the React web UI locally.

    ``` bash
    npm start
    ```

    By default, React apps run on port `3000`. If port `3000` is already used by the MPS server or any other application, you'll be prompted to use another port. If this happens, enter 'Y'.

    !!! success
        <figure class="figure-image">
        <img src="..\..\assets\images\UIToolkit_npmstart.png" alt="Figure 2: React reports successful deployment">
        <figcaption>Figure 2: React reports successful deployment</figcaption>
        </figure>

    !!! Note "Note - Using Chromium Browser and Refreshing"
        By default, React launches in your machine's default browser. However for best experience, navigate to the page using a Chromium based web browser.

        When you make changes, you do not need to stop the application and restart. It will update and refresh automatically as you make code changes.


## Add a Sample Control
The following sections outline how to add controls.  Refresh the web browser after adding a control if it does not update automatically after a few seconds.

### Add Keyboard, Video, Mouse (KVM) Redirection and IDE-Redirection (IDER)

The code snippet below adds both the KVM and IDER controls to the React application. 

1. Open `./my-app/src/App.js` in a text editor or IDE of choice, such as Visual Studio Code or Notepad.

2. Delete the existing code and replace it with the code snippet below.

3. Change the following values:

    | Field       |  Value   |
    | :----------- | :-------------- |
    | `deviceId` | **Replace the example deviceId** value with the GUID of the Intel® AMT device.  See [How to Find GUIDs in Intel® AMT](../Reference/guids.md). |
    | `mpsServer` | **Replace the localhost** with the IP Address or FQDN of your MPS Server. <br><br> **When using Kong**, `/mps/ws/relay` must be appended to the IP or FQDN. |
    | `authToken` | **Provide a redirection-specific JWT authentication token. This is different from the `/authorize` login token.** [See the `/authorize/redirection/{guid}` GET API in the Auth section.](../APIs/indexMPS.md){target=_blank} <br><br> For a general example on how to make an API call and how to get an auth token from `/authorize` to pass to `/authorize/redirection/{guid}`, see [Generating a JWT by using an Authorize API call](./apiTutorial.md#generate-a-jwt){target=_blank}. |


    ``` javascript hl_lines="7 8 9"
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

    You are now able to remotely control your Intel® AMT device using Keyboard, Video, Mouse control.

    !!! success
        <figure class="figure-image">
        <img src="..\..\assets\images\UIToolkit_react_success.png" alt="Figure 2: React reports successful deployment">
        <figcaption>Figure 3: Successful KVM Connection</figcaption>
        </figure>

## Troubleshooting

### Page will not load

- Insure using a Chromium-based browser (Chrome, Microsoft Edge, Firefox) 
- Compilation errors, verify that the ui-toolkit-react npm package was downloaded and installed to the `my-app` directory, not another directory.


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

<br>

## Next Steps

### Try Other Controls

Try out other React controls such as [Serial Over LAN](../Reference/UIToolkit/Controls/serialOverLANControl.md).

### Customize and Create Bundles

Try out creating and customizing React bundles for things such as Serial Over LAN or KVM [here](../Reference/UIToolkit/Bundles/kvmReact.md).


## License Note

If you are distributing the FortAwesome Icons, please provide attribution to the source per the [CC-by 4.0](https://creativecommons.org/licenses/by/4.0/deed.ast) license obligations.
