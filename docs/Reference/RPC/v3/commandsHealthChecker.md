# Health Checker

Use the Health Checker to evaluate Intel® AMT readiness before or after activation and diagnose conditions that may affect management.

## Prerequisites

- RPC-Go v3.0.0-beta.80 or later. The `status` command is not available in v2.x.
- Run with elevated privileges: use `sudo` on Linux or an Administrator Command Prompt or PowerShell on Windows.

## Run the Health Checker

```console
rpc status
```

If the binary is not on `PATH`, use `./rpc` on Linux or `.\rpc.exe` on Windows.

The following command names are equivalent:

```console
rpc status
rpc health
rpc doctor
```

Use `status` as the primary command name. The other commands are aliases that produce the same result. RPC automatically selects the relevant checks based on device state:

- **Before activation:** evaluates provisioning readiness.
- **After activation:** evaluates manageability and whether AMT management operations can proceed.

## Options

| Option | Purpose |
|--------|---------|
| `--acm` | Select ACM readiness checks; after activation, check that AMT is in ACM. |
| `--ccm` | Select CCM readiness checks; after activation, check that AMT is in CCM. |
| `--host <address>` | On activated devices in Direct (LAN) mode, make a 3-second TCP connection probe. Defaults to port `443` (`80` for `http://` URLs); an explicit port is honored. An unreachable endpoint warns. |
| `--json` | Emit machine-readable JSON instead of the text report. |
| `AMT_PASSWORD` | Recommended explicit credentials for the local WSMAN session; see the shell examples below. |
| `--password <value>` | Lab use only; command-line values may appear in shell history and process listings. |

`--acm` and `--ccm` cannot be used together. Before activation, without either flag, the **Activation profile readiness** block reports separate ACM and CCM results. After activation, a mode flag adds a **Requested control mode** check that fails if AMT is in the other mode.

If no mode flag is supplied, RPC performs a general readiness check. In default mode, DNS differences and a missing AMT network link are warnings because CCM may still proceed. For `--acm`, a DNS mismatch warns; missing both suffixes or a down wired AMT link fails the corresponding check.

For activated devices, RPC does not prompt for a password. If `--password` and `AMT_PASSWORD` are absent, it attempts to retrieve local system account credentials through HECI. WSMAN-backed checks run whenever the local WSMAN session opens, regardless of credential source.

The password is used only to establish the local WSMAN session and is not persisted. For scripting, use a secret-managed `AMT_PASSWORD`. For interactive use, read the password without echoing it and clear it after the check. On Linux, use `sudo --preserve-env=AMT_PASSWORD` to pass only that variable. If sudo refuses, ask an administrator to add `Defaults env_keep += "AMT_PASSWORD"`; then plain `sudo` preserves it.

=== "Linux"
    ```bash
    read -rsp 'AMT password: ' AMT_PASSWORD; echo
    export AMT_PASSWORD
    sudo --preserve-env=AMT_PASSWORD ./rpc status
    unset AMT_PASSWORD
    ```

=== "Windows"
    ```powershell
    $securePassword = Read-Host 'AMT password' -AsSecureString
    try {
      $env:AMT_PASSWORD = [System.Net.NetworkCredential]::new('', $securePassword).Password
      .\rpc.exe status
    }
    finally {
      Remove-Item Env:AMT_PASSWORD -ErrorAction SilentlyContinue
      $securePassword.Dispose()
    }
    ```

## Checks

| Check | When it runs | WSMAN required |
|-------|--------------|----------------|
| Administrator/root, MEI/HECI driver, activation state, platform type, AMT version | Pre- and post-activation | No |
| AMT operational state | Pre-activation when reported; post-activation when supported | No |
| DNS suffix, AMT network link, LMS | Pre- and post-activation | No |
| Host networking for remote activation; ACM/CCM profile readiness | Pre-activation | No |
| AMT provisioning state, AMT connection mode | Post-activation | No |
| Requested control-mode alignment | Post-activation when `--acm` or `--ccm` is specified | No |
| CIRA connection | Post-activation on CIRA devices | No |
| Direct host reachability | Post-activation in Direct (LAN) mode when `--host` is specified | No |
| Monitor connection | Post-activation | No |
| WSMAN session | Post-activation | Yes |
| CIRA configuration | Post-activation on CIRA devices | Yes |
| Redirection service, SOL redirection, KVM user consent | Post-activation | Yes |
| TLS mode, trusted root certificates | Post-activation; trusted roots only for mutual TLS | Yes |
| KVM redirection | Post-activation on AMT devices (not ISM) | Yes |

If the WSMAN session cannot open, the **Local WSMAN session** check is marked unavailable (**Not verified** in text; `unavailable` in JSON), while dependent checks that cannot run are omitted. The summary reports `Activated; management features not verified`, and the command exits with status `6`. Local and HECI checks still run.

## Result Meanings

The text report groups checks into four categories:

| Category | Meaning |
|----------|---------|
| **Passed** | The requirement was satisfied. |
| **Warnings** | The check found a concern that may not prevent the selected operation. |
| **Failed** | The check found a condition that prevents the selected operation. |
| **Not verified** | The check was not applicable or a required component, such as MEI or WSMAN, was unavailable. |

The final summary recommends a next action based on the readiness result.

!!! note
    Some checks apply only in specific configurations. For example, CIRA checks apply only when the device uses CIRA, and unsupported features are not treated as failures.

The examples reflect the v3.0.0-beta.80 release version. DNS suffixes and the MPS hostname are anonymized placeholders.

### Pre-Activation Status

This pre-activation report is from RPC-Go v3.0.0-beta.80. DNS suffixes are anonymized placeholders.

=== "Text"

    Command: `sudo ./rpc_linux_x64 status`

    ```text
      AMT Health Check
      ────────────────
      Detected state: Pre-provisioning
      Selected checks: pre-activation

    Passed
      ✓ Running as administrator/root
      ✓ MEI/HECI driver is responding (version 7.0.0-34-generic)
      ✓ AMT is in pre-provisioning mode
      ✓ Platform type: vPro
      ✓ AMT version 16.1.25 is supported
      ✓ AMT network link is available
      ✓ Local Manageability Service is listening (version 2406.0.0.0)
      ✓ OS adapter matching an AMT MAC is enabled; verify RPS/Console endpoint reachability

    Warnings
      ! AMT DNS suffix (amt.example.com) differs from host DNS suffix (host.example.com). Confirm this matches your provisioning setup

    Activation profile readiness
      ACM: Conditionally ready
      CCM: Conditionally ready

    ! Device is conditionally ready; AMT and host DNS suffixes differ
    → ACM or CCM can proceed conditionally; review warnings for your provisioning profile.

    SKU Information
      Processor: 12th Gen Intel(R) Core(TM) i5-1250P
      Wired Adapter: Ethernet controller: Intel Corporation Ethernet Controller I225-LM (rev 03), AMT link up; OS state up
      Wireless Adapter: No matching OS adapter, AMT link down; OS state not verified
      OS: Ubuntu 24.04.1 LTS 7.0.0-34-generic

    AMT Details
      Operational state: Not reported

    AMT Connectivity
      AMT-reported network status: unknown
      Remote access connection: not connected
      Remote access trigger: user initiated
      TLS mode: Unavailable (WSMAN data unavailable)
    ```

=== "JSON"

    Command: `sudo ./rpc_linux_x64 status --json`

    JSON output from the same pre-activation report:

    ```json
    {
      "metadata": {
        "command": "status",
        "timestamp": "2026-11-11T11:23:26+05:30",
        "rpcVersion": "3.0.0-beta.80",
        "elevated": true,
        "passwordProvided": false
      },
      "evaluation": {
        "detectedState": "pre_provisioning",
        "selectedCheckSet": "pre_activation",
        "deviceType": "AMT Pro Corporate",
        "amtVersion": "16.1.25",
        "amtDnsSuffix": "amt.example.com",
        "osDnsSuffix": "host.example.com",
        "remoteAccess": {
          "networkStatus": "unknown",
          "remoteStatus": "not connected",
          "remoteTrigger": "user initiated",
          "mpsHostname": ""
        },
        "processor": "12th Gen Intel(R) Core(TM) i5-1250P",
        "os": "Ubuntu 24.04.1 LTS 7.0.0-34-generic",
        "wiredAdapterName": "Ethernet controller: Intel Corporation Ethernet Controller I225-LM (rev 03)",
        "wirelessAdapterName": "No matching OS adapter",
        "wiredAdapterStatus": "AMT link up; OS state up",
        "wirelessAdapterStatus": "AMT link down; OS state not verified",
        "activationProfiles": [
          {
            "profile": "ACM",
            "result": "conditional",
            "status": "Device is conditionally ready; AMT and host DNS suffixes differ",
            "readyToProvision": true,
            "readyForRemoteActivation": true
          },
          {
            "profile": "CCM",
            "result": "conditional",
            "status": "Device is conditionally ready; AMT and host DNS suffixes differ",
            "readyToProvision": true,
            "readyForRemoteActivation": true
          }
        ],
        "overallResult": "conditional",
        "overallStatus": "Device is conditionally ready; AMT and host DNS suffixes differ",
        "totalChecks": 9,
        "passed": 8,
        "warned": 1,
        "failed": 0,
        "notVerified": 0,
        "readyToProvision": true,
        "readyForRemoteActivation": true
      },
      "checks": [
        { "id": "running_as_admin_root", "name": "Running as admin/root", "status": "pass", "message": "Running as administrator/root" },
        { "id": "mei_driver", "name": "MEI driver", "status": "pass", "message": "MEI/HECI driver is responding (version 7.0.0-34-generic)" },
        { "id": "amt_activated_state", "name": "AMT activated state", "status": "pass", "message": "AMT is in pre-provisioning mode" },
        { "id": "platform_type", "name": "Platform type", "status": "pass", "message": "Platform type: vPro" },
        { "id": "amt_version", "name": "AMT version", "status": "pass", "message": "AMT version 16.1.25 is supported" },
        { "id": "dns_suffix", "name": "DNS suffix", "status": "warn", "message": "AMT DNS suffix (amt.example.com) differs from host DNS suffix (host.example.com). Confirm this matches your provisioning setup", "reason": "dns_suffix_mismatch" },
        { "id": "amt_network_link", "name": "AMT network link", "status": "pass", "message": "AMT network link is available" },
        { "id": "lms", "name": "LMS", "status": "pass", "message": "Local Manageability Service is listening (version 2406.0.0.0)" },
        { "id": "host_network_for_remote_activation", "name": "Host networking for remote activation", "status": "pass", "message": "OS adapter matching an AMT MAC is enabled; verify RPS/Console endpoint reachability" }
      ]
    }
    ```

### Post-Activation Status

This ACM/CIRA report is from one v3.0.0-beta.80 run using `--password`; the secret is redacted below. The Text and JSON tabs show the same result.

=== "Text"

    Command used (password redacted): `sudo ./rpc_linux_x64 status --password [REDACTED]`

    ```text
      AMT Health Check
      ────────────────
      Detected state: Admin Control Mode
      Selected checks: post-activation

    Passed
      ✓ Running as administrator/root
      ✓ MEI/HECI driver is responding (version 7.0.0-42-generic)
      ✓ AMT activated state: admin control mode
      ✓ Platform type: vPro
      ✓ AMT version 16.1.25 is supported
      ✓ AMT network link is available for remote management
      ✓ Local Manageability Service is listening (version 2406.0.0.0)
      ✓ AMT provisioning is complete
      ✓ Local WSMAN session available
      ✓ AMT Connection Mode: CIRA
      ✓ CIRA MPS and remote-access policy are configured
      ✓ CIRA connection is connected
      ✓ Redirection listener is enabled; SOL and IDER are enabled
      ✓ SOL is enabled
      ✓ KVM user consent: none
      ✓ TLS mode: Server
      ✓ Monitor connected
      ✓ KVM is enabled but offline (EnabledState 6); an active KVM session is not verified

    Warnings
      ! AMT DNS suffix differs from the host DNS suffix; verify the intended management DNS configuration

    ✓ Device is fully configured and ready for remote management; review warnings
    → Review the warnings for your management configuration.

    SKU Information
      Processor: 12th Gen Intel(R) Core(TM) i5-1250P
      Wired Adapter: Ethernet controller: Intel Corporation Ethernet Controller I225-LM (rev 03), AMT link up; OS state up
      Wireless Adapter: No matching OS adapter, AMT link down; OS state not verified
      OS: Ubuntu 24.04.1 LTS 7.0.0-42-generic

    AMT Details
      Operational state: Not reported

    AMT Connectivity
      AMT-reported network status: outside enterprise (CIRA)
      Remote access connection: connected
      Remote access trigger: periodic
      TLS mode: Server
    ```

=== "JSON"

    Command used (password redacted): `sudo ./rpc_linux_x64 status --password [REDACTED] --json`

    This JSON excerpt is from the same post-activation report.

    ```json
    {
      "metadata": {
        "command": "status",
        "timestamp": "2026-11-11T11:43:36+05:30",
        "rpcVersion": "3.0.0-beta.80",
        "elevated": true,
        "passwordProvided": true
      },
      "evaluation": {
        "detectedState": "admin control mode",
        "selectedCheckSet": "post_activation",
        "deviceType": "AMT Pro Corporate",
        "amtVersion": "16.1.25",
        "amtDnsSuffix": "amt.example.com",
        "osDnsSuffix": "host.example.com",
        "remoteAccess": {
          "networkStatus": "outside enterprise (CIRA)",
          "remoteStatus": "connected",
          "remoteTrigger": "periodic",
          "mpsHostname": "mps.example.com",
          "mpsPort": 4433
        },
        "tlsMode": "Server",
        "processor": "12th Gen Intel(R) Core(TM) i5-1250P",
        "os": "Ubuntu 24.04.1 LTS 7.0.0-42-generic",
        "wiredAdapterName": "Ethernet controller: Intel Corporation Ethernet Controller I225-LM (rev 03)",
        "wirelessAdapterName": "No matching OS adapter",
        "wiredAdapterStatus": "AMT link up; OS state up",
        "wirelessAdapterStatus": "AMT link down; OS state not verified",
        "overallResult": "ready",
        "overallStatus": "Device is fully configured and ready for remote management; review warnings",
        "totalChecks": 19,
        "passed": 18,
        "warned": 1,
        "failed": 0,
        "notVerified": 0,
        "readyToProvision": false,
        "readyForManagement": true,
        "readyForRemoteActivation": false
      },
      "checks": [
        {
          "id": "running_as_admin_root",
          "name": "Running as admin/root",
          "status": "pass",
          "message": "Running as administrator/root"
        },
        {
          "id": "mei_driver",
          "name": "MEI driver",
          "status": "pass",
          "message": "MEI/HECI driver is responding (version 7.0.0-42-generic)"
        },
        {
          "id": "amt_activated_state",
          "name": "AMT activated state",
          "status": "pass",
          "message": "AMT activated state: admin control mode"
        },
        {
          "id": "platform_type",
          "name": "Platform type",
          "status": "pass",
          "message": "Platform type: vPro"
        },
        {
          "id": "amt_version",
          "name": "AMT version",
          "status": "pass",
          "message": "AMT version 16.1.25 is supported"
        },
        {
          "id": "dns_suffix",
          "name": "DNS suffix",
          "status": "warn",
          "message": "AMT DNS suffix differs from the host DNS suffix; verify the intended management DNS configuration",
          "reason": "dns_suffix_mismatch"
        },
        {
          "id": "amt_network_link",
          "name": "AMT network link",
          "status": "pass",
          "message": "AMT network link is available for remote management"
        },
        {
          "id": "lms",
          "name": "LMS",
          "status": "pass",
          "message": "Local Manageability Service is listening (version 2406.0.0.0)"
        },
        {
          "id": "amt_provisioning_state",
          "name": "AMT provisioning state",
          "status": "pass",
          "message": "AMT provisioning is complete"
        },
        {
          "id": "wsman_session",
          "name": "Local WSMAN session",
          "status": "pass",
          "message": "Local WSMAN session available"
        },
        {
          "id": "amt_connection_mode",
          "name": "AMT connection mode",
          "status": "pass",
          "message": "AMT Connection Mode: CIRA"
        },
        {
          "id": "cira_configuration",
          "name": "CIRA configuration",
          "status": "pass",
          "message": "CIRA MPS and remote-access policy are configured"
        },
        {
          "id": "cira_connection",
          "name": "CIRA connection",
          "status": "pass",
          "message": "CIRA connection is connected"
        },
        {
          "id": "redirection_service",
          "name": "Redirection service",
          "status": "pass",
          "message": "Redirection listener is enabled; SOL and IDER are enabled"
        },
        {
          "id": "sol_redirection",
          "name": "SOL redirection",
          "status": "pass",
          "message": "SOL is enabled"
        },
        {
          "id": "kvm_user_consent",
          "name": "KVM user consent",
          "status": "pass",
          "message": "KVM user consent: none"
        },
        {
          "id": "tls_mode",
          "name": "TLS mode",
          "status": "pass",
          "message": "TLS mode: Server"
        },
        {
          "id": "monitor_connected",
          "name": "Monitor",
          "status": "pass",
          "message": "Monitor connected"
        },
        {
          "id": "kvm_redirection",
          "name": "KVM redirection",
          "status": "pass",
          "message": "KVM is enabled but offline (EnabledState 6); an active KVM session is not verified"
        }
      ]
    }
    ```

## JSON Output

Use `--json` for machine-readable output with `metadata`, `evaluation`, and `checks` objects:

```console
rpc status --json
```

The scenario tabs above pair each text report with a JSON excerpt from the same run.

| Field | Type | Meaning |
|-------|------|---------|
| `metadata` | object | Command, timestamp, RPC version, elevation, and `passwordProvided`. The latter is true when `--password` or `AMT_PASSWORD` supplied a password; HECI fallback credentials do not set it. |
| `evaluation.detectedState` | string | Detected AMT state: `not activated`, `client control mode`, `admin control mode`, `unknown control mode`, `unknown`, or `amt_unavailable`. |
| `evaluation.selectedCheckSet` | string | Check set used: `pre_activation`, `pre_activation_acm`, `pre_activation_ccm`, or `post_activation`. |
| `evaluation.overallResult` | string | `ready`, `conditional`, `not_ready`, `not_amt`, `unknown`, or `not_evaluated`. |
| `evaluation.readyForManagement` | boolean | Emitted only when true; if omitted, it is false. |
| `evaluation.activationProfiles` | array | ACM/CCM readiness results; present only before activation. |
| `checks` | array | Check objects with `id`, `name`, `status`, and `message`; optional `reason` gives a machine-readable cause, such as `dns_suffix_mismatch`. Statuses are `pass`, `warn`, `fail`, `unavailable`, `not_evaluated`, and `already_activated`; the last three appear under **Not verified** in text output. |

The command exit code follows the overall result:

| Exit code | `overallResult` | Meaning |
|-----------|-----------------|---------|
| `0` | `ready`, `conditional`, `not_evaluated` | No reported blocking error. |
| `3` | `not_amt` | AMT was not detected. |
| `4` | `not_ready` | The device is not ready for the selected operation. |
| `6` | `unknown` | Readiness could not be determined. |

## Troubleshooting

### LMS Is Not Running or Not Installed

The checker reports an unavailable LMS as a warning; LMS is optional for `rpc status`. RPC can query AMT over its built-in HECI transport when LMS is unavailable. The checker does not start LMS.

### WSMAN Checks Are Not Verified

WSMAN-backed checks run whenever RPC opens a local WSMAN session, using either the supplied AMT password or local system account credentials retrieved through HECI. If the session fails, the report marks **Local WSMAN session** as **Not verified** and omits dependent checks that could not run. Verify the credentials, AMT TLS/trust settings, and local WSMAN connectivity; LMS is not required for this command.

### The Device Is Not Ready for Provisioning

Review the failed checks. For ACM, missing AMT and host DNS suffixes or a down wired AMT link can fail readiness. Without administrator privileges, readiness is unknown (exit 6), not `not_ready`. The checker does not inspect BIOS settings; an unavailable LMS is only a warning.

### DNS Suffix or Wired-Link Warning

These checks are especially important for ACM. Verify that the AMT DNS suffix is configured, matches the provisioning certificate or profile domain, and that the wired AMT interface is available. CCM may still proceed when the issue is ACM-specific.

### Management Endpoint Is Unreachable

This warning applies only after activation when AMT reports Direct (LAN) mode and `--host` is supplied. The checker attempts a TCP connection for up to 3 seconds; it does not run before activation or in CIRA mode. Verify the host, port, and network path from the device.

### The Check Is Marked as Not Verified

This means a check was not applicable or a required dependency was unavailable. For WSMAN, confirm that RPC can open the local session; it first tries HECI local system account credentials and can also use `AMT_PASSWORD`. If the dependency remains unavailable, the result is inconclusive rather than a pass or fail.

## Related Topics

- [About RPC-Go v3](./about-v3.md)
- [RPC overview](../overview.md)
- [Build RPC-Go manually](../buildRPC_Manual.md)
- [Transition an activated device](../transitionDeviceRPC.md)