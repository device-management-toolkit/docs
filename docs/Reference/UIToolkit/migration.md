
# Migration from v4 to v5

If you are upgrading from UI Toolkit React v4, review the breaking changes below.

## Import Path Changes

The bundle-based import paths have been removed. Update all imports to use the main package export.

``` typescript
// v4 (old) - no longer works
import { KVM } from '@device-management-toolkit/ui-toolkit-react/reactjs/src/kvm.bundle'
import { Sol } from '@device-management-toolkit/ui-toolkit-react/reactjs/src/sol.bundle'
import { AttachDiskImage } from '@device-management-toolkit/ui-toolkit-react/reactjs/src/ider.bundle'

// v5 (new)
import { KVM, Sol, AttachDiskImage } from '@device-management-toolkit/ui-toolkit-react'
```

## Styling Changes

SCSS and CSS file-based styling has been removed. Components now accept `className` and `style` props directly for customization.

{% raw %}
``` typescript
// v4 (old) - CSS/SCSS class overrides
// Required importing SCSS files and overriding CSS classes

// v5 (new) - inline style props
<KVM deviceId={deviceId} mpsServer={mpsServer} authToken={authToken}
  mouseDebounceTime={200} canvasHeight="100%" canvasWidth="100%"
  containerStyle={{ padding: '10px' }}
  connectButtonStyle={{ backgroundColor: '#007bff', color: '#fff' }}
  canvasStyle={{ border: '1px solid #ccc' }}
/>
```
{% endraw %}

## Build System Changes

The build system has moved from Webpack to Rollup. If you were using custom Webpack configurations for bundling, these are no longer needed. The package now ships as:

- **ESM**: `dist/index.esm.js`
- **CJS**: `dist/index.cjs.js`
- **Types**: `dist/index.d.ts`

## Internationalization (i18n) Changes

- The default language is English (`en`). Language must be set explicitly using `i18n.changeLanguage()`.
- Supported languages: English (en), Spanish (es), French (fr), German (de), Japanese (ja), Chinese (zh).
- See [React Localization](reactLocalization.md) for full details on adding languages and configuring i18n.

## Development Setup

The example application now uses Vite instead of webpack-dev-server.

``` bash
# v4 (old)
npx create-react-app my-app
npm start  # webpack-dev-server on port 3000

# v5 (new)
npm create vite@latest my-app -- --template react-ts
npm run dev  # Vite dev server on port 5173
```
