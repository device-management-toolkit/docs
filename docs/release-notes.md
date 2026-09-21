# Release Notes

!!! note "September 2026 — Release Draft"

    This draft covers changes since the August component versions, including releases published between the two monthly releases. Release status was checked on September 21, 2026. RPC-Go `v2.52.7` is tagged, but its GitHub Release is not yet published. Console `v1.42.1` remains on hold; the Console changes below are already available through `v1.42.0`.

!!! note "Note From the Team"

    In this September release, we are continuing to improve device management across cloud and Console deployments. This month's updates include Console multi-tenancy and device export, improvements to RPC-Go v3 device synchronization, and a simpler profile experience in the Sample Web UI when CIRA is disabled on the server.

    Following the Remote Platform Erase introduction in August, MPS now includes the additional RPE capability work released in `v2.35.0`. We have also refreshed the MPS and RPS Swagger definitions to bring the API documentation in line with the current components.

    Console releases have resumed since our last update. The interim releases bring stronger configuration and authentication checks, HttpOnly session cookies, and improvements for devices that take longer to respond. The next Console patch is still pending and will be included once it is released.

    RPC-Go v3 remains in Beta. This month brings better handling of credentials, tenant-aware communication with Console, and more complete device information after activation. We encourage you to try these improvements in your test environments and share your feedback as we continue working toward the official v3 release.

    As always, thanks to everyone providing feedback, testing new functionality, and contributing to the toolkit.

    Cheers,<br>
    **The Device Management Toolkit Team**

## 🚀 What's New?

### Console: Multi-Tenancy

Console `v1.42.0` adds tenant isolation across REST APIs, CIRA, and WebSocket device-management paths. REST requests identify the tenant through the `x-tenant-id` header, and device operations use tenant-scoped lookups before communicating with Intel® AMT.

RPC-Go `v3.0.0-beta.57` forwards the configured tenant ID to Console device, profile, and device-information requests. This keeps provisioning and device synchronization within the same tenant context.

For implementation details, see [Console #1220](https://github.com/device-management-toolkit/console/pull/1220) and [RPC-Go #1533](https://github.com/device-management-toolkit/rpc-go/pull/1533).

### Console & RPC-Go v3: Device Export and Inventory

The interim Console releases add `GET /api/v1/devices/export`, with a consistent nested response across SQL and MongoDB backends. The response includes an `X-Total-Count` header, and subsystems without available data are represented as `null`.

Console `v1.41.0` and RPC-Go `v3.0.0-beta.54` add the corresponding device-export field mappings. RPC-Go `v3.0.0-beta.58` also collects UPID and certificate hashes during post-activation synchronization, helping keep the device inventory complete after activation.

See [Console #1209](https://github.com/device-management-toolkit/console/pull/1209), [Console #1233](https://github.com/device-management-toolkit/console/pull/1233), [RPC-Go #1529](https://github.com/device-management-toolkit/rpc-go/pull/1529), and [RPC-Go #1555](https://github.com/device-management-toolkit/rpc-go/pull/1555).

### MPS: Remote Platform Erase Follow-Up

MPS `v2.35.0`, released after the August component cutoff, includes additional Remote Platform Erase capability work. The API exposes the erase capabilities supported by the device and supports requesting the available erase operations.

RPE availability continues to depend on the device's Intel® AMT, CSME, and BIOS capabilities. See [MPS #2407](https://github.com/device-management-toolkit/mps/pull/2407) for the changes included in this interval.

## 🧩 Enhancements & Improvements

### Sample Web UI: CIRA Options Follow Server Configuration

Starting with `v3.66.0`, the Sample Web UI hides CIRA options in the profile when CIRA is disabled on the server. This keeps the available configuration options aligned with the deployment. See the [v3.66.0 changes](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.65.1...v3.66.0).

### RPC-Go v3: Credential Handling and Lifecycle Sync

- Passwords can be supplied through environment variables, reducing the need to pass them on the command line ([#1474](https://github.com/device-management-toolkit/rpc-go/pull/1474)).
- Additional credential flags now display a warning when credentials are passed through CLI arguments ([#1543](https://github.com/device-management-toolkit/rpc-go/pull/1543)).
- Lifecycle synchronization makes automatic registration opt-in and disables it during deactivation, preventing a missing device from being recreated immediately before deletion ([#1533](https://github.com/device-management-toolkit/rpc-go/pull/1533)).

### Console: Authentication and Configuration

The releases from `v1.40.1` through `v1.42.0` include improvements that were not available at the August release cutoff:

- Session JWTs are issued as HttpOnly cookies ([#1192](https://github.com/device-management-toolkit/console/pull/1192)).
- Configuration moves to the user directory with owner-only permissions ([#1078](https://github.com/device-management-toolkit/console/pull/1078)).
- Startup checks validate the administrator password, application encryption key, HTTP port, and JWT expiration settings ([#1193](https://github.com/device-management-toolkit/console/pull/1193), [#1201](https://github.com/device-management-toolkit/console/pull/1201), [#1198](https://github.com/device-management-toolkit/console/pull/1198), [#1172](https://github.com/device-management-toolkit/console/pull/1172)).
- A JWT signing key is generated on first run, while authenticated operation requires a usable key ([#1264](https://github.com/device-management-toolkit/console/pull/1264)).
- Device creation defaults to TLS, and development service port bindings default to loopback ([#1169](https://github.com/device-management-toolkit/console/pull/1169), [#1168](https://github.com/device-management-toolkit/console/pull/1168)).
- Release artifacts gain Cosign signing, and Linux release binaries are built as position-independent executables. See the [Console comparison](https://github.com/device-management-toolkit/console/compare/v1.40.0...v1.42.0).

### API Documentation Refresh

Updated Swagger definitions have been saved for [MPS 2.35.1](https://app.swaggerhub.com/apis/rbheopenamt/mps/2.35.1) and [RPS 2.40.2](https://app.swaggerhub.com/apis/rbheopenamt/rps/2.40.2). They remain unpublished pending the documentation release.

The MPS definition documents the existing network-settings and remote-erase APIs and corrects the KVM settings route to `PUT /api/v1/amt/kvm/displays/{guid}`. The RPS definition preserves the profile-export endpoint. These are documentation updates; the network-settings APIs are not being introduced as new features in this month's component comparison.

## 🔧 Fixes & Maintenance

- **RPC-Go v2 and v3:** Improve Linux Intel® ME device discovery by supporting `/dev/mei0` through `/dev/mei3`. The stable fix is available in `v2.52.6`; the corresponding beta changes are included in `v3.0.0-beta.55` ([v2 #1505](https://github.com/device-management-toolkit/rpc-go/pull/1505), [v3 #1504](https://github.com/device-management-toolkit/rpc-go/pull/1504)).
- **Console:** Align timeout budgets with the WSMAN client for slow devices ([#1153](https://github.com/device-management-toolkit/console/pull/1153)).
- **Console:** Correct disabled-auth behavior and stop issuing signed tokens when authentication is disabled ([#1271](https://github.com/device-management-toolkit/console/pull/1271)).
- **Console:** Harden Windows browser launch, prevent integer overflow in query parameters, and limit PostgreSQL SSL-mode defaults to migrations ([#1198](https://github.com/device-management-toolkit/console/pull/1198), [#1180](https://github.com/device-management-toolkit/console/pull/1180), [v1.40.1 changes](https://github.com/device-management-toolkit/console/compare/v1.40.0...v1.40.1)).
- **Sample Web UI:** Expand activation and deactivation test coverage for RPC-Go v2 and v3 in cloud and Console deployments, correct the CIRA status assertion, and address a navigation test race ([#3509](https://github.com/device-management-toolkit/sample-web-ui/pull/3509), [#3504](https://github.com/device-management-toolkit/sample-web-ui/pull/3504), [#3542](https://github.com/device-management-toolkit/sample-web-ui/pull/3542), [#3552](https://github.com/device-management-toolkit/sample-web-ui/pull/3552)).
- **UI Toolkit, UI Toolkit Angular, and Sample Web UI:** Migrate unit tests to Vitest. Sample Web UI unit tests no longer require a browser ([UI Toolkit #1808](https://github.com/device-management-toolkit/ui-toolkit/pull/1808), [Angular #2571](https://github.com/device-management-toolkit/ui-toolkit-angular/pull/2571), [Sample Web UI #3528](https://github.com/device-management-toolkit/sample-web-ui/pull/3528), [#3540](https://github.com/device-management-toolkit/sample-web-ui/pull/3540)).
- Dependency updates, build-tool updates, and general maintenance across the remaining components. The comparisons below include the full changes for each repository.

## Compatibility & Upgrade Notes

- **Tenant-aware deployments:** Use the same tenant context in Console requests and RPC-Go v3 configuration. The tenant-forwarding changes are available from `v3.0.0-beta.57`.
- **Console configuration:** Review the move to the user configuration directory and the stronger startup validation when upgrading from the August baseline. Preserve your existing encryption keys and configuration during migration.
- **Encrypted profiles:** The August compatibility requirement still applies: profiles generated with 256-bit key entropy require RPC-Go `v2.52.4` or later.
- **Go builds:** RPC-Go's September branches and Console `v1.42.0` use Go 1.27. MPS Router's minimum is Go 1.26, while `go-wsman-messages` retains Go 1.25 compatibility.
- **RPC-Go v3:** This remains a beta release and should be evaluated accordingly before production adoption.

## :material-update:{ .icon-log } Changelog

The August baselines below come from the August release checklist and documentation. RPC-Go v3 uses `beta.51`, which the August checklist records as the published prerelease. Console was absent from that checklist; `v1.40.0` was its latest published release at the August component cutoff, even though the August documentation's Console API link pointed to `1.41.0`.

| Component | August baseline | September version / status | Complete comparison |
| --- | --- | --- | --- |
| MPS | v2.34.2 | v2.35.1 | [Changes](https://github.com/device-management-toolkit/mps/compare/v2.34.2...v2.35.1) |
| RPS | v2.40.1 | v2.40.2 | [Changes](https://github.com/device-management-toolkit/rps/compare/v2.40.1...v2.40.2) |
| Sample Web UI | v3.65.1 | v3.66.2 | [Changes](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.65.1...v3.66.2) |
| RPC-Go v2 | v2.52.5 | v2.52.6 released; v2.52.7 tagged, publication pending | [Through v2.52.7](https://github.com/device-management-toolkit/rpc-go/compare/v2.52.5...v2.52.7) |
| RPC-Go v3 beta | v3.0.0-beta.51 | v3.0.0-beta.59 | [Changes](https://github.com/device-management-toolkit/rpc-go/compare/v3.0.0-beta.51...v3.0.0-beta.59) |
| Console | v1.40.0 | v1.42.0 released; v1.42.1 on hold | [Through v1.42.0](https://github.com/device-management-toolkit/console/compare/v1.40.0...v1.42.0) |
| UI Toolkit | v3.3.20 | v3.3.21 | [Changes](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.20...v3.3.21) |
| UI Toolkit React | v5.0.8 | v5.0.9 | [Changes](https://github.com/device-management-toolkit/ui-toolkit-react/compare/v5.0.8...v5.0.9) |
| UI Toolkit Angular | v11.1.8 | v11.1.9 | [Changes](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v11.1.8...v11.1.9) |
| WSMAN Messages | v6.1.4 | v6.1.5 | [Changes](https://github.com/device-management-toolkit/wsman-messages/compare/v6.1.4...v6.1.5) |
| Go WSMAN Messages | v2.50.3 | v2.50.4 | [Changes](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.50.3...v2.50.4) |
| MPS Router | v2.5.14 | v2.5.15 | [Changes](https://github.com/device-management-toolkit/mps-router/compare/v2.5.14...v2.5.15) |

### Interim Releases Included

| Component | Releases since the August baseline |
| --- | --- |
| MPS | `v2.35.0` — RPE capability work; `v2.35.1` — dependency and release maintenance |
| RPS | `v2.40.2` — dependency and release maintenance, including WSMAN Messages `v6.1.5` |
| Sample Web UI | `v3.66.0` — conditional CIRA visibility; `v3.66.1` — CIRA test assertion fix; `v3.66.2` — dependency and release maintenance |
| RPC-Go v2 | `v2.52.6` — Linux ME device discovery; `v2.52.7` — tagged dependency/toolchain update, GitHub Release pending |
| RPC-Go v3 beta | `beta.52` — password environment variables; `beta.53` — maintenance; `beta.54` — export fields; `beta.55` — ME device discovery; `beta.56` — CLI credential warnings; `beta.57` — tenant forwarding and lifecycle sync; `beta.58` — post-activation inventory; `beta.59` — dependency and release maintenance |
| Console | `v1.40.1` — timeout, authentication, and configuration fixes; `v1.41.0` — device-export fields; `v1.41.1` — disabled-auth handling; `v1.41.2` — no signed tokens with auth disabled; `v1.42.0` — multi-tenancy |
| Libraries and wrappers | UI Toolkit `v3.3.21`, React `v5.0.9`, Angular `v11.1.9`, WSMAN Messages `v6.1.5`, and Go WSMAN Messages `v2.50.4` include dependency/build/test maintenance; React and Angular consume UI Toolkit `v3.3.21` |
| MPS Router | `v2.5.15` — dependency and toolchain maintenance |

!!! note "Before Publication"

    Confirm RPC-Go `v2.52.7` publication and the held Console release, then refresh this draft. The consolidated September deployment version and documentation version/redirect will be updated after the release version is confirmed. The existing site version and redirect are unchanged in this branch update.
