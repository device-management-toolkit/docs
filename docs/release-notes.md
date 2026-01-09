

# Release Notes

!!! note "Note From the Team"
    We’re excited to share our October release. Work on **RPC-Go v3 Beta** is progressing well, and your feedback will help us shape the final v3 release.  
    Our efforts to enable **Console deployment in the cloud** are also moving forward, with more updates planned for Q1.

    We’re expanding the team to accelerate feature delivery starting Q1.

## 🚀 What's New?

### :material-new-box:{ .icon-new } RPC-Go v3 Beta Release

v3 introduces a faster activation workflow, TLS-secured profile fetch, and a clearer configuration model. **v2.x remains fully supported** during Beta.

**Highlights**

- Faster **local activation workflow** using encrypted profile export  
- **TLS required** for profile fetch from Console/RPS  
- Clear separation of **application config** vs **provisioning profile**  
- Standardized CLI flags; `configv2` removed in favor of `--profile`

### :material-new-box:{ .icon-new } Console TLS Support

Console now serves APIs over **HTTPS**.  
Certificates can be configured through `config.yaml`, allowing Console to use either self-signed or user-provided certificates for secure API communication.


### :material-new-box:{ .icon-new } Wireless Reliability Improvement

To improve CIRA reliability over Wi-Fi, the default value:

```text
ConsoleTcpMaxRetransmissions = 7
```

is now applied automatically.  
Running your Wi-Fi profile again with the latest RPS image will apply this setting.

### :material-new-box:{ .icon-new } Web UI Localization

Thank you to **@Robert-Preda** for contribution to Localization support & translations feature. UI translated into 11 languages (FR, DE, ES, NL, IT, JA, AR, FI, HE, RU, SV).

### :material-new-box:{ .icon-new } Certificate Deletion in Console

You can now delete unused or unassociated AMT certificates directly from Console.

## :material-checkbox-marked:{ .icon-new } Fixes & Improvements

- UI stability fixes across Console and Sample Web UI  
- MPS UUID validation issue resolved  
- Wi-Fi coexistence fix

## :material-handshake:{ .icon-handshake } Community Contributions

Thank you to all community contributors for your continued feedback, testing, and pull requests. Your support helps us prioritize and deliver features that matter most.

## :material-update:{ .icon-log } Changelog
  
### RPS

#### [2.30.2](https://github.com/device-management-toolkit/rps/compare/v2.30.1...v2.30.2) (2025-11-06)

#### [2.30.1](https://github.com/device-management-toolkit/rps/compare/v2.30.0...v2.30.1) (2025-11-05)

Bug Fixes

* add coexistence check for profile share ([#2401](https://github.com/device-management-toolkit/rps/issues/2401)) ([790ffdd](https://github.com/device-management-toolkit/rps/commit/790ffddbb899b50141ce9950a54fda91cedc89c8))

#### [2.30.0](https://github.com/device-management-toolkit/rps/compare/v2.29.1...v2.30.0) (2025-11-05)

Features

* extend max retransmission setting for WiFi network configuration ([#2390](https://github.com/device-management-toolkit/rps/issues/2390)) ([39ee524](https://github.com/device-management-toolkit/rps/commit/39ee524cf44e7b3dc50c94010ea6981bcb7768b4))

### MPS

#### [2.22.5](https://github.com/device-management-toolkit/mps/compare/v2.22.4...v2.22.5) (2025-11-07)

 Bug Fixes

* loosens UUID check for API ([#2194](https://github.com/device-management-toolkit/mps/issues/2194)) ([f741380](https://github.com/device-management-toolkit/mps/commit/f741380937cfc8f69a26d2ca4ef13fccbafcff2e))

#### [2.22.4](https://github.com/device-management-toolkit/mps/compare/v2.22.3...v2.22.4) (2025-11-06)

### RPC Go

#### [2.48.7](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.6...v2.48.7) (2025-11-06)

#### [3.0.0-beta.1](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.2...v3.0.0-beta.1) (2025-11-05)

* feat!: begin 3.0 beta series ([a888af2](https://github.com/device-management-toolkit/rpc-go/commit/a888af26c2a1f98c8fa815172a34cb77fe472f8c))

BREAKING CHANGES

* see v3.0-changes.md for the command and flag syntax overhaul, profile/config realignment,
and the new restful profile activation flow.

#### [2.48.6](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.5...v2.48.6) (2025-11-04)

Bug Fixes

* add -n to all the configure subcommands ([c5a4232](https://github.com/device-management-toolkit/rpc-go/commit/c5a423297f89c481e9c9e16c77aea9f27611a696))

#### [2.48.5](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.4...v2.48.5) (2025-10-23)

Bug Fixes

* cert cleanup now excludes mpsroot cert ([9e98143](https://github.com/device-management-toolkit/rpc-go/commit/9e981433d1d67397230959063639bb070ad06d27))

#### [2.48.4](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.3...v2.48.4) (2025-10-13)

#### [2.48.3](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.2...v2.48.3) (2025-10-13)

Bug Fixes

* address panic when operationalState is requested ([#985](https://github.com/device-management-toolkit/rpc-go/issues/985)) ([b16ac56](https://github.com/device-management-toolkit/rpc-go/commit/b16ac56c1ab81970df9926212caa99dd60a8e2e6)), closes [#978](https://github.com/device-management-toolkit/rpc-go/issues/978)
* **dockerfile:** license comment now correct ([74d13b3](https://github.com/device-management-toolkit/rpc-go/commit/74d13b31d491909da14e00d281cb8d2e52d57c42))
* ci: update release to support 2.x branch by @rsdmike in https://github.com/device-management-toolkit/rpc-go/pull/984
* fix: address panic when operationalState is requested by @rsdmike in https://github.com/device-management-toolkit/rpc-go/pull/985
* docs: update readme for 2.x.x. branch by @rsdmike in https://github.com/device-management-toolkit/rpc-go/pull/988

### Sample Web UI

#### [3.49.2](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.49.1...v3.49.2) (2025-11-07)

Bug Fixes

* **domains:** adds better error handling for domain responses to surface in web ui ([#2952](https://github.com/device-management-toolkit/sample-web-ui/issues/2952)) ([1dcbe0d](https://github.com/device-management-toolkit/sample-web-ui/commit/1dcbe0daa0b1fb72941af7d1fdb69d1607ed7fa2)), closes [#2863](https://github.com/device-management-toolkit/sample-web-ui/issues/2863)

#### [3.49.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.49.0...v3.49.1) (2025-11-06)

#### [3.49.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.48.0...v3.49.0) (2025-11-05)

Features

* allow export of profile for cloud mode ([#2960](https://github.com/device-management-toolkit/sample-web-ui/issues/2960)) ([008e60c](https://github.com/device-management-toolkit/sample-web-ui/commit/008e60cb35c32068a6e8042890ebd14f3fce1d18))

#### [3.48.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.47.0...v3.48.0) (2025-10-27)

Bug Fixes

* addresses issue with console version being empty ([#2944](https://github.com/device-management-toolkit/sample-web-ui/issues/2944)) ([d0d3a0c](https://github.com/device-management-toolkit/sample-web-ui/commit/d0d3a0cf85f4c9b7b2f21b51e49526f423b29521))

Features

* **ui:** display console version in toolbar ([#2934](https://github.com/device-management-toolkit/sample-web-ui/issues/2934)) ([24956a0](https://github.com/device-management-toolkit/sample-web-ui/commit/24956a025adbaf2d33fc4ca9356d64ea7c3155af))

#### [3.47.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.46.1...v3.47.0) (2025-10-20)

Bug Fixes

* hide proxy's on console ([#2941](https://github.com/device-management-toolkit/sample-web-ui/issues/2941)) ([9fb20a0](https://github.com/device-management-toolkit/sample-web-ui/commit/9fb20a06b229ae6ed73dc4301cf8fdfd90aae989))

Features

* **i18n:** add and update missing translations and localization support  ([78df33e](https://github.com/device-management-toolkit/sample-web-ui/commit/78df33e4d0a213786a0747165846535da996c29f))

### UI Toolkit

#### [3.3.6](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.5...v3.3.6) (2025-11-06)

### UI Toolkit Angular

#### [10.1.5](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v10.1.4...v10.1.5) (2025-11-06)

### Console

#### [1.13.0](https://github.com/device-management-toolkit/console/compare/v1.12.0...v1.13.0) (2025-11-03)

Features

* adds tls configuration support and self-signed cert generation ([125fbe5](https://github.com/device-management-toolkit/console/commit/125fbe52026365b262f07165ec9ee04de22c9266)), closes [#663](https://github.com/device-management-toolkit/console/issues/663)

#### [1.12.0](https://github.com/device-management-toolkit/console/compare/v1.11.0...v1.12.0) (2025-10-22)

Bug Fixes

* **ci:** resolve go-licenses failure by upgrading to Go 1.25.x ([#683](https://github.com/device-management-toolkit/console/issues/683)) ([1cec86b](https://github.com/device-management-toolkit/console/commit/1cec86b9e4026c3d5d3a6b96a89afeb4d07fac96))

Features

* include translation files as static assets ([7738966](https://github.com/device-management-toolkit/console/commit/77389665fd1efcd07683df00c98510f8ca394d8e))

### Go WSMAN Messages

#### [2.32.4](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.32.3...v2.32.4) (2025-11-06)

### WSMAN Messages

#### [5.13.1](https://github.com/device-management-toolkit/wsman-messages/compare/v5.13.0...v5.13.1) (2025-11-06)