--8<-- "References/abbreviations.md"

# Release Notes

!!! note "Note From the Team"
    Hey Everyone,

    It has been a long few months since our last communicated release, and I want to take a moment to acknowledge that. Our team here at Intel has been through a number of changes—some exciting, others bittersweet. We’ve had to say goodbye to several valued colleagues, and we are deeply grateful for their contributions.  

    You may also have noticed that we’ve paused our monthly video updates. We know they provide useful insights into our work and roadmap; however, our focus has shifted to ensure we are getting our features out in a timely manner.

    The work itself has never stopped. Development for version **3.0** is moving forward strongly, and we’re excited about the features in this release. While this is the first formal communication since March, we want to remind you that we continuously ship updates as features are developed. Be sure to check the repositories regularly for the latest tagged versions.  

    We encourage you to reach out to us on Discord with questions, feedback, or suggestions. This project has always been about building together with the community, and we greatly value your input.  

    *Best wishes,*  
    **Mike Johanson**
    Lead Developer / Architect  
    The Device Management Toolkit Team  

## 🚀 What's New?

### :material-new-box:{ .icon-new } Feature: Multi-Monitor KVM

You can now switch between multiple displays during an active AMT KVM session without disconnecting. This makes remote troubleshooting on multi-monitor systems seamless and efficient.

### :material-new-box:{ .icon-new } Feature: One-Click Recovery (OCR)

One-Click Recovery (OCR) allows IT administrators to remotely trigger a secure and reliable boot to a recovery application, environment, or network boot, ensuring recovery from system failures with minimum downtime.

Device Management Toolkit (DMT) now supports the complete One-Click Recovery (OCR) feature set across both cloud and enterprise deployments. Supported Recovery Options include:

- UEFI HTTPS Network Boot – Securely boot a recovery image over HTTPS.
- Windows Recovery Environment (WinRE) – Access Windows repair and troubleshooting tools.
- Local Pre-Boot Application (PBA) – Launch a locally installed diagnostic or recovery utility.

See the [MPS](https://device-management-toolkit.github.io/docs/2.28/Tutorials/ocrTutorial/) and [Console](https://device-management-toolkit.github.io/docs/2.28/Reference/Console/Features/ocr/) guides for setup details.

### :material-new-box:{ .icon-new } Feature: KVM Hot-Key Support

You can now send common keyboard shortcuts directly through the KVM interface for faster remote troubleshooting and configuration. The UI provides predefined options to send hot-key combinations such as `Ctrl + Alt + Del`, `Alt + Tab`, `Win + R`, and others, making it easier to perform essential actions during remote sessions.

### :material-new-box:{ .icon-new } Feature: Proxy Configuration Support

Customer environments with devices behind a proxy can now define proxy settings (address, port, and credentials) as part of AMT configuration profiles. This enables AMT to connect to MPS or a cloud service over a proxy, ensuring secure and compliant network routing.

Thanks to contributions from `Blanca Ortega` and `Fernando Madrigal` for this feature.

### :material-new-box:{ .icon-new } Feature: Secure Host‑Based Configuration (SHBC)

Provision supported platforms securely over mTLS to ACM using RPC-Go local activation. Failed ACM attempts are now cleaned up automatically, preventing devices from getting stuck in partial configuration states and ensuring a smoother provisioning experience.

### :material-new-box:{ .icon-new } Feature: Certificate and profile management

- List and add AMT certificates through the server API to simplify rotation.
- Export local profiles from the provisioning service to back up or migrate fleets.

## :material-speedometer:{ .icon-perf } Quality of Life Improvements

- Increased CIRA window size to maintain a larger buffer and improve KVM performance during remote sessions.
- Improved KVM behavior when switching encodings or combining SOL/IDER sessions.
- Strengthened CLI handling for invalid URLs and added an option to skip AMT certificate verification.
- Added support to specify a PostgreSQL SSL certificate path for stricter database security.
- Introduced Local CIRA configuration, an important step towards the 3.0 architecture.

## :material-checkbox-marked:{ .icon-new } Resolved Issues

This release includes security updates, stability improvements, and bug fixes across MPS, RPS, RPC-Go, UI-Toolkit, and other components.

Below are a few key highlights:

- Fixed KVM stability issues when switching encoding or combining SOL/IDER connections.
- Fixed issue where SOL sessions did not display the BIOS screen after performing a Reset to BIOS action.
- Corrected certificate upload statuses in the Sample-Web-UI and devices view.
- Fixed panic scenarios in RPC‑Go with invalid RPS URLs.

## :material-handshake:{ .icon-handshake } Community Contributions

Special thanks to our community contributors `@jclab-joseph` and `@KalleDK` for minor bug fixes in this release. We appreciate their contributions!

## :material-arrow-up-bold:{ .icon-upgrade } Upgrade Path

This release includes schema changes specific to RPS. Before deploying the latest RPS image, follow the steps in the [Upgrade Guide](https://device-management-toolkit.github.io/docs/2.28/Deployment/upgradeVersion/) to apply the necessary database updates.

## :material-alert-circle-outline:{ .icon-opens } Open Issues and Requests

- **Bulk Provisioning & Performance:** Enhancements to bulk device provisioning, registration, and performance tuning are planned for upcoming releases.

- **Logging & Compliance:** Community requests for improved logging and audit compliance are currently under evaluation.

- **OCR Workflows:** We continue to gather feedback and make iterative improvements to OCR workflows.

## :material-update:{ .icon-log } Changelog
  
### RPS

#### [2.29.1](https://github.com/device-management-toolkit/rps/compare/v2.29.0...v2.29.1) (2025-10-13)

Bug Fixes

* Local ipsync and wifisync configurations ([#2375](https://github.com/device-management-toolkit/rps/issues/2375)) ([36f1272](https://github.com/device-management-toolkit/rps/commit/36f1272a46dc3e31fb3e60c4fe40dff027f40d23))

#### [2.29.0](https://github.com/device-management-toolkit/rps/compare/v2.28.0...v2.29.0) (2025-10-10)

Features

* adds UEFIWiFiSyncEnabled for OCR ([#2319](https://github.com/device-management-toolkit/rps/issues/2319)) ([9b799a9](https://github.com/device-management-toolkit/rps/commit/9b799a943e7732e4479f37818f30668c4703fb91))


#### [2.28.0](https://github.com/device-management-toolkit/rps/compare/v2.27.1...v2.28.0) (2025-10-08)

Features

* enable http proxy for cira ([#2352](https://github.com/device-management-toolkit/rps/issues/2352)) ([5b9ede0](https://github.com/device-management-toolkit/rps/commit/5b9ede0dedac2cbbdbb7e24254359404fca836bd))


#### [2.27.1](https://github.com/device-management-toolkit/rps/compare/v2.27.0...v2.27.1) (2025-08-20)

Bug Fixes

* apply localWifiSyncEnabled value from profile instead of defaulting ([#2287](https://github.com/device-management-toolkit/rps/issues/2287)) ([c63b3c0](https://github.com/device-management-toolkit/rps/commit/c63b3c0a41535774585b93b9207c94ea71dee09e))

#### [2.27.0](https://github.com/device-management-toolkit/rps/compare/v2.26.0...v2.27.0) (2025-06-30)

Features

* allow specifying path to ssl certs for postgres ([#2176](https://github.com/device-management-toolkit/rps/issues/2176)) ([04b34eb](https://github.com/device-management-toolkit/rps/commit/04b34eb51ee00978035417577f37d877e7a97ea6))

#### [2.26.0](https://github.com/device-management-toolkit/rps/compare/v2.25.1...v2.26.0) (2025-06-30)

Features

* **api:** add export endpoint for local ([a0be4c5](https://github.com/device-management-toolkit/rps/commit/a0be4c5082972bfc3467e18253496a705e69ca7e))
* enable export endpoint ([7615649](https://github.com/device-management-toolkit/rps/commit/7615649afb49ade581794a23012391e172a49a86))

#### [2.25.1](https://github.com/device-management-toolkit/rps/compare/v2.25.0...v2.25.1) (2025-06-05)

Bug Fixes

* deactivates when shbc acm fails ([#2167](https://github.com/device-management-toolkit/rps/issues/2167)) ([fe47416](https://github.com/device-management-toolkit/rps/commit/fe474162893e6cc13c4befabfbdec28d5224a3c4))

#### [2.25.0](https://github.com/device-management-toolkit/rps/compare/v2.24.0...v2.25.0) (2025-06-02)

Features

* Secure host based configuration acm ([#2164](https://github.com/device-management-toolkit/rps/issues/2164)) ([a2c82cf](https://github.com/device-management-toolkit/rps/commit/a2c82cfceb74204d51975f1b5bfb4ff9462321c5))

#### [2.24.0](https://github.com/device-management-toolkit/rps/compare/v2.23.1...v2.24.0) (2025-03-17)

Features

* enable multiarch build ([80f19cc](https://github.com/device-management-toolkit/rps/commit/80f19cc496ea1c6cf45c86cf287c7b4bb00a4288))


### MPS

#### [2.22.3](https://github.com/device-management-toolkit/mps/compare/v2.22.2...v2.22.3) (2025-10-14)

Bug Fixes

* get boot source for ocr boot ([#2163](https://github.com/device-management-toolkit/mps/issues/2163)) ([be6e611](https://github.com/device-management-toolkit/mps/commit/be6e6114c590e73209211ba5b42f3fc385c12cc3))

#### [2.22.2](https://github.com/device-management-toolkit/mps/compare/v2.22.1...v2.22.2) (2025-10-13)

Bug Fixes

* **api:** get boot source ([#2162](https://github.com/device-management-toolkit/mps/issues/2162)) ([3cb6fa8](https://github.com/device-management-toolkit/mps/commit/3cb6fa8b7a1af9f02b670ddffa283c057ffca810))

#### [2.22.1](https://github.com/device-management-toolkit/mps/compare/v2.22.0...v2.22.1) (2025-10-10)

#### [2.22.0](https://github.com/device-management-toolkit/mps/compare/v2.21.0...v2.22.0) (2025-09-30)

Features

* enable KVM multi-monitor support ([#2129](https://github.com/device-management-toolkit/mps/issues/2129)) ([858f5ad](https://github.com/device-management-toolkit/mps/commit/858f5ad8e6639ae2771b2576590cf08e3a1ecf05))

#### [2.21.0](https://github.com/device-management-toolkit/mps/compare/v2.20.3...v2.21.0) (2025-09-24)

Features

* adds OCR local PBA and WinRE ([#2112](https://github.com/device-management-toolkit/mps/issues/2112)) ([f6d648c](https://github.com/device-management-toolkit/mps/commit/f6d648cc534793b0df866cba8df99b074bdb6316))

#### [2.20.3](https://github.com/device-management-toolkit/mps/compare/v2.20.2...v2.20.3) (2025-09-10)

Performance Improvements

* **cira:** bump default window size to 80KB ([#2109](https://github.com/device-management-toolkit/mps/issues/2109)) ([8b5264b](https://github.com/device-management-toolkit/mps/commit/8b5264bf592c4515076e4d16501f9501f2b45d51))

#### [2.20.2](https://github.com/device-management-toolkit/mps/compare/v2.20.1...v2.20.2) (2025-08-01)

Bug Fixes

* typo in winre boot ([#2074](https://github.com/device-management-toolkit/mps/issues/2074)) ([04ee5ab](https://github.com/device-management-toolkit/mps/commit/04ee5ab6f0e33f735d8a6fbdd21b26ce1b15af52))

#### [2.20.1](https://github.com/device-management-toolkit/mps/compare/v2.20.0...v2.20.1) (2025-07-31)

Bug Fixes

* adds HTTP, WinRE and PBA to OCR status ([#2072](https://github.com/device-management-toolkit/mps/issues/2072)) ([3606a8c](https://github.com/device-management-toolkit/mps/commit/3606a8c75ce7d3cc2d5b8b6ba80d4e2e360fcf89))

#### [2.20.0](https://github.com/device-management-toolkit/mps/compare/v2.19.1...v2.20.0) (2025-07-31)

Features

* **api:** update bootoptions for OCR ([#2070](https://github.com/device-management-toolkit/mps/issues/2070)) ([4ab9f73](https://github.com/device-management-toolkit/mps/commit/4ab9f73902792be0a15bb880ff7b80953047d59a))

#### [2.19.1](https://github.com/device-management-toolkit/mps/compare/v2.19.0...v2.19.1) (2025-07-29)

#### [2.19.0](https://github.com/device-management-toolkit/mps/compare/v2.18.0...v2.19.0) (2025-07-29)


Features

* **api:** add OCR to get and set of amt features ([#2064](https://github.com/device-management-toolkit/mps/issues/2064)) ([24c73ea](https://github.com/device-management-toolkit/mps/commit/24c73ea06138378de3c26200d155baef7b132655))

#### [2.18.0](https://github.com/device-management-toolkit/mps/compare/v2.17.0...v2.18.0) (2025-07-24)


Features

* **api:** get and add amt certificates ([#2052](https://github.com/device-management-toolkit/mps/issues/2052)) ([fcb5e6e](https://github.com/device-management-toolkit/mps/commit/fcb5e6e735770c0cd3a76258a82656352cda9320))

#### [2.17.0](https://github.com/device-management-toolkit/mps/compare/v2.16.1...v2.17.0) (2025-05-01)


Features

* **api:** manage power state timeout ([#1929](https://github.com/device-management-toolkit/mps/issues/1929)) ([9ff7526](https://github.com/device-management-toolkit/mps/commit/9ff7526becaadb491c0e71bc38ea0598f278726b))

#### [2.16.1](https://github.com/device-management-toolkit/mps/compare/v2.16.0...v2.16.1) (2025-04-21)


Bug Fixes

* grab req.tenantId for device token ([#1908](https://github.com/device-management-toolkit/mps/issues/1908)) ([f006d6d](https://github.com/device-management-toolkit/mps/commit/f006d6df59e0d9690f39dedc5b1ddc55f040634e)), closes [#1767](https://github.com/device-management-toolkit/mps/issues/1767)

#### [2.16.0](https://github.com/device-management-toolkit/mps/compare/v2.15.0...v2.16.0) (2025-04-11)


Features

* **api:** manage OS Power Saving State ([#1869](https://github.com/device-management-toolkit/mps/issues/1869)) ([0b98295](https://github.com/device-management-toolkit/mps/commit/0b98295c9cb152eeec6e27c0faadc69b2f6fad18))

#### [2.15.0](https://github.com/device-management-toolkit/mps/compare/v2.14.2...v2.15.0) (2025-03-18)


Features

* **docker:** enable multiarch build ([70e7d55](https://github.com/device-management-toolkit/mps/commit/70e7d55fd04bb36931f79c2a2acbeedddacaad6d))

#### [2.14.2](https://github.com/device-management-toolkit/mps/compare/v2.14.1...v2.14.2) (2025-03-12)


Bug Fixes

* removed unnecessary import ([d02be86](https://github.com/device-management-toolkit/mps/commit/d02be861ce20f5f46ff069c70d9ac8eab90e6dfd))

### RPC Go

#### [2.48.2](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.1...v2.48.2) (2025-07-03)


Bug Fixes

* **deps:** update go-wsman-messages calls to use pointers for PUT ([c276a0d](https://github.com/device-management-toolkit/rpc-go/commit/c276a0d74b864898a123680f23c8c4f381cd2e90))

#### [2.48.1](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.0...v2.48.1) (2025-07-03)


Reverts

* leverage kong cli for better organization of cli commands ([2386bdb](https://github.com/device-management-toolkit/rpc-go/commit/2386bdb3e04cfb1b3476c29b49c27bde5b32be09))

#### [2.48.0](https://github.com/device-management-toolkit/rpc-go/compare/v2.47.3...v2.48.0) (2025-07-01)


Features

* adds UEFIWiFiSyncEnabled is added to config for OCR ([bc4855d](https://github.com/device-management-toolkit/rpc-go/commit/bc4855d65af38a800da21afe13d69f5f06f5edfc))

#### [2.47.3](https://github.com/device-management-toolkit/rpc-go/compare/v2.47.2...v2.47.3) (2025-06-17)


Bug Fixes

* address panic when incorrect URL for RPS ([72cf72e](https://github.com/device-management-toolkit/rpc-go/commit/72cf72e59a3dccf766e2810e0680dca3cbb9c3bd))

#### [2.47.2](https://github.com/device-management-toolkit/rpc-go/compare/v2.47.1...v2.47.2) (2025-06-09)


Bug Fixes

* add seperate check to skip amt cert verification ([#858](https://github.com/device-management-toolkit/rpc-go/issues/858)) ([d5c65a9](https://github.com/device-management-toolkit/rpc-go/commit/d5c65a90f9be865ced9bb8a66fe8dd9cf4d0d02e))

#### [2.47.1](https://github.com/device-management-toolkit/rpc-go/compare/v2.47.0...v2.47.1) (2025-05-16)


Bug Fixes

* add commit for ccm SHBC ([fc184d3](https://github.com/device-management-toolkit/rpc-go/commit/fc184d32848d646579253e5262b1f1469b122602))

#### [2.47.0](https://github.com/device-management-toolkit/rpc-go/compare/v2.46.1...v2.47.0) (2025-05-15)


Features

* adds support for secure host based configuration ([4e7753e](https://github.com/device-management-toolkit/rpc-go/commit/4e7753e660f6d0efb7e37d351fbfe2aeed999422)), closes [#797](https://github.com/device-management-toolkit/rpc-go/issues/797)

#### [2.46.1](https://github.com/device-management-toolkit/rpc-go/compare/v2.46.0...v2.46.1) (2025-04-09)


Bug Fixes

* updates CCM AMT features except user consent ([53b5ade](https://github.com/device-management-toolkit/rpc-go/commit/53b5ade262e2899fa5ef0c531a9fa4fb45911fa2))

#### [2.46.0](https://github.com/device-management-toolkit/rpc-go/compare/v2.45.1...v2.46.0) (2025-04-09)


Features

* enable local cira configuration ([6d0d648](https://github.com/device-management-toolkit/rpc-go/commit/6d0d648749300c5074bc627adbef07c505f35e98))

#### [2.45.1](https://github.com/device-management-toolkit/rpc-go/compare/v2.45.0...v2.45.1) (2025-03-25)


Bug Fixes

* prevent partial unprovision in CCM (only allow in ACM) ([afb7112](https://github.com/device-management-toolkit/rpc-go/commit/afb71120d2adceba8d910041c0d66ccd1b683727))

#### [2.45.0](https://github.com/device-management-toolkit/rpc-go/compare/v2.44.0...v2.45.0) (2025-03-24)


Features

* adds support for partial unprovisioning ([a78f092](https://github.com/device-management-toolkit/rpc-go/commit/a78f0925f9f9cae182f899fd43c2c98860350589)), closes [#781](https://github.com/device-management-toolkit/rpc-go/issues/781)

#### [2.44.0](https://github.com/device-management-toolkit/rpc-go/compare/v2.43.1...v2.44.0) (2025-03-19)


Features

* add -all flag to list all amtinfo including cert hashes ([db702c0](https://github.com/device-management-toolkit/rpc-go/commit/db702c0caf9611bb674e449bb5d69f24b872757b))


### Sample Web UI

#### [3.46.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.46.0...v3.46.1) (2025-10-13)

#### [3.46.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.45.0...v3.46.0) (2025-10-10)

Features

* adds UEFI wifi sync  to profile ([#2880](https://github.com/device-management-toolkit/sample-web-ui/issues/2880)) ([6c78c73](https://github.com/device-management-toolkit/sample-web-ui/commit/6c78c73a5e90945f67f7b9e657c974ff45460b98))

#### [3.45.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.44.0...v3.45.0) (2025-10-09)

Features

* **profiles:** add proxy support to profile configuration ([#2901](https://github.com/device-management-toolkit/sample-web-ui/issues/2901)) ([caf59d0](https://github.com/device-management-toolkit/sample-web-ui/commit/caf59d05a61dca19c2ca3df340ea74b35faeca17))

#### [3.44.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.43.0...v3.44.0) (2025-09-30)

Features

* enable selecting display ([#2891](https://github.com/device-management-toolkit/sample-web-ui/issues/2891)) ([3f83412](https://github.com/device-management-toolkit/sample-web-ui/commit/3f83412537176bb16cbe6112adda8775874dff5e))


#### [3.43.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.42.7...v3.43.0) (2025-09-24)


Features

* adds OCR local PBA and WinRE ([0a889fc](https://github.com/device-management-toolkit/sample-web-ui/commit/0a889fc0697dc0ba40172891246e4f86da62cec8))

#### [3.42.7](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.42.6...v3.42.7) (2025-08-23)


Bug Fixes

* addresses connection issue with KVM when switching encoding ([995e867](https://github.com/device-management-toolkit/sample-web-ui/commit/995e86710a50b3a40c0066fc992fc7ef8c2575f3))

#### [3.42.6](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.42.5...v3.42.6) (2025-08-21)


Bug Fixes

* squashes bugs with KVM, IDER with SOL connections ([134cff6](https://github.com/device-management-toolkit/sample-web-ui/commit/134cff6237b260b5433c4172adeacf00f68ea795))

#### [3.42.5](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.42.4...v3.42.5) (2025-08-20)


Bug Fixes

* ui not showing cert uploaded ([#2805](https://github.com/device-management-toolkit/sample-web-ui/issues/2805)) ([242a95f](https://github.com/device-management-toolkit/sample-web-ui/commit/242a95fc8f368e7315e57b6651e94711eb0b4073))

#### [3.42.4](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.42.3...v3.42.4) (2025-08-06)


Bug Fixes

* device power status ([#2791](https://github.com/device-management-toolkit/sample-web-ui/issues/2791)) ([3a1f0d2](https://github.com/device-management-toolkit/sample-web-ui/commit/3a1f0d21ce5e22b6ecb515b632f9847f629ff40e))

#### [3.42.3](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.42.2...v3.42.3) (2025-08-06)


Bug Fixes

* domain cert upload status ([#2790](https://github.com/device-management-toolkit/sample-web-ui/issues/2790)) ([434ad61](https://github.com/device-management-toolkit/sample-web-ui/commit/434ad614452f3c2f6d50c6e532fc51a324bcec01))

#### [3.42.2](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.42.1...v3.42.2) (2025-08-06)


Bug Fixes

* status update on cert upload in devices ([#2789](https://github.com/device-management-toolkit/sample-web-ui/issues/2789)) ([534a4d9](https://github.com/device-management-toolkit/sample-web-ui/commit/534a4d9d2ceef12825e7ad5aac327ef84dc37d56))

#### [3.42.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.42.0...v3.42.1) (2025-08-01)


Bug Fixes

* disable read-only features of ocr ([#2782](https://github.com/device-management-toolkit/sample-web-ui/issues/2782)) ([4fc9bbf](https://github.com/device-management-toolkit/sample-web-ui/commit/4fc9bbf29e570eb7ec4ce074d5dab9b36bd0c41f))

#### [3.42.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.41.0...v3.42.0) (2025-07-31)


Features

* adds http, winre and pba support to ocr status ([#2780](https://github.com/device-management-toolkit/sample-web-ui/issues/2780)) ([5cdd39f](https://github.com/device-management-toolkit/sample-web-ui/commit/5cdd39f1a0091fad7057d1ca0a4e2ac8a42dabe9))

#### [3.41.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.40.0...v3.41.0) (2025-07-31)


Features

* add ocr to cloud environment ([#2778](https://github.com/device-management-toolkit/sample-web-ui/issues/2778)) ([23870ee](https://github.com/device-management-toolkit/sample-web-ui/commit/23870ee8b07f7ede7c55630064d5e8ba7d0d1e67))

#### [3.40.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.39.0...v3.40.0) (2025-07-29)


Features

* enable hotkey drop down for KVM ([6a12c7f](https://github.com/device-management-toolkit/sample-web-ui/commit/6a12c7ff02db589aa95211fda9b6f3b11e33f0c9))

#### [3.39.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.38.0...v3.39.0) (2025-07-02)


Features

* adds UEFIWiFiSyncEnabled is added to profile for OCR ([#2726](https://github.com/device-management-toolkit/sample-web-ui/issues/2726)) ([01f2a53](https://github.com/device-management-toolkit/sample-web-ui/commit/01f2a53ae0a265a66656336c1e2c5b815c57354e))

#### [3.38.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.37.0...v3.38.0) (2025-05-05)


Features

* sso config ([ec201fc](https://github.com/device-management-toolkit/sample-web-ui/commit/ec201fca2d027ada799e6898a603e58c67f24692))

#### [3.37.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.36.4...v3.37.0) (2025-04-02)


Features

* add Power up to OCR HTTPS Boot ([#2575](https://github.com/device-management-toolkit/sample-web-ui/issues/2575)) ([43c7748](https://github.com/device-management-toolkit/sample-web-ui/commit/43c7748c73c28d43c1de269af8be58c99f2c0676))

#### [3.36.4](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.36.3...v3.36.4) (2025-04-01)


Bug Fixes

* fixes wireless config name translation ([4770e9b](https://github.com/device-management-toolkit/sample-web-ui/commit/4770e9be35846ee0084e03bcaf6260dc18b4678d))

#### [3.36.3](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.36.2...v3.36.3) (2025-04-01)


Bug Fixes

* correct HTTPS boot message ([#2576](https://github.com/device-management-toolkit/sample-web-ui/issues/2576)) ([a451a28](https://github.com/device-management-toolkit/sample-web-ui/commit/a451a282c5c663cb956579aee9911dd2d8064b02))

#### [3.36.2](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.36.1...v3.36.2) (2025-03-28)


Bug Fixes

* remove username and password from https boot ([#2572](https://github.com/device-management-toolkit/sample-web-ui/issues/2572)) ([2448564](https://github.com/device-management-toolkit/sample-web-ui/commit/24485645247f9c8762176995d2189c2434dcf6f8))

#### [3.36.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.36.0...v3.36.1) (2025-03-27)


Bug Fixes

* add tooltip to https network boot ([#2571](https://github.com/device-management-toolkit/sample-web-ui/issues/2571)) ([ae87fd4](https://github.com/device-management-toolkit/sample-web-ui/commit/ae87fd44717b08bfd6fe2bf93fc25aca28b9011c))

#### [3.36.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.35.0...v3.36.0) (2025-03-27)


Features

* add OCR HTTPS Network boot ([#2509](https://github.com/device-management-toolkit/sample-web-ui/issues/2509)) ([ac1ebce](https://github.com/device-management-toolkit/sample-web-ui/commit/ac1ebcecf767d8de1b27ab9356326342a45c7934))

#### [3.35.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.34.2...v3.35.0) (2025-03-17)

### UI Toolkit

#### [3.3.5](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.4...v3.3.5) (2025-10-13)

#### [3.3.4](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.3...v3.3.4) (2025-08-20)

#### [3.3.3](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.2...v3.3.3) (2025-05-23)

Bug Fixes

* address type issue with NodeJS.Timer ([e4c8766](https://github.com/device-management-toolkit/ui-toolkit/commit/e4c87661003091db4e1666df321e151a3e4ec86e))

#### [3.3.2](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.1...v3.3.2) (2025-05-21)

Bug Fixes

* remove unnecessary node-canvas dependency ([#1356](https://github.com/device-management-toolkit/ui-toolkit/issues/1356)) ([889dd7a](https://github.com/device-management-toolkit/ui-toolkit/commit/889dd7af86529ee17ae863c9467e353d4aa8e66c))

### UI Toolkit Angular

#### [10.1.4](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v10.1.3...v10.1.4) (2025-10-13)

#### [10.1.3](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v10.1.2...v10.1.3) (2025-08-22)

Bug Fixes

* addresses encoding change issue ([7045d59](https://github.com/device-management-toolkit/ui-toolkit-angular/commit/7045d5993d9ee51c0c9bd6a9a8953d3b3902740d))

#### [10.1.2](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v10.1.1...v10.1.2) (2025-08-21)

Bug Fixes

* address KVM connection issue ([05fc284](https://github.com/device-management-toolkit/ui-toolkit-angular/commit/05fc2848df3da587082bdff2a480583dddb389f6))

#### [10.1.1](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v10.1.0...v10.1.1) (2025-08-20)

Bug Fixes

* address instantiation timing issues with SOL ([727f06e](https://github.com/device-management-toolkit/ui-toolkit-angular/commit/727f06e5baed59a358510bfd803866115b8d3b5f))

#### [10.1.0](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v10.0.0...v10.1.0) (2025-07-29)

Features

* add support for hotkeys ([#1984](https://github.com/device-management-toolkit/ui-toolkit-angular/issues/1984)) ([47ce911](https://github.com/device-management-toolkit/ui-toolkit-angular/commit/47ce9110cbcdf0bb36f99591ce7e06334eda2518))


#### [10.0.0](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v9.1.4...v10.0.0) (2025-06-23)

Code Refactoring

* since inputs are signals, removes EventEmitter ([#1905](https://github.com/device-management-toolkit/ui-toolkit-angular/issues/1905)) ([8194c47](https://github.com/device-management-toolkit/ui-toolkit-angular/commit/8194c479fa5594111184c0ae9f8bef887a67c0ec))

BREAKING CHANGES

* KVM/SOL/IDER inputs are no longer EventEmitters
* build(deps): update angular to v20
* test: update tests to use signals

#### [9.1.4](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v9.1.3...v9.1.4) (2025-05-27)

Bug Fixes

* ensure package is published as public ([#1893](https://github.com/device-management-toolkit/ui-toolkit-angular/issues/1893)) ([a80ee9d](https://github.com/device-management-toolkit/ui-toolkit-angular/commit/a80ee9d69631e12e2ad073f263b92008be76abe7))


### Console

#### [1.11.0](https://github.com/device-management-toolkit/console/compare/v1.10.0...v1.11.0) (2025-10-03)

Features

* generate third party licenses zip for every release ([#660](https://github.com/device-management-toolkit/console/issues/660)) ([dbf2440](https://github.com/device-management-toolkit/console/commit/dbf244090b923480b7f4e3eedf0d8eb00332423a))

#### [1.10.0](https://github.com/device-management-toolkit/console/compare/v1.9.0...v1.10.0) (2025-09-30)

Features

* enable KVM multi-monitor support ([#658](https://github.com/device-management-toolkit/console/issues/658)) ([6b62d51](https://github.com/device-management-toolkit/console/commit/6b62d5126d20200f10c32a8f717306ce96ebc443)), closes [#598](https://github.com/device-management-toolkit/console/issues/598)

#### [1.9.0](https://github.com/device-management-toolkit/console/compare/v1.8.5...v1.9.0) (2025-09-24)

Features

* adds OCR local PBA and WinRe ([#649](https://github.com/device-management-toolkit/console/issues/649)) ([499828f](https://github.com/device-management-toolkit/console/commit/499828f2ff90fb8b0562e8a810b54dee0c505b94))

#### [1.8.5](https://github.com/device-management-toolkit/console/compare/v1.8.4...v1.8.5) (2025-09-16)

Bug Fixes

* enhance redirection disconnection handling ([#634](https://github.com/device-management-toolkit/console/issues/634)) ([5cc303b](https://github.com/device-management-toolkit/console/commit/5cc303bc40c05a8b9efd04456b8cd7f0661c33d1))

#### [1.8.4](https://github.com/device-management-toolkit/console/compare/v1.8.3...v1.8.4) (2025-09-12)

#### [1.8.3](https://github.com/device-management-toolkit/console/compare/v1.8.2...v1.8.3) (2025-08-23)

Performance Improvements

* enhances websocket performance for redirection sessions ([57699ac](https://github.com/device-management-toolkit/console/commit/57699ac2821fb55e912eba01afc2012c973e1058))

#### [1.8.2](https://github.com/device-management-toolkit/console/compare/v1.8.1...v1.8.2) (2025-08-23)

Bug Fixes

* addresses device update causing devices to no longer connect ([a1ba99f](https://github.com/device-management-toolkit/console/commit/a1ba99f2c23a19ff1c3a21fa1a0e230343bd1856))

#### [1.8.1](https://github.com/device-management-toolkit/console/compare/v1.8.0...v1.8.1) (2025-08-21)

#### [1.8.0](https://github.com/device-management-toolkit/console/compare/v1.7.1...v1.8.0) (2025-08-20)

Features

* adds cira data to export ([#610](https://github.com/device-management-toolkit/console/issues/610)) ([da12879](https://github.com/device-management-toolkit/console/commit/da1287905fa98b38a503778ee2172862ac70e71f))

#### [1.7.1](https://github.com/device-management-toolkit/console/compare/v1.7.0...v1.7.1) (2025-08-12)

Bug Fixes

* ocr status in amt features ([#614](https://github.com/device-management-toolkit/console/issues/614)) ([3772e99](https://github.com/device-management-toolkit/console/commit/3772e99570032772337c28e9c1115b33823a6615))

#### [1.7.0](https://github.com/device-management-toolkit/console/compare/v1.6.1...v1.7.0) (2025-07-02)

Features

* adds UEFIWiFiSyncEnabled is added to amt profile for OCR ([#595](https://github.com/device-management-toolkit/console/issues/595)) ([19452ec](https://github.com/device-management-toolkit/console/commit/19452ec3780f917774328d2484231b312ede456b))

#### [1.6.1](https://github.com/device-management-toolkit/console/compare/v1.6.0...v1.6.1) (2025-07-01)

Bug Fixes

* upgrade golang base image to 1.24.4 to fix CVE-2025-22874 ([#599](https://github.com/device-management-toolkit/console/issues/599)) ([3aaf603](https://github.com/device-management-toolkit/console/commit/3aaf6032b0eacd80126dc3808d64fac52a3a9326))

#### [1.6.0](https://github.com/device-management-toolkit/console/compare/v1.5.0...v1.6.0) (2025-05-05)

Features

* sso ui config ([38b0c91](https://github.com/device-management-toolkit/console/commit/38b0c91296faecc47755cfe617cdeea823b3ab71))

#### [1.5.0](https://github.com/device-management-toolkit/console/compare/v1.4.1...v1.5.0) (2025-04-24)

Features

* **api:** Add OSPowerSavingState management capabilities ([#572](https://github.com/device-management-toolkit/console/issues/572)) ([cc09c8d](https://github.com/device-management-toolkit/console/commit/cc09c8de1d42cd7323cc7a2c734b0408c5fdc72e))

#### [1.4.1](https://github.com/device-management-toolkit/console/compare/v1.4.0...v1.4.1) (2025-04-09)

#### [1.4.0](https://github.com/device-management-toolkit/console/compare/v1.3.2...v1.4.0) (2025-04-02)

Features

* add Power up to OCR HTTPS Boot ([#558](https://github.com/device-management-toolkit/console/issues/558)) ([b352453](https://github.com/device-management-toolkit/console/commit/b352453f91b43e164b7ce3fa21fc16c34971461b))

#### [1.3.2](https://github.com/device-management-toolkit/console/compare/v1.3.1...v1.3.2) (2025-04-01)

#### [1.3.1](https://github.com/device-management-toolkit/console/compare/v1.3.0...v1.3.1) (2025-03-28)

Bug Fixes

* add cert accepts all formats ([#555](https://github.com/device-management-toolkit/console/issues/555)) ([9da2588](https://github.com/device-management-toolkit/console/commit/9da2588ae3600f76605d8e23b1884d506d2c0119))

#### [1.3.0](https://github.com/device-management-toolkit/console/compare/v1.2.4...v1.3.0) (2025-03-27)

Features

* add https network boot configuration ([#518](https://github.com/device-management-toolkit/console/issues/518)) ([4d16c50](https://github.com/device-management-toolkit/console/commit/4d16c5056201fddf6e0d7b58e468045395e75c7e))

#### [1.2.4](https://github.com/device-management-toolkit/console/compare/v1.2.3...v1.2.4) (2025-03-25)

Bug Fixes

* error should not be returned when OCR not supported ([d222a3a](https://github.com/device-management-toolkit/console/commit/d222a3a53947fafb5d69220857a930d9a9f4777d))

#### [1.2.3](https://github.com/device-management-toolkit/console/compare/v1.2.2...v1.2.3) (2025-03-24)

Bug Fixes

* attempts to fix automated CI versioning ([77c994e](https://github.com/device-management-toolkit/console/commit/77c994eb0e9ced0430b34fefd900f2637a21a102))
* attempts to fix automated CI versioning ([96e70e0](https://github.com/device-management-toolkit/console/commit/96e70e0e8471f952da210d8842b05175fb9651c2))
* automatically determine version for console ([4d99ea7](https://github.com/device-management-toolkit/console/commit/4d99ea79ad68a4657c0a36fc4c6c6accf483da34))
* ci job dependency for release and optimize release ([edb46be](https://github.com/device-management-toolkit/console/commit/edb46be6b1a1d8f2ee4ea0090f8a93aea2c65998))

#### [1.2.2](https://github.com/device-management-toolkit/console/compare/v1.2.1...v1.2.2) (2025-03-19)

Bug Fixes

* handles AMT features changes when OCR not supported ([edaa4e7](https://github.com/device-management-toolkit/console/commit/edaa4e75ccdb995256bc66226fa287ab0b5fa877))


### Go WSMAN Messages

#### [2.32.3](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.32.2...v2.32.3) (2025-09-30)

Bug Fixes

* **ips:** simplify response types as ints for screensettingdata ([#586](https://github.com/device-management-toolkit/go-wsman-messages/issues/586)) ([9bd6f25](https://github.com/device-management-toolkit/go-wsman-messages/commit/9bd6f2512389520da1f5521808f8bba98450510b))

#### [2.32.2](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.32.1...v2.32.2) (2025-09-30)

Bug Fixes

* **ips:** adjust KVMRedirectionSettingsRequest properties ([#585](https://github.com/device-management-toolkit/go-wsman-messages/issues/585)) ([c3f5ccf](https://github.com/device-management-toolkit/go-wsman-messages/commit/c3f5ccfb2329cd78dc516d048d94bd41c79338ac))

#### [2.32.1](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.32.0...v2.32.1) (2025-09-16)

Bug Fixes

* boot setting validator ([#581](https://github.com/device-management-toolkit/go-wsman-messages/issues/581)) ([0ee589d](https://github.com/device-management-toolkit/go-wsman-messages/commit/0ee589dbdcbcbc45d987192741f376986f2c3343))

#### [2.32.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.31.0...v2.32.0) (2025-09-11)

Features

* **ips:** adds support of IPS_HTTPProxyAccessPoint ([#578](https://github.com/device-management-toolkit/go-wsman-messages/issues/578)) ([ee1404a](https://github.com/device-management-toolkit/go-wsman-messages/commit/ee1404a171d8492b8b4fb991767b76fad9db5811))

#### [2.31.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.30.5...v2.31.0) (2025-09-05)

Features

* adds proxy config support to configuration ([#571](https://github.com/device-management-toolkit/go-wsman-messages/issues/571)) ([6187699](https://github.com/device-management-toolkit/go-wsman-messages/commit/618769932dea42b0b38fdca40cee2cda12f9b41d))

#### [2.30.5](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.30.4...v2.30.5) (2025-09-03)

Bug Fixes

* unmarshalling SelectorResponse now includes Text data ([#567](https://github.com/device-management-toolkit/go-wsman-messages/issues/567)) ([0293528](https://github.com/device-management-toolkit/go-wsman-messages/commit/0293528b183f6afe63721d2f0976d1c1a11a83c6))

#### [2.30.4](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.30.3...v2.30.4) (2025-08-23)

Performance Improvements

* tweak tcp settings for better redirection performance ([#559](https://github.com/device-management-toolkit/go-wsman-messages/issues/559)) ([6f8c486](https://github.com/device-management-toolkit/go-wsman-messages/commit/6f8c486f8aff406f13cb904b0fc6097251857f93))

#### [2.30.3](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.30.2...v2.30.3) (2025-08-20)

Reverts

* Revert "fix: empty resourceURI in put body (#552)" (#556) ([308af21](https://github.com/device-management-toolkit/go-wsman-messages/commit/308af21c29e147ccbe9b2b21fa9c9b3ece089bc1)), closes [#552](https://github.com/device-management-toolkit/go-wsman-messages/issues/552) [#556](https://github.com/device-management-toolkit/go-wsman-messages/issues/556)

#### [2.30.2](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.30.1...v2.30.2) (2025-08-12)

Bug Fixes

* empty resourceURI in put body ([#552](https://github.com/device-management-toolkit/go-wsman-messages/issues/552)) ([1e50f5a](https://github.com/device-management-toolkit/go-wsman-messages/commit/1e50f5a6c581ac99027af9ecf5a8b92db26cda49))

#### [2.30.1](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.30.0...v2.30.1) (2025-07-31)

Bug Fixes

* type in BootCapabilitiesResponse ([#549](https://github.com/device-management-toolkit/go-wsman-messages/issues/549)) ([54fbb8a](https://github.com/device-management-toolkit/go-wsman-messages/commit/54fbb8acf9cd6ac6fc871567ff7e0aaf0fcf384a))

#### [2.30.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.29.0...v2.30.0) (2025-07-30)

Features

* adds CIRA section to config ([#548](https://github.com/device-management-toolkit/go-wsman-messages/issues/548)) ([f99714c](https://github.com/device-management-toolkit/go-wsman-messages/commit/f99714cdd6138ff3e6a9caf82862dca5dc9e102f))

#### [2.29.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.28.0...v2.29.0) (2025-07-29)

Features

* add decoders for wifimaps and adds signing authority to tls config ([#543](https://github.com/device-management-toolkit/go-wsman-messages/issues/543)) ([2c66c06](https://github.com/device-management-toolkit/go-wsman-messages/commit/2c66c06904ddcc6865e5eaacab42687cfa0d880f))

#### [2.28.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.27.0...v2.28.0) (2025-07-14)

Features

* enable http proxy for CIRA ([#541](https://github.com/device-management-toolkit/go-wsman-messages/issues/541)) ([40db987](https://github.com/device-management-toolkit/go-wsman-messages/commit/40db9875f361aff87ac1cd310800359da9dcb6c5))

#### [2.27.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.26.2...v2.27.0) (2025-06-30)

Features

* add UEFIWiFiSyncEnabled to v2 wireless config ([#538](https://github.com/device-management-toolkit/go-wsman-messages/issues/538)) ([b11850b](https://github.com/device-management-toolkit/go-wsman-messages/commit/b11850b1c54eb275b1bec4761e246ec66ee33612))

#### [2.26.2](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.26.1...v2.26.2) (2025-06-02)

Renames the go module from open-amt-cloud-toolkit to device-management-toolkit. To fix import errors, 
replace `open-amt-cloud-toolkit/go-wsman-messages/v2` with `device-management-toolkit/go-wsman-messages/v2` across your files.

#### [2.26.1](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.26.0...v2.26.1) (2025-04-03)

Bug Fixes

* **cim:** remove boot source settings if empty ([#516](https://github.com/device-management-toolkit/go-wsman-messages/issues/516)) ([38e4376](https://github.com/device-management-toolkit/go-wsman-messages/commit/38e4376906b90759b1aa5a306f073329b484640d))

#### [2.26.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.25.1...v2.26.0) (2025-03-26)

Features

* boot settings tlv validation ([#508](https://github.com/device-management-toolkit/go-wsman-messages/issues/508)) ([30320e8](https://github.com/device-management-toolkit/go-wsman-messages/commit/30320e819fd7edda1436fca15423a9c78af5ed5b))

#### [2.25.1](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.25.0...v2.25.1) (2025-03-25)

Bug Fixes

* expose newly created IPS Services ([#511](https://github.com/device-management-toolkit/go-wsman-messages/issues/511)) ([4ac0ecc](https://github.com/device-management-toolkit/go-wsman-messages/commit/4ac0eccbf5b65376a8be4def65cd1557692c982b))

#### [2.25.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.24.0...v2.25.0) (2025-03-21)

Features

* **ips:** adds support for _ScreenSettingData ([#506](https://github.com/device-management-toolkit/go-wsman-messages/issues/506)) ([1fa166e](https://github.com/device-management-toolkit/go-wsman-messages/commit/1fa166e8a2ba053c4d2521e1d6f5fc27a2e9b95f))

#### [2.24.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.23.0...v2.24.0) (2025-03-21)

Features

* **amt:** adds support for partial unprovisioning ([#507](https://github.com/device-management-toolkit/go-wsman-messages/issues/507)) ([9fcd24b](https://github.com/device-management-toolkit/go-wsman-messages/commit/9fcd24bb7302b298614125ab324009818e05a9a7))

#### [2.23.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.22.0...v2.23.0) (2025-03-20)

Features

* **ips:** adds support for SecIOService ([e6ad684](https://github.com/device-management-toolkit/go-wsman-messages/commit/e6ad68449c795015f906b99821b8c67d6d2e3dbc))

#### [2.22.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.21.0...v2.22.0) (2025-03-20)

Features

* **ips:** adds support for KVMRedirectionSettingData ([#505](https://github.com/device-management-toolkit/go-wsman-messages/issues/505)) ([f930531](https://github.com/device-management-toolkit/go-wsman-messages/commit/f930531fc0a60e380aa2d5c52eb152c65e9db9b9))

### WSMAN Messages

#### [5.13.0](https://github.com/device-management-toolkit/wsman-messages/compare/v5.12.0...v5.13.0) (2025-10-07)

Features

* **ips:** adds HTTP Proxy Access Point ([#1114](https://github.com/device-management-toolkit/wsman-messages/issues/1114)) ([b48dd5e](https://github.com/device-management-toolkit/wsman-messages/commit/b48dd5ecebf88a8e1e53cc17716dca85d70a7bb9))


#### [5.12.0](https://github.com/device-management-toolkit/wsman-messages/compare/v5.11.0...v5.12.0) (2025-09-30)

Features

* **ips:** add screen and redirection setting data ([#1106](https://github.com/device-management-toolkit/wsman-messages/issues/1106)) ([96e043f](https://github.com/device-management-toolkit/wsman-messages/commit/96e043fdf1b3d96b17d7e8aeb1781aeae6c0facc))

#### [5.11.0](https://github.com/device-management-toolkit/wsman-messages/compare/v5.10.0...v5.11.0) (2025-09-24)

Bug Fixes

* adding unit test ([56ebc8c](https://github.com/device-management-toolkit/wsman-messages/commit/56ebc8c1fdf3806a8a61232b9114ef7544b305ff))

Features

* enable http proxy for CIRA ([df534c6](https://github.com/device-management-toolkit/wsman-messages/commit/df534c67e539a71ebcd16c5be2ea647cc01cbea4))

#### [5.10.0](https://github.com/device-management-toolkit/wsman-messages/compare/v5.9.5...v5.10.0) (2025-07-16)

Features

* **cim:** add credential context and concrete dependency interfaces ([#1065](https://github.com/device-management-toolkit/wsman-messages/issues/1065)) ([f42389b](https://github.com/device-management-toolkit/wsman-messages/commit/f42389be8cac248a926fc6358740097270e5c7c4))

#### [5.9.5](https://github.com/device-management-toolkit/wsman-messages/compare/v5.9.4...v5.9.5) (2025-05-20)

Bug Fixes

* update readme for new name ([d49dd3e](https://github.com/device-management-toolkit/wsman-messages/commit/d49dd3eccbcf29d003936701af63a1249c135fee))

#### [5.9.4](https://github.com/device-management-toolkit/wsman-messages/compare/v5.9.3...v5.9.4) (2025-05-20)

Bug Fixes

* update ci to use node 22 for release ([23e3b25](https://github.com/device-management-toolkit/wsman-messages/commit/23e3b25f5800b1a009ffce5ebee12849f30ea418))

#### [5.9.3](https://github.com/device-management-toolkit/wsman-messages/compare/v5.9.2...v5.9.3) (2025-05-19)

Bug Fixes

* address ci file name issue ([04201c7](https://github.com/device-management-toolkit/wsman-messages/commit/04201c7f97fa4bbdb095328f8204c30aac88d0cf))

#### [5.9.2](https://github.com/device-management-toolkit/wsman-messages/compare/v5.9.1...v5.9.2) (2025-05-19)

Bug Fixes

* test patch release with device-management-toolkit ([2151b94](https://github.com/device-management-toolkit/wsman-messages/commit/2151b94876e83ce43885a76505b97fe3896c5d42))

#### [5.9.1](https://github.com/device-management-toolkit/wsman-messages/compare/v5.9.0...v5.9.1) (2025-03-24)

Bug Fixes

* updates the states for Power Management Service ([#979](https://github.com/device-management-toolkit/wsman-messages/issues/979)) ([c11cd72](https://github.com/device-management-toolkit/wsman-messages/commit/c11cd72b4bfdf2e2b351c6eda48b42cac12482bc))