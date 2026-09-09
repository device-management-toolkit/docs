# Release Notes

!!! note "Note From the Team"

    In this August release (v2.38.0), we are excited to introduce Provisioning Status Tracking in MPS for cloud deployments during the RPS provisioning flow, as well as Remote Platform Erase (RPE) support in MPS and Sample Web UI. Full documentation for RPE is currently being finalized and will be published later this week.

    Additionally, this release brings key security and usability improvements, including HttpOnly session cookie authentication, default TLS options when adding devices, 256-bit key entropy, and User ACL Management in `go-wsman-messages` (contributed by an external community contributor).

    You may have noticed that a new version of Console hasn't been released over the past month. As we navigate additional review and compliance approvals behind the scenes, Console releases were temporarily paused until these required checks were completed. These approvals are concluding, and our rapid release rhythm will be back on track very soon with a major set of Console improvements releasing shortly.

    Security remains our highest priority. While enforcing stronger security baselines out-of-the-box can sometimes add steps to initial setup, we are dedicated to keeping onboarding as smooth as possible. To preserve user experience and simplicity, we are actively developing installers, guided web configuration options, and other UX improvements.

    Looking ahead, we are working on introducing a bulk power state pull feature in MPS, enabling supported deployment architectures where customers can deploy Console and RPS together (a key v3 capability), completing the official release of RPC-Go v3, as well as advancing device health and discovery capabilities and much more.

    Follow our [Sprint Board](https://github.com/orgs/device-management-toolkit/projects/10/views/2) to learn more and track upcoming features.

    As always, thanks to everyone providing feedback, testing new functionality, and contributing to the toolkit.

    Cheers,<br>
    **The Device Management Toolkit Team**

## 🚀 What's New?

### RPS: Provisioning Status Tracking in MPS

During the RPS provisioning flow in cloud deployments, RPS now persists granular, per-component provisioning status directly to the MPS `deviceInfo` record upon activation.

Rather than simple flat status strings, the `status` field in `deviceInfo` contains structured results for each applicable component (such as `Activation`, `WiredNetwork`, `WirelessNetwork`, `TLS`, `CIRAProxy`, and `CIRAConnection`), complete with `Result` (`Success` or `Failure`), optional `Mode`, and diagnostic `Details`.

**Example: Successful Activation**

```json
{
  "fwVersion": "16.1.25",
  "fwBuild": "2026",
  "fwSku": "16392",
  "currentMode": "0",
  "features": "redirection,kvm",
  "ipAddress": "192.168.1.100",
  "status": {
    "Activation": {
      "Result": "Success",
      "Mode": "ACM",
      "Details": "Device activated in admin control mode"
    },
    "WiredNetwork": {
      "Result": "Success",
      "Details": "Wired Network Configured"
    },
    "TLS": {
      "Result": "Success",
      "Details": "Configured"
    },
    "CIRAConnection": {
      "Result": "Success",
      "Details": "Configured"
    }
  },
  "activatedAt": "2026-08-21T10:00:00.000Z",
  "lastProvisionedAt": "2026-08-26T14:30:00.000Z",
  "lastUpdated": "2026-08-26T14:30:00.000Z"
}
```

**Example: Failed Network Step (e.g., Wired or Wireless Network Failure)**

When a network configuration step fails during activation or re-provisioning, the corresponding network component's `Result` is marked as `"Failure"`, with `Details` describing the specific failure reason:

```json
{
  "fwVersion": "16.1.25",
  "fwBuild": "2026",
  "fwSku": "16392",
  "currentMode": "0",
  "features": "redirection,kvm",
  "ipAddress": "192.168.1.100",
  "status": {
    "Activation": {
      "Result": "Success",
      "Mode": "ACM",
      "Details": "Device activated in admin control mode"
    },
    "WiredNetwork": {
      "Result": "Failure",
      "Details": "Failed to set wired network configuration"
    },
    "WirelessNetwork": {
      "Result": "Failure",
      "Details": "Failed to add profile"
    }
  },
  "activatedAt": "2026-08-21T10:00:00.000Z",
  "lastProvisionedAt": "2026-08-26T14:30:00.000Z",
  "lastUpdated": "2026-08-26T14:30:00.000Z"
}
```

!!! note "Note"

    In upcoming releases, error codes will also be introduced per component status to provide ISVs with exact error taxonomy when debugging failed state-machine steps.

### MPS & Sample Web UI: Remote Platform Erase

MPS and the Sample Web UI now support triggering Remote Platform Erase (RPE) on managed Intel® AMT devices, giving administrators a way to securely wipe device components remotely via REST APIs or directly from the web console.

Based on the platform's CSME capabilities and BIOS support, administrators can select granular target components to erase:

- **Secure Erase of All SSDs (`secureEraseSsds`)**: Removes storage content across ATA and NVMe drives via media erase and crypto erase (with optional drive password support for encrypted SSDs).
- **TPM Clear (`tpmClear`)**: Clears keys and data protected by the Trusted Platform Module (such as virtual smart cards and PINs).
- **Restore BIOS Settings (`biosRestore`)**: Resets BIOS settings to End of Manufacture (EOM) golden configuration state and clears post-EOM BIOS variables.

!!! note "Note"

    Detailed documentation for Remote Platform Erase is currently being finalized and will be released this week.

## 🧩 Enhancements & Improvements

### go-wsman-messages: User ACL Management

Adds `AddUserAclEntryEx` and ACL response types to `go-wsman-messages`, enabling finer-grained management of Intel® AMT user access control entries at the library level.

*Special thanks to our external open-source contributors [@bennyc-huji](https://github.com/bennyc-huji) and [@1kamma](https://github.com/1kamma) for contributing this feature!*

!!! note "Note"

    While currently enabled in `go-wsman-messages`, integration into Console and `rpc-go` may be explored in future releases as customer requirements for AMT ACL management evolve—community contributions and pull requests are always welcome!

### Sample Web UI: Dedicated IDER Experience for Intel® Standard Manageability (ISM) Systems

The web UI now automatically adapts its device details interface based on the managed device's SKU capabilities. On Intel® Standard Manageability (ISM) systems—where KVM (Keyboard Video Mouse) is not supported—the KVM tab is hidden to avoid confusion and attempt failed connections. 

Instead, a dedicated **IDER (IDE Redirection)** tab is displayed, introducing a new standalone `IderComponent` that allows administrators to upload disk images, manage user consent flows, and control IDER sessions seamlessly on ISM devices.

### go-wsman-messages: Stronger Key Entropy & RPC Compatibility

Key generation in `go-wsman-messages` (`v2.50.0`) has been upgraded from 192-bit (24-byte) to 256-bit (32-byte) key entropy. While profile payload encryption itself continues to use AES-256, generating keys with full 256-bit entropy significantly strengthens cryptographic security across generated keys and profile exports.

!!! warning "Important Compatibility Requirement & Breaking Change"

    Profiles generated using the new 256-bit key entropy (such as in upcoming **Console** releases) require **RPC-Go `v2.52.4` or later** on target endpoints.

    * **Impact**: Attempting to execute local activation or profile export using older versions of `rpc-go` against a Console generating 256-bit keys will fail with a `crypto/aes: invalid key size` error due to key length mismatch.
    * **Action Required**: Ensure all managed endpoints running RPC are updated to **`rpc-go` v2.52.4+**. If you build `rpc-go` from source, run `go mod tidy` in your repository to ensure it pulls `go-wsman-messages` `v2.50.0` or higher.

### Sample Web UI: HttpOnly Session Cookie Authentication

Authentication in the Sample Web UI now uses an HttpOnly session cookie instead of `localStorage`, hardening the application against unauthorized token access from client-side scripts. This UI-specific security enhancement is especially useful for Console deployments and does not block or impact direct REST API requests using bearer auth.

### Sample Web UI: TLS Defaults on Add Device

Adding a device now defaults `useTLS` and `allowSelfSigned` to enabled. Because Intel® AMT version 16+ devices only permit connections over TLS, this usability enhancement streamlines adding newly managed devices without requiring manual TLS toggle selection.

!!! note "Note"

    rpc-go v3 is currently in Beta. Once released, its automatic device registration feature will handle device addition and connection settings automatically with Console, eliminating manual device entry entirely.

## 🔧 Fixes & Maintenance

- RPC Go fix to prevent a nil pointer panic when root CA generation fails
- Sample Web UI fix to keep bearer auth for cloud builds
- Sample Web UI fix to remove the "Use CIRA" option from the Add Device dialog
- go-wsman-messages fix for bounded concurrency and thread-safe digest handling on slow devices
- go-wsman-messages fix to compare the pinned certificate against the connection leaf
- go-wsman-messages fix to restore the HTTP request timeout on Target
- go-wsman-messages fix to handle missing 2057 data
- Minor dependency updates and general maintenance across toolkit components

## :material-update:{ .icon-log } Changelog
  
### RPS

#### [2.40.1](https://github.com/device-management-toolkit/rps/compare/v2.40.0...v2.40.1) (2026-08-26)

Features

* **activation:** prevent orphaned MPS device records on re-provision ([#2873](https://github.com/device-management-toolkit/rps/issues/2873)) ([624c6d6](https://github.com/device-management-toolkit/rps/commit/624c6d6432abbf76c3a5bca25c416c3a12baa8dc))

#### [2.40.0](https://github.com/device-management-toolkit/rps/compare/v2.39.4...v2.40.0) (2026-08-21)

Features

* **activation:** persist provisioning status to MPS deviceInfo ([#2771](https://github.com/device-management-toolkit/rps/issues/2771)) ([1a22e3b](https://github.com/device-management-toolkit/rps/commit/1a22e3b6ecb85f391d29ea79bb1ef7e2c489de7b)), closes [#2665](https://github.com/device-management-toolkit/rps/issues/2665)


### MPS

#### [2.34.2](https://github.com/device-management-toolkit/mps/compare/v2.34.1...v2.34.2) (2026-08-26)


### RPC Go

#### [2.52.5](https://github.com/device-management-toolkit/rpc-go/compare/v2.52.4...v2.52.5) (2026-08-26)

#### [2.52.4](https://github.com/device-management-toolkit/rpc-go/compare/v2.52.3...v2.52.4) (2026-08-18)

Bug Fixes

* prevent nil pointer panic when root CA generation fails ([#1506](https://github.com/device-management-toolkit/rpc-go/issues/1506)) ([cd84648](https://github.com/device-management-toolkit/rpc-go/commit/cd8464833d6286534a2c6e755f041419b1c59380))


### Sample Web UI

#### [3.65.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.65.0...v3.65.1) (2026-08-26)

#### [3.65.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.64.1...v3.65.0) (2026-08-20)

Features

* **devices:** default useTLS and allowSelfSigned on add device ([#3480](https://github.com/device-management-toolkit/sample-web-ui/issues/3480)) ([ede6745](https://github.com/device-management-toolkit/sample-web-ui/commit/ede6745b210c407afc89dc36bfd5c572665025fa))

#### [3.64.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.64.0...v3.64.1) (2026-08-13)

Bug Fixes

* **login:** keep bearer auth for cloud builds ([#3501](https://github.com/device-management-toolkit/sample-web-ui/issues/3501)) ([301146f](https://github.com/device-management-toolkit/sample-web-ui/commit/301146fbca41aa9bd272c5583561112338400f0a)), closes [#3499](https://github.com/device-management-toolkit/sample-web-ui/issues/3499)

#### [3.64.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.63.1...v3.64.0) (2026-08-12)

Features

* **login:** use HttpOnly session cookie instead of localStorage ([#3499](https://github.com/device-management-toolkit/sample-web-ui/issues/3499)) ([f008ded](https://github.com/device-management-toolkit/sample-web-ui/commit/f008dedadc2530b8674ad8e7ed1289682bff8b74))

#### [3.63.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.63.0...v3.63.1) (2026-08-10)

Bug Fixes

* remove "Use CIRA" option from Add Device dialog ([#3282](https://github.com/device-management-toolkit/sample-web-ui/issues/3282)) ([9eae667](https://github.com/device-management-toolkit/sample-web-ui/commit/9eae667df28e39b39b280cdec4b20052bc721afe))

#### [3.63.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.62.0...v3.63.0) (2026-08-04)

Features

* **devices:** add remote platform erase support ([#3206](https://github.com/device-management-toolkit/sample-web-ui/issues/3206)) ([d63792c](https://github.com/device-management-toolkit/sample-web-ui/commit/d63792c027e12b4f99462049c4cae6746c36b24a))

#### [3.62.0](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.61.1...v3.62.0) (2026-07-31)

Features

* hide KVM tab on ISM systems.  Use IDER tab instead ([#3418](https://github.com/device-management-toolkit/sample-web-ui/issues/3418)) ([0823640](https://github.com/device-management-toolkit/sample-web-ui/commit/08236406f9e23a1583fa86b9bd0a600c1bec4f19))

#### [3.61.1](https://github.com/device-management-toolkit/sample-web-ui/compare/v3.61.0...v3.61.1) (2026-07-28)


### Go WSMAN Messages

#### [2.50.3](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.50.2...v2.50.3) (2026-08-26)

#### [2.50.2](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.50.1...v2.50.2) (2026-08-24)

Bug Fixes

* bounded concurrency and thread-safe digest for slow devices ([#752](https://github.com/device-management-toolkit/go-wsman-messages/issues/752)) ([750289c](https://github.com/device-management-toolkit/go-wsman-messages/commit/750289cc148826ad195da32f9dda6c4a4d3df522)), closes [#1082](https://github.com/device-management-toolkit/go-wsman-messages/issues/1082)

#### [2.50.1](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.50.0...v2.50.1) (2026-08-13)

Bug Fixes

* **client:** compare pinned certificate against the connection leaf ([#768](https://github.com/device-management-toolkit/go-wsman-messages/issues/768)) ([70c3c98](https://github.com/device-management-toolkit/go-wsman-messages/commit/70c3c981315dc6c7a913caf6a3190775a0342e92))

#### [2.50.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.49.1...v2.50.0) (2026-08-11)

Features

* increase key entropy from 192 to 256 ([#758](https://github.com/device-management-toolkit/go-wsman-messages/issues/758)) ([2b13592](https://github.com/device-management-toolkit/go-wsman-messages/commit/2b13592b5c71a802ffc535e4c41303baca55f5b7))

#### [2.49.1](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.49.0...v2.49.1) (2026-08-11)

Bug Fixes

* **client:** restore HTTP request timeout on Target ([#767](https://github.com/device-management-toolkit/go-wsman-messages/issues/767)) ([1802607](https://github.com/device-management-toolkit/go-wsman-messages/commit/1802607098a463a2a09411e2cbc984a7665d434b)), closes [#755](https://github.com/device-management-toolkit/go-wsman-messages/issues/755)

#### [2.49.0](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.48.4...v2.49.0) (2026-08-11)

Features

* **amt:** add AddUserAclEntryEx and ACL response types ([#755](https://github.com/device-management-toolkit/go-wsman-messages/issues/755)) ([b7c10d1](https://github.com/device-management-toolkit/go-wsman-messages/commit/b7c10d1214f08e54ba54a130036db8184ec2de27))

#### [2.48.4](https://github.com/device-management-toolkit/go-wsman-messages/compare/v2.48.3...v2.48.4) (2026-08-07)

Bug Fixes

* handles 2057 data missing ([#760](https://github.com/device-management-toolkit/go-wsman-messages/issues/760)) ([8801860](https://github.com/device-management-toolkit/go-wsman-messages/commit/8801860fb5aba7c3a157eb0dd55dbc80859ed165))