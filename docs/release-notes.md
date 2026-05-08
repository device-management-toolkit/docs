

# Release Notes

!!! note "Note From the Team"

    This release brings a major update to the React UI Toolkit with the v5 modernization, expanded hotkey support across UI components, and improved redirection handling in the Web UI. On the backend side, we focused on improving activation reliability for newer AMT platforms and refining Secure Boot handling in OCR workflows.

    Looking ahead, work on rpc-go `v3` continues to ramp up. We’re adding new diagnostic capabilities, including flash logs, CIRA logs, and WSMAN class retrieval, which will begin rolling out in upcoming beta releases. We’re also improving rpc-go behavior when LMS is not available and adding better KVM feedback so users get clearer insight when starting a session. **And of course, steady progress continues toward the broader v3 direction**.

    As always, thanks for the feedback and contributions, especially to our external contributors helping expand platform support.

    Cheers,<br>
    **The Device Management Toolkit Team**

## 🚀 What's New?

### UI Toolkit React: v5 Release (Breaking Change)

The React UI Toolkit received a major update introducing functional components and a style-props API. Builds now use Rollup, and component exports were restructured to better support future UI integrations.

You can see a summary of the improvements in PR [#1906](https://github.com/device-management-toolkit/ui-toolkit-react/pull/1906)

Along with this release, we’ve also published an example app to help users test KVM, IDER, and SOL components. Instructions to get started are available [here](https://device-management-toolkit.github.io/docs/2.32/Tutorials/uitoolkitReact/#test-the-react-library-with-the-example-app)

### Console: Linux `arm64` Binary

We now publish Console binaries for Linux `arm64`, expanding deployment options for edge and ARM-based environments. This extends the build workflow to generate Linux `arm64` binaries as part of the release assets.

Thanks to external contributor **@justfrt** for helping enable this support.

### UI Toolkit & UI Toolkit Angular: Expanded Hotkey Support

New keyboard shortcuts were added, including *ALT + F1* through *F12* and *CTRL + ALT + F1* through *F12*, giving users more options for sending remote key combinations.

### Web UI: Option to Enable Redirection

The Web UI now displays a warning when KVM, SOL, or IDER is enabled but the overall *Redirection feature* is disabled. Users can now enable Redirection through Console or MPS before starting a session.

## 🧩 Enhancements & Improvements

### Console & MPS: Secure Boot Handling Improvements for OCR

For One-Click Recovery workflows, Console and MPS now provide clearer feedback when *EnforceSecureBoot* is used in CCM mode. These updates align behavior with firmware expectations and help prevent unsupported boot scenarios earlier in the workflow.

### RPC-Go: Activation Stability Improvements for AMT 19 and above versions

Updates the local ACM activation workflow to better support AMT 19+ platforms with TLS enforcement. This includes improved handling of MEBx password requirements and activation state transitions, resulting in more reliable activation on newer firmware versions.

## 🔧 Fixes & Maintenance

- Console fixes related to encryption and decryption error handling, along with case-insensitive UUID comparisons

- Console fix for IDER boot order handling

- RPC-Go fixes for LME timeout handling and formatted log stability

- RPS update to consistently use SHA256 for compatibility with older firmware versions

- RPS improvement to validate upgrade results before reporting ACM activation success

- UI Toolkit keyboard event handling fixes

- Cypress test fixes for Linux environments in Sample Web UI

- Minor dependency updates and general maintenance across toolkit components

## :material-update:{ .icon-log } Changelog
  
### RPS

#### [2.31.3](https://github.com/device-management-toolkit/rps/compare/v2.31.2...v2.31.3) (2026-02-18)

Bug Fixes

* always use sha256 in createSignedString for firmware compatibility ([#2537](https://github.com/device-management-toolkit/rps/issues/2537)) ([8fc2c95](https://github.com/device-management-toolkit/rps/commit/8fc2c952985b4f655954ac9fd8bdc6dcefbec44a))

#### [2.31.2](https://github.com/device-management-toolkit/rps/compare/v2.31.1...v2.31.2) (2026-01-16)

Bug Fixes

* **activation:** check upgrade result before reporting ACM activation success ([#2503](https://github.com/device-management-toolkit/rps/issues/2503)) ([765cb93](https://github.com/device-management-toolkit/rps/commit/765cb932bbf87bdd0e63d2a71827fb953fd4a03c))

### MPS

#### [2.26.0](https://github.com/device-management-toolkit/mps/compare/v2.25.4...v2.26.0) (2026-02-18)

Features

* **api:** Add CCM validation for EnforceSecureBoot in boot options ([#2323](https://github.com/device-management-toolkit/mps/issues/2323)) ([5f4193c](https://github.com/device-management-toolkit/mps/commit/5f4193c0e25e2d1cc10619e77b6bd0086302599d))

### RPC Go

#### [2.49.0](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.16...v2.49.0) (2026-02-17)

Bug Fixes

* addresses amt19+ activation on new machines ([#1162](https://github.com/device-management-toolkit/rpc-go/issues/1162)) ([e56715b](https://github.com/device-management-toolkit/rpc-go/commit/e56715bac4d256c89359b45a9aa5fd9780e5c4bc))
* updating redirection log proccess using thread safe and buffer ([36b0a07](https://github.com/device-management-toolkit/rpc-go/commit/36b0a07698b0a96cdf9b88b038ac0efde9d582d7))

Features

* support for SHA-384 provisioning certificates in rpc-go ([#1078](https://github.com/device-management-toolkit/rpc-go/issues/1078)) ([a60c97d](https://github.com/device-management-toolkit/rpc-go/commit/a60c97d3228c7a675e9d049aaaba18d934828243))

#### [2.48.16](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.15...v2.48.16) (2026-01-30)

Bug Fixes

* **lme:** add timeout in lme-execute method ([bffd2d3](https://github.com/device-management-toolkit/rpc-go/commit/bffd2d322d3898b0a12e2af244387dc9aa15ccc6))

#### [2.48.15](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.14...v2.48.15) (2026-01-15)

Bug Fixes

* workaround for fixing crash in formated logs ([996b559](https://github.com/device-management-toolkit/rpc-go/commit/996b5599a2ba23e4e5842d248f6b840f8e8568d2))

### Sample Web UI

#### [3.54.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.53.1...v3.54.0) (2026-02-18)

Bug Fixes

* disable Enforce Secure Boot checkbox in CCM mode ([#3101](https://github.com/device-management-toolkit/sample-web-ui/issues/3101)) ([17ad7ea](https://github.com/device-management-toolkit/sample-web-ui/commit/17ad7eab4ec323d11ed74114e8e6b8e508598e69))
* update redirection form state after enabling AMT features ([#3131](https://github.com/device-management-toolkit/sample-web-ui/issues/3131)) ([40a0276](https://github.com/device-management-toolkit/sample-web-ui/commit/40a0276e0eb98a91d89cfbc8ad897b054cd4c3d1))

Features

* show redirection warning when KVM/SOL/IDER is enabled but redirection is off ([#3125](https://github.com/device-management-toolkit/sample-web-ui/issues/3125)) ([a532bf7](https://github.com/device-management-toolkit/sample-web-ui/commit/a532bf7421e750350a2a9985465df4cc47bed852))

#### [3.53.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.53.0...v3.53.1) (2026-01-29)

Bug Fixes

* fixed cypress ts code for Linux device ([#3085](https://github.com/device-management-toolkit/sample-web-ui/issues/3085)) ([cfcfb8e](https://github.com/device-management-toolkit/sample-web-ui/commit/cfcfb8e7b9e07abad53cce961938928254309243))

#### [3.53.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.52.4...v3.53.0) (2026-01-28)

Features

* Added hotkey support for ALT+Fx and CTL+ATL+Fx ([bd681b7](https://github.com/device-management-toolkit/sample-web-ui/commit/bd681b7f2b9212f62a24aebe2d18a40583fdbd35))

#### [3.52.4](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.52.3...v3.52.4) (2026-01-16)

Bug Fixes

* hide edit device button in cloud deployment mode ([#3078](https://github.com/device-management-toolkit/sample-web-ui/issues/3078)) ([6e56b04](https://github.com/device-management-toolkit/sample-web-ui/commit/6e56b043312c7e4f9e0cb93f3e3c11dcb04f691b))

### UI Toolkit

#### [3.3.10](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.9...v3.3.10) (2026-02-09)

Bug Fixes

* KeyboardHelper overrides kb event listener ([#1583](https://github.com/device-management-toolkit/ui-toolkit/issues/1583)) ([15a9157](https://github.com/device-management-toolkit/ui-toolkit/commit/15a9157239a3316085da44e91fbddd1b302c1106))

### UI Toolkit Angular

#### [11.1.1](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v11.1.0...v11.1.1) (2026-02-09)

#### [11.1.0](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v11.0.1...v11.1.0) (2026-01-27)

Features

* Added new hotkeys support for ALT+F1-F12 and CTRL+ALT+F1-F12 ([463c352](https://github.com/device-management-toolkit/ui-toolkit-angular/commit/463c35246da7f6e91f01afe331f68e8dee6a6529))

### UI Toolkit React

#### [5.0.1](https://github.com/device-management-toolkit/ui-toolkit-react/compare/v5.0.0...v5.0.1) (2026-02-24)

Bug Fixes

* remove prepublishOnly  to fix publish failure ([#1907](https://github.com/device-management-toolkit/ui-toolkit-react/issues/1907)) ([bed6e83](https://github.com/device-management-toolkit/ui-toolkit-react/commit/bed6e83ac147a3ba92207e9381897a192333a098))

#### [5.0.0](https://github.com/device-management-toolkit/ui-toolkit-react/compare/v4.0.6...v5.0.0) (2026-02-24)

* feat!: modernize library with functional components and style props API ([#1906](https://github.com/device-management-toolkit/ui-toolkit-react/issues/1906)) ([50a6183](https://github.com/device-management-toolkit/ui-toolkit-react/commit/50a618347db3b25fbc4a8886276ae762b67cd51b))

BREAKING CHANGES

* Component styling now uses style props (containerStyle, canvasStyle, etc.) instead of CSS classes, canvasWidth/canvasHeight
props now apply to CSS display size, replaced webpack with rollup for builds, restructured exports from src/components/*

### Console

#### [1.20.1](https://github.com/device-management-toolkit/console/compare/v1.20.0...v1.20.1) (2026-02-16)

Bug Fixes

* handle encryption and decryption errors instead of silently ignoring them ([#778](https://github.com/device-management-toolkit/console/issues/778)) ([ba02a58](https://github.com/device-management-toolkit/console/commit/ba02a5811d0f3ac1417692f2cf2ec6d515d24f55))

#### [1.20.0](https://github.com/device-management-toolkit/console/compare/v1.19.2...v1.20.0) (2026-02-11)

Features

* **power:** add EnforceSecureBoot error message for CCM mode ([#779](https://github.com/device-management-toolkit/console/issues/779)) ([e16afa8](https://github.com/device-management-toolkit/console/commit/e16afa862d86cba094eb182b20f24f08e16b8505))

#### [1.19.2](https://github.com/device-management-toolkit/console/compare/v1.19.1...v1.19.2) (2026-02-06)

Bug Fixes

* case-insensitive UUID comparison for CIRA ([#784](https://github.com/device-management-toolkit/console/issues/784)) ([4d3e507](https://github.com/device-management-toolkit/console/commit/4d3e50761d1ff5840672039f97d00eae803d99b6))

#### [1.19.1](https://github.com/device-management-toolkit/console/compare/v1.19.0...v1.19.1) (2026-02-04)

Bug Fixes

* return empty boot source for IDER actions ([#783](https://github.com/device-management-toolkit/console/issues/783)) ([865fd9b](https://github.com/device-management-toolkit/console/commit/865fd9b48db9de4c5bfedae1c5a4933ed25d44b3))

#### [1.19.0](https://github.com/device-management-toolkit/console/compare/v1.18.2...v1.19.0) (2026-01-22)

Features

* adds support for linux arm64 builds ([5820237](https://github.com/device-management-toolkit/console/commit/5820237f0763d873b87e00c960354a993cfe4ae1))

#### [1.18.2](https://github.com/device-management-toolkit/console/compare/v1.18.1...v1.18.2) (2026-01-14)

Bug Fixes

* gracefully handles failures setting up wsman client connections ([#754](https://github.com/device-management-toolkit/console/issues/754)) ([b37698a](https://github.com/device-management-toolkit/console/commit/b37698a2e6d4d10ecf5402387c5de63d70cbc641))

#### [1.18.1](https://github.com/device-management-toolkit/console/compare/v1.18.0...v1.18.1) (2026-01-12)

Bug Fixes

* supports null values for MEBX and MPSPasswords ([#753](https://github.com/device-management-toolkit/console/issues/753)) ([e568fca](https://github.com/device-management-toolkit/console/commit/e568fca24e188b20b07db1515c59269b794a1257))

### Go WSMAN Messages

#### [2.36.2](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.36.1...v2.36.2) (2026-02-09)

### WSMAN Messages

#### [5.14.4](https://github.com/device-management-toolkit/wsman-messages/compare/v5.14.3...v5.14.4) (2026-02-09)

### MPS Router

#### [2.5.7](https://github.com/device-management-toolkit/mps-router/compare/v2.5.6...v2.5.7) (2026-02-18)