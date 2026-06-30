# Release Notes

!!! note "Note From the Team"

    This release marks the beginning of the next evolution of our deployment experience. As part of this effort, the `cloud-deployment` repository has been renamed to `deployment` to better reflect its long-term direction of supporting both on-premises and cloud deployments from a common deployment framework.

    The current production deployment assets remain available on the [`v2` branch](https://github.com/device-management-toolkit/deployment/tree/v2), which continues to be supported for existing deployments. New deployment capabilities and features are being developed on the `main` branch as we continue expanding Console support for both cloud and on-premises deployment scenarios. You can follow the latest work here: https://github.com/device-management-toolkit/deployment.

    This release also introduces a random administrator password during Console setup, continues the rollout of discovery and wireless profile management capabilities, and includes several quality improvements across Console, RPC-Go, Go WSMAN Messages, and the Sample Web UI.

    In upcoming releases, you will continue to see investments in deployment capabilities, expanded discovery information (OS details such as OS version, CPU model, and network adapters; AMT fields such as TLS mode and DHCP status; and hardware insights like monitor detection), wireless profile management, AMT 22 platform support, installer enhancements, and additional device management capabilities across the toolkit.

    Follow our [Sprint Board](https://github.com/orgs/device-management-toolkit/projects/10/views/2) to learn more and track upcoming features.

    As always, thanks to everyone providing feedback, testing new functionality, and contributing to the toolkit.

    Cheers,<br>
    **The Device Management Toolkit Team**

## 🚀 What's New?

### Deployment Repository: Expanded Beyond Cloud Deployments

The `cloud-deployment` repository has been renamed to `deployment` to better reflect its long-term direction. The repository is evolving to support multiple deployment models, including both on-premises and cloud deployments, from a common deployment framework.

The current production deployment assets remain available on the [`v2` branch](https://github.com/device-management-toolkit/deployment/tree/v2), which continues to be supported for existing deployments. New deployment capabilities and features, however, are being developed on the `main` branch as Console expands its support for both cloud and on-premises deployment scenarios.

You can follow the latest deployment work in the `main` branch [here](https://github.com/device-management-toolkit/deployment).

### Console: Random Administrator Password on First Run

Console now generates a random administrator password during the initial setup, ensuring each installation starts with a unique administrator credential.

Users can update the generated password to a password of their choice as part of their normal deployment and security practices.

!!! note
    A dedicated Console installer is currently in development. Once available, the random password generation may no longer be required and could be removed in a future release.

### Console & RPC-Go v3 (Beta): Discovery Improvements

Support has been added for capturing Intel LMS installation status during device registration when using rpc-go v3 (Beta). Rpc-go v3 detects the presence of Intel LMS on the endpoint, and Console stores this information as part of the device details.

This is the first of several planned discovery enhancements that will continue to expand the device information and health insights available in Console over the coming releases.

### Go WSMAN Messages: Wireless Profile Management

The Go WSMAN Messages library now includes the underlying support for Intel AMT WiFi profile management. In upcoming releases, these capabilities will be surfaced through new Console APIs and user interface enhancements, making wireless profile management easier and more intuitive.

## 🧩 Enhancements & Improvements

### Console: OAuth Configuration Improvements

Console now supports additional `AUTH_*` environment variables for OAuth configuration beyond the configuration file, providing greater flexibility when deploying Console in containerized and cloud environments.

This is one of several ongoing improvements to support the evolving deployment architecture. Additional deployment capabilities and documentation will continue to be added to the `deployment` repository over the coming releases.

### Console: Platform Information Improvements

Console now retrieves processor information using Enumerate/Pull operations, more accurately reports KVM availability after AMT feature configuration, and launches the browser using the configured Console host.


## 🔧 Fixes & Maintenance

- RPC-Go fix to gracefully handle busy Intel ME watchdog (HECI) clients during `amtinfo`

- Sample Web UI fixes for Intel AMT feature selection persistence and AUTH_MODE parsing

- Go WSMAN Messages fixes for WiFi profile updates and UEFI WiFi profile handling

- RPC-Go v3 (Beta) fixes for activation workflows, including CCM activation and local profile activation

- Minor dependency updates and general maintenance across toolkit components

## :material-update:{ .icon-log } Changelog
  
### RPS

#### [2.36.5](https://github.com/device-management-toolkit/rps/compare/v2.36.4...v2.36.5) (2026-06-03)

### MPS

#### [2.26.7](https://github.com/device-management-toolkit/mps/compare/v2.26.6...v2.26.7) (2026-06-03)

### RPC Go

#### [2.50.8](https://github.com/device-management-toolkit/rpc-go/compare/v2.50.7...v2.50.8) (2026-06-03)

#### [2.50.7](https://github.com/device-management-toolkit/rpc-go/compare/v2.50.6...v2.50.7) (2026-05-28)

Bug Fixes

* handle busy watchdog HECI client in amtinfo ([#1343](https://github.com/device-management-toolkit/rpc-go/issues/1343)) ([b473599](https://github.com/device-management-toolkit/rpc-go/commit/b473599ef87ec8202ff9f5473f2296581714f89d))

### Sample Web UI

#### [3.57.10](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.57.9...v3.57.10) (2026-06-03)

#### [3.57.9](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.57.8...v3.57.9) (2026-05-27)

Bug Fixes

* ensure amt features remain selected upon form re-entry ([#3343](https://github.com/device-management-toolkit/sample-web-ui/issues/3343)) ([e376bd5](https://github.com/device-management-toolkit/sample-web-ui/commit/e376bd5f604f27f326c88652052a4f7450aed809))

#### [3.57.8](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.57.7...v3.57.8) (2026-05-26)

Bug Fixes

* correctly parse AUTH_MODE_ENABLED ([#3329](https://github.com/device-management-toolkit/sample-web-ui/issues/3329)) ([f4a6f9b](https://github.com/device-management-toolkit/sample-web-ui/commit/f4a6f9b4739ecdd0e93ec7b5dee952ac65a8d735))

### UI Toolkit

#### [3.3.16](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.15...v3.3.16) (2026-06-03)

### UI Toolkit Angular

#### [11.1.5](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v11.1.4...v11.1.5) (2026-06-03)

### UI Toolkit React

#### [5.0.5](https://github.com/device-management-toolkit/ui-toolkit-react/compare/v5.0.4...v5.0.5) (2026-06-03)

### Console

#### [1.29.1](https://github.com/device-management-toolkit/console/compare/v1.29.0...v1.29.1) (2026-06-04)

#### [1.29.0](https://github.com/device-management-toolkit/console/compare/v1.28.1...v1.29.0) (2026-06-01)

Features

* store lmsInstalled in deviceInfo JSON column ([#905](https://github.com/device-management-toolkit/console/issues/905)) ([f01cb2b](https://github.com/device-management-toolkit/console/commit/f01cb2b4f599dad6a215a5574cc9e44fb8f23e1c)), closes [device-management-toolkit/rpc-go#1246](https://github.com/device-management-toolkit/rpc-go/issues/1246)

#### [1.28.1](https://github.com/device-management-toolkit/console/compare/v1.28.0...v1.28.1) (2026-05-27)

Bug Fixes

* ensure kvmavailable is returned accurately upon amtfeature set ([#1030](https://github.com/device-management-toolkit/console/issues/1030)) ([1d0d432](https://github.com/device-management-toolkit/console/commit/1d0d432092966454da72f54aad29901002d7a89b))

#### [1.28.0](https://github.com/device-management-toolkit/console/compare/v1.27.5...v1.28.0) (2026-05-27)

Features

* adds support for randomly generated admin password on first run ([d60f24c](https://github.com/device-management-toolkit/console/commit/d60f24c96d24f63c230f3bd219106a8dfd822993))

#### [1.27.5](https://github.com/device-management-toolkit/console/compare/v1.27.4...v1.27.5) (2026-05-27)

Bug Fixes

* fetch processor info via Enumerate/Pull instead of Get ([#1028](https://github.com/device-management-toolkit/console/issues/1028)) ([6d891f3](https://github.com/device-management-toolkit/console/commit/6d891f3d6eadeb18aad7c2856e7dba7b908a46d3))

#### [1.27.4](https://github.com/device-management-toolkit/console/compare/v1.27.3...v1.27.4) (2026-05-25)

Bug Fixes

* default browser launch host to configured host ([#1015](https://github.com/device-management-toolkit/console/issues/1015)) ([5a076ce](https://github.com/device-management-toolkit/console/commit/5a076cef2bb0bd09e640ce613871f8d011445451))

#### [1.27.3](https://github.com/device-management-toolkit/console/compare/v1.27.2...v1.27.3) (2026-05-22)

Bug Fixes

* allow AUTH_ env vars for OAuth Configuration beyond just config ([5e11665](https://github.com/device-management-toolkit/console/commit/5e116650985e188142fef17933cfd095d2d29cf0))

### Go WSMAN Messages

#### [2.47.2](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.47.1...v2.47.2) (2026-06-03)

Bug Fixes

* Remove wiFiPortConfigurationService Put post-processes check ([#706](https://github.com/device-management-toolkit/go-wsman-messages/issues/706)) ([5276af1](https://github.com/device-management-toolkit/go-wsman-messages/commit/5276af138bd79737bf416f5a92b9678f236c0d27))

#### [2.47.1](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.47.0...v2.47.1) (2026-06-03)

Bug Fixes

* Remove omitempty from UEFIWiFiProfileShareEnabled ([#705](https://github.com/device-management-toolkit/go-wsman-messages/issues/705)) ([b5e72ad](https://github.com/device-management-toolkit/go-wsman-messages/commit/b5e72ad02166c39c249e937f8d682e6d826c0544))

#### [2.47.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.46.1...v2.47.0) (2026-06-03)

Features

* add update wifi profile wsman adapter ([#686](https://github.com/device-management-toolkit/go-wsman-messages/issues/686)) ([3fb0776](https://github.com/device-management-toolkit/go-wsman-messages/commit/3fb07769fe6e52b1c24696a98e027d8d35350226))

### WSMAN Messages

#### [6.0.3](https://github.com/device-management-toolkit/wsman-messages/compare/v6.0.2...v6.0.3) (2026-06-03)

### MPS Router

#### [2.5.11](https://github.com/device-management-toolkit/mps-router/compare/v2.5.10...v2.5.11) (2026-06-03)