
# Getting Started

## Installation

To integrate the UI Toolkit controls into your React application, add the package as a dependency:

``` bash
npm install @device-management-toolkit/ui-toolkit-react
```

## Usage

Import the components you need and add them to your application. Each component requires a `deviceId`, `mpsServer`, and `authToken`.

``` typescript
import { KVM, Sol, AttachDiskImage } from '@device-management-toolkit/ui-toolkit-react'
```

!!! note
    The `authToken` requires a valid redirection JWT. [See the `/authorize/redirection/{guid}` GET API.](../../APIs/indexMPS.md){target=_blank}

The `mpsServer` prop expects the WebSocket relay URL. The format depends on your MPS setup:

| Setup | Relay URL |
| :---- | :-------- |
| HTTPS (with Kong) | `https://<your-server>/mps/ws/relay` |
| HTTP (standalone) | `http://<your-server>:<port>/relay` |

## Controls

For usage, props, and styling options, see the individual control reference pages:

- [Keyboard, Video, Mouse (KVM)](Controls/kvmControl.md)
- [Serial Over LAN (SOL)](Controls/serialOverLANControl.md)
- [IDE Redirection (IDER)](Controls/ideRedirectionControl.md)

## Example Application

An example application is included in the repository for quick testing. See the [UI Toolkit React Tutorial](../../Tutorials/uitoolkitReact.md) for setup instructions.
