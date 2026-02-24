
Not sure how to implement Serial Over LAN (SOL)? View the [UI Toolkit KVM Module Tutorial](../../../Tutorials/uitoolkitReact.md) for a step-by-step walkthrough of the prerequisites and instructions for implementing a React Control using the UI Toolkit.


## Add Serial Over LAN (SOL) Control

Use the following code snippet to add the SOL control to the React Application.
Open `src/App.tsx` and add the code shown below:

!!! note
    Change `deviceId` value to your device GUID, `mpsServer` value to your MPS server address, and pass in a valid JWT  for `authToken`.

{% raw %}
``` typescript
import { Sol } from '@device-management-toolkit/ui-toolkit-react'

<Sol
  deviceId="4c4c4544-005a-3510-8047-b4c04f564433"
  mpsServer="https://localhost/mps/ws/relay"
  authToken=""
  containerClassName=""
  containerStyle={{ padding: '10px' }}
  buttonClassName=""
  buttonStyle={{
    padding: '10px 20px',
    fontSize: '14px',
    fontWeight: 'bold',
    color: '#fff',
    backgroundColor: '#007bff',
    border: 'none',
    borderRadius: '4px',
    cursor: 'pointer'
  }}
  xtermClassName=""
  xtermStyle={{ border: '1px solid #ccc', borderRadius: '4px' }}
/>
```
{% endraw %}

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
