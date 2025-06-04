--8<-- "References/abbreviations.md"
Not sure how to implement Keyboard, Video Mouse (KVM)? View the [UI Toolkit KVM Module Tutorial](../../../Tutorials/uitoolkitReact.md) for a step-by-step walkthrough prerequisites and instructions for implementing a React Control using the UI Toolkit.

## Add KVM Control

Use the following code snippet to add the KVM control to the React Application.
Open `src/App.js` and add the code shown below:

!!! note
    Change `deviceId` value to your device GUID, `mpsServer` value to your MPS server address, and pass in a valid JWT  for `authToken`.

``` javascript hl_lines="8 9 11"
    import React from "react";
    import "./App.css";
    import { KVM } from "@device-management-toolkit/ui-toolkit-react/reactjs/src/kvm.bundle";

    function App() {
        return (
            <div className="App">
                <KVM deviceId="038d0240-045c-05f4-7706-980700080009" //Replace with AMT Device GUID
                mpsServer="https://localhost/mps/ws/relay" //Replace 'localhost' with Development System or MPS Server IP Address
                mouseDebounceTime="200"
                authToken="" // Replace with a valid JWT provided during login of MPS
                canvasHeight="100%"
                canvasWidth="100%"></KVM>
            </div>
        );
    }

export default App;
```