--8<-- "References/abbreviations.md"
Not sure how to implement Serial Over LAN (SOL)? View the [UI Toolkit KVM Module Tutorial](../../../Tutorials/uitoolkitReact.md) for a step-by-step walkthrough of the prerequisites and instructions for implementing a React Control using the UI Toolkit.


## Add Serial Over LAN (SOL) Control

Use the following code snippet to add the SOL control to the React Application.
Open `src/App.js` and add the code shown below:

!!! note
    Change `deviceId` value to your device GUID, `mpsServer` value to your MPS server address, and pass in a valid JWT  for `authToken`.

``` javascript hl_lines="7 8 9"
import React from "react";
import { Sol } from "@device-management-toolkit/ui-toolkit-react/reactjs/src/sol.bundle";

function App() {
  return (
    <div>
        <Sol deviceId="038d0240-045c-05f4-7706-980700080009"//Replace with AMT Device GUID
        mpsServer="https://localhost/mps/ws" //Replace 'localhost' with Development System or MPS Server IP Address
        authToken=""> // Replace with a valid JWT provided during login of MPS
        </Sol>
    </div>
  );
}
​
export default App;
```