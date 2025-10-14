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

:material-new-box: Feature: Multi‑monitor KVM

You can switch between displays during an AMT KVM session without dropping the connection. 

:material-new-box: Feature: Local PBA and Windows Recovery in One-Click Recovery (OCR)

Kick off local Pre‑Boot Application (PBA) and Windows Recovery Environment (WinRE) directly from the UI or API. This pairs well with HTTPS Network Boot so you can standardize remote recovery, even when the OS is down.

:material-new-box: Enhancement: Clearer OCR flows

- HTTPS Network Boot now includes clearer prompts and tooltips, plus an optional Power up action to start from a full off state.
- OCR status is richer end‑to‑end (HTTP, WinRE, PBA) so you can see what’s happening at a glance.
- UEFI Wi‑Fi credential sync helps devices connect in pre‑boot scenarios.

:material-new-box: Feature: Secure Host‑Based Configuration (ACM/SHBC)

Provision devices securely with host‑based configuration. We added CLI support and safer server‑side handling so failed ACM attempts clean up cleanly instead of leaving devices in limbo.

:material-new-box: Feature: Certificate and profile management

- List and add AMT certificates through the server API to simplify rotation.
- Export local profiles from the provisioning service to back up or migrate fleets.
- Specify a Postgres SSL certificate path to meet stricter database security policies.

:material-new-box: Enhancement: Connectivity, performance, and stability

- Configure Local CIRA for flexible network setups.
- Increased CIRA window size reduces chattiness on high‑latency links.
- Better KVM behavior when switching encodings and when combining SOL/IDER.
- Hardening in the CLI prevents panics on bad URLs and allows skipping AMT cert verification when appropriate.


## ✅ Resolved Issues

Fixed several KVM stability issues when switching encoding or combining SOL/IDER connections.

Corrected certificate upload statuses in the Sample Web UI and devices view.

Addressed multiple OCR‑related UI inconsistencies and status reporting gaps.

Fixed panic scenarios in RPC‑Go with invalid RPS URLs.

Numerous small bug fixes across MPS, RPS, and UI Toolkit.

## 🔭 Open Issues and Requests

We continue to track feedback on extending OCR workflows in enterprise recovery environments.

Community requests around enhanced logging and audit compliance are under evaluation.

Improvements to bulk device provisioning and performance tuning are planned for follow-up releases.


## Device Management Toolkit Changelog

### RPS

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

### RPC

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

#### [3.3.4](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.3...v3.3.4) (2025-08-20)


Bug Fixes

* address type issue with NodeJS.Timer ([e4c8766](https://github.com/device-management-toolkit/ui-toolkit/commit/e4c87661003091db4e1666df321e151a3e4ec86e))


