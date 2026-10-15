# RPC Health Checker

Use the RPC Health Checker to evaluate an Intel® AMT device before or after activation. It highlights prerequisites, likely blockers, and conditions that could prevent AMT management operations.

Use this quick workflow:

1. Run `rpc status` as an administrator or root user.
2. Add `--acm` or `--ccm` to validate a specific activation mode.
3. Provide `--password` or set `AMT_PASSWORD` for WSMAN-dependent checks on an activated device.
4. Add `--json` when you need a machine-readable result.

## Before you begin

Run RPC with elevated privileges. On Linux, use `sudo`. On Windows, open an Administrator Command Prompt.

This guide is most useful when you need to confirm prerequisites before activation, validate an activated device, or troubleshoot a device that is not ready for normal management.

## Run the health checker

=== "Linux"
    ```bash
    sudo ./rpc status
    ```

=== "Windows"
    ```cmd
    rpc.exe status
    ```

The following command names are equivalent:

=== "Linux"
    ```bash
    sudo ./rpc status
    sudo ./rpc health
    sudo ./rpc doctor
    ```

=== "Windows"
    ```cmd
    rpc.exe status
    rpc.exe health
    rpc.exe doctor
    ```

Use `status` as the primary command name. The other commands are aliases that produce the same result. RPC automatically selects the relevant checks based on the device state:

- **Before activation:** evaluates whether the device is ready to be provisioned.
- **After activation:** evaluates the device's manageability and whether AMT management operations can proceed.

## Select an activation mode

If no activation-mode flag is supplied, RPC performs a general readiness check. To validate a specific activation flow, add only one of the following flags:

| Flag | Purpose |
|------|---------|
| `--acm` | Evaluate Admin Control Mode (ACM) prerequisites. |
| `--ccm` | Evaluate Client Control Mode (CCM) prerequisites. |

Use `--acm` for an admin-managed activation flow and `--ccm` for a client-managed activation flow. If you are unsure which mode applies, start with the default check and then narrow it to the relevant mode.

For ACM-specific checks, DNS suffix and wired-network requirements are blockers. In the default check, those same conditions are reported as warnings because CCM may still proceed.

=== "Linux"
    ```bash
    sudo ./rpc status --acm
    sudo ./rpc status --ccm
    ```

=== "Windows"
    ```cmd
    rpc.exe status --acm
    rpc.exe status --ccm
    ```

## Test management endpoint reachability

Use `--host` to verify that a management endpoint is reachable from the device. If you do not specify a port, RPC uses port `443`. To check a different port, append it to the host name, such as `console.example.com:8443`.

=== "Linux"
    ```bash
    sudo ./rpc status --host console.example.com
    ```

=== "Windows"
    ```cmd
    rpc.exe status --host console.example.com
    ```

This check is optional. An unreachable host does not prevent provisioning, but the report warns that management operations may not work through that endpoint. Use it when a device must reach a specific Console or management service on a known host and port before continuing with provisioning or management operations.

## Post-activation checks and the AMT password

The command does not prompt for an AMT password. For an activated device, provide `--password` when you want RPC to run the additional WSMAN checks that depend on it:

=== "Linux"
    ```bash
    sudo ./rpc status --password '<AMT-password>'
    ```

=== "Windows"
    ```cmd
    rpc.exe status --password "<AMT-password>"
    ```

Without a password, RPC still runs checks that do not require WSMAN. Password-dependent checks are reported as **Not verified**, which indicates that the evaluation is incomplete.

When a password is supplied, RPC evaluates the WSMAN-dependent checks, including:

- local WSMAN session
- TLS configuration and trust inventory
- redirection and consent configuration
- One Click Recovery (OCR) support and status
- KVM support and status
- CIRA configuration and connectivity, when applicable

Use a password only for the command you are running. The password is not persisted by the tool; it is only used to establish the local WSMAN session and run the additional checks. For automation or scripting, prefer `AMT_PASSWORD` over embedding the secret directly in the command line.

To avoid writing the password to shell history or exposing it as a command argument, read it interactively into an exported variable and forward it with `sudo -E`. This requires your `sudoers` policy to preserve `AMT_PASSWORD` (for example, `Defaults env_keep += "AMT_PASSWORD"`); ask an administrator to add this if it is not already configured:

=== "Linux"
    ```bash
    read -rsp 'AMT password: ' AMT_PASSWORD; echo
    export AMT_PASSWORD
    sudo -E ./rpc status
    unset AMT_PASSWORD
    ```

=== "Windows"
    ```cmd
    set "AMT_PASSWORD=<AMT-password>"
    rpc.exe status
    set "AMT_PASSWORD="
    ```

## Health check results

The text report groups checks into four categories:

| Category | Meaning |
|----------|---------|
| **Passed** | The requirement was satisfied. |
| **Warnings** | The check found a concern that may not prevent the selected operation. |
| **Failed** | The check found a condition that prevents the selected operation. |
| **Not verified** | The check was not applicable or a required component, such as MEI or WSMAN, was unavailable. |

The final summary recommends the next action. In practice, **Passed** means continue, **Warning** means review, **Failed** means block the selected mode, and **Not verified** means either the check was not applicable or the required AMT password or dependency was unavailable.

!!! note
    Some checks apply only in specific configurations. For example, CIRA checks apply only when the device uses CIRA, and unsupported features are not treated as failures.

### Example: Pre-activation Status

Before activation, the report evaluates local prerequisites and produces output similar to the following:

```text
AMT Health Check
  ────────────────
  Detected state: Pre-provisioning
  Selected checks: pre-activation

Passed
  ✓ Running as admin/root
  ✓ Intel MEI driver installed and responding — 7.0.0-31-generic, current
  ✓ Platform type: vPro
  ✓ MEBx enabled in BIOS
  ✓ AMT version 16.1.25 (supported)
  ✓ AMT network link available for ACM checks
  ✓ LMS installed, running — 2406.0.0.0, current
  ✓ AMT activated state: Pre-provisioning

Warnings
  ! AMT=vprodemo.com OS=iind.intel.com (verify provisioning cert/profile domain alignment)

! Device conditionally ready; CCM activation can proceed, but ACM requires DNS domain alignment with the provisioning certificate/profile.
→ Proceed with CCM, or align the AMT DNS suffix to the provisioning cert/profile domain and re-run health check for ACM.

SKU Information
  Processor: 12th Gen Intel(R) Core(TM) i5-1250P
  Wired Adapter: Intel Corporation Ethernet Controller I225-LM
  Wireless Adapter: Not detected
  OS: Ubuntu 24.04.1 LTS 7.0.0-31-generic
```

Depending on the selected mode, pre-activation checks can include administrator privileges, MEI availability, platform and AMT-version support, BIOS configuration, DNS suffix, wired-network availability, LMS, and optional management-endpoint reachability. Use `--acm` or `--ccm` to evaluate the requirements for one activation mode.

### Example: Activated Device Without a Password

After activation, RPC verifies the AMT state and management configuration. Without an AMT password, checks that need a local WSMAN session are listed as **Not verified**:

```text
AMT Health Check
  Detected state: Client Control Mode
  Selected checks: post-activation

Password context: AMT password not provided; password-dependent checks are marked as Not verified

Passed
  ✓ Running as admin/root
  ✓ Intel MEI driver installed and responding — 7.0.0-31-generic, current
  ✓ Platform type: vPro
  ✓ MEBx enabled in BIOS
  ✓ AMT version 16.1.25 (supported)
  ✓ AMT network link available for CCM checks
  ✓ LMS installed, running — 2406.0.0.0, current
  ✓ AMT activated state: Client Control Mode
  ✓ AMT Connection Mode: Direct

Warnings
  ! AMT=vprodemo.com OS=iind.intel.com (verify provisioning cert/profile domain alignment)

Not verified
  • Requested mode alignment: auto mode (no --acm/--ccm constraint requested)
  • Management endpoint reachability: direct mode: use --host <console-address> to probe console reachability
  • Local WSMAN session: AMT password not provided; WSMAN-only checks skipped
  • TLS configuration / trust inventory: unavailable (WSMAN client required)
  • Redirection / consent baseline: unavailable (WSMAN client required)
  • OCR enabled in BIOS: unavailable (WSMAN client required)
  • KVM enabled: unavailable (WSMAN client required)

! Some prerequisites missing or not fully configured.
→ Review warnings and re-run health check after remediation.

SKU Information
  Processor: 12th Gen Intel(R) Core(TM) i5-1250P
  Wired Adapter: Intel Corporation Ethernet Controller I225-LM
  Wireless Adapter: Not detected
  OS: Ubuntu 24.04.1 LTS 7.0.0-31-generic
```

### Example: Activated Device With a Password

With `--password` or `AMT_PASSWORD`, RPC can evaluate WSMAN-dependent checks and report them under **Passed**, **Warnings**, or **Failed**:

```text
AMT Health Check
  Detected state: Client Control Mode
  Selected checks: post-activation (CCM profile)

Password context: AMT password provided; full post-activation checks executed

Passed
  ✓ Running as admin/root
  ✓ Intel MEI driver installed and responding — 7.0.0-31-generic, current
  ✓ Platform type: vPro
  ✓ MEBx enabled in BIOS
  ✓ AMT version 16.1.25 (supported)
  ✓ AMT network link available for CCM checks
  ✓ LMS installed, running — 2406.0.0.0, current
  ✓ device is in Client Control Mode (CCM)
  ✓ AMT activated state: Client Control Mode
  ✓ Local WSMAN session available
  ✓ AMT Connection Mode: Direct
  ✓ redirection listener=true enabledState=32771, user consent=all (CCM default)
  ✓ OCR supported and enabled
  ✓ KVM enabled, monitor connected

Warnings
  ! AMT=vprodemo.com OS=iind.intel.com (verify provisioning cert/profile domain alignment)
  ! mode Server, no trusted root certificates found in inventory

Not verified
  • Management endpoint reachability: direct mode: use --host <console-address> to probe console reachability

✓ Device is fully configured and ready for remote management.
→ No action required.

SKU Information
  Processor: 12th Gen Intel(R) Core(TM) i5-1250P
  Wired Adapter: Intel Corporation Ethernet Controller I225-LM
  Wireless Adapter: Not detected
  OS: Ubuntu 24.04.1 LTS 7.0.0-31-generic
```

Activated devices can also include control-mode alignment, CIRA configuration and connectivity, remote manageability, One Click Recovery, and management-endpoint reachability checks when applicable.

## JSON output

Use `--json` to print the health check result in JSON format:

=== "Linux"
    ```bash
    sudo ./rpc status --json > health.json
    ```

=== "Windows"
    ```cmd
    rpc.exe status --json > health.json
    ```

The JSON document contains `metadata`, `evaluation`, and `checks` objects. Use this structured output in scripts instead of parsing the text report.

The `metadata` object includes the command name, timestamp, RPC version, elevation state, and whether a password was provided.

The `evaluation` object includes the detected device state, selected check set, password context, overall result, a human-readable status summary, check counts by category, and the provisioning or manageability result.

Each item in `checks` contains an `id`, a display `name`, a `status`, and a `message`. Status values are `pass`, `warn`, `fail`, `skip`, or `unavailable`. The text report uses the equivalent human-readable labels: **Passed**, **Warning**, **Failed**, and **Not verified**.

### Example: Pre-Activation Status (JSON)

This corresponds to the [pre-activation status](#example-pre-activation-status) text example:

```json
{
  "metadata": {
    "command": "status",
    "timestamp": "2026-09-25T22:08:30+05:30",
    "rpcVersion": "Development Build",
    "elevated": true,
    "passwordProvided": false
  },
  "evaluation": {
    "detectedState": "pre_provisioning",
    "selectedCheckSet": "pre_activation",
    "passwordContext": "not required",
    "overallResult": "ready",
    "overallStatus": "Device conditionally ready; CCM activation can proceed, but ACM requires DNS domain alignment with the provisioning certificate/profile",
    "totalChecks": 9,
    "passed": 8,
    "warned": 1,
    "failed": 0,
    "skipped": 0,
    "unavailable": 0,
    "readyToProvision": true
  },
  "checks": [
    { "id": "running_as_admin_root", "name": "Running as admin/root", "status": "pass", "message": "Running as admin/root" },
    { "id": "mei_driver", "name": "MEI driver", "status": "pass", "message": "Intel MEI driver installed and responding — 7.0.0-31-generic, current" },
    { "id": "platform_type", "name": "Platform type", "status": "pass", "message": "Platform type: vPro" },
    { "id": "mebx_enabled_in_bios", "name": "MEBx enabled in BIOS", "status": "pass", "message": "MEBx enabled in BIOS" },
    { "id": "amt_version", "name": "AMT version", "status": "pass", "message": "AMT version 16.1.25 (supported)" },
    { "id": "dns_suffix_amt_vs_os", "name": "DNS suffix (AMT vs OS)", "status": "warn", "message": "AMT=vprodemo.com OS=iind.intel.com (verify provisioning cert/profile domain alignment)" },
    { "id": "amt_wired_wireless_link", "name": "AMT wired/wireless link", "status": "pass", "message": "AMT wired link up" },
    { "id": "lms_local_manageability_service", "name": "LMS (Local Manageability Service)", "status": "pass", "message": "LMS installed, running — 2406.0.0.0, current" },
    { "id": "amt_activated_state", "name": "AMT activated state", "status": "pass", "message": "AMT activated state: Pre-provisioning" }
  ]
}
```

### Example: Activated Device Without a Password (JSON)

This corresponds to the [activated device without a password](#example-activated-device-without-a-password) text example:

```json
{
  "metadata": {
    "command": "status",
    "timestamp": "2026-09-25T22:12:04+05:30",
    "rpcVersion": "Development Build",
    "elevated": true,
    "passwordProvided": false
  },
  "evaluation": {
    "detectedState": "client_control_mode",
    "selectedCheckSet": "post_activation",
    "passwordContext": "AMT password not provided; password-dependent checks are marked as Not verified",
    "overallResult": "partial",
    "overallStatus": "Some prerequisites missing or not fully configured",
    "totalChecks": 17,
    "passed": 9,
    "warned": 1,
    "failed": 0,
    "skipped": 0,
    "unavailable": 7,
    "manageableInProduction": false,
    "partialEvaluation": true
  },
  "checks": [
    { "id": "running_as_admin_root", "name": "Running as admin/root", "status": "pass", "message": "Running as admin/root" },
    { "id": "mei_driver", "name": "MEI driver", "status": "pass", "message": "Intel MEI driver installed and responding — 7.0.0-31-generic, current" },
    { "id": "platform_type", "name": "Platform type", "status": "pass", "message": "Platform type: vPro" },
    { "id": "mebx_enabled_in_bios", "name": "MEBx enabled in BIOS", "status": "pass", "message": "MEBx enabled in BIOS" },
    { "id": "amt_version", "name": "AMT version", "status": "pass", "message": "AMT version 16.1.25 (supported)" },
    { "id": "amt_wired_wireless_link", "name": "AMT wired/wireless link", "status": "pass", "message": "AMT network link available for CCM checks" },
    { "id": "lms_local_manageability_service", "name": "LMS (Local Manageability Service)", "status": "pass", "message": "LMS installed, running — 2406.0.0.0, current" },
    { "id": "amt_activated_state", "name": "AMT activated state", "status": "pass", "message": "AMT activated state: Client Control Mode" },
    { "id": "amt_connection_mode", "name": "AMT connection mode", "status": "pass", "message": "AMT Connection Mode: Direct" },
    { "id": "dns_suffix_amt_vs_os", "name": "DNS suffix (AMT vs OS)", "status": "warn", "message": "AMT=vprodemo.com OS=iind.intel.com (verify provisioning cert/profile domain alignment)" },
    { "id": "requested_mode_alignment", "name": "Requested mode alignment", "status": "unavailable", "message": "auto mode (no --acm/--ccm constraint requested)" },
    { "id": "management_endpoint_reachability", "name": "Management endpoint reachability", "status": "unavailable", "message": "direct mode: use --host <console-address> to probe console reachability" },
    { "id": "local_wsman_session", "name": "Local WSMAN session", "status": "unavailable", "message": "AMT password not provided; WSMAN-only checks skipped" },
    { "id": "tls_configuration_trust_inventory", "name": "TLS configuration / trust inventory", "status": "unavailable", "message": "WSMAN client required" },
    { "id": "redirection_consent_baseline", "name": "Redirection / consent baseline", "status": "unavailable", "message": "WSMAN client required" },
    { "id": "ocr_enabled_in_bios", "name": "OCR enabled in BIOS", "status": "unavailable", "message": "WSMAN client required" },
    { "id": "kvm_enabled", "name": "KVM enabled", "status": "unavailable", "message": "WSMAN client required" }
  ]
}
```

### Example: Activated Device with a Password (JSON)

This corresponds to the [activated device with a password](#example-activated-device-with-a-password) text example:

```json
{
  "metadata": {
    "command": "status",
    "timestamp": "2026-09-25T22:15:47+05:30",
    "rpcVersion": "Development Build",
    "elevated": true,
    "passwordProvided": true
  },
  "evaluation": {
    "detectedState": "client_control_mode",
    "selectedCheckSet": "post_activation_ccm",
    "passwordContext": "AMT password provided; full post-activation checks executed",
    "overallResult": "ready",
    "overallStatus": "Device is fully configured and ready for remote management",
    "totalChecks": 17,
    "passed": 14,
    "warned": 2,
    "failed": 0,
    "skipped": 0,
    "unavailable": 1,
    "manageableInProduction": true,
    "partialEvaluation": false
  },
  "checks": [
    { "id": "running_as_admin_root", "name": "Running as admin/root", "status": "pass", "message": "Running as admin/root" },
    { "id": "mei_driver", "name": "MEI driver", "status": "pass", "message": "Intel MEI driver installed and responding — 7.0.0-31-generic, current" },
    { "id": "platform_type", "name": "Platform type", "status": "pass", "message": "Platform type: vPro" },
    { "id": "mebx_enabled_in_bios", "name": "MEBx enabled in BIOS", "status": "pass", "message": "MEBx enabled in BIOS" },
    { "id": "amt_version", "name": "AMT version", "status": "pass", "message": "AMT version 16.1.25 (supported)" },
    { "id": "amt_wired_wireless_link", "name": "AMT wired/wireless link", "status": "pass", "message": "AMT network link available for CCM checks" },
    { "id": "lms_local_manageability_service", "name": "LMS (Local Manageability Service)", "status": "pass", "message": "LMS installed, running — 2406.0.0.0, current" },
    { "id": "control_mode", "name": "Control mode", "status": "pass", "message": "device is in Client Control Mode (CCM)" },
    { "id": "amt_activated_state", "name": "AMT activated state", "status": "pass", "message": "AMT activated state: Client Control Mode" },
    { "id": "local_wsman_session", "name": "Local WSMAN session", "status": "pass", "message": "Local WSMAN session established" },
    { "id": "amt_connection_mode", "name": "AMT connection mode", "status": "pass", "message": "AMT Connection Mode: Direct" },
    { "id": "redirection_consent_baseline", "name": "Redirection / consent baseline", "status": "pass", "message": "listener=true enabledState=32771, user consent=all (CCM default)" },
    { "id": "ocr_enabled_in_bios", "name": "OCR enabled in BIOS", "status": "pass", "message": "OCR supported and enabled" },
    { "id": "kvm_enabled", "name": "KVM enabled", "status": "pass", "message": "KVM enabled, monitor connected" },
    { "id": "dns_suffix_amt_vs_os", "name": "DNS suffix (AMT vs OS)", "status": "warn", "message": "AMT=vprodemo.com OS=iind.intel.com (verify provisioning cert/profile domain alignment)" },
    { "id": "tls_configuration_trust_inventory", "name": "TLS configuration / trust inventory", "status": "warn", "message": "mode Server, no trusted root certificates found in inventory" },
    { "id": "management_endpoint_reachability", "name": "Management endpoint reachability", "status": "unavailable", "message": "direct mode: use --host <console-address> to probe console reachability" }
  ]
}
```


## Troubleshooting

### LMS is not running or not installed

The checker tests the local LMS ports and reports whether LMS is missing or not responding. It does not start the service. Install or start LMS, then rerun the check.

### WSMAN checks are not verified

For an activated device, provide the AMT password and rerun the command. RPC uses the local LMS service to establish the WSMAN session. If WSMAN remains unavailable, verify the password, LMS service, and local AMT/WSMAN connection.

### The device is not ready for provisioning

Review the specific blocker in the report. Common causes include missing administrator privileges, MEI or LMS not available, BIOS settings not in the expected state, or DNS or wired-network requirements not met for ACM.

### DNS suffix or wired-link warning

These checks are especially important for ACM. Verify that the AMT DNS suffix is configured, matches the provisioning certificate or profile domain, and that the wired AMT interface is available. CCM may still proceed when the issue is ACM-specific.

### Management endpoint is unreachable

Verify that the host is correct, the port is open, and the endpoint is reachable from the device. If the endpoint is a Console or management service, confirm that the device can reach it over the expected network path. This is usually a networking issue rather than a local AMT issue.

### The check is marked as Not verified

This usually means a required dependency was unavailable. Confirm that the AMT password is supplied for password-dependent checks, make sure the local LMS service is running, and rerun the command. If the dependency is still unavailable, the report indicates that the evaluation is incomplete rather than conclusively passing or failing.

## Related RPC documentation

- [RPC CLI commands and flags](../v2/commandsRPC.md)
- [RPC overview](../overview.md)
- [Build RPC-Go manually](../buildRPC_Manual.md)
- [Transition an activated device](../transitionDeviceRPC.md)