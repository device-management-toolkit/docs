# Release Notes

!!! note "Note From the Team"

    Hello, DMT community!

    In September, we added multi-tenant management to Console and a new way for enterprise users to download RPC packages through Console and the Sample Web UI. RPC-Go v3 Beta also continues to improve device exports and tenant-aware workflows.

    We also fixed issues affecting authentication-disabled Console setups, Linux MEI connectivity, and SOL reconnection. Thanks for testing the releases, sharing feedback, and contributing fixes. Your reports help us decide what to improve next.

    Work on Trusted Endpoint Provisioning (TEP) and other new capabilities is also progressing through development and review. We look forward to sharing more as these efforts mature for future releases.

    Follow our [Sprint Board](https://github.com/orgs/device-management-toolkit/projects/10/views/2) to learn more and track upcoming features.

    Cheers,<br>
    **The Device Management Toolkit Team**

## 🚀 What's New?

### Console: Multi-Tenancy

Organizations that manage devices for multiple customers or business units can now use one Console deployment while keeping each tenant's data and devices organized within its tenant boundary. This can reduce the need to operate separate Console deployments for each tenant.

### Sample Web UI: Enterprise Download RPC

Enterprise users can download RPC packages directly from the Sample Web UI through Console, making packages easier to access when needed without requiring a separate download workflow.

## 🧩 Enhancements & Improvements

### Console and RPC-Go v3 (Beta): Device Export Fields

Console now maps additional device export fields collected by RPC-Go v3 (Beta). Customers can retain more device details in their exports and keep the exported data aligned with what RPC-Go v3 collects.

### RPC-Go v3 (Beta): Tenant-Aware Operations and Credential Guidance

RPC-Go v3 (Beta) forwards the tenant header and keeps device deactivation synchronized in multi-tenant deployments, helping operations stay within the intended tenant and reflect device status accurately. It also warns when credentials are supplied through CLI flags, helping users avoid exposing secrets in shell history or process listings.

## 🔧 Fixes & Maintenance

- RPC-Go v3 (Beta) now collects UPID and certificate hashes during post-activation synchronization.
- RPC-Go v3 (Beta) supports Linux MEI device nodes `/dev/mei0` through `/dev/mei3`.
- Console accepts credentials when authentication is disabled and does not issue signed tokens in that mode.
- Console hardens credential validation and corrects the `handleAdminPassword` comment.
- Console hardens JWT key validation, generates the key on first run, validates the HTTP port, improves Windows browser launch, aligns timeout budgets for slow devices, and limits the PostgreSQL `sslmode` default to migrations.
- The Sample Web UI fixes SOL reconnection state and the cloud activation CIRA status assertion.
- MPS Router raises its minimum Go version to 1.26.
- Minor dependency updates and maintenance across toolkit components.

## :material-update:{ .icon-log } Changelog

### Console

#### [1.43.1](https://github.com/device-management-toolkit/console/compare/v1.43.0...v1.43.1) (2026-09-23)

#### [1.43.0](https://github.com/device-management-toolkit/console/compare/v1.42.0...v1.43.0) (2026-09-23)

Features

* **api:** add download-rpc package endpoints ([#1279](https://github.com/device-management-toolkit/console/issues/1279)) ([dd4709f](https://github.com/device-management-toolkit/console/commit/dd4709f16779ff375a17b7913a8e5681dd517cc1))

#### [1.42.0](https://github.com/device-management-toolkit/console/compare/v1.41.2...v1.42.0) (2026-09-16)

Features

* **api:** add multi-tenancy support ([#1220](https://github.com/device-management-toolkit/console/issues/1220)) ([4e10714](https://github.com/device-management-toolkit/console/commit/4e10714d67a990392421b967d53dc167c28391aa))

#### [1.41.2](https://github.com/device-management-toolkit/console/compare/v1.41.1...v1.41.2) (2026-09-15)

Bug Fixes

* stop issuing signed tokens when authentication is disabled ([#1271](https://github.com/device-management-toolkit/console/issues/1271)) ([5483085](https://github.com/device-management-toolkit/console/commit/548308578cfb61b20f630ba2c774ff16abc586d3))

#### [1.41.1](https://github.com/device-management-toolkit/console/compare/v1.41.0...v1.41.1) (2026-09-14)

Bug Fixes

* accept credentials when authentication is disabled ([0da481a](https://github.com/device-management-toolkit/console/commit/0da481a83fefb7466f2447e813d7fe82ca346fb0))
* correct the `handleAdminPassword` comment ([732fe7d](https://github.com/device-management-toolkit/console/commit/732fe7d81af7f1356cf6aec3cae6ddf64286b87c))

#### [1.41.0](https://github.com/device-management-toolkit/console/compare/v1.40.1...v1.41.0) (2026-09-11)

Features

* map additional device export fields ([#1233](https://github.com/device-management-toolkit/console/issues/1233)) ([c2c3ad8](https://github.com/device-management-toolkit/console/commit/c2c3ad8b236bb555b2cc1f2dbf87ea296321b084)), closes [rpc-go#1513](https://github.com/device-management-toolkit/rpc-go/issues/1513)

#### [1.40.1](https://github.com/device-management-toolkit/console/compare/v1.40.0...v1.40.1) (2026-09-10)

Bug Fixes

* align timeout budget with WSMAN client for slow devices ([#1082](https://github.com/device-management-toolkit/console/issues/1082)) ([374987e](https://github.com/device-management-toolkit/console/commit/374987e848ce22843e77b5e1f0295735b497f00e))
* **auth:** enforce a required JWT key to prevent forged token attacks ([2d97b3c](https://github.com/device-management-toolkit/console/commit/2d97b3c36c886ec18e98c3b8ef698adc25e82e69))
* **auth:** support disabled authentication without a JWT key ([df00f05](https://github.com/device-management-toolkit/console/commit/df00f05e345373eedbc12160010fababfb69930d))
* **config:** generate `auth.jwtKey` on first run ([#1264](https://github.com/device-management-toolkit/console/issues/1264)) ([95ebad9](https://github.com/device-management-toolkit/console/commit/95ebad91466d8e2ee86675b5c7cf40aafc5ac58c))
* **config:** validate the HTTP port and harden Windows browser launch ([#1198](https://github.com/device-management-toolkit/console/issues/1198)) ([6e0906e](https://github.com/device-management-toolkit/console/commit/6e0906e921dcbb6fe06d62000fa531dc0a0f29c5))
* **db:** default PostgreSQL `sslmode` only for migrations ([b9c232a](https://github.com/device-management-toolkit/console/commit/b9c232ab2e41a446ca608aece48ecb2e51dac7ec))

### RPS

#### [2.40.2](https://github.com/device-management-toolkit/rps/compare/v2.40.1...v2.40.2) (2026-09-21)

### MPS

#### [2.35.1](https://github.com/device-management-toolkit/mps/compare/v2.35.0...v2.35.1) (2026-09-21)

### MPS Router

#### [2.5.15](https://github.com/device-management-toolkit/mps-router/compare/v2.5.14...v2.5.15) (2026-09-21)


### RPC Go

#### [2.52.7](https://github.com/device-management-toolkit/rpc-go/compare/v2.52.6...v2.52.7) (2026-09-24)

### RPC Go v3 (Beta)

#### [3.0.0-beta.60](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.59...v3.0.0-beta.60) (2026-09-24)

#### [3.0.0-beta.59](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.58...v3.0.0-beta.59) (2026-09-21)

#### [3.0.0-beta.58](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.57...v3.0.0-beta.58) (2026-09-16)

Bug Fixes

* collect UPID and certificate hashes during post-activation sync ([#1555](https://github.com/device-management-toolkit/rpc-go/issues/1555)) ([0ea20c5](https://github.com/device-management-toolkit/rpc-go/commit/0ea20c569e1e96300479d263ab05bc04c8b700af)), closes [#1549](https://github.com/device-management-toolkit/rpc-go/issues/1549)

#### [3.0.0-beta.57](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.56...v3.0.0-beta.57) (2026-09-16)

Features

* **internal:** forward tenant header and fix deactivation sync ([#1533](https://github.com/device-management-toolkit/rpc-go/issues/1533)) ([8daa112](https://github.com/device-management-toolkit/rpc-go/commit/8daa112c0992ba6cff2377f5214c83a6d94788da))

#### [3.0.0-beta.56](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.55...v3.0.0-beta.56) (2026-09-16)

Features

* warn when credentials are passed via CLI flags for remaining flags ([#1543](https://github.com/device-management-toolkit/rpc-go/issues/1543)) ([7303adf](https://github.com/device-management-toolkit/rpc-go/commit/7303adff4700435a97df4c9467deb2875c324b39))

#### [3.0.0-beta.55](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.54...v3.0.0-beta.55) (2026-09-14)

Bug Fixes

* support Linux MEI connections on `/dev/mei0` through `/dev/mei3` ([3b77c9c](https://github.com/device-management-toolkit/rpc-go/commit/3b77c9c3cc8f4df95a77b395efeebe29ffe36a6a)) ([9f85db7](https://github.com/device-management-toolkit/rpc-go/commit/9f85db7d48a05b295fcdcf279568b2367240e7e4))

#### [3.0.0-beta.54](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.53...v3.0.0-beta.54) (2026-09-11)

Features

* send additional device export fields required for device export ([#1529](https://github.com/device-management-toolkit/rpc-go/issues/1529)) ([752595b](https://github.com/device-management-toolkit/rpc-go/commit/752595b1a2a5a0cd472baa32dcdfbd9ded154035)), closes [#1513](https://github.com/device-management-toolkit/rpc-go/issues/1513)

#### [3.0.0-beta.53](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.52...v3.0.0-beta.53) (2026-09-01)

### Sample Web UI

#### [3.67.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.67.0...v3.67.1) (2026-09-24)

Bug Fixes

* flip SOL button back to Connect after manual disconnect ([#3568](https://github.com/device-management-toolkit/sample-web-ui/issues/3568)) ([9d5a302](https://github.com/device-management-toolkit/sample-web-ui/commit/9d5a302b98055a36ded3cfac3476d6604d5ebdb2))

#### [3.67.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.66.2...v3.67.0) (2026-09-23)

Features

* **devices:** add enterprise Download RPC page ([#3572](https://github.com/device-management-toolkit/sample-web-ui/issues/3572)) ([8c4108c](https://github.com/device-management-toolkit/sample-web-ui/commit/8c4108c6de0a7174002c050aeb7609fde7953de0)), closes [Console#1144](https://github.com/device-management-toolkit/console/issues/1144)

#### [3.66.2](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.66.1...v3.66.2) (2026-09-21)

#### [3.66.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.66.0...v3.66.1) (2026-09-03)

Bug Fixes

* **e2e:** match `CIRA: Configured` output in the cloud activation assertion ([#3542](https://github.com/device-management-toolkit/sample-web-ui/issues/3542)) ([5e01225](https://github.com/device-management-toolkit/sample-web-ui/commit/5e012258eb08f230b8532c27d8fea4a64b48ae66))

### Go WSMAN Messages

#### [2.50.4](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.50.3...v2.50.4) (2026-09-21)


### WSMAN Messages

#### [6.1.5](https://github.com/device-management-toolkit/wsman-messages/compare/v6.1.4...v6.1.5) (2026-09-21)


### UI Toolkit

#### [3.3.21](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.20...v3.3.21) (2026-09-21)


### UI Toolkit Angular

#### [11.1.9](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v11.1.8...v11.1.9) (2026-09-21)


### UI Toolkit React

#### [5.0.9](https://github.com/device-management-toolkit/ui-toolkit-react/compare/v5.0.8...v5.0.9) (2026-09-21)


### MPS Router

#### [2.5.15](https://github.com/device-management-toolkit/mps-router/compare/v2.5.14...v2.5.15) (2026-09-21)

Build

* set Go 1.26 as the minimum version ([3cacc24](https://github.com/device-management-toolkit/mps-router/commit/3cacc24f3a43b146f0c353eb466d2b89677ddd50))