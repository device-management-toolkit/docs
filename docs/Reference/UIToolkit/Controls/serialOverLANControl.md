
Not sure how to implement Serial Over LAN (SOL)? View the [UI Toolkit KVM Module Tutorial](../../../Tutorials/uitoolkitReact.md) for a step-by-step walkthrough of the prerequisites and instructions for implementing a React Control using the UI Toolkit.


## Add Serial Over LAN (SOL) Control

Use the following code snippet to add the SOL control to the React Application.
Open `src/App.tsx` and add the code shown below:

!!! note
    Change `deviceId` value to your device GUID, `mpsServer` value to your MPS server address, and pass in a valid JWT  for `authToken`.

``` typescript hl_lines="7 8 9"
import React from 'react'
import { Sol } from '@device-management-toolkit/ui-toolkit-react'

function App() {
  return (
    <div>
      <Sol deviceId="038d0240-045c-05f4-7706-980700080009" //Replace with AMT Device GUID
        mpsServer="https://localhost/mps/ws/relay" //Replace 'localhost' with Development System or MPS Server IP Address
        authToken="" // Replace with a valid JWT provided during login of MPS
      />
    </div>
  )
}

export default App
```

### Props

| Prop | Type | Required | Description |
| :--- | :--- | :------- | :---------- |
| `deviceId` | `string` | Yes | GUID of the Intel® AMT device |
| `mpsServer` | `string` | Yes | MPS server WebSocket relay URL |
| `authToken` | `string` | Yes | JWT authentication token |
| `containerClassName` | `string` | No | Custom CSS class for the outer container |
| `containerStyle` | `React.CSSProperties` | No | Inline styles for the outer container |
| `buttonClassName` | `string` | No | Custom CSS class for the connect/disconnect button |
| `buttonStyle` | `React.CSSProperties` | No | Inline styles for the connect/disconnect button |
| `xtermClassName` | `string` | No | Custom CSS class for the xterm terminal |
| `xtermStyle` | `React.CSSProperties` | No | Inline styles for the xterm terminal |

### Customizing Styles

{% raw %}
``` typescript
<Sol deviceId={deviceId} mpsServer={mpsServer} authToken={authToken}
  containerStyle={{ padding: '10px' }}
  buttonStyle={{
    padding: '10px 20px',
    color: '#fff',
    backgroundColor: '#007bff',
    border: 'none',
    borderRadius: '4px',
    cursor: 'pointer'
  }}
  xtermStyle={{ border: '1px solid #ccc', borderRadius: '4px' }}
/>
```
{% endraw %}

??? note "v4 (Legacy)"

    ``` javascript
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

    export default App;
    ```
