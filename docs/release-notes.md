

# Release Notes

!!! note "Note From the Team"
    We’re excited to share our November release. This release includes improvements across MPS, RPC-Go, and supporting components, with a focus on adding the initial APF transaction, clearer KVM logs and safer certificate handling.
    
    In the upcoming releases, we’re continuing work on expanded certificate support (including SHA-384 and larger key sizes), along with prerequisites for making Console deployable in the cloud, such as adding CIRA capabilities in Console and integrating secret management for cloud deployments. More updates will follow as these changes roll out.

## 🚀 What's New?

### :material-new-box:{ .icon-new } Initial CIRA APF Message Support (go-wsman-messages)

Initial support has been added for CIRA APF (AMT Port Forwarding) messages and handlers. This lays the groundwork for supporitng CIRA functionality in future releases.

### :material-new-box:{ .icon-new } KVM Session Closure Detection (MPS)

KVM session logging has been enhanced to provide clearer visibility into how sessions end. MPS can now identify whether a session was closed by the API client or by the AMT device, making it easier to troubleshoot unexpected disconnects.

### :material-new-box:{ .icon-new } AMT Network Link Preference API (MPS)

A new API endpoint allows programmatic control over AMT network link preferences:
`/api/v1/amt/network/linkPreference/{guid}`.

This is primarily useful when AMT is connected over a wireless network. If users want to control how the ME accesses the network, they can leverage this API to influence Wi-Fi link selection and behavior.

### :material-new-box:{ .icon-new } Ability to Delete Unassociated Certificates (MPS)

Users can now delete unassociated or unused certificates. The API validates against read-only certificates and certificates actively associated with TLS, wired, or wireless profiles, and returns clearer error messages when deletion is blocked.

### :material-new-box:{ .icon-new } UUID Validation During Device Activation (RPC-Go)

RPC-Go now validates device UUIDs during activation to prevent invalid or corrupted devices from entering the managed inventory. Known invalid `UUID` patterns are detected and blocked early in the activation flow.

## :material-checkbox-marked:{ .icon-new } Fixes & Improvements

- Local wired IEEE 802.1X provisioning fix in RPC-Go

- Restricted AMT domain profile names in RPS to safe characters (alphanumeric, underscores, and hyphens)

- Improved error handling in WSMAN message processing when keys are missing

- Fixed keyboard lock issues during active KVM sessions in the Sample Web UI

- Corrected Console version display to show the running version instead of the latest release

- Dependency updates, General maintenance and stability improvements across components


## :material-update:{ .icon-log } Changelog
  
### RPS

#### [2.30.4](https://github.com/device-management-toolkit/rps/compare/v2.30.3...v2.30.4) (2025-12-16)

#### [2.30.3](https://github.com/device-management-toolkit/rps/compare/v2.30.2...v2.30.3) (2025-11-28)

Bug Fixes

* Update the AMT Domain Profile Name to only support letters, numbers, underscores and hyphens ([#2425](https://github.com/device-management-toolkit/rps/issues/2425)) ([c00a8db](https://github.com/device-management-toolkit/rps/commit/c00a8dbd4081340dd0332430f828c857af463a07))

### MPS

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

#### [2.48.10](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.9...v2.48.10) (2025-12-10)

Bug Fixes

* reject invalid UUIDs during activation ([dba3b6e](https://github.com/device-management-toolkit/rpc-go/commit/dba3b6e4afb4a9a9fe0abdf4db676cf5ca84dab4)), closes [#480](https://github.com/device-management-toolkit/rpc-go/issues/480)

#### [3.0.0-beta.3](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.2...v3.0.0-beta.3) (2025-12-02)

Features

* add cira to orchestrator ([b796a54](https://github.com/device-management-toolkit/rpc-go/commit/b796a54b585739407586935d5d09265d468c891a))

#### [2.48.9](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.8...v2.48.9) (2025-12-02)

#### [2.48.8](https://github.com/device-management-toolkit/rpc-go/compare/v2.48.7...v2.48.8) (2025-11-18)

Bug Fixes

* --local issue with wired 8021x configure failing ([f9c0a7a](https://github.com/device-management-toolkit/rpc-go/commit/f9c0a7a1c72e1afe24f9bf0ae609a05278967b78))

#### [3.0.0-beta.2](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.1...v3.0.0-beta.2) (2025-11-10)

### Sample Web UI

#### [3.52.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.52.0...v3.52.1) (2025-12-12)

Bug Fixes

* certificate list not refreshing after deletion ([#3037](https://github.com/device-management-toolkit/sample-web-ui/issues/3037)) ([0f69922](https://github.com/device-management-toolkit/sample-web-ui/commit/0f699228b711edfc63f5f9a857ab12334a272448))

#### [3.52.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.51.2...v3.52.0) (2025-12-12)

Features

* enable CIRA profiles and adding device manually ([#3039](https://github.com/device-management-toolkit/sample-web-ui/issues/3039)) ([a80b299](https://github.com/device-management-toolkit/sample-web-ui/commit/a80b2994f21cb08fb1b24f1f4e913d3bf722ed26))

#### [3.51.2](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.51.1...v3.51.2) (2025-12-04)

Bug Fixes

* display actual console version instead of latest release ([#3026](https://github.com/device-management-toolkit/sample-web-ui/issues/3026)) ([09cd49f](https://github.com/device-management-toolkit/sample-web-ui/commit/09cd49f2d6f48d2d421b54d96b7fc6848bb50f60)), closes [#707](https://github.com/device-management-toolkit/sample-web-ui/issues/707)

#### [3.51.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.51.0...v3.51.1) (2025-12-03)

#### [3.51.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.50.2...v3.51.0) (2025-12-02)

Features

* improve certificate deletion error handling ([#3007](https://github.com/device-management-toolkit/sample-web-ui/issues/3007)) ([9eef82a](https://github.com/device-management-toolkit/sample-web-ui/commit/9eef82ab7acfb5e35196be7a491e3c1699187d4f))

#### [3.50.2](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.50.1...v3.50.2) (2025-11-28)

Bug Fixes

* prevent kb input lock in the active KVM session ([#2994](https://github.com/device-management-toolkit/sample-web-ui/issues/2994)) ([925b7b5](https://github.com/device-management-toolkit/sample-web-ui/commit/925b7b56dbb6aeb5e6c18927ffa1ac33c07d060b))

#### [3.50.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.50.0...v3.50.1) (2025-11-20)

Bug Fixes

* update dependencies ([696cd47](https://github.com/device-management-toolkit/sample-web-ui/commit/696cd473dc9b7d44f76a18fc6cd62098e5f25f53))

#### [3.50.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.49.2...v3.50.0) (2025-11-17)

Features

* Add certificate delete functionality to device management UI ([#2969](https://github.com/device-management-toolkit/sample-web-ui/issues/2969)) ([c560da9](https://github.com/device-management-toolkit/sample-web-ui/commit/c560da929081d58d11cccccfc0df93cfb6434ef3))

### UI Toolkit

#### [3.3.7](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.6...v3.3.7) (2025-12-02)

### UI Toolkit Angular

#### [10.1.6](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v10.1.5...v10.1.6) (2025-12-02)

### UI Toolkit React

#### [4.0.5](https://github.com/device-management-toolkit/ui-toolkit-react/compare/v4.0.4...v4.0.5) (2025-12-02)

### Console

#### [1.14.1](https://github.com/device-management-toolkit/console/compare/v1.14.0...v1.14.1) (2025-12-03)

#### [1.14.0](https://github.com/device-management-toolkit/console/compare/v1.13.0...v1.14.0) (2025-11-20)

Bug Fixes

* **domains:** allow hyphens and underscores in domain profile names ([#702](https://github.com/device-management-toolkit/console/issues/702)) ([78dd456](https://github.com/device-management-toolkit/console/commit/78dd4563dff4b0d9731b52edaf7889d354698664)), closes [#700](https://github.com/device-management-toolkit/console/issues/700)

Features

* add certificate deletion API with validation rules ([#688](https://github.com/device-management-toolkit/console/issues/688)) ([e6109dd](https://github.com/device-management-toolkit/console/commit/e6109dde5a3b65c25abdec3d727fb160cd63ac82)), closes [#567](https://github.com/device-management-toolkit/console/issues/567)

### Go WSMAN Messages

#### [2.33.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.32.6...v2.33.0) (2025-12-10)

Features

* adds initial support for CIRA APF messages and handlers ([#423](https://github.com/device-management-toolkit/go-wsman-messages/issues/423)) ([e7b78d6](https://github.com/device-management-toolkit/go-wsman-messages/commit/e7b78d66c889f9c1d0e85aa42acc6bbd07a61552))

#### [2.32.6](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.32.5...v2.32.6) (2025-12-09)

Bug Fixes

* handle gracefully when key not found with typed error message ([#612](https://github.com/device-management-toolkit/go-wsman-messages/issues/612)) ([340bd0a](https://github.com/device-management-toolkit/go-wsman-messages/commit/340bd0a70343131545b0ead2696976b3c2fc101b))


#### [2.32.5](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.32.4...v2.32.5) (2025-12-02)

### WSMAN Messages

#### [5.14.1](https://github.com/device-management-toolkit/wsman-messages/compare/v5.14.0...v5.14.1) (2025-12-02)

#### [5.14.0](https://github.com/device-management-toolkit/wsman-messages/compare/v5.13.1...v5.14.0) (2025-11-19)

Features

* add SetLinkPreference API msg compose ([#1136](https://github.com/device-management-toolkit/wsman-messages/issues/1136)) ([5eb8b96](https://github.com/device-management-toolkit/wsman-messages/commit/5eb8b96302be88092478e116f2fb51166cc3b0f0))

### MPS Router

#### [2.5.5](https://github.com/device-management-toolkit/mps-router/compare/v2.5.4...v2.5.5) (2025-12-02)