
Not sure how to implement IDE Redirection (IDER)? View the [UI Toolkit React Tutorial](../../../Tutorials/uitoolkitReact.md) for a step-by-step walkthrough of the prerequisites and instructions for implementing a React Control using the UI Toolkit.


## Add IDE Redirection (IDER) Control

Use the following code snippet to add the IDER control to the React Application.
Open `src/App.tsx` and add the code shown below:

!!! note
    Change `deviceId` value to your device GUID, `mpsServer` value to your MPS server address, and pass in a valid JWT  for `authToken`.

{% raw %}
``` typescript
import { AttachDiskImage } from '@device-management-toolkit/ui-toolkit-react'

<AttachDiskImage
  deviceId="4c4c4544-005a-3510-8047-b4c04f564433"
  mpsServer="https://localhost/mps/ws/relay"
  authToken=""
  fileSelectLabel="Browse ISO/IMG"
  noFileSelectedLabel="No file selected"
  containerClassName=""
  containerStyle={{
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    gap: '10px',
    padding: '20px',
    border: '1px solid #ccc',
    borderRadius: '4px'
  }}
  buttonClassName=""
  buttonStyle={{
    padding: '10px 40px',
    fontSize: '14px',
    fontWeight: 'bold',
    color: '#fff',
    backgroundColor: '#007bff',
    border: 'none',
    borderRadius: '4px',
    cursor: 'pointer'
  }}
  fileSelectClassName=""
  fileSelectStyle={{
    padding: '8px 16px',
    fontSize: '14px',
    color: '#fff',
    backgroundColor: '#6c757d',
    border: 'none',
    borderRadius: '4px',
    cursor: 'pointer'
  }}
  fileNameClassName=""
  fileNameStyle={{ fontSize: '14px', color: '#333' }}
/>
```
{% endraw %}

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
