

# Release Notes

!!! note "Note From the Team"

    This release includes several enhancements across Console, RPS, RPC-Go, and the Sample Web UI, including support for redirection over CIRA, improved connection tracking, KVM performance metrics, hardware information improvements, and multiple validation and stability fixes across the toolkit.

    The end-to-end TLS work included in this release is still considered preview support and will continue to evolve over the next few releases as we refine the provisioning and TLS configuration flow across different AMT versions.

    In upcoming releases, you should start seeing improvements coming to rpc-go v3, including a revamped `amtinfo` experience, proxy information support in `amtinfo`, non-admin support for basic commands, along with wireless profile configuration support in Console, and a lot more.

    Follow our [Sprint Board](https://github.com/orgs/device-management-toolkit/projects/10/views/2) to learn more and track upcoming features.

    As always, thanks to everyone providing feedback, testing new functionality, and contributing to the toolkit.

    Cheers,<br>
    **The Device Management Toolkit Team**

## 🚀 What's New?

### Console: Redirection Over CIRA

Console now supports launching redirection sessions over CIRA connections, enabling remote KVM, SOL, and IDER workflows when devices are outside the enterprise network. This builds on the broader effort to make Console support cloud-based deployment scenarios.

### Console: KVM Performance Metrics

Console now includes KVM performance timing metrics and monitoring support, helping users better understand remote session responsiveness and troubleshoot performance-related issues.

### Sample Web UI: Improved Hardware Information Layout

The Hardware Information experience in the Sample Web UI was updated with layout improvements to make device details easier to navigate and review.

### RPS & RPC-Go: Preview Support for End-to-End TLS Between AMT and RPS

This release includes preview support for end-to-end TLS communication between Intel AMT and RPS using the `-tls-tunnel` flag in rpc-go.

This capability is still being improved and is not considered fully ready for all deployment scenarios yet. We are continuing to refine the provisioning and TLS configuration flow across different AMT versions, and more documentation around this workflow will be added in later releases.

## 🧩 Enhancements & Improvements

### Sample Web UI: Improved Request Handling and Performance

The Sample Web UI now cancels pending requests when navigating between pages and caches AMT feature queries to reduce duplicate HTTP requests.

### Console: Connection Status Tracking

Console now tracks device connection status changes along with last connected and disconnected timestamps, improving visibility into device connectivity state.

### RPS: Provisioning Certificate Validation Improvements

RPS now validates that provisioning certificates include the expected root certificate before activation begins. Additional validation and error handling improvements were also added for unsupported ECDSA/EC provisioning certificates.

## 🔧 Fixes & Maintenance

- Console stability and validation fixes for CIRA cleanup, invalid CIRA configuration names, auth handling, and WiFi profile validation

- Console Hardware Information fixes for Memory Summary display, CIM_Chip formatting, and power state handling

- Console and redirection fixes for KVM websocket cleanup, redirect session handling, and no-UI browser launch behavior

- RPS activation and profile export fixes for domain suffix handling, shared static IP export, and invalid CIRA configuration validation

- Sample Web UI fixes for cloud activation, reconnect handling, AMT 19+ activation support, validation messaging, translations, and redirection form state

- RPC-Go fix to prevent crashes on fresh Windows 11 systems with outdated or missing MEI drivers

- Go WSMAN Messages fixes for non-chunked responses over CIRA channels

- WSMAN Messages `v6` migration from CommonJS to ESM modules

- Minor dependency updates and general maintenance across toolkit components

## :material-update:{ .icon-log } Changelog
  
### RPS

#### [2.34.2](https://github.com/device-management-toolkit/rps/compare/v2.34.1...v2.34.2) (2026-04-10)

#### [2.34.1](https://github.com/device-management-toolkit/rps/compare/v2.34.0...v2.34.1) (2026-04-09)

Bug Fixes

* return clear error for unsupported ECDSA/EC provisioning certificates ([#2604](https://github.com/device-management-toolkit/rps/issues/2604)) ([35d4840](https://github.com/device-management-toolkit/rps/commit/35d484017b1b8428e53eef3c550a75da2a843298))

#### [2.34.0](https://github.com/device-management-toolkit/rps/compare/v2.33.1...v2.34.0) (2026-04-02)

Features

* adds support for E2E TLS connection between AMT and RPS ([#2598](https://github.com/device-management-toolkit/rps/issues/2598)) ([73baf43](https://github.com/device-management-toolkit/rps/commit/73baf4318b23b8ed1d9ad2e5749b5fcce5bc9346))

#### [2.33.1](https://github.com/device-management-toolkit/rps/compare/v2.33.0...v2.33.1) (2026-03-30)

Bug Fixes

* tighten CIRA config name validation to prevent 500 errors ([#2635](https://github.com/device-management-toolkit/rps/issues/2635)) ([3ebeae6](https://github.com/device-management-toolkit/rps/commit/3ebeae64f304a15e5c94788c7e221bd3132bc73d))

#### [2.33.0](https://github.com/device-management-toolkit/rps/compare/v2.32.2...v2.33.0) (2026-03-30)

Features

* validate root certificate exists in provisioning cert ([#2627](https://github.com/device-management-toolkit/rps/issues/2627)) ([62315a7](https://github.com/device-management-toolkit/rps/commit/62315a76ac3d8a15e8fbc37ea06a6616c5bc8573))

#### [2.32.2](https://github.com/device-management-toolkit/rps/compare/v2.32.1...v2.32.2) (2026-03-24)

Bug Fixes

* ACM activation fails when device FQDN has more segments than stored domain suffix ([#2622](https://github.com/device-management-toolkit/rps/issues/2622)) ([e360876](https://github.com/device-management-toolkit/rps/commit/e360876bc9db288cb9288ab632029350cc09ffb2))

#### [2.32.1](https://github.com/device-management-toolkit/rps/compare/v2.32.0...v2.32.1) (2026-03-23)

Bug Fixes

* derive sharedStaticIP from DHCPEnabled in profile export ([#2618](https://github.com/device-management-toolkit/rps/issues/2618)) ([e86a250](https://github.com/device-management-toolkit/rps/commit/e86a250cb1e42243a047bc4549a987ade60ecba5))

#### [2.32.0](https://github.com/device-management-toolkit/rps/compare/v2.31.4...v2.32.0) (2026-03-18)

Features

* adds support for E2E TLS connection between AMT and RPS ([0a60ff3](https://github.com/device-management-toolkit/rps/commit/0a60ff3cf4242ba6bef6bf3e413210588b9eaabf))

#### [2.31.4](https://github.com/device-management-toolkit/rps/compare/v2.31.3...v2.31.4) (2026-03-11)

### MPS

#### [2.26.4](https://github.com/device-management-toolkit/mps/compare/v2.26.3...v2.26.4) (2026-04-10)

#### [2.26.3](https://github.com/device-management-toolkit/mps/compare/v2.26.2...v2.26.3) (2026-03-24)

Bug Fixes

* remove tenantId filter from clearInstanceStatus ([#2404](https://github.com/device-management-toolkit/mps/issues/2404)) ([5084072](https://github.com/device-management-toolkit/mps/commit/508407208fc788d13e564e1649f1c574edfce9cc))

#### [2.26.2](https://github.com/device-management-toolkit/mps/compare/v2.26.1...v2.26.2) (2026-03-11)

#### [2.26.1](https://github.com/device-management-toolkit/mps/compare/v2.26.0...v2.26.1) (2026-03-02)

Bug Fixes

* prevent redirect session crash during device validation ([#2359](https://github.com/device-management-toolkit/mps/issues/2359)) ([3aa2c0c](https://github.com/device-management-toolkit/mps/commit/3aa2c0cfc8ada76405eb14ff4fbcf39cf57475b6))

### RPC Go

#### [2.50.1](https://github.com/device-management-toolkit/rpc-go/compare/v2.50.0...v2.50.1) (2026-04-10)

#### [2.50.0](https://github.com/device-management-toolkit/rpc-go/compare/v2.49.2...v2.50.0) (2026-03-28)

Features

* enable tls tunnel for e2e tls connection for RPS <-> AMT ([a9cf653](https://github.com/device-management-toolkit/rpc-go/commit/a9cf653529c211ee60cd4b195f5c0b88c09a9ff0))

#### [2.49.2](https://github.com/device-management-toolkit/rpc-go/compare/v2.49.1...v2.49.2) (2026-03-20)

#### [2.49.1](https://github.com/device-management-toolkit/rpc-go/compare/v2.49.0...v2.49.1) (2026-02-23)

Bug Fixes

* prevent crash when MEI driver on fresh Windows 11 install is not updated ([4cbec7f](https://github.com/device-management-toolkit/rpc-go/commit/4cbec7f5a0035d6e6a9cb4077d546f10ed9c1f68))

### Sample Web UI

#### [3.57.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.57.0...v3.57.1) (2026-04-10)

#### [3.57.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.56.0...v3.57.0) (2026-04-06)

Features

* improves layout for HW Info ([24f0aca](https://github.com/device-management-toolkit/sample-web-ui/commit/24f0aca6eb01e1c9bdf2a44d971f9873a855110f))

#### [3.56.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.55.10...v3.56.0) (2026-04-06)

Features

* support cancel requests upon navigating away from page ([7d94c74](https://github.com/device-management-toolkit/sample-web-ui/commit/7d94c741a3ae2ca9ab2874a09d389a1d3f0ea703))

#### [3.55.10](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.55.9...v3.55.10) (2026-03-31)

Bug Fixes

* Fix cloud activation to support version-specific RPC flags and overlay handling ([#3232](https://github.com/device-management-toolkit/sample-web-ui/issues/3232)) ([f15a08f](https://github.com/device-management-toolkit/sample-web-ui/commit/f15a08ff6ba3706fcdf1cbbc58ce5db19af4d179))

#### [3.55.9](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.55.8...v3.55.9) (2026-03-30)

Bug Fixes

* add pattern validation for CIRA config name field ([#3233](https://github.com/device-management-toolkit/sample-web-ui/issues/3233)) ([dacbb63](https://github.com/device-management-toolkit/sample-web-ui/commit/dacbb63f566675f188d2384006b8344c3fb19843)), closes [device-management-toolkit/rps#2599](https://github.com/device-management-toolkit/rps/issues/2599)

#### [3.55.8](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.55.7...v3.55.8) (2026-03-30)

Bug Fixes

* show msg only in validation errors ([#3223](https://github.com/device-management-toolkit/sample-web-ui/issues/3223)) ([610d0ed](https://github.com/device-management-toolkit/sample-web-ui/commit/610d0edf061b85799674036a28c8dbfca287994f))

#### [3.55.7](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.55.6...v3.55.7) (2026-03-20)

#### [3.55.6](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.55.5...v3.55.6) (2026-03-16)

Performance Improvements

* cache AMT features to reduce duplicate HTTP requests ([#3169](https://github.com/device-management-toolkit/sample-web-ui/issues/3169)) ([48942cd](https://github.com/device-management-toolkit/sample-web-ui/commit/48942cde89a749d789415bba38bcb440bc18b8ed))

#### [3.55.5](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.55.4...v3.55.5) (2026-03-16)

Bug Fixes

* **devices:** show Connect button after disconnect and refresh auth token on reconnect ([#3159](https://github.com/device-management-toolkit/sample-web-ui/issues/3159)) ([3fc4793](https://github.com/device-management-toolkit/sample-web-ui/commit/3fc4793f17b5d91d73b8b0a4be14239a1e10259d))

#### [3.55.4](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.55.3...v3.55.4) (2026-03-16)

Bug Fixes

* add skipamtcertcheck flag for AMT19+ activation support ([#3195](https://github.com/device-management-toolkit/sample-web-ui/issues/3195)) ([26eb87a](https://github.com/device-management-toolkit/sample-web-ui/commit/26eb87a67aef8fade90872c76d7ade30e575f99c))

#### [3.55.3](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.55.2...v3.55.3) (2026-03-11)

Bug Fixes

* shows correct error message on device load failure ([56fcf1b](https://github.com/device-management-toolkit/sample-web-ui/commit/56fcf1bbcde8021f6d093252b4bc87b6f112d079))

#### [3.55.2](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.55.1...v3.55.2) (2026-03-09)

Bug Fixes

* **i18n:** add and update missing translations ([528ea4d](https://github.com/device-management-toolkit/sample-web-ui/commit/528ea4dc5996fc95e047f7ea7905c11950950f70))

#### [3.55.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.55.0...v3.55.1) (2026-02-26)

Bug Fixes

* false "Redirection is disabled" alert after updating AMT features ([#3157](https://github.com/device-management-toolkit/sample-web-ui/issues/3157)) ([2512a5f](https://github.com/device-management-toolkit/sample-web-ui/commit/2512a5f6de936a2b53ff2fa513a6fcc2f6e4cc78))

#### [3.55.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.54.1...v3.55.0) (2026-02-24)

Bug Fixes

* disable Enforce Secure Boot checkbox in CCM mode ([#3101](https://github.com/device-management-toolkit/sample-web-ui/issues/3101)) ([17ad7ea](https://github.com/device-management-toolkit/sample-web-ui/commit/17ad7eab4ec323d11ed74114e8e6b8e508598e69))
* update redirection form state after enabling AMT features ([#3131](https://github.com/device-management-toolkit/sample-web-ui/issues/3131)) ([40a0276](https://github.com/device-management-toolkit/sample-web-ui/commit/40a0276e0eb98a91d89cfbc8ad897b054cd4c3d1))

Features

* show redirection warning when KVM/SOL/IDER is enabled but redirection is off ([#3125](https://github.com/device-management-toolkit/sample-web-ui/issues/3125)) ([a532bf7](https://github.com/device-management-toolkit/sample-web-ui/commit/a532bf7421e750350a2a9985465df4cc47bed852))

#### [3.54.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.54.0...v3.54.1) (2026-02-24)

Bug Fixes

* alarm creation and deletion with proper validation and instant feedback ([#3135](https://github.com/device-management-toolkit/sample-web-ui/issues/3135)) ([d7d4188](https://github.com/device-management-toolkit/sample-web-ui/commit/d7d4188507c7b8ea094c26e0c2040e4d8d711fac))

### UI Toolkit

#### [3.3.12](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.11...v3.3.12) (2026-04-09)

#### [3.3.11](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.10...v3.3.11) (2026-03-11)

### UI Toolkit Angular

#### [11.1.3](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v11.1.2...v11.1.3) (2026-04-10)

#### [11.1.2](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v11.1.1...v11.1.2) (2026-03-20)

### UI Toolkit React

#### [5.0.3](https://github.com/device-management-toolkit/ui-toolkit-react/compare/v5.0.2...v5.0.3) (2026-04-10)

#### [5.0.2](https://github.com/device-management-toolkit/ui-toolkit-react/compare/v5.0.1...v5.0.2) (2026-03-11)

### Console

#### [1.22.9](https://github.com/device-management-toolkit/console/compare/v1.22.8...v1.22.9) (2026-04-10)

#### [1.22.8](https://github.com/device-management-toolkit/console/compare/v1.22.7...v1.22.8) (2026-04-07)

Bug Fixes

* check len of state before accessing power state ([efd1dac](https://github.com/device-management-toolkit/console/commit/efd1dac121a56ead2af2d9aa90795ed70b2413db))

#### [1.22.7](https://github.com/device-management-toolkit/console/compare/v1.22.6...v1.22.7) (2026-04-06)

Bug Fixes

* ensure CIM_Chip is returned in correct format ([14fb6da](https://github.com/device-management-toolkit/console/commit/14fb6dafbe5c8f7219a821edae11e2e1738397d4))

#### [1.22.6](https://github.com/device-management-toolkit/console/compare/v1.22.5...v1.22.6) (2026-03-30)

Bug Fixes

* add name validation to CIRA config to prevent 500 on invalid configName ([#867](https://github.com/device-management-toolkit/console/issues/867)) ([220e5fa](https://github.com/device-management-toolkit/console/commit/220e5fa07476538f97b8fb3942fca923c78db9af)), closes [device-management-toolkit/rps#2599](https://github.com/device-management-toolkit/rps/issues/2599)

#### [1.22.5](https://github.com/device-management-toolkit/console/compare/v1.22.4...v1.22.5) (2026-03-23)

Bug Fixes

* derive sharedStaticIP from DHCPEnabled in profile export ([#853](https://github.com/device-management-toolkit/console/issues/853)) ([92f460f](https://github.com/device-management-toolkit/console/commit/92f460f90c5cb7f465bc8880087889db02f8f48d))

#### [1.22.4](https://github.com/device-management-toolkit/console/compare/v1.22.3...v1.22.4) (2026-03-19)

Bug Fixes

* add connection status tracking with last connected/disconnected ([#828](https://github.com/device-management-toolkit/console/issues/828)) ([476f798](https://github.com/device-management-toolkit/console/commit/476f798d788c0e06930835dff3884d7caafcba55))

#### [1.22.3](https://github.com/device-management-toolkit/console/compare/v1.22.2...v1.22.3) (2026-03-18)

Bug Fixes

* add connection status tracking with last connected/disconnected ([#849](https://github.com/device-management-toolkit/console/issues/849)) ([bec829a](https://github.com/device-management-toolkit/console/commit/bec829a9f6b1b8dcf15e861e8ffa1b6a97b48300))

#### [1.22.2](https://github.com/device-management-toolkit/console/compare/v1.22.1...v1.22.2) (2026-03-16)

Bug Fixes

* kvm: close browser websocket immediately on AMT disconnect ([#820](https://github.com/device-management-toolkit/console/issues/820)) ([3cead82](https://github.com/device-management-toolkit/console/commit/3cead8201330e8496a909b82eaa056af1cd87756))

#### [1.22.1](https://github.com/device-management-toolkit/console/compare/v1.22.0...v1.22.1) (2026-03-11)

Bug Fixes

* resolve Memory Summary showing no data in Hardware Information ([#821](https://github.com/device-management-toolkit/console/issues/821)) ([c8521ae](https://github.com/device-management-toolkit/console/commit/c8521ae86d9c6ec5fe64a67156ace69d08380210)), closes [#816](https://github.com/device-management-toolkit/console/issues/816)

#### [1.22.0](https://github.com/device-management-toolkit/console/compare/v1.21.3...v1.22.0) (2026-03-09)

Features

* enables support for redirection over CIRA ([10adaf9](https://github.com/device-management-toolkit/console/commit/10adaf9bcb93b2bfb9198d2113782bd28f309d28)), closes [#743](https://github.com/device-management-toolkit/console/issues/743)

#### [1.21.3](https://github.com/device-management-toolkit/console/compare/v1.21.2...v1.21.3) (2026-02-25)

Bug Fixes

* ensure auth failure returns without next() call ([#803](https://github.com/device-management-toolkit/console/issues/803)) ([76161c2](https://github.com/device-management-toolkit/console/commit/76161c239e04c33ff23602898af39795dbae599e))
* suppress browser launch in noui builds ([#812](https://github.com/device-management-toolkit/console/issues/812)) ([26f5b47](https://github.com/device-management-toolkit/console/commit/26f5b47d5e80a59566ecf90ccb1b2088410b1a72))

#### [1.21.2](https://github.com/device-management-toolkit/console/compare/v1.21.1...v1.21.2) (2026-02-23)

Bug Fixes

* Update the validator criteria to allow wifi config is empty when DHCP is false ([#799](https://github.com/device-management-toolkit/console/issues/799)) ([f3c3926](https://github.com/device-management-toolkit/console/commit/f3c39265e365d0f25ad89d0c0689d98613875152))

#### [1.21.1](https://github.com/device-management-toolkit/console/compare/v1.21.0...v1.21.1) (2026-02-20)

Bug Fixes

* prevent segfault in CIRA cleanup and EOF errors in hardware collection ([#776](https://github.com/device-management-toolkit/console/issues/776)) ([#788](https://github.com/device-management-toolkit/console/issues/788)) ([3c87e88](https://github.com/device-management-toolkit/console/commit/3c87e88ce89554ff74d86369f81fcb0cf78edc3e))

#### [1.21.0](https://github.com/device-management-toolkit/console/compare/v1.20.1...v1.21.0) (2026-02-18)

Features

* add KVM performance timing metrics and monitoring ([#761](https://github.com/device-management-toolkit/console/issues/761)) ([5b7221f](https://github.com/device-management-toolkit/console/commit/5b7221ff2ebb6e31ab5debe3a23d4a8f1833a309))

### Go WSMAN Messages

#### [2.38.1](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.38.0...v2.38.1) (2026-04-10)

#### [2.38.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.37.0...v2.38.0) (2026-03-17)

Features

* add tags to config ([#653](https://github.com/device-management-toolkit/go-wsman-messages/issues/653)) ([fb5dad2](https://github.com/device-management-toolkit/go-wsman-messages/commit/fb5dad2f9dee5bc09bdf512841142222a1ca546c))

#### [2.37.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.36.3...v2.37.0) (2026-03-06)

Features

* adds support for redirection over CIRA ([#649](https://github.com/device-management-toolkit/go-wsman-messages/issues/649)) ([45f7abd](https://github.com/device-management-toolkit/go-wsman-messages/commit/45f7abd877feadc0ed6953cc70a058a8b7b3a105))

#### [2.36.3](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.36.2...v2.36.3) (2026-03-06)

Bug Fixes

* address issue with non-chunked responses over CIRA channel ([#648](https://github.com/device-management-toolkit/go-wsman-messages/issues/648)) ([cf7dead](https://github.com/device-management-toolkit/go-wsman-messages/commit/cf7deadb54132ec5f830ca3acf05de8d976bf448))


### WSMAN Messages

#### [6.0.1](https://github.com/device-management-toolkit/wsman-messages/compare/v6.0.0...v6.0.1) (2026-04-09)

#### [6.0.0](https://github.com/device-management-toolkit/wsman-messages/compare/v5.15.0...v6.0.0) (2026-04-06)

* build!: moves to ESM from CJS ([6c05e50](https://github.com/device-management-toolkit/wsman-messages/commit/6c05e503a7f2556d41cd91ea5e5a0d91bb3339b7))

BREAKING CHANGES

* require() will no longer work with this package.

#### [5.15.0](https://github.com/device-management-toolkit/wsman-messages/compare/v5.14.5...v5.15.0) (2026-03-17)

Features

* adds Put to AMT TLS Credential Context ([86b1791](https://github.com/device-management-toolkit/wsman-messages/commit/86b179102cdc06492548c989c3a2183b0242270c))

#### [5.14.5](https://github.com/device-management-toolkit/wsman-messages/compare/v5.14.4...v5.14.5) (2026-03-11)

### MPS Router

#### [2.5.9](https://github.com/device-management-toolkit/mps-router/compare/v2.5.8...v2.5.9) (2026-04-09)

#### [2.5.8](https://github.com/device-management-toolkit/mps-router/compare/v2.5.7...v2.5.8) (2026-03-11)