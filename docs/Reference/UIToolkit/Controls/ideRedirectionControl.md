
Not sure how to implement IDE Redirection (IDER)? View the [UI Toolkit React Tutorial](../../../Tutorials/uitoolkitReact.md) for a step-by-step walkthrough of the prerequisites and instructions for implementing a React Control using the UI Toolkit.


## Add IDE Redirection (IDER) Control

Use the following code snippet to add the IDER control to the React Application.
Open `src/App.tsx` and add the code shown below:

!!! note
    Change `deviceId` value to your device GUID, `mpsServer` value to your MPS server address, and pass in a valid JWT  for `authToken`.

``` typescript hl_lines="7 8 9"
import React from 'react'
import { AttachDiskImage } from '@device-management-toolkit/ui-toolkit-react'

function App() {
  return (
    <div>
      <AttachDiskImage deviceId="038d0240-045c-05f4-7706-980700080009" //Replace with AMT Device GUID
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
| `authToken` | `string` | No | JWT authentication token |
| `fileSelectLabel` | `string` | No | Custom label for the file select button (default: `'Choose File'`) |
| `noFileSelectedLabel` | `string` | No | Custom label when no file is selected (default: `'No file chosen'`) |
| `containerClassName` | `string` | No | Custom CSS class for the outer container |
| `containerStyle` | `React.CSSProperties` | No | Inline styles for the outer container |
| `buttonClassName` | `string` | No | Custom CSS class for the start/stop button |
| `buttonStyle` | `React.CSSProperties` | No | Inline styles for the start/stop button |
| `fileSelectClassName` | `string` | No | Custom CSS class for the file select button |
| `fileSelectStyle` | `React.CSSProperties` | No | Inline styles for the file select button |
| `fileNameClassName` | `string` | No | Custom CSS class for the file name display |
| `fileNameStyle` | `React.CSSProperties` | No | Inline styles for the file name display |

### Customizing Styles

{% raw %}
``` typescript
<AttachDiskImage deviceId={deviceId} mpsServer={mpsServer} authToken={authToken}
  containerStyle={{ padding: '10px' }}
  buttonStyle={{
    padding: '10px 20px',
    color: '#fff',
    backgroundColor: '#007bff',
    border: 'none',
    borderRadius: '4px',
    cursor: 'pointer'
  }}
  fileSelectStyle={{ backgroundColor: '#f0f0f0', border: '1px solid #ccc' }}
  fileNameStyle={{ color: '#666', fontStyle: 'italic' }}
/>
```
{% endraw %}

!!! note "Note - User Consent"
    Currently, the implementation of IDER in Device Management Toolkit does not support User Consent. In order to use IDER, the device must be activated in ACM. To see when support for User Consent will be added, [follow the Github Backlog](https://github.com/orgs/device-management-toolkit/projects/10).
