# Release Notes

!!! note "Note From the Team"

    Hello, DMT community!

    In this September release (v2.39), Console introduced three major features: the ability to download RPC-Go v3 (Beta) with guided command generation from the UI, a new device export API, and multi-tenancy (a key v3 capability). Additionally, we fixed issues so that Console no longer prompts for authentication when it is disabled, RPC-Go v3 (Beta) can enumerate Linux MEI devices across `/dev/mei0` through `/dev/mei3`, and the UI correctly reflects SOL reconnection state.

    Remote Platform Erase (RPE) documentation is now available:

    - [Tutorial](Tutorials/rpeTutorial.md)
    - [Feature reference](Reference/Console/Features/rpe.md)
    - [MPS RPE API documentation](https://github.com/device-management-toolkit/mps/blob/main/swagger.yaml#L302)

    As we mentioned previously, Console releases were paused while we completed additional review and compliance approvals. Those approvals are now complete, and Console releases are back on track.

    Looking ahead, we are working on a bulk power state pull in MPS, enabling supported deployment architectures where customers can run Console and RPS together (a key v3 capability), completing the official release of RPC-Go v3, and advancing Trusted Endpoint Provisioning (TEP), device health, discovery, and Console Redfish API support, along with much more.

    Follow our [Sprint Board](https://github.com/orgs/device-management-toolkit/projects/10/views/2) to learn more and track upcoming features.

    As always, thanks to everyone providing feedback, testing new functionality, and contributing to the toolkit.

    Cheers,<br>
    **The Device Management Toolkit Team**

## 🚀 What's New?

### Console: Download RPC-Go v3 (Beta) and Generate Commands (Preview)

From the Console UI, users can now download the latest supported RPC-Go v3 (Beta) release for their target platform - Windows or Linux - without leaving Console to find the right package. The Console UI also walks users through generating the correct RPC-Go command and configuration for activation and deactivation, which they can copy or download instead of recalling command-line flags.

!!! note "Download availability"

    Console supports RPC-Go v3 only and lists the five latest v3 beta releases. If Console cannot access the internet, download the RPC-Go builds into a local directory with a subdirectory for each version, then set `package.local_dir` to that directory in Console's `config.yml`. Set `package.disable_fetch: true` to make Console use only the local files. 
    
    Detailed setup instructions are in progress; keep an eye out for their release.

### Console: Device Export API

Console now exposes a device export API, `GET /api/v1/devices/export`, that returns device inventory in a consistent nested shape grouped by subsystem - Management Engine (ME), OS, network and platform - along with an `X-Total-Count` header and an audit log entry for each export attempt. Credentials are excluded from the response, and the endpoint currently serves up to 500 devices per synchronous request.

**Example: Device Export Output**

```json
{
    "metadata": {
        "exportedAt": "2026-10-09T06:11:02.14461394Z",
        "swVersion": "console 1.45.0"
    },
    "summary": {
        "totalCount": 1
    },
    "data": [
        {
            "guid": "f440232e-da5d-d52a-fd63-48210b50d81d",
            "hostname": "203.0.113.10",
            "friendlyName": "",
            "tags": [],
            "tenantId": "",
            "firstDiscovered": "2026-10-05T01:00:03.895685232Z",
            "lastSynced": "2026-10-05T01:00:03.895685232Z",
            "lastUpdated": null,
            "deviceInfo": {
                "me": {
                    "dnsSuffix": "",
                    "currentMode": "not activated",
                    "mebxEnabledInBIOS": true,
                    "fwVersion": "16.1.27",
                    "fwBuild": "2176",
                    "fwSku": "16392",
                    "features": "AMT Pro Corporate",
                    "tlsMode": "",
                    "dhcpEnabled": true,
                    "certHashes": [
                        "..."
                    ],
                    "upid": {
                        "csmeId": "0000000000000000000000000000000000000000000000000000000000000001234",
                        "oemId": "0000000000000000000000000000000000000000000000000000000000000000",
                        "oemPlatformIdType": "Not Set (0)"
                    },
                    "network": {
                        "wired": {
                            "ipAddress": "0.0.0.0",
                            "dhcpEnabled": true,
                            "dhcpMode": "passive",
                            "linkStatus": "up",
                            "macAddress": "00:00:00:00:00:00"
                        },
                        "wireless": {
                            "ipAddress": "0.0.0.0",
                            "dhcpEnabled": true,
                            "dhcpMode": "active",
                            "linkStatus": "down",
                            "macAddress": "00:00:00:00:00:00"
                        }
                    }
                },
                "os": {
                    "dnsSuffix": "example.com",
                    "name": "linux",
                    "version": "6.17.0-29-generic",
                    "distro": "Ubuntu 24.04 LTS",
                    "lmsInstalled": false,
                    "lmsVersion": "",
                    "meInterfaceVersion": "6.17.0-29-generic",
                    "monitorConnected": true,
                    "ieee8021xEnabled": null,
                    "network": {
                        "wired": [
                            {
                                "name": "enp100s0",
                                "ipAddress": "203.0.113.10",
                                "dhcpEnabled": true,
                                "linkStatus": "up",
                                "macAddress": "00:00:00:00:00:00"
                            }
                        ],
                        "wireless": {
                            "name": "wlo1",
                            "ipAddress": "",
                            "dhcpEnabled": null,
                            "linkStatus": "up",
                            "macAddress": "00:00:00:00:00:00"
                        }
                    }
                },
                "platform": {
                    "cpu": "12th Gen Intel(R) Core(TM) i5-1250P",
                    "ethernetAdapterCount": 2,
                    "adapters": {
                        "wired": [
                            "Ethernet controller: Intel Corporation Ethernet Controller I225-LM (rev 03)"
                        ],
                        "wireless": [
                            "Network controller: Intel Corporation Alder Lake-P PCH CNVi WiFi (rev 01)"
                        ]
                    }
                },
                "bmc": null
            }
        }
    ]
}
```

### Console and RPC-Go v3 (Beta): Multi-Tenancy

Console now supports multi-tenancy, letting a single deployment serve multiple customers or business units while keeping each tenant's devices and data fully isolated. This removes the need to stand up and maintain a separate Console deployment per tenant, making it easier to scale cloud deployments where strict tenant boundaries are required.

RPC-Go v3 (Beta) works within the same model, so device activation and deactivation stay scoped to the correct tenant end-to-end, keeping device status accurate in multi-tenant deployments.

!!! note
    This work is currently focused on Cloud deployments (v3). We may revisit multi-tenancy for on-premises deployments, specifically the Console binary, based on customer requests. Documentation for this feature is in progress and will be published in the coming weeks.

## 🧩 Enhancements & Improvements

### RPC-Go v3 (Beta): Credential Guidance

RPC-Go v3 (Beta) now warns when you pass credentials as CLI flags, helping you avoid exposing secrets in shell history or process listings.

### Console: JWT Key Generation and Handling

On first run, Console generates and saves a unique authentication key for the installation.

!!! warning "Configure your JWT key for production"

    When no key is configured, Console generates 32 random bytes (256 bits), base64-encoded as a 44-character secret, and saves it in `config.yml`. This provides a unique randomized key for the installation; for production, set and securely manage your own strong key using `auth.jwtKey` in `config.yml` or the `AUTH_JWT_KEY` environment variable.

### Console: Device Details Performance for Powered-Off Devices

Viewing details for a powered-off or sleeping device is now faster and more reliable, with fewer timeouts and a smoother loading experience.

## 🔧 Fixes & Maintenance

- Console
    - Accepts credentials when authentication is disabled and does not issue signed tokens in that mode.
    - Password and HTTP Port validation has been hardened.
    - Improves Windows browser launch handling.
    - Limits the PostgreSQL `sslmode` default to migrations.
    - Aligns timeout handling with slow-responding devices to reduce failed requests.
- RPC-Go v3 (Beta)
    - Now collects UPID and certificate hashes during post-activation synchronization.
    - Supports Linux MEI device nodes `/dev/mei0` through `/dev/mei3`.
- Sample Web UI
    - Fixes SOL reconnection state, flipping the SOL button back to Connect after a manual disconnect.
- MPS Router
    - Raises its minimum Go version to 1.26.
- Dependencies
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