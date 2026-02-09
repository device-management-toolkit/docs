

# Release Notes

!!! note "Note From the Team"
    We hope everyone had a great break and is coming back refreshed — although judging by the number of commits, not everyone managed to stay away from the keyboard 😄

    This December release includes updates across Console, RPS, MPS, RPC-Go, and supporting components. The focus this month was on expanding certificate support, adding initial CIRA-related capabilities in Console, and introducing key prerequisites for deploying Console in cloud environments, including secret management.

    Looking ahead, we have a larger team ramping up, and you should start seeing more traction across the repositories. We’re beginning work on new diagnostics features in rpc-go, which will be part of the upcoming v3 release. Most major rpc-go features are now being developed directly for v3. We’re also tracking customer-requested improvements, such as additional hot-key options in the Console UI.

    The longer-term goal remains the same: Console evolving into a unified service that can be used for both Cloud and Enterprise deployments, and you’ll continue to see us move steadily in that direction.

Cheers,  
**The Device Management Toolkit Team**

## 🚀 What's New?

### Console: Optional Web UI Build (noui)

This release introduces the `noui build tag, allowing you to compile a smaller Console binary without the embedded web UI. The Console UI is a static Angular application that is bundled into the executable by default for convenience and all-in-one deployments.

For cloud and headless deployments, we now also publish headless Console binaries built without the embedded UI, such as **Windows x64 Console headless (No UI)**. When the UI is hosted independently, building Console with `go build -tags noui` or using the headless binaries can reduce the binary size by approximately `100 MB`.

### Console: Initial Support for CIRA Connections

We’ve added initial support for CIRA connections in Console, enabling CIRA-related workflows. At this stage, Console does not support automatic CIRA configuration through rpc-go. CIRA profiles can be added manually via RPC-GO, but automated configuration (similar to RPS) is planned for upcoming releases.

### Console: Vault Secret Store Integration

As part of preparing Console for cloud deployments, Console now supports integrating with HashiCorp Vault as a secret store. This allows sensitive configuration, such as credentials and secrets, to be managed securely running in cloud environments.

### Console: Network Link Preference API 

This capability was added to MPS in a previous monthly release and is now also available in Console. The API allows control over AMT network link preferences via
`/network/linkPreference/{guid}`.

This is primarily useful when AMT is connected over a wireless network. If users need to influence how the ME accesses the network, they can leverage this API to control Wi-Fi link selection and related behavior.

## 🧩 Enhancements & Improvements

### MPS: Support for 3K Key Size CIRA Certificates

MPS now supports `3K` key size CIRA certificates, improving compatibility with environments using larger key sizes for CIRA deployments.

### RPS: SHA-384 Provisioning Certificate Support

RPS now supports `SHA-384` provisioning certificate chain, expanding compatibility with stronger hashes.

## 🔧 Fixes & Maintenance

- RPC-Go fixes related to SkipAmtCertCheck and hostname verification behavior for AMT 19+ platforms

- RPC-Go fix to ensure `stdout` and `stderr` are correctly captured in output variables

- MPS fix to detect Wi-Fi ethernet using InstanceID instead of PhysicalConnectionType

- MPS fix to return a default value for `OSPowerSavingState` when a device is powered off

- Sample Web UI fixes for blank GUID handling in enterprise mode and snackbar success styling

- go-wsman-messages improvements to randomize password generation

- Minor fixes and dependency updates across all toolkit components

## :material-update:{ .icon-log } Changelog
  
### RPS

#### [2.31.1](https://github.com/device-management-toolkit/rps/compare/v2.31.0...v2.31.1) (2026-01-08)

#### [2.31.0](https://github.com/device-management-toolkit/rps/compare/v2.30.4...v2.31.0) (2025-12-29)

Features

* Support for SHA384 Provisioning Certificates for RPS ([#2434](https://github.com/device-management-toolkit/rps/issues/2434)) ([01650c3](https://github.com/device-management-toolkit/rps/commit/01650c34ebf2778c6e3a77bfdfb809baf73ea857))

### MPS

#### [2.25.4](https://github.com/device-management-toolkit/mps/compare/v2.25.3...v2.25.4) (2026-01-08)

#### [2.25.3](https://github.com/device-management-toolkit/mps/compare/v2.25.2...v2.25.3) (2026-01-05)

Bug Fixes

* Return default value for OSPowerSavingState when device is powered off ([#2277](https://github.com/device-management-toolkit/mps/issues/2277)) ([f7a0adf](https://github.com/device-management-toolkit/mps/commit/f7a0adf26ab90a100a4fd87732be3fd372c6bd2d))

#### [2.25.2](https://github.com/device-management-toolkit/mps/compare/v2.25.1...v2.25.2) (2025-12-22)

Bug Fixes

* get WiFi eth by InstanceID instead of PhysicalConnectionType ([#2267](https://github.com/device-management-toolkit/mps/issues/2267)) ([0262a01](https://github.com/device-management-toolkit/mps/commit/0262a017e67832e6e79bd8d5e9d3152dd384ec21))

#### [2.25.1](https://github.com/device-management-toolkit/mps/compare/v2.25.0...v2.25.1) (2025-12-17)

Bug Fixes

* Support for 3K Key Size for CIRA Certificates ([71b673f](https://github.com/device-management-toolkit/mps/commit/71b673f25440c61ae364cf23e5e81d9b327554ba))

---

#### [2.25.0](https://github.com/device-management-toolkit/mps/compare/v2.24.0...v2.25.0) (2025-12-11)

Features

* implement certificate deletion functionality with safety guards ([#2221](https://github.com/device-management-toolkit/mps/issues/2221)) ([9ede411](https://github.com/device-management-toolkit/mps/commit/9ede411ca8439b23eaef20267621a35b3df79f34))

#### [2.24.0](https://github.com/device-management-toolkit/mps/compare/v2.23.0...v2.24.0) (2025-12-03)

Features

* add setLinkPreference API for MPS ([#2212](https://github.com/device-management-toolkit/mps/issues/2212)) ([9e2a7fb](https://github.com/device-management-toolkit/mps/commit/9e2a7fb93327422f7399b4c29b65c063d0567c3d))

#### [2.23.0](https://github.com/device-management-toolkit/mps/compare/v2.22.5...v2.23.0) (2025-11-20)

Features

* support KVM ending detection in wsRedirect ([#2201](https://github.com/device-management-toolkit/mps/issues/2201)) ([6cb9ef7](https://github.com/device-management-toolkit/mps/commit/6cb9ef757b8198e404ef6f927902bd39b2b5cb2c))

### RPC Go

#### [2.48.14](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.13...v2.48.14) (2026-01-12)

#### [2.48.13](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.12...v2.48.13) (2026-01-06)

Bug Fixes

* capturing stdout and stderr to output variable ([b6dc09e](https://github.com/device-management-toolkit/rpc-go/commit/b6dc09ebb1c6aadf8a708602d382ce9189747a11))

#### [2.48.12](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.11...v2.48.12) (2026-01-06)

Bug Fixes

* apply SkipAmtCertCheck flag to all TLS configurations ([#1080](https://github.com/device-management-toolkit/rpc-go/issues/1080)) ([eb056e7](https://github.com/device-management-toolkit/rpc-go/commit/eb056e7ecc46aaf67e620abfeccedebc5ee92bf7)), closes [#1068](https://github.com/device-management-toolkit/rpc-go/issues/1068)

#### [2.48.11](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.10...v2.48.11) (2026-01-05)

Bug Fixes

* bypasses hostname verification for AMT 19+ certificates with -n or -skipamtcertcheck ([#1071](https://github.com/device-management-toolkit/rpc-go/issues/1071)) ([41cc832](https://github.com/device-management-toolkit/rpc-go/commit/41cc832b9b83c52f2d30408f01f4b105824db215))

### Sample Web UI

#### [3.52.3](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.52.2...v3.52.3) (2026-01-12)

Bug Fixes

* updates class to use success for snackbar when creating profile ([#3066](https://github.com/device-management-toolkit/sample-web-ui/issues/3066)) ([d3ec564](https://github.com/device-management-toolkit/sample-web-ui/commit/d3ec564fd62be8bed429c9483527ef4dd4b8fdd9))

#### [3.52.2](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.52.1...v3.52.2) (2026-01-12)

Bug Fixes

* addresses issue with blank guid when saving non-cira device in enterprise mode ([79c887a](https://github.com/device-management-toolkit/sample-web-ui/commit/79c887aa2fafda61f41dee7d55c251c8a476a22b))

### UI Toolkit

#### [3.3.9](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.8...v3.3.9) (2026-01-08)

### UI Toolkit Angular

#### [11.0.1](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v11.0.0...v11.0.1) (2026-01-08)

#### [11.0.0](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v10.1.6...v11.0.0) (2026-01-08)

* build(deps)!: upgrade angular to v21 ([#2185](https://github.com/device-management-toolkit/ui-toolkit-angular/issues/2185)) ([c2f7e51](https://github.com/device-management-toolkit/ui-toolkit-angular/commit/c2f7e518b6a6c66ee31a497cba2f4769d9c70c85))

BREAKING CHANGES

* Upgraded peer dependency from Angular v20 to v21.
    Downstream applications may require code changes to support
    Angular 21 APIs and behaviors.

### UI Toolkit React

#### [4.0.6](https://github.com/device-management-toolkit/ui-toolkit-react/compare/v4.0.5...v4.0.6) (2026-01-08)

### Console

#### [1.18.0](https://github.com/device-management-toolkit/console/compare/v1.17.0...v1.18.0) (2026-01-06)

This release introduces the `noui` build tag, allowing you to compile a smaller binary without the embedded web UI. The Console UI is a static Angular application that we bundle into the executable for convenience, providing an all-in-one deployment experience. However, for production environments, we recommend deploying the UI separately using platforms like Azure Static Web Apps or AWS Amplify Hosting for cloud-based hosting, or traditional web servers like IIS or NGINX for on-premises deployments. By building with `go build -tags noui`, you can reduce the binary size by ~100MB when the UI is hosted independently, while still retaining the option to use the full bundled executable for simpler setups or development scenarios.

Features

* add build flags for reduced binary size ([#737](https://github.com/device-management-toolkit/console/issues/737)) ([3940981](https://github.com/device-management-toolkit/console/commit/394098190d12979eba2aa058131181489cec4cae))

#### [1.17.0](https://github.com/device-management-toolkit/console/compare/v1.16.0...v1.17.0) (2025-12-23)

Features

* SetLinkPreference API with timeout for WiFi port ([332be3a](https://github.com/device-management-toolkit/console/commit/332be3adc440b7a30dfedc1b1de23daef0dfb0e0))

#### [1.16.0](https://github.com/device-management-toolkit/console/compare/v1.15.0...v1.16.0) (2025-12-15)

Features

* adds support for CIRA connections in console ([6af7325](https://github.com/device-management-toolkit/console/commit/6af7325aee530b085eb0b8469f4341bd7a863eee)), closes [#684](https://github.com/device-management-toolkit/console/issues/684)

#### [1.15.0](https://github.com/device-management-toolkit/console/compare/v1.14.1...v1.15.0) (2025-12-10)

Bug Fixes

* clean up linting errors and test failures, address api tests, remove invalid default config ([bb5af18](https://github.com/device-management-toolkit/console/commit/bb5af18ce42f82bc0fd229d956222867accd0788))

Features

* enables secret store integration using vault ([6c056f0](https://github.com/device-management-toolkit/console/commit/6c056f0fe84698a6c94f77e9f6cd08186232e665))
* **secrets:** Vault integration ([dd4aace](https://github.com/device-management-toolkit/console/commit/dd4aacef38bc681312733704813753ea367429a8))


### Go WSMAN Messages

#### [2.36.1](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.36.0...v2.36.1) (2026-01-07)

#### [2.36.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.35.0...v2.36.0) (2025-12-19)

Features

* add SetLinkPreference with timeout ([#622](https://github.com/device-management-toolkit/go-wsman-messages/issues/622)) ([18fbf1d](https://github.com/device-management-toolkit/go-wsman-messages/commit/18fbf1d94e1f8c0799c71cbc31f883c7f9ef2beb))

#### [2.35.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.34.1...v2.35.0) (2025-12-12)

Features

* adds cira channel manager ([#618](https://github.com/device-management-toolkit/go-wsman-messages/issues/618)) ([4329fb2](https://github.com/device-management-toolkit/go-wsman-messages/commit/4329fb294967b2ed699cb549ef96bbea484b1fc0))

#### [2.34.1](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.34.0...v2.34.1) (2025-12-11)

Bug Fixes

* correct random generate password type ([#617](https://github.com/device-management-toolkit/go-wsman-messages/issues/617)) ([6ee7f62](https://github.com/device-management-toolkit/go-wsman-messages/commit/6ee7f626782ee3b2b672c922167b71fe9f18cde5))

#### [2.34.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.33.0...v2.34.0) (2025-12-10)

Features

* add random generate passwords to config ([#616](https://github.com/device-management-toolkit/go-wsman-messages/issues/616)) ([c224e58](https://github.com/device-management-toolkit/go-wsman-messages/commit/c224e58f0a2b24eae907f90fb2fbbd8be0ac3ab9))

### WSMAN Messages

#### [5.14.3](https://github.com/device-management-toolkit/wsman-messages/compare/v5.14.2...v5.14.3) (2026-01-08)

#### [5.14.2](https://github.com/device-management-toolkit/wsman-messages/compare/v5.14.1...v5.14.2) (2026-01-08)

### MPS Router

#### [2.5.6](https://github.com/device-management-toolkit/mps-router/compare/v2.5.5...v2.5.6) (2026-01-07)