
Not sure how to implement Keyboard, Video Mouse (KVM)? View the [UI Toolkit KVM Module Tutorial](../../../Tutorials/uitoolkitReact.md) for a step-by-step walkthrough prerequisites and instructions for implementing a React Control using the UI Toolkit.

## Add KVM Control

Use the following code snippet to add the KVM control to the React Application.
Open `src/App.tsx` and add the code shown below:

!!! note
    Change `deviceId` value to your device GUID, `mpsServer` value to your MPS server address, and pass in a valid JWT  for `authToken`.

``` typescript hl_lines="8 9 11"
import React from 'react'
import { KVM } from '@device-management-toolkit/ui-toolkit-react'

function App() {
  return (
    <div>
      <KVM deviceId="038d0240-045c-05f4-7706-980700080009" //Replace with AMT Device GUID
        mpsServer="https://localhost/mps/ws/relay" //Replace 'localhost' with Development System or MPS Server IP Address
        mouseDebounceTime={200}
        authToken="" // Replace with a valid JWT provided during login of MPS
        canvasHeight="100%"
        canvasWidth="100%"
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
| `autoConnect` | `boolean` | No | When `true`, hides the header and auto-connects on mount |
| `mouseDebounceTime` | `number` | Yes | Mouse movement debounce time in milliseconds |
| `canvasHeight` | `string` | Yes | Canvas height (CSS value, e.g. `'100%'`, `'480px'`) |
| `canvasWidth` | `string` | Yes | Canvas width (CSS value, e.g. `'100%'`, `'640px'`) |
| `containerClassName` | `string` | No | Custom CSS class for the outer container |
| `containerStyle` | `React.CSSProperties` | No | Inline styles for the outer container |
| `connectButtonClassName` | `string` | No | Custom CSS class for the connect/disconnect button |
| `connectButtonStyle` | `React.CSSProperties` | No | Inline styles for the connect/disconnect button |
| `canvasClassName` | `string` | No | Custom CSS class for the canvas element |
| `canvasStyle` | `React.CSSProperties` | No | Inline styles for the canvas element |

### Customizing Styles

{% raw %}
``` typescript
<KVM deviceId={deviceId} mpsServer={mpsServer} authToken={authToken}
  mouseDebounceTime={200} canvasHeight="480px" canvasWidth="100%"
  containerStyle={{ padding: '10px' }}
  connectButtonStyle={{
    padding: '10px 20px',
    color: '#fff',
    backgroundColor: '#007bff',
    border: 'none',
    borderRadius: '4px',
    cursor: 'pointer'
  }}
  canvasStyle={{ border: '1px solid #ccc', borderRadius: '4px' }}
/>
```
{% endraw %}

??? note "v4 (Legacy)"

    ``` javascript
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
