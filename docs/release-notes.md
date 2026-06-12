

# Release Notes

!!! note "Note From the Team"

    This release includes several enhancements across Console, RPS, RPC-Go, and supporting libraries, including the official release of end-to-end TLS support between Intel AMT and RPS, MongoDB support for Console, wireless state APIs, container health checks, provisioning certificate validation improvements, and continued investments in the rpc-go v3 experience.

    End-to-end TLS communication between Intel AMT and RPS is now considered production-ready and officially supported. Over the last several releases, we have continued to improve certificate validation, TLS tunnel reliability, TLS rollover behavior, and compatibility across different Intel AMT versions to support this milestone.

    We also made significant progress on rpc-go v3 with improvements to the CLI experience, richer device information, expanded certificate visibility, HTTP proxy configuration support, improved activation workflows, and better supportability features. Additional enhancements are already in development and will continue rolling out over the next few releases.

    In upcoming releases, you should start seeing support for Intel AMT 22 platforms, additional wireless management capabilities in Console, continued rpc-go v3 improvements, installer enhancements, discovery improvements, and further investments in certificate and provisioning workflows.

    Follow our [Sprint Board](https://github.com/orgs/device-management-toolkit/projects/10/views/2) to learn more and track upcoming features.

    As always, thanks to everyone providing feedback, testing new functionality, and contributing to the toolkit.

    Cheers,<br>
    **The Device Management Toolkit Team**

## 🚀 What's New?

### RPS & RPC-Go: End-to-End TLS Support for Intel AMT

This release officially supports end-to-end TLS communication between Intel AMT and RPS using the `-tls-tunnel` flag in rpc-go.

As part of this flow, RPS creates a new Intel AMT TLS leaf certificate signed by the existing MPS Root Certificate. Intel AMT then uses that certificate for the TLS session with RPS.

The AMT private key always remains within Intel AMT and is never exposed to rpc-go or the host OS. rpc-go only proxies the encrypted TLS traffic between Intel AMT and RPS, so the TLS session is not decrypted on the device.

This capability is now considered production-ready and officially supported.

### RPC-Go v3: Improved CLI Experience and Device Information

This release includes several improvements to the rpc-go v3 user experience, including a redesigned `amtinfo` command with improved formatting, richer device information, expanded certificate visibility, and support for viewing Intel AMT HTTP proxy configuration.

The updated output provides a more structured view of device configuration, network adapters, remote access settings, certificates, and other platform information, making troubleshooting and device validation easier for administrators.

Additional improvements include a more detailed `version` command for troubleshooting and supportability, the ability to launch from a non-administrator terminal and elevate only when required, and enhancements to activation workflows for local profile-based deployments.

### Console: MongoDB Database Support

Console now supports MongoDB as an alternative database backend. This provides organizations with additional deployment flexibility and enables environments that prefer document-based storage to run Console without requiring PostgreSQL.

### Console: Health Checks for Containerized Deployments

Console now includes a CLI health check command designed for containerized deployments. This simplifies readiness and health monitoring when running Console in Docker, Kubernetes, and other orchestration environments.

### RPS: Provisioning Certificate Validation

RPS now validates provisioning certificates before activation begins, helping identify invalid or unsupported certificates earlier in the provisioning workflow and reducing activation failures.

### Console: Wireless API

Console now includes APIs to query and manage wireless state information, providing a foundation for upcoming wireless management capabilities in Console.

## 🧩 Enhancements & Improvements

### Console: Improved Request Handling

Console now supports cancellation of in-flight requests, helping prevent stale operations from continuing in the background and improving responsiveness during long-running device operations.

### Go WSMAN Messages: Expanded CIM, AMT, and IPS Coverage

The Go WSMAN Messages library continues to expand its coverage of Intel AMT, CIM, and IPS resources, adding support for CIM_Battery, CIM_Fan, and CIM_Sensor classes based on customer feedback.

In addition to the new CIM, AMT, and IPS service wrappers, significant internal improvements were made to reduce code duplication, improve maintainability, and simplify the process of extending WSMAN service support in future releases.

### Sample Web UI: Faster KVM Session Connection

The KVM connection initialization sequence has been optimized, reducing the time from clicking "Connect KVM" to seeing the remote desktop.

## 🔧 Fixes & Maintenance

- RPS fixes for legacy TLS compatibility, TLS rollover reliability, post-TLS validation behavior, and certificate serial number generation

- RPC-Go fix to correctly handle TLS 1.3 data received from Intel AMT

- MPS validation improvements for DNS suffix configuration

- Console fixes for request cancellation handling, profile updates, OpenAPI specification updates, PostgreSQL compatibility, CIRA configuration handling, redirection token expiration, certificate generation, configuration path resolution, and general API stability

- Console fixes to improve profile validation and allow profile updates without re-entering passwords

- Sample Web UI fixes for profile editing, certificate list refresh behavior, WSMAN Explorer UI behavior, and password handling improvements

- Go WSMAN Messages fixes for APF channel cleanup, channel lifecycle management, and event-driven response handling

- UI Toolkit fix to release held keyboard keys when KVM sessions lose focus

- Minor dependency updates and general maintenance across toolkit components

## :material-update:{ .icon-log } Changelog
  
### RPS

#### [2.36.4](https://github.com/device-management-toolkit/rps/compare/v2.36.3...v2.36.4) (2026-05-26)

Bug Fixes

* **api:** allow profile PATCH without passwords ([#2715](https://github.com/device-management-toolkit/rps/issues/2715)) ([7d77f64](https://github.com/device-management-toolkit/rps/commit/7d77f641e5a50cd2a384f145d5d6f4149fd0221e))

#### [2.36.3](https://github.com/device-management-toolkit/rps/compare/v2.36.2...v2.36.3) (2026-05-11)

Bug Fixes

* harden post CCM TLS rollover and retry behavior ([#2691](https://github.com/device-management-toolkit/rps/issues/2691)) ([0576cca](https://github.com/device-management-toolkit/rps/commit/0576ccaec4c98dd00149df94e86da248b9899992))

#### [2.36.2](https://github.com/device-management-toolkit/rps/compare/v2.36.1...v2.36.2) (2026-04-30)

Bug Fixes

* address negative serial numbers generated ~20% of the time ([#2690](https://github.com/device-management-toolkit/rps/issues/2690)) ([aa30c80](https://github.com/device-management-toolkit/rps/commit/aa30c80eafb33f9c9a92de9a0366020f2587c1e0))

#### [2.36.1](https://github.com/device-management-toolkit/rps/compare/v2.36.0...v2.36.1) (2026-04-29)

Bug Fixes

* enable AMT legacy TLS compatibility and post-TLS reject by default ([#2689](https://github.com/device-management-toolkit/rps/issues/2689)) ([b9d4397](https://github.com/device-management-toolkit/rps/commit/b9d43976d8902de930bd57406e674fba8afeb3d2))

#### [2.36.0](https://github.com/device-management-toolkit/rps/compare/v2.35.0...v2.36.0) (2026-04-28)

Features

* improves tls tunnel flow ([#2683](https://github.com/device-management-toolkit/rps/issues/2683)) ([652d2bf](https://github.com/device-management-toolkit/rps/commit/652d2bf3997e06dd7ce8246954fc1fe494126428))

#### [2.35.0](https://github.com/device-management-toolkit/rps/compare/v2.34.3...v2.35.0) (2026-04-24)

Features

* add provisioning certificate validation checks ([#2686](https://github.com/device-management-toolkit/rps/issues/2686)) ([e473dda](https://github.com/device-management-toolkit/rps/commit/e473dda72429879f536aa6584287c7ee4917c8b0))

#### [2.34.3](https://github.com/device-management-toolkit/rps/compare/v2.34.2...v2.34.3) (2026-04-22)

Performance Improvements

* improves rpc to rps performance ([#2681](https://github.com/device-management-toolkit/rps/issues/2681)) ([79f9a53](https://github.com/device-management-toolkit/rps/commit/79f9a5370d518d79efbe7aeec8048d3dd6e9bb52))

### MPS

#### [2.26.6](https://github.com/device-management-toolkit/mps/compare/v2.26.5...v2.26.6) (2026-05-20)

#### [2.26.5](https://github.com/device-management-toolkit/mps/compare/v2.26.4...v2.26.5) (2026-04-21)

Bug Fixes

* added input validator for dnsSuffix ([#2393](https://github.com/device-management-toolkit/mps/issues/2393)) ([355bb85](https://github.com/device-management-toolkit/mps/commit/355bb8540577db7c87c85dfcc88f6119fb5470fd))

### RPC Go

#### [2.50.6](https://github.com/device-management-toolkit/rpc-go/compare/v2.50.5...v2.50.6) (2026-05-21)

#### [2.50.5](https://github.com/device-management-toolkit/rpc-go/compare/v2.50.4...v2.50.5) (2026-05-14)

#### [2.50.4](https://github.com/device-management-toolkit/rpc-go/compare/v2.50.3...v2.50.4) (2026-04-29)

Bug Fixes

* ensure latest go version is used ([#1298](https://github.com/device-management-toolkit/rpc-go/issues/1298)) ([494cd77](https://github.com/device-management-toolkit/rpc-go/commit/494cd77ffbe8ce50a72148ae52e938f6a6c9f54a))

#### [2.50.3](https://github.com/device-management-toolkit/rpc-go/compare/v2.50.2...v2.50.3) (2026-04-29)

Bug Fixes

* ensure semantic release uses latest version of go ([2251071](https://github.com/device-management-toolkit/rpc-go/commit/225107155c8f2121d2cd486acc198e91eaa4f358))

#### [2.50.2](https://github.com/device-management-toolkit/rpc-go/compare/v2.50.1...v2.50.2) (2026-04-28)

Bug Fixes

* handle tls v1.3 data from AMT ([56bc354](https://github.com/device-management-toolkit/rpc-go/commit/56bc3545d3f21ed7a53c5ce27f894be6661d0949))

### Sample Web UI

#### [3.57.7](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.57.6...v3.57.7) (2026-05-26)

Bug Fixes

* require password when switching random to static on edit ([#3334](https://github.com/device-management-toolkit/sample-web-ui/issues/3334)) ([f262b20](https://github.com/device-management-toolkit/sample-web-ui/commit/f262b20bd71f6236cbc316df6416ed5ee1788658))

#### [3.57.6](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.57.5...v3.57.6) (2026-05-22)

Bug Fixes

* correct malformed translate interpolation on proxy label ([#3331](https://github.com/device-management-toolkit/sample-web-ui/issues/3331)) ([82431b2](https://github.com/device-management-toolkit/sample-web-ui/commit/82431b29ccff9f7bfc49076242f16a79b78e8dac))

#### [3.57.5](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.57.4...v3.57.5) (2026-05-20)

#### [3.57.4](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.57.3...v3.57.4) (2026-05-20)

Bug Fixes

* devices: bind WSMAN Explorer placeholder via property syntax ([#3320](https://github.com/device-management-toolkit/sample-web-ui/issues/3320)) ([2473592](https://github.com/device-management-toolkit/sample-web-ui/commit/2473592605bc593137632b99922dcc6e5e7d9b8f)), closes [#3319](https://github.com/device-management-toolkit/sample-web-ui/issues/3319)
* devices: refresh certificate list immediately on add and delete ([#3318](https://github.com/device-management-toolkit/sample-web-ui/issues/3318)) ([5874a05](https://github.com/device-management-toolkit/sample-web-ui/commit/5874a05a47a78c5046dfac5e2cc7d715adc667bb)), closes [#3317](https://github.com/device-management-toolkit/sample-web-ui/issues/3317)

#### [3.57.3](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.57.2...v3.57.3) (2026-05-15)

Bug Fixes

* allow editing profile without re-entering passwords ([#3307](https://github.com/device-management-toolkit/sample-web-ui/issues/3307)) ([4df57b2](https://github.com/device-management-toolkit/sample-web-ui/commit/4df57b2723c20a594cd2d5ec34c0f975c4916567))

#### [3.57.2](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.57.1...v3.57.2) (2026-04-22)

Performance Improvements

* improve KVM connection time ([f97baa2](https://github.com/device-management-toolkit/sample-web-ui/commit/f97baa2ab933b57990faa9a4c124510698135273))

### UI Toolkit

#### [3.3.15](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.14...v3.3.15) (2026-05-20)

#### [3.3.14](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.13...v3.3.14) (2026-05-19)

Bug Fixes

* build: restore dist/core/package.json subpath shim ([218930f](https://github.com/device-management-toolkit/ui-toolkit/commit/218930f2d02904afbe28e878578a1687a505b070))

#### [3.3.13](https://github.com/device-management-toolkit/ui-toolkit/compare/v3.3.12...v3.3.13) (2026-05-19)

Bug Fixes

* kvm: release held keys on blur ([#1696](https://github.com/device-management-toolkit/ui-toolkit/issues/1696)) ([5629ca1](https://github.com/device-management-toolkit/ui-toolkit/commit/5629ca1e48c66dc3bc6d525492d59b6f68a43dc9))

### UI Toolkit Angular

#### [11.1.4](https://github.com/device-management-toolkit/ui-toolkit-angular/compare/v11.1.3...v11.1.4) (2026-05-20)

### UI Toolkit React

#### [5.0.4](https://github.com/device-management-toolkit/ui-toolkit-react/compare/v5.0.3...v5.0.4) (2026-05-20)

### Console

#### [1.27.2](https://github.com/device-management-toolkit/console/compare/v1.27.1...v1.27.2) (2026-05-20)

#### [1.27.1](https://github.com/device-management-toolkit/console/compare/v1.27.0...v1.27.1) (2026-05-19)

Reverts

* Revert "fix: correct inverted GIN_MODE condition in handleDebugMode ([#979](https://github.com/device-management-toolkit/console/pull/979))" ([d8d9ef0](https://github.com/device-management-toolkit/console/commit/d8d9ef028f8a8e482998acdc49f2e92f5305c925)), closes [#979](https://github.com/device-management-toolkit/console/issues/979)

#### [1.27.0](https://github.com/device-management-toolkit/console/compare/v1.26.6...v1.27.0) (2026-05-18)

Features

* tray: enforce single instance and expose reachable URLs ([676bd75](https://github.com/device-management-toolkit/console/commit/676bd75bfc3f7d656cd429dc80de01e5032890ea)), closes [#870](https://github.com/device-management-toolkit/console/issues/870)

#### [1.26.6](https://github.com/device-management-toolkit/console/compare/v1.26.5...v1.26.6) (2026-05-18)

Bug Fixes

* config: resolve symlinks when locating config dir ([#985](https://github.com/device-management-toolkit/console/issues/985)) ([3c696e6](https://github.com/device-management-toolkit/console/commit/3c696e6e5a7fd968dc65c86a6cbbe02da2d3fe4b))

#### [1.26.5](https://github.com/device-management-toolkit/console/compare/v1.26.4...v1.26.5) (2026-05-18)

Bug Fixes

* cert generation returns parsed cert with valid Raw field ([#970](https://github.com/device-management-toolkit/console/issues/970)) ([9d06967](https://github.com/device-management-toolkit/console/commit/9d06967160dc155006380c14cc01d29c9f39aa90)), closes [device-management-toolkit/deployment#573](https://github.com/device-management-toolkit/deployment/issues/573)

#### [1.26.4](https://github.com/device-management-toolkit/console/compare/v1.26.3...v1.26.4) (2026-05-18)

Bug Fixes

* correct inverted GIN_MODE condition in handleDebugMode ([#979](https://github.com/device-management-toolkit/console/issues/979)) ([8bb7d69](https://github.com/device-management-toolkit/console/commit/8bb7d6966b5a09aed113bd6d9e60cd61c906698d)), closes [device-management-toolkit/deployment#573](https://github.com/device-management-toolkit/deployment/issues/573)

#### [1.26.3](https://github.com/device-management-toolkit/console/compare/v1.26.2...v1.26.3) (2026-05-15)

Bug Fixes

* api: allow profile PATCH without passwords ([#973](https://github.com/device-management-toolkit/console/issues/973)) ([18ba76d](https://github.com/device-management-toolkit/console/commit/18ba76dfb6c41f5e394f9ba31de9583be5f48dd3))

#### [1.26.2](https://github.com/device-management-toolkit/console/compare/v1.26.1...v1.26.2) (2026-05-12)

Bug Fixes

* enforce RPS profile name and password rules on /profiles ([#963](https://github.com/device-management-toolkit/console/issues/963)) ([b484704](https://github.com/device-management-toolkit/console/commit/b48470444e94fd7bbb62fbcd7388a98f9629ac13))

#### [1.26.1](https://github.com/device-management-toolkit/console/compare/v1.26.0...v1.26.1) (2026-05-12)

Bug Fixes

* fix redirection token expiration ([#958](https://github.com/device-management-toolkit/console/issues/958)) ([2985470](https://github.com/device-management-toolkit/console/commit/29854706461e4d9fc3fdc5e86fa8dd38d7ee3047))

#### [1.26.0](https://github.com/device-management-toolkit/console/compare/v1.25.2...v1.26.0) (2026-05-06)

Features

* add MongoDB NoSQL database backend ([#904](https://github.com/device-management-toolkit/console/issues/904)) ([e4e33d2](https://github.com/device-management-toolkit/console/commit/e4e33d2a662f73788cb7583141d67451d5b78d3a))

#### [1.25.2](https://github.com/device-management-toolkit/console/compare/v1.25.1...v1.25.2) (2026-05-06)

Bug Fixes

* remove postgres-only IF NOT EXISTS from ALTER TABLE ([#953](https://github.com/device-management-toolkit/console/issues/953)) ([45c1686](https://github.com/device-management-toolkit/console/commit/45c168630551131425aed50c088e4f162ad51282))

#### [1.25.1](https://github.com/device-management-toolkit/console/compare/v1.25.0...v1.25.1) (2026-05-05)

Bug Fixes

* ensure postgres works with ciraconfigs ([#950](https://github.com/device-management-toolkit/console/issues/950)) ([f3690c5](https://github.com/device-management-toolkit/console/commit/f3690c58980ac092727985f2f333d419265815ca))

#### [1.25.0](https://github.com/device-management-toolkit/console/compare/v1.24.4...v1.25.0) (2026-05-05)

Features

* enables healthcheck via cli for containerized deployments ([#949](https://github.com/device-management-toolkit/console/issues/949)) ([f5975ba](https://github.com/device-management-toolkit/console/commit/f5975ba867629277a4f8da473f9cd19da5a2f6dd))

#### [1.24.4](https://github.com/device-management-toolkit/console/compare/v1.24.3...v1.24.4) (2026-05-05)

Bug Fixes

* address small issues ([#948](https://github.com/device-management-toolkit/console/issues/948)) ([10877dd](https://github.com/device-management-toolkit/console/commit/10877dd020fddf6c94f2fb0eb77f54c60637c08c))

#### [1.24.3](https://github.com/device-management-toolkit/console/compare/v1.24.2...v1.24.3) (2026-04-30)

Bug Fixes

* preserve omitted fields on PATCH ([#917](https://github.com/device-management-toolkit/console/issues/917)) ([e86bdd8](https://github.com/device-management-toolkit/console/commit/e86bdd80eb1bfa667e702a4251130b5989d98114))

#### [1.24.2](https://github.com/device-management-toolkit/console/compare/v1.24.1...v1.24.2) (2026-04-29)

Bug Fixes

* update openapi spec ([#915](https://github.com/device-management-toolkit/console/issues/915)) ([1d2f1ce](https://github.com/device-management-toolkit/console/commit/1d2f1cec58bb2532a6f039489c5c7c81aec80719))

#### [1.24.1](https://github.com/device-management-toolkit/console/compare/v1.24.0...v1.24.1) (2026-04-28)

Bug Fixes

* serve full monaco asset subtree for Explorer ([#911](https://github.com/device-management-toolkit/console/issues/911)) ([abbc036](https://github.com/device-management-toolkit/console/commit/abbc036ba70b96012c2befa2267ef4ebcd470ecd))

#### [1.24.0](https://github.com/device-management-toolkit/console/compare/v1.23.2...v1.24.0) (2026-04-28)

Features

* add wireless state get and request API ([#885](https://github.com/device-management-toolkit/console/issues/885)) ([ccd254c](https://github.com/device-management-toolkit/console/commit/ccd254c62bb543c29cd22d3efa75c418074a4b96))

#### [1.23.2](https://github.com/device-management-toolkit/console/compare/v1.23.1...v1.23.2) (2026-04-23)

#### [1.23.1](https://github.com/device-management-toolkit/console/compare/v1.23.0...v1.23.1) (2026-04-22)

Bug Fixes

* address issue with calls failing after being cancelled ([3067bb8](https://github.com/device-management-toolkit/console/commit/3067bb863962cb91836b3abf8b73d845be827e7f))

#### [1.23.0](https://github.com/device-management-toolkit/console/compare/v1.22.9...v1.23.0) (2026-04-16)

Features

* enable cancelling of requests ([92f6575](https://github.com/device-management-toolkit/console/commit/92f65759fbe4f01eb72f85bb42d6b85d7b2b7cf3))

### Go WSMAN Messages

#### [2.46.1](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.46.0...v2.46.1) (2026-05-20)

#### [2.46.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.45.0...v2.46.0) (2026-05-12)

Features

* cim: add CIM_Battery service ([#692](https://github.com/device-management-toolkit/go-wsman-messages/issues/692)) ([469d11d](https://github.com/device-management-toolkit/go-wsman-messages/commit/469d11d2f6d8c230b77eaa4ae8a6172c0c9dc47d))

#### [2.45.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.44.0...v2.45.0) (2026-05-12)

Features

* cim: add fan sensor ([#693](https://github.com/device-management-toolkit/go-wsman-messages/issues/693)) ([c59d02d](https://github.com/device-management-toolkit/go-wsman-messages/commit/c59d02dcb66f4483a7c3daa13666f6fcb7423c5c))

#### [2.44.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.43.0...v2.44.0) (2026-05-12)

Features

* cim: add CIM_Sensor service ([#691](https://github.com/device-management-toolkit/go-wsman-messages/issues/691)) ([9477280](https://github.com/device-management-toolkit/go-wsman-messages/commit/9477280110e2eab79c4fc918be84306fc1563a10))

#### [2.43.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.42.0...v2.43.0) (2026-04-29)

Features

* add CIM_AssociatedPowerManagementService wrapper ([#679](https://github.com/device-management-toolkit/go-wsman-messages/issues/679)) ([2fc831a](https://github.com/device-management-toolkit/go-wsman-messages/commit/2fc831a4c4b461598688c33afa2eb778fe47e155))

#### [2.42.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.41.0...v2.42.0) (2026-04-29)

Features

* add missing wsman fetcher class function ([#664](https://github.com/device-management-toolkit/go-wsman-messages/issues/664)) ([8dd142f](https://github.com/device-management-toolkit/go-wsman-messages/commit/8dd142fc89ae5c3484ff562f77d6ceebbdede274))

#### [2.41.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.40.0...v2.41.0) (2026-04-29)

Features

* add missing wsman fetcher class function for CIM classes ([#681](https://github.com/device-management-toolkit/go-wsman-messages/issues/681)) ([75f8a82](https://github.com/device-management-toolkit/go-wsman-messages/commit/75f8a82f7bf50dacbd5e91d536dba26cdb47a015))

#### [2.40.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.39.0...v2.40.0) (2026-04-29)

Features

* add missing wsman fetcher class function for IPS Classes ([#671](https://github.com/device-management-toolkit/go-wsman-messages/issues/671)) ([61db8da](https://github.com/device-management-toolkit/go-wsman-messages/commit/61db8dab4a0d52a26040a76b8876332fd2a4bb8c))

#### [2.39.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.38.4...v2.39.0) (2026-04-17)

Features

* amt/boot: add RPE parameter types, sizes, validation maps, and tests ([#665](https://github.com/device-management-toolkit/go-wsman-messages/issues/665)) ([05e5dd4](https://github.com/device-management-toolkit/go-wsman-messages/commit/05e5dd4aa91f9e799cbef28532fcb59179d3ed11))

#### [2.38.4](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.38.3...v2.38.4) (2026-04-17)

Bug Fixes

* ack APF_CHANNEL_CLOSE so AMT can reclaim the channel slot ([#675](https://github.com/device-management-toolkit/go-wsman-messages/issues/675)) ([f4435ef](https://github.com/device-management-toolkit/go-wsman-messages/commit/f4435efc891c5f644f1be95118f5c79721503d5a))

#### [2.38.3](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.38.2...v2.38.3) (2026-04-17)

Bug Fixes

* ensure proper channel is being closed and adjusted ([bc8cfbf](https://github.com/device-management-toolkit/go-wsman-messages/commit/bc8cfbf772baf858044da48f272c8f76121b323e))
* ensure proper channel is being closed and adjusted ([#674](https://github.com/device-management-toolkit/go-wsman-messages/issues/674)) ([18b1a72](https://github.com/device-management-toolkit/go-wsman-messages/commit/18b1a72e9f320b5b33f5f6fbab606c94c2ecdae1))

#### [2.38.2](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.38.1...v2.38.2) (2026-04-16)

Bug Fixes

* apf: event-driven response completion and window adjust replies ([#673](https://github.com/device-management-toolkit/go-wsman-messages/issues/673)) ([6ce79a9](https://github.com/device-management-toolkit/go-wsman-messages/commit/6ce79a9d4ea6c9fe9e8bd410e38095788a710df1))

### WSMAN Messages

#### [6.0.2](https://github.com/device-management-toolkit/wsman-messages/compare/v6.0.1...v6.0.2) (2026-05-20)

### MPS Router

#### [2.5.10](https://github.com/device-management-toolkit/mps-router/compare/v2.5.9...v2.5.10) (2026-05-20)