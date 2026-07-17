# Release Notes

!!! note "Note From the Team"

    This release marks an important milestone for rpc-go v3 (Beta) with the introduction of provisioning over the Local Manageability Engine (LME). For Linux users, this addresses a longstanding deployment pain point by enabling Intel® AMT provisioning on supported platforms without requiring Intel® LMS. It's important to note that this work is currently focused on provisioning. Other host-based capabilities that depend on Intel® LMS, such as host power management features (for example, Soft-On/Off), will continue to require LMS. We will continue expanding and hardening LME support over the coming releases.

    This release also introduces real-time provisioning progress, structured provisioning diagnostics in RPS, and expanded networking APIs that continue building toward richer device management experiences in MPS/Console.

    In upcoming releases, you will continue to see investments in Console stability, usability, and user experience, along with continued enhancements to discovery and health checker capabilities. We're also getting very close to introducing Remote Platform Erase (RPE) support in both Console and MPS, with many more exciting features and improvements planned over the coming releases.

    Follow our [Sprint Board](https://github.com/orgs/device-management-toolkit/projects/10/views/2) to learn more and track upcoming features.

    As always, thanks to everyone providing feedback, testing new functionality, and contributing to the toolkit.

    Cheers,<br>
    **The Device Management Toolkit Team**

## 🚀 What's New?

### RPC-Go v3 (Beta): Local Manageability Engine (LME) Support

rpc-go v3 (Beta) now introduces support for communicating directly with the Intel® Local Manageability Engine (LME) driver, significantly reducing the dependency on Intel® Local Management Service.

This has been one of the most requested capabilities for Linux deployments, where Intel® LMS is often unavailable. The new LME transport enables provisioning, deactivation, upgrades, and local management workflows without requiring LMS.

While rpc-go v3 remains in Beta, we encourage the community to begin testing these capabilities and sharing feedback. Additional resiliency improvements and remaining LME enhancements are already underway as we continue preparing rpc-go v3 for production readiness.

### RPS & RPC-Go: Real-Time Provisioning Progress

Provisioning now reports real-time activation progress from RPS directly to rpc-go, allowing users to monitor each stage of the activation workflow as it happens instead of waiting until the operation completes.

In addition, provisioning results are now returned as structured per-component status, making it significantly easier to understand which provisioning step succeeded or failed when troubleshooting activation issues.

### MPS: Expanded Network Management APIs

MPS continues to expand its network management capabilities with new APIs for wired network configuration, combined network settings, wireless radio state, wireless profile synchronization, and wireless profile retrieval.

### RPS & MPS: Persistent Provisioning Status

RPS now persists provisioning status to the device information stored in MPS. Users can query this status through the MPS API to review the current or most recent provisioning result for a device.

## 🧩 Enhancements & Improvements

### RPC-Go v3 (Beta): Device Discovery

rpc-go v3 (Beta) now collects and synchronizes significantly more device information with Console during discovery and device registration, including operating system details, CPU information, networking information, Intel® AMT configuration, TLS settings, and other platform details.

We'll continue building on these discovery capabilities, with much more to come in future releases.

### Sample Web UI: Enterprise-Aware CIRA Experience

The Sample Web UI now automatically enables or hides CIRA functionality based on the capabilities exposed by the connected server, providing a more streamlined experience across different deployment environments.

### Go WSMAN Messages & WSMAN Messages: Continued Wireless Management Enhancements

The underlying WS-MAN libraries continue to expand support for Intel® AMT wireless management, including additional WiFi management operations and improvements to tunneled communication over APF channels.

These enhancements continue building toward richer wireless management capabilities that will be surfaced through future Console APIs and user interface improvements.

## 🔧 Fixes & Maintenance

- RPS fixes for activation timeout handling, WiFi/proxy configuration handling, and domain certificate validation

- MPS fix to prevent Vault secrets from being deleted when the associated device lookup returns `null`

- Go WSMAN Messages and WSMAN Messages improvements for WiFi management and APF tunneled communication

- Expanded automated fuzz testing coverage for rpc-go activation workflows

- Minor dependency updates and general maintenance across toolkit components

## :material-update:{ .icon-log } Changelog
  
### RPS

#### [2.39.1](https://github.com/device-management-toolkit/rps/compare/v2.39.0...v2.39.1) (2026-07-01)

#### [2.39.0](https://github.com/device-management-toolkit/rps/compare/v2.38.2...v2.39.0) (2026-07-01)

Features

* activation: persist provisioning status to MPS deviceInfo ([#2771](https://github.com/device-management-toolkit/rps/issues/2771)) ([1a22e3b](https://github.com/device-management-toolkit/rps/commit/1a22e3b6ecb85f391d29ea79bb1ef7e2c489de7b)), closes [#2665](https://github.com/device-management-toolkit/rps/issues/2665)

#### [2.38.2](https://github.com/device-management-toolkit/rps/compare/v2.38.1...v2.38.2) (2026-07-01)

Bug Fixes

* db: dedupe profile wifi/proxy configs in Cartesian-product join ([#2770](https://github.com/device-management-toolkit/rps/issues/2770)) ([630f666](https://github.com/device-management-toolkit/rps/commit/630f666574c4c7913bd555def41f92bf68dc9679)), closes [#2665](https://github.com/device-management-toolkit/rps/issues/2665)

#### [2.38.1](https://github.com/device-management-toolkit/rps/compare/v2.38.0...v2.38.1) (2026-07-01)

Bug Fixes

* dedupe wifi/proxy added & failed status lists ([#2766](https://github.com/device-management-toolkit/rps/issues/2766)) ([2d5d9a3](https://github.com/device-management-toolkit/rps/commit/2d5d9a30632479d51637efe25509f2f6c47dc492))

#### [2.38.0](https://github.com/device-management-toolkit/rps/compare/v2.37.0...v2.38.0) (2026-07-01)

Features

* activation: stream real-time provisioning progress to rpc-go ([#2765](https://github.com/device-management-toolkit/rps/issues/2765)) ([4416fbb](https://github.com/device-management-toolkit/rps/commit/4416fbbfa4cd46494a7efd1ee5b0b073a4e3a86c)), closes [device-management-toolkit/rps#2665](https://github.com/device-management-toolkit/rps/issues/2665)

#### [2.37.0](https://github.com/device-management-toolkit/rps/compare/v2.36.7...v2.37.0) (2026-07-01)

Features

* activation: structured per-component provisioning result ([#2744](https://github.com/device-management-toolkit/rps/issues/2744)) ([47f1166](https://github.com/device-management-toolkit/rps/commit/47f1166fb5be9cd590694ef0e2787af347d80683)), closes [#2665](https://github.com/device-management-toolkit/rps/issues/2665)

#### [2.36.7](https://github.com/device-management-toolkit/rps/compare/v2.36.6...v2.36.7) (2026-06-30)

Bug Fixes

* Update the domain cert checking to cater for the edit of domain cert reupload ([#2757](https://github.com/device-management-toolkit/rps/issues/2757)) ([febfc0f](https://github.com/device-management-toolkit/rps/commit/febfc0ff632599fcf3391482c53ec25acf98426d))

#### [2.36.6](https://github.com/device-management-toolkit/rps/compare/v2.36.5...v2.36.6) (2026-06-17)

Bug Fixes

* activation: don't retry one-shot ACM activation calls on timeout ([#2743](https://github.com/device-management-toolkit/rps/issues/2743)) ([0602b24](https://github.com/device-management-toolkit/rps/commit/0602b24e161a7f3be67969a0b93730a5be9fcb1c))


### MPS

#### [2.32.2](https://github.com/device-management-toolkit/mps/compare/v2.32.1...v2.32.2) (2026-07-01)

#### [2.32.1](https://github.com/device-management-toolkit/mps/compare/v2.32.0...v2.32.1) (2026-07-01)

Bug Fixes

* api: never delete Vault secrets on a null device lookup ([#2542](https://github.com/device-management-toolkit/mps/issues/2542)) ([78b2f4d](https://github.com/device-management-toolkit/mps/commit/78b2f4d1a364e97e544a9bbcc919c48bfd9d8476))

#### [2.32.0](https://github.com/device-management-toolkit/mps/compare/v2.31.0...v2.32.0) (2026-06-26)

Features

* api: add get wireless profiles endpoint ([#2541](https://github.com/device-management-toolkit/mps/issues/2541)) ([117d97d](https://github.com/device-management-toolkit/mps/commit/117d97d80d0646dd2e4f39d276c911be3ff5d877))

#### [2.31.0](https://github.com/device-management-toolkit/mps/compare/v2.30.0...v2.31.0) (2026-06-26)

Features

* api: add wireless profile sync endpoints ([#2540](https://github.com/device-management-toolkit/mps/issues/2540)) ([fead077](https://github.com/device-management-toolkit/mps/commit/fead0772579b449eb0b5899e4786e5e7c753ec1e))

#### [2.30.0](https://github.com/device-management-toolkit/mps/compare/v2.29.0...v2.30.0) (2026-06-25)

Features

* api: add wireless radio state endpoints ([#2539](https://github.com/device-management-toolkit/mps/issues/2539)) ([266e2e6](https://github.com/device-management-toolkit/mps/commit/266e2e630b1e64202c16af211c53c00da45fcbd1))

#### [2.29.0](https://github.com/device-management-toolkit/mps/compare/v2.28.0...v2.29.0) (2026-06-19)

Features

* api: add combined network settings endpoint ([#2536](https://github.com/device-management-toolkit/mps/issues/2536)) ([2abcac7](https://github.com/device-management-toolkit/mps/commit/2abcac72a95ee16f632fb8f464ae276610b8a9b9))

#### [2.28.0](https://github.com/device-management-toolkit/mps/compare/v2.27.0...v2.28.0) (2026-06-19)

Features

* api: add patch wired network settings endpoint ([#2535](https://github.com/device-management-toolkit/mps/issues/2535)) ([abf3985](https://github.com/device-management-toolkit/mps/commit/abf3985b9ca2f8c9450510ab7138a3695017725c))

#### [2.27.0](https://github.com/device-management-toolkit/mps/compare/v2.26.7...v2.27.0) (2026-06-19)

Features

* api: add get wired network settings endpoint ([#2534](https://github.com/device-management-toolkit/mps/issues/2534)) ([d082a38](https://github.com/device-management-toolkit/mps/commit/d082a38c8010d2a8b12b5da990525ddd9630e27f))


### RPC Go

#### [2.52.1](https://github.com/device-management-toolkit/rpc-go/compare/v2.52.0...v2.52.1) (2026-07-01)

#### [2.52.0](https://github.com/device-management-toolkit/rpc-go/compare/v2.51.0...v2.52.0) (2026-07-01)

Features

* rps: display real-time activation progress on the CLI ([#1391](https://github.com/device-management-toolkit/rpc-go/issues/1391)) ([241f53c](https://github.com/device-management-toolkit/rpc-go/commit/241f53c221b958a3b6d276a5bb46305a65e1a43d)), closes [device-management-toolkit/rps#2665](https://github.com/device-management-toolkit/rps/issues/2665)

#### [2.51.0](https://github.com/device-management-toolkit/rpc-go/compare/v2.50.8...v2.51.0) (2026-07-01)

Features

* rps: display structured per-component activation result ([#1349](https://github.com/device-management-toolkit/rpc-go/issues/1349)) ([91260ad](https://github.com/device-management-toolkit/rpc-go/commit/91260ade241c412389154182b3475bef9c24118f)), closes [device-management-toolkit/rps#2665](https://github.com/device-management-toolkit/rps/issues/2665)

### RPC-Go v3 (Beta)

#### [3.0.0-beta.39](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.38...v3.0.0-beta.39) (2026-06-25)

Features

* include discovered flag in device sync payloads ([#1397](https://github.com/device-management-toolkit/rpc-go/issues/1397)) ([cf35329](https://github.com/device-management-toolkit/rpc-go/commit/cf353295882a0483ee6eecbce1957e4e38c8655e))

#### [3.0.0-beta.38](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.37...v3.0.0-beta.38) (2026-06-25)

Features

* auto-register device on 404 and sync on activation lifecycle ([#1369](https://github.com/device-management-toolkit/rpc-go/issues/1369)) ([8909e5d](https://github.com/device-management-toolkit/rpc-go/commit/8909e5dbbba24be5872e742ffec216d90a3bcd0a))

#### [3.0.0-beta.37](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.36...v3.0.0-beta.37) (2026-06-24)

Features

* Enabled ODCA verification for rpc-go activation ([cab9e79](https://github.com/device-management-toolkit/rpc-go/commit/cab9e7979f80b4ba42425a1514148a44f8b0bb88))

#### [3.0.0-beta.36](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.35...v3.0.0-beta.36) (2026-06-24)

#### [3.0.0-beta.35](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.34...v3.0.0-beta.35) (2026-06-19)

Bug Fixes

* Update fuzz tests to avoid panic supress with recoverPanic ([32b91da](https://github.com/device-management-toolkit/rpc-go/commit/32b91da5760aeb1e531f92c9c614ad22b16e2137))

#### [3.0.0-beta.34](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.33...v3.0.0-beta.34) (2026-06-19)

Bug Fixes

* copilot fix ([2d4fa93](https://github.com/device-management-toolkit/rpc-go/commit/2d4fa938c8f855bf1c199e1948fdabb6dce3ce8c))
* fix review comments ([20ff868](https://github.com/device-management-toolkit/rpc-go/commit/20ff868268196e26fb821b9ae8e9144a0158d038))
* lme: fall back to LME on TLS-enforced AMT when LMS is unavailable ([f1a87e3](https://github.com/device-management-toolkit/rpc-go/commit/f1a87e365fbfd6a0bfabb0d08fa0944ebe6a62cb))
* lme: make AMT 18.x LME activation reliable through TLS port switch ([7a279b9](https://github.com/device-management-toolkit/rpc-go/commit/7a279b940ec1eea00c62a8e77bdbb29de71d8c26))
* lme: stabilize persistent APF TLS tunnel and channel-close recovery ([379298e](https://github.com/device-management-toolkit/rpc-go/commit/379298ea722f57cf9b083c08fedd98826f062114))
* rps: copilot fix, avoid immediate reset after payload+channel-close ([fbcf8e0](https://github.com/device-management-toolkit/rpc-go/commit/fbcf8e0c5417936e7e610f532499122d4a5a5773))
* rps: copilot fix, send APF close sentinel with bounded wait ([c369418](https://github.com/device-management-toolkit/rpc-go/commit/c36941812be795e206e1d673a9ae1366b1987a41))
* rps: keep LME HECI handle open between requests ([b127efe](https://github.com/device-management-toolkit/rpc-go/commit/b127efe3252c7983723ab7c69f1e7a307a3b4d5c))

#### [3.0.0-beta.33](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.32...v3.0.0-beta.33) (2026-06-18)

Bug Fixes

* remove cleartext HTTP from localTransport.go and engine.go ([19cdbf6](https://github.com/device-management-toolkit/rpc-go/commit/19cdbf6e333068de3048b58f75fed301321fd4fd))

#### [3.0.0-beta.32](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.31...v3.0.0-beta.32) (2026-06-17)

Features

* SMBIOS UUID fallback for non-vPro device sync ([#1356](https://github.com/device-management-toolkit/rpc-go/issues/1356)) ([7f692f7](https://github.com/device-management-toolkit/rpc-go/commit/7f692f74f8ee6777918611baeb596c067f801848)), closes [#1355](https://github.com/device-management-toolkit/rpc-go/issues/1355)

#### [3.0.0-beta.31](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.30...v3.0.0-beta.31) (2026-06-17)

Bug Fixes

* fixed copilot review comments ([1356c48](https://github.com/device-management-toolkit/rpc-go/commit/1356c485c65fd45eccfa26244d62a0751143f9df))

#### [3.0.0-beta.30](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.29...v3.0.0-beta.30) (2026-06-15)

Features

* expand deviceInfo with discovery fields ([#1341](https://github.com/device-management-toolkit/rpc-go/issues/1341)) ([24170fc](https://github.com/device-management-toolkit/rpc-go/commit/24170fc4e584702510280315b130a76cb0b1aa05)), closes [#1340](https://github.com/device-management-toolkit/rpc-go/issues/1340)

### Sample Web UI

#### [3.58.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.58.0...v3.58.1) (2026-07-01)

#### [3.58.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.57.11...v3.58.0) (2026-06-11)

Features

* gate CIRA UI on server features API (enterprise) ([#3350](https://github.com/device-management-toolkit/sample-web-ui/issues/3350)) ([ed104ea](https://github.com/device-management-toolkit/sample-web-ui/commit/ed104ea31450887a433e7e170075d5279d49804c)), closes [#3200](https://github.com/device-management-toolkit/sample-web-ui/issues/3200)

#### [3.57.11](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.57.10...v3.57.11) (2026-06-04)

Bug Fixes

* e2e: update cloud activation spec for tls-tunnel implementation ([#3352](https://github.com/device-management-toolkit/sample-web-ui/issues/3352)) ([3d2f199](https://github.com/device-management-toolkit/sample-web-ui/commit/3d2f199ce77c0d864c961e94ac6ead8dc45e13b7))


### UI Toolkit

#### [3.3.17](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.16...v3.3.17) (2026-07-01)


### UI Toolkit Angular

#### [11.1.6](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v11.1.5...v11.1.6) (2026-07-01)


### UI Toolkit React

#### [5.0.6](https://github.com/device-management-toolkit/ui-toolkit-react/compare/v5.0.5...v5.0.6) (2026-07-01)


### Go WSMAN Messages

#### [2.48.1](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.48.0...v2.48.1) (2026-07-01)

#### [2.48.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.47.2...v2.48.0) (2026-06-11)

Features

* apf: support tunneled channel streams; fix close and cancel replies ([#682](https://github.com/device-management-toolkit/go-wsman-messages/issues/682)) ([de80d31](https://github.com/device-management-toolkit/go-wsman-messages/commit/de80d318d93b63c4d9c1f68f7ef343d666893d4c))


### WSMAN Messages

#### [6.1.2](https://github.com/device-management-toolkit/wsman-messages/compare/v6.1.1...v6.1.2) (2026-07-01)

#### [6.1.1](https://github.com/device-management-toolkit/wsman-messages/compare/v6.1.0...v6.1.1) (2026-07-01)

#### [6.1.0](https://github.com/device-management-toolkit/wsman-messages/compare/v6.0.3...v6.1.0) (2026-06-24)

Features

* amt: add UpdateWiFiSettings to WiFiPortConfigurationService ([#1299](https://github.com/device-management-toolkit/wsman-messages/issues/1299)) ([b6557d5](https://github.com/device-management-toolkit/wsman-messages/commit/b6557d5d6f3dce04a5d6babb9160fa4b7b497b6e)), closes [#1298](https://github.com/device-management-toolkit/wsman-messages/issues/1298)


### MPS Router

#### [2.5.12](https://github.com/device-management-toolkit/mps-router/compare/v2.5.11...v2.5.12) (2026-07-01)