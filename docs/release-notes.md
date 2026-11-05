# Release Notes

!!! note "Note From the Team"

    Hello, DMT community!

    October Release (v2.40) brings a refreshed Sample Web UI built on Material 3, Managed and Discovered device views, signed Console and RPC-Go releases, and a new RPC-Go diagnostics bundle. RPS now enables AMT local time synchronization during activation, and MPS scopes redirection tokens to the requesting tenant.

    This release also includes a breaking change for UI Toolkit Angular users upgrading to v12 detailed below.

    We're working on several features for upcoming DMT releases including, enabling supported deployment architectures where customers can run Console and RPS together (a key v3 capability), bulk power state pull in MPS, completing the official release of RPC-Go v3, Secure Storage of Console Credentials, (TEP) Trusted Endpoint Provisioning device information and a Google Cloud Secret Manager provider for RPS etc.

    As always, thanks to everyone providing feedback, testing new functionality, and contributing to the toolkit. Follow our [Sprint Board](https://github.com/orgs/device-management-toolkit/projects/10/views/2) for updates on work in progress.

    Cheers,<br>
    **The Device Management Toolkit Team**

## 🚀 What's New?

### Sample Web UI: Material 3 Refresh (v4.0)

Sample Web UI 4.0 migrates to Angular 22 and Material 3, moves the application controls (app chrome) into the sidebar, updates the product logo, and adds call-to-action empty states to list pages so new users know what to do next.
!!! note "Custom branding"
    4.0 is a major release. If you maintain a fork with custom branding or styling, review the logo and layout changes before upgrading

### UI Toolkit Angular: Angular 22 upgrade

UI Toolkit Angular v12 upgrades the library to Angular 22. As part of the upgrade, `SOLComponent.deviceState` and `IDERComponent.deviceState` are read-only signals. Consumers that previously accessed `deviceState` as a property must now call `deviceState()`.

!!! warning "Breaking change"

    Update integrations that read either component's `deviceState` property to use the signal accessor before upgrading to UI Toolkit Angular v12.

### RPC-Go v3 (Beta): Diagnostic Bundles

The new `diag bundle` command collects device diagnostics into a single ZIP file to share when investigating deployment or device issues.

```bash
sudo rpc diag bundle --output diagnostics.zip
```

The bundle contains `cira.txt` (CIRA diagnostics), `csme_flash_log.bin` (CSME flash log), `wsman.json` (AMT WSMAN state), and `manifest.json` (collection status for each collector). If WSMAN collection fails with AMT/LMS TLS certificate errors, add `--skip-amt-cert-check`.

### Console & Sample Web UI: Managed and Discovered Devices

The Sample Web UI **Devices** page now separates devices into **Managed** and **Discovered (Preview)** tabs, shows a live device count on each tab, and adds **Product Type** (ISM or vPro) and **Control Mode** columns.

To support this view in enterprise (on-premises) deployments, Console adds `activatedCount` and `discoveredCount` to the `GET /api/v1/devices/stats` response. Console also adds the `activated=true` and `discovered=true` query parameters to `GET /api/v1/devices` to filter managed and discovered devices.

```json
{
  "totalCount": 10,
  "connectedCount": 0,
  "disconnectedCount": 0,
  "activatedCount": 6,
  "discoveredCount": 4
}
```

!!! note

    `connectedCount` and `disconnectedCount` apply to cloud deployments. In Console, these fields are always `0`.

### Console and RPC-Go: Signed Releases

Console and RPC-Go release artifacts are now signed with [Cosign](https://docs.sigstore.dev/cosign/signing/overview/) during the GitHub Actions release build. Before extracting or running a downloaded archive or executable, you can confirm it is the file the project published and has not been changed. The signature bundles are published with each release in `cosign-signatures.zip`. See [Verify Console and RPC-Go Releases](Reference/verifyReleases.md) for the signed files, expected signing identities, and verification commands for Linux and Windows. This helps to confirm a download is authentic before deploying it.

### Console: Redfish API (Preview)

Console now offers a preview of its [Redfish API](https://www.dmtf.org/standards/redfish) (`/redfish/v1`), allowing the [DMTF Redfish Tool](https://github.com/DMTF/Redfishtool) or other manageability software that supports Redfish APIs to discover and manage Intel AMT devices. The preview supports session login and logout, system inventory, power control, and KVM and SOL redirection with user consent. See the [Redfish user guide](Tutorials/Redfish/redfishUserGuide.md) to get started, and share your feedback or contributions on our [GitHub repositories](https://github.com/device-management-toolkit).

!!! warning "Pre-release feature"

    Not production ready and subject to change. Available in pre-release builds tagged `-redfish-preview`, such as [`v1.46.0-redfish-preview.1`](https://github.com/device-management-toolkit/console/releases/tag/v1.46.0-redfish-preview.1), under Console [Releases](https://github.com/device-management-toolkit/console/releases).

## 🧩 Enhancements & Improvements

### RPS

- **AMT local time synchronization:** RPS now enables AMT local time synchronization as part of activation, not only when TLS is configured. When LMS is available it uses `EnableLocalTimeSync`; otherwise it falls back to the legacy time sync flow.

### MPS

- **Tenant-scoped redirection tokens:** `GET /api/v1/authorize/redirection/{guid}` now only issues tokens for devices in the requesting tenant; devices outside the tenant return 404. Cloud deployments should also pick up deployment v2.39.1, which adds a dedicated Kong route for this endpoint.

### Console

- **Device capability details:** Console now exposes activated/discovered device stats and filters, and includes `isElevated` and `heciAvailable` in device info returned to clients.

### RPC-Go v3 (Beta)

- **AMT local time synchronization:** Configure the setting through a remote RPS workflow as part of device setup.
- **Device capability reporting:** Send elevation and HECI availability during synchronization, and report AMT cryptographic capabilities to RPS.
- **macOS support for 'amtinfo --sync':** RPC-Go reads the platform UUID on macOS, detects the Wi-Fi interface correctly, and reports HECI as not detected instead of failing on privileges.
- **Public Go packages:** 'pkg/activate','pkg/configure','pkg/deactivate' and 'pkg/amtinfo' are now available for applications that embed RPC-Go.

### Sample Web UI

- **Connection feedback:** KVM connection feedback has been improved.
- **Sign-in behavior:** Skip the sign-in prompt when Console authentication is disabled.

### WSMAN messages

- **AMT 22 certificates:** `wsman-messages` widens the AMT certificate parameter types to support AMT 22 (6.3.0), and adds an `EnableLocalTimeSync` builder for `AMT_TimeSynchronizationService` (6.2.0).

## 🔧 Fixes & Maintenance

### RPC-Go v3 (Beta)

- Environment variables now take precedence over `config.yaml`.
- Sync results are clearer, and users without root access receive guidance.
- Command output is more concise, credential warnings fit on one line, and `amtinfo` validates box-output bounds correctly.

### Console

- Hardens CORS: the KVM/SOL/IDER relay now validates the request origin, and the wildcard (`*`) default has been removed from the shipped configuration.
!!! warning "Console: review `allowed_origins` before upgrading"
    Console no longer ships with a wildcard CORS allowlist, rejects an empty `http.allowed_origins` at startup, and the relay ignores `*` (falling back to same-origin only). If you serve the UI from a different origin than Console, add that origin explicitly to `http.allowed_origins`. Same-origin deployments are unaffected.
- Return 400 for malformed requests, and prevent a slow device from blocking requests for other devices.
- Validate domain suffixes against the provisioning certificate.
- Serve the UI's complete media directory and require a username for PEAP-MSCHAPv2 wireless profiles.

### Sample Web UI

- Show domain validation errors in a snackbar and count expired domain certificates correctly.
- Correct stale rendering and layout issues on the device page.

### Dependencies

- **Deployment v2.39.1:** Replaces v2.39.0, whose GitHub source ZIP was built from the wrong branch. If you downloaded the v2.39.0 source ZIP, use v2.39.1 instead.
- Routine dependency updates and maintenance across toolkit components.


## :material-update:{ .icon-log } Changelog

### Console

#### [1.46.2](https://github.com/device-management-toolkit/console/compare/v1.46.1...v1.46.2) (2026-10-26)

#### [1.46.1](https://github.com/device-management-toolkit/console/compare/v1.46.0...v1.46.1) (2026-10-26)

Bug Fixes

* require 802.1x username for PEAP-MSCHAPv2 in wireless profile API ([#1319](https://github.com/device-management-toolkit/console/issues/1319))

#### [1.46.0](https://github.com/device-management-toolkit/console/compare/v1.45.5...v1.46.0) (2026-10-16)

Features

- **add isElevated and heciAvailable to deviceInfo** ([#1306](https://github.com/device-management-toolkit/console/issues/1306)), closes [device-management-toolkit/rpc-go#1613](https://github.com/device-management-toolkit/rpc-go/issues/1613)

#### [1.45.5](https://github.com/device-management-toolkit/console/compare/v1.45.4...v1.45.5) (2026-10-13)

Bug Fixes

* ui: serve the UI build's whole media directory ([#1318](https://github.com/device-management-toolkit/console/issues/1318))

#### [1.45.4](https://github.com/device-management-toolkit/console/compare/v1.45.3...v1.45.4) (2026-10-12)

Bug Fixes

* domains: validate domain suffix against provisioning cert CN ([#1300](https://github.com/device-management-toolkit/console/issues/1300)), closes [#1298](https://github.com/device-management-toolkit/console/issues/1298)

#### [1.45.3](https://github.com/device-management-toolkit/console/compare/v1.45.2...v1.45.3) (2026-10-12)

Bug Fixes

* consign names based on artifact names

#### [1.45.2](https://github.com/device-management-toolkit/console/compare/v1.45.1...v1.45.2) (2026-10-03)

Bug Fixes

* api: omit empty password properties from device responses

#### [1.45.1](https://github.com/device-management-toolkit/console/compare/v1.45.0...v1.45.1) (2026-10-02)

Bug Fixes

* api: return bad request for malformed payloads ([#1248](https://github.com/device-management-toolkit/console/issues/1248))
* stop one slow device from blocking the others ([#1247](https://github.com/device-management-toolkit/console/issues/1247)) ([#1246](https://github.com/device-management-toolkit/console/issues/1246))

#### [1.45.0](https://github.com/device-management-toolkit/console/compare/v1.44.0...v1.45.0) (2026-09-25)

Features

- **expose activated/discovered stats and device filters** ([#1214](https://github.com/device-management-toolkit/console/issues/1214)), closes [#1210](https://github.com/device-management-toolkit/console/issues/1210)

#### [1.44.0](https://github.com/device-management-toolkit/console/compare/v1.43.2...v1.44.0) (2026-09-25)

Features

- **denormalize currentMode/discovered into device columns** ([#1211](https://github.com/device-management-toolkit/console/issues/1211))

#### [1.43.2](https://github.com/device-management-toolkit/console/compare/v1.43.1...v1.43.2) (2026-09-25)

Bug Fixes

* cors: reject cross-origin relay handshakes and drop wildcard def… ([#1236](https://github.com/device-management-toolkit/console/issues/1236))

### RPS

#### [2.41.1](https://github.com/device-management-toolkit/rps/compare/v2.41.0...v2.41.1) (2026-10-26)

#### [2.41.0](https://github.com/device-management-toolkit/rps/compare/v2.40.2...v2.41.0) (2026-10-14)

Features

- **Add AMT Local Time Synchronization Support** ([#2912](https://github.com/device-management-toolkit/rps/issues/2912)), closes [#2905](https://github.com/device-management-toolkit/rps/issues/2905)

### MPS

#### [2.36.1](https://github.com/device-management-toolkit/mps/compare/v2.36.0...v2.36.1) (2026-10-24)

#### [2.36.0](https://github.com/device-management-toolkit/mps/compare/v2.35.1...v2.36.0) (2026-10-23)

Features

- **redir: scope token issuance to request tenant** ([#2723](https://github.com/device-management-toolkit/mps/issues/2723)), closes [device-management-toolkit/deployment#711](https://github.com/device-management-toolkit/deployment/issues/711)

### RPC Go

#### [2.52.8](https://github.com/device-management-toolkit/rpc-go/compare/v2.52.7...v2.52.8) (2026-10-26)

### RPC Go v3 (Beta)

#### [3.0.0-beta.73](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.72...v3.0.0-beta.73) (2026-10-26)

#### [3.0.0-beta.72](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.71...v3.0.0-beta.72) (2026-10-26)

Bug Fixes

* ensure bounds correctly checked for box output ([#1631](https://github.com/device-management-toolkit/rpc-go/issues/1631))

#### [3.0.0-beta.71](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.70...v3.0.0-beta.71) (2026-10-26)

Bug Fixes

* shorten CLI credential warning to a single line ([#1649](https://github.com/device-management-toolkit/rpc-go/issues/1649))

#### [3.0.0-beta.70](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.69...v3.0.0-beta.70) (2026-10-26)

Bug Fixes

* show concise sync results instead of full device details ([#1635](https://github.com/device-management-toolkit/rpc-go/issues/1635)), closes [#1633](https://github.com/device-management-toolkit/rpc-go/issues/1633)

#### [3.0.0-beta.69](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.68...v3.0.0-beta.69) (2026-10-23)

Bug Fixes

* show info and offer sudo when sync lacks root access ([#1601](https://github.com/device-management-toolkit/rpc-go/issues/1601))

#### [3.0.0-beta.68](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.67...v3.0.0-beta.68) (2026-10-16)

Bug Fixes

* report sync success and failure clearly ([#1622](https://github.com/device-management-toolkit/rpc-go/issues/1622)), closes [#1621](https://github.com/device-management-toolkit/rpc-go/issues/1621)

#### [3.0.0-beta.67](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.66...v3.0.0-beta.67) (2026-10-16)

Features

* include isElevated and heciAvailable in device sync payload ([#1614](https://github.com/device-management-toolkit/rpc-go/issues/1614)), closes [#1613](https://github.com/device-management-toolkit/rpc-go/issues/1613)

#### [3.0.0-beta.66](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.65...v3.0.0-beta.66) (2026-10-16)

Features

- **Implement diag bundle command** ([#1547](https://github.com/device-management-toolkit/rpc-go/issues/1547)), closes [#1544](https://github.com/device-management-toolkit/rpc-go/issues/1544)

#### [3.0.0-beta.65](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.64...v3.0.0-beta.65) (2026-10-15)

Features

- **Add remote RPS support to configure sync-clock** ([#1562](https://github.com/device-management-toolkit/rpc-go/issues/1562)), closes [#1561](https://github.com/device-management-toolkit/rpc-go/issues/1561) [device-management-toolkit/rps#2905](https://github.com/device-management-toolkit/rps/issues/2905)

#### [3.0.0-beta.64](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.63...v3.0.0-beta.64) (2026-10-15)

Features

- **rps: report AMT crypto capabilities to RPS** ([#1615](https://github.com/device-management-toolkit/rpc-go/issues/1615))

#### [3.0.0-beta.63](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.62...v3.0.0-beta.63) (2026-10-12)

Features

- **add public pkg/deactivate API** ([#1583](https://github.com/device-management-toolkit/rpc-go/issues/1583))

#### [3.0.0-beta.62](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.61...v3.0.0-beta.62) (2026-10-12)

Features

- **utils: support non-AMT device discovery on macOS** ([#1585](https://github.com/device-management-toolkit/rpc-go/issues/1585)), closes [#1355](https://github.com/device-management-toolkit/rpc-go/issues/1355)

#### [3.0.0-beta.61](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.60...v3.0.0-beta.61) (2026-09-25)

Bug Fixes

* cli: let environment variables override config.yaml values ([#1574](https://github.com/device-management-toolkit/rpc-go/issues/1574))

### Sample Web UI

#### [4.2.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v4.2.0...v4.2.1) (2026-10-26)

#### [4.2.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v4.1.0...v4.2.0) (2026-10-23)

Features

- **devices: improve KVM connection feedback** ([#3659](https://github.com/device-management-toolkit/sample-web-ui/issues/3659)), closes [device-management-toolkit/deployment#711](https://github.com/device-management-toolkit/deployment/issues/711)

#### [4.1.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v4.0.1...v4.1.0) (2026-10-16)

Features

- **login: skip login when Console runs with auth disabled** ([#3577](https://github.com/device-management-toolkit/sample-web-ui/issues/3577)), closes [#3643](https://github.com/device-management-toolkit/sample-web-ui/issues/3643)

#### [4.0.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v4.0.0...v4.0.1) (2026-10-13)

Bug Fixes

* show domain validation errors in snackbar ([#3636](https://github.com/device-management-toolkit/sample-web-ui/issues/3636))

#### [4.0.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.69.3...v4.0.0) (2026-10-13)

Features

- **add call-to-action empty states to the list pages** ([#3634](https://github.com/device-management-toolkit/sample-web-ui/issues/3634))
- **migrate to Material 3 and move app chrome into the sidebar** ([#3633](https://github.com/device-management-toolkit/sample-web-ui/issues/3633))

#### [3.69.3](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.69.2...v3.69.3) (2026-10-12)

Bug Fixes

* add proxy configuration selector

#### [3.69.2](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.69.1...v3.69.2) (2026-10-06)

#### [3.69.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.69.0...v3.69.1) (2026-10-02)

Bug Fixes

* devices: clean up devices page layout and stale rendering

#### [3.69.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.68.1...v3.69.0) (2026-09-30)

Features

- **mark Discovered tab as preview and show Managed first** ([#3592](https://github.com/device-management-toolkit/sample-web-ui/issues/3592))

#### [3.68.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.68.0...v3.68.1) (2026-09-25)

Bug Fixes

* Added control mode column to the UI ([#3535](https://github.com/device-management-toolkit/sample-web-ui/issues/3535))

#### [3.68.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.67.1...v3.68.0) (2026-09-25)

Features

- **add tabs, product type column, and discovered field** ([#3417](https://github.com/device-management-toolkit/sample-web-ui/issues/3417))

Bug Fixes

- **show the correct number of expired domain certs** ([#3599](https://github.com/device-management-toolkit/sample-web-ui/issues/3599))

### UI Toolkit

#### [3.3.22](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.21...v3.3.22) (2026-10-23)

### UI Toolkit Angular

#### [12.0.1](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v12.0.0...v12.0.1) (2026-10-23)

#### [12.0.0](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v11.1.9...v12.0.0) (2026-10-12)

Features

- **build(deps)!: upgrade angular to v22** ([#2661](https://github.com/device-management-toolkit/ui-toolkit-angular/issues/2661)), closes [#2636](https://github.com/device-management-toolkit/ui-toolkit-angular/issues/2636)

Breaking Changes

- **SOLComponent.deviceState and IDERComponent.deviceState are now read-only signals. Read them as deviceState() instead of deviceState.**

### UI Toolkit React

#### [5.0.10](https://github.com/device-management-toolkit/ui-toolkit-react/compare/v5.0.9...v5.0.10) (2026-10-23)

### Go WSMAN Messages

#### [2.50.5](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.50.4...v2.50.5) (2026-10-23)

### WSMAN Messages

#### [6.3.1](https://github.com/device-management-toolkit/wsman-messages/compare/v6.3.0...v6.3.1) (2026-10-23)

#### [6.3.0](https://github.com/device-management-toolkit/wsman-messages/compare/v6.2.0...v6.3.0) (2026-10-15)

Features

- **amt: widen the AMT certificate parameter types for AMT 22** ([#1430](https://github.com/device-management-toolkit/wsman-messages/issues/1430))

#### [6.2.0](https://github.com/device-management-toolkit/wsman-messages/compare/v6.1.5...v6.2.0) (2026-09-23)

Features

- **amt: add EnableLocalTimeSync builder for AMT_TimeSynchronizationService**, closes [device-management-toolkit/rps#2905](https://github.com/device-management-toolkit/rps/issues/2905)

### MPS Router

#### [2.5.16](https://github.com/device-management-toolkit/mps-router/compare/v2.5.15...v2.5.16) (2026-10-23)

* Go Docker image digest for a security fix