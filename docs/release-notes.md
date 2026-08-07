# Release Notes

!!! note "Note From the Team"

    This release completes a major set of network management capabilities that we began introducing in the June release. Users can now manage Intel® AMT wired and wireless network settings through both Console and MPS deployments.

    The new Network Settings experience includes wired IP configuration, wireless radio controls, wireless profile synchronization, and support for creating, editing, and deleting wireless profiles. Together, these capabilities provide a complete end-to-end network management experience.

    We also continued improving device discovery in rpc-go v3 (Beta) with clearer command options and discovery timestamps that help distinguish when a device was first discovered and when its information was most recently synchronized.

    In upcoming releases, we'll continue improving Console stability and user experience while expanding discovery and health checker capabilities. We're also very close to releasing Remote Platform Erase (RPE) support in both Console and MPS, one of the major upcoming capabilities for the toolkit. 
    
    There is much more underway across the toolkit, and we look forward to sharing additional features over the coming releases. Follow our [Sprint Board](https://github.com/orgs/device-management-toolkit/projects/10/views/2) to learn more and track upcoming features.

    As always, thanks to everyone providing feedback, testing new functionality, and contributing to the toolkit.

    Cheers,<br>
    **The Device Management Toolkit Team**

## 🚀 What's New?

### Console & MPS: Network Settings

Console and MPS now support configuring Intel® AMT wired and wireless network settings through both REST APIs and the UI.

For wired connections, users can view and configure IP and link settings, configure DHCP or static IP settings, and synchronize the operating system's IP configuration with Intel® AMT.

For wireless connections, users can view connection information, enable or disable the wireless radio, manage local profile synchronization and UEFI WiFi profile sharing, and add, update, or remove wireless profiles.

## 🧩 Enhancements & Improvements

### RPC-Go v3 (Beta): Discovery Command Improvements

rpc-go v3 (Beta) now supports `--discover` and `--register` as aliases for `amtinfo --sync`. All three options collect device information, register the device with Console when needed, and synchronize the latest information.

The new aliases make the purpose of the command clearer while preserving the existing `--sync` workflow.

### Console & RPC-Go v3 (Beta): Discovery Timestamps

Device discovery information now includes timestamps for when a device was first discovered and when its information was most recently synchronized.

The first-discovered timestamp remains unchanged after the initial discovery, while the last-synchronized timestamp is updated each time rpc-go synchronizes device information with Console. More improvements to discovery are planned for future releases.

### Sample Web UI: Improved AMT Feature Updates

Updating Intel AMT features no longer reloads the entire AMT Summary. The UI now displays progress specifically for the feature update, providing clearer feedback while leaving the existing device summary in place.

## 🔧 Fixes & Maintenance

- RPC-Go v3 (Beta) fix for Local Manageability Engine channel handling during channel creation

- RPS fix to provide a consistent domain suffix mismatch error across Intel® AMT versions

- Sample Web UI fix for the power-state refresh button

- Go WSMAN Messages fix to omit an empty CA credential when adding wireless settings

- RPS security dependency update for `js-yaml`

- Minor dependency updates and general maintenance across toolkit components

## :material-update:{ .icon-log } Changelog
  
### RPS

#### [2.39.4](https://github.com/device-management-toolkit/rps/compare/v2.39.3...v2.39.4) (2026-07-28)

#### [2.39.3](https://github.com/device-management-toolkit/rps/compare/v2.39.2...v2.39.3) (2026-07-28)

Bug Fixes

* **deps:** bump js-yaml from 5.2.1 to 5.2.2 ([#2842](https://github.com/device-management-toolkit/rps/issues/2842)) ([fc09b59](https://github.com/device-management-toolkit/rps/commit/fc09b5977d8b4026d9f3a549e6eb2e177b4ed622))

#### [2.39.2](https://github.com/device-management-toolkit/rps/compare/v2.39.1...v2.39.2) (2026-07-10)

Bug Fixes

* match error string with given domain suffix does not match any A… ([#2788](https://github.com/device-management-toolkit/rps/issues/2788)) ([bd2f122](https://github.com/device-management-toolkit/rps/commit/bd2f1228891b4c6d39f5131615c63d67ad25d6c3))

### MPS

#### [2.34.1](https://github.com/device-management-toolkit/mps/compare/v2.34.0...v2.34.1) (2026-07-28)

#### [2.34.0](https://github.com/device-management-toolkit/mps/compare/v2.33.0...v2.34.0) (2026-07-14)

Features

* **api:** add update and delete wireless profile endpoints ([#2549](https://github.com/device-management-toolkit/mps/issues/2549)) ([a1a32ae](https://github.com/device-management-toolkit/mps/commit/a1a32aee17fbe97f5932e93259f5a1ec3746e00c)), closes [#2525](https://github.com/device-management-toolkit/mps/issues/2525)

#### [2.33.0](https://github.com/device-management-toolkit/mps/compare/v2.32.2...v2.33.0) (2026-07-02)

Features

* **api:** add wireless profile creation endpoint ([#2545](https://github.com/device-management-toolkit/mps/issues/2545)) ([d85ad1b](https://github.com/device-management-toolkit/mps/commit/d85ad1b44b3b681491eeea4c8086b7641df1b836)), closes [#2525](https://github.com/device-management-toolkit/mps/issues/2525)

### RPC Go

#### [2.52.3](https://github.com/device-management-toolkit/rpc-go/compare/v2.52.2...v2.52.3) (2026-07-28)

#### [2.52.2](https://github.com/device-management-toolkit/rpc-go/compare/v2.52.1...v2.52.2) (2026-07-09)

### RPC Go v3 (Beta)

#### [3.0.0-beta.43](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.42...v3.0.0-beta.43) (2026-07-28)

#### [3.0.0-beta.42](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.41...v3.0.0-beta.42) (2026-07-20)

Bug Fixes

• lme: add to WaitGroup before sending CHANNEL_OPEN ([#1437](https://github.com/device-management-toolkit/rpc-go/issues/1437)) ([1fab4c8](https://github.com/device-management-toolkit/rpc-go/commit/1fab4c8e4b1ef2c596ce9101193c66560050eea5))

#### [3.0.0-beta.41](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.40...v3.0.0-beta.41) (2026-07-20)

Features

• cli: add --discover and --register as aliases for amtinfo --sync ([#1448](https://github.com/device-management-toolkit/rpc-go/issues/1448)) ([e8267f3](https://github.com/device-management-toolkit/rpc-go/commit/e8267f3615d3eba5c9db6ad2b7786cd262713daf)), closes [#1406](https://github.com/device-management-toolkit/rpc-go/issues/1406)

#### [3.0.0-beta.40](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.39...v3.0.0-beta.40) (2026-07-20)

Features

• add discovery timestamps to deviceInfo ([#1441](https://github.com/device-management-toolkit/rpc-go/issues/1441)) ([777c380](https://github.com/device-management-toolkit/rpc-go/commit/777c3806faddc4160c61e8b75fd37ba5e7145174)), closes [#1394](https://github.com/device-management-toolkit/rpc-go/issues/1394)

### Sample Web UI

#### [3.61.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.60.1...v3.61.0) (2026-07-20)

Features

* avoid reloading AMT Summary when updating AMT Features ([#3427](https://github.com/device-management-toolkit/sample-web-ui/issues/3427)) ([2703ec1](https://github.com/device-management-toolkit/sample-web-ui/commit/2703ec1281c86d3c1664e4857ed3631900b28f7c))

#### [3.60.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.60.0...v3.60.1) (2026-07-20)

Bug Fixes

* fix refresh power button issue ([#3441](https://github.com/device-management-toolkit/sample-web-ui/issues/3441)) ([98210d2](https://github.com/device-management-toolkit/sample-web-ui/commit/98210d29feeb823ef62df84b4b2300a37d49d9a9))

#### [3.60.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.59.0...v3.60.0) (2026-07-16)

Features

* **devices:** enable device network settings in cloud mode ([#3396](https://github.com/device-management-toolkit/sample-web-ui/issues/3396)) ([b48c200](https://github.com/device-management-toolkit/sample-web-ui/commit/b48c20067898c501bdfce092e015b534b28c1fa6)), closes [#3376](https://github.com/device-management-toolkit/sample-web-ui/issues/3376)

#### [3.59.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.58.2...v3.59.0) (2026-07-16)

Features

* **devices:** add network settings management for AMT devices ([#3370](https://github.com/device-management-toolkit/sample-web-ui/issues/3370)) ([d7b3829](https://github.com/device-management-toolkit/sample-web-ui/commit/d7b382911bc4bbf8e4e4ddabf8d83b06bdd1fac8)), closes [#3353](https://github.com/device-management-toolkit/sample-web-ui/issues/3353)

#### [3.58.2](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.58.1...v3.58.2) (2026-07-06)

Bug Fixes

* **e2e:** update rpc-go v3 CLI flags ([#3407](https://github.com/device-management-toolkit/sample-web-ui/issues/3407)) ([9ccec21](https://github.com/device-management-toolkit/sample-web-ui/commit/9ccec2131ad19b9719dca90caff2595305565f57))

### UI Toolkit

#### [3.3.19](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.18...v3.3.19) (2026-07-28)

#### [3.3.18](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.17...v3.3.18) (2026-07-27)

### UI Toolkit Angular

#### [11.1.7](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v11.1.6...v11.1.7) (2026-07-28)

### UI Toolkit React

#### [5.0.7](https://github.com/device-management-toolkit/ui-toolkit-react/compare/v5.0.6...v5.0.7) (2026-07-28)

### Go WSMAN Messages

#### [2.48.3](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.48.2...v2.48.3) (2026-07-28)

#### [2.48.2](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.48.1...v2.48.2) (2026-07-17)

Bug Fixes

* **amt:** omit empty CACredential in AddWiFiSettings ([#745](https://github.com/device-management-toolkit/go-wsman-messages/issues/745)) ([f89c812](https://github.com/device-management-toolkit/go-wsman-messages/commit/f89c812e29e6169cd72b79ba97208b8b348aa8c1))

### WSMAN Messages

#### [6.1.3](https://github.com/device-management-toolkit/wsman-messages/compare/v6.1.2...v6.1.3) (2026-07-27)

### MPS Router

#### [2.5.13](https://github.com/device-management-toolkit/mps-router/compare/v2.5.12...v2.5.13) (2026-07-27)