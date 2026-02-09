
# Quickstart - Serial Over LAN (SOL) Control

## Using the SOL Control

The SOL control is available as a named export from the UI Toolkit React package.

### Prerequisites

- [Git](https://git-scm.com/)
- [Visual Studio Code](https://code.visualstudio.com/) or any other IDE
- [Node.js](https://nodejs.org/)
- [Chrome* Browser](https://www.google.com/chrome)
- [MPS Server with an AMT Device Connected](../../../GetStarted/Cloud/prerequisites.md)

### Install

``` bash
npm install @device-management-toolkit/ui-toolkit-react@{{ repoVersion.ui_toolkit_react }}
```

### Usage

``` typescript
import React from 'react'
import { Sol } from '@device-management-toolkit/ui-toolkit-react'

function App() {
  return (
    <Sol deviceId="[AMT-Device-GUID]"
      mpsServer="https://[MPS-Server-IP-Address]/mps/ws/relay"
      authToken="[JWT-Token]"
    />
  )
}

export default App
```

### Run in Development Environment

1. Start the Vite dev server:
	```
	npm run dev
	```

2. Open a Chrome* browser and navigate to the local dev server URL (default: `http://localhost:5173`).

### Build for Production

The package ships as ESM and CJS modules. No custom bundling configuration is needed.

``` bash
npm run build
```

Build outputs:

- **ESM**: `dist/index.esm.js`
- **CJS**: `dist/index.cjs.js`
- **Types**: `dist/index.d.ts`

Errors may occur in the following scenarios:

- UI-toolkit was not downloaded and installed into your react app
- MPS Server is not running
- MPS Server is running but the device is not connected

??? note "v4 (Legacy) - Webpack Bundle Approach"

    In v4, the SOL control was distributed as a separate webpack bundle.

    ### Download and Install UI Toolkit (v4)

    1. Clone the UI-Toolkit Repository:
    	```
    	git clone https://github.com/device-management-toolkit/ui-toolkit --branch v{{ repoVersion.ui_toolkit_react }}
    	```

    2. Change to the `ui-toolkit` directory and install dependencies:
    	```
    	cd ui_toolkit
    	npm install
    	```

    ### Run in Development Environment (v4)

    1. Start the webpack dev server:
    	```
    	npm start
    	```

    2. Open a Chrome* browser and navigate to:
    	```
    	http://localhost:8080/sol.htm?deviceId=[AMT-Device-GUID]&mpsServer=https://[MPS-Server-IP-Address]:3000
    	```

    ### Create Bundle (v4)

    1. Remove or rename the existing *sol.min.js* in the `ui-toolkit/dist/` directory before building.

    2. Build the bundle:
    	```
    	npm run build
    	```

    ### Add to Sample HTML Page (v4)

    ```html
    <body>
      <div id="sol"></div>
      <script src="../../dist/sol.min.js" crossorigin></script>
    </body>
    ```
