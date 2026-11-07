# RPC Health Checker

Use the RPC Health Checker to evaluate an Intel® AMT device before or after activation. It highlights prerequisites, likely blockers, and conditions that could prevent AMT management operations.

Use this quick workflow:

1. Run `rpc status` as an administrator or root user.
2. Add `--acm` or `--ccm` to validate a specific activation mode.
3. Set `AMT_PASSWORD` for WSMAN-dependent checks on an activated device. The `--password` flag is also available, but avoid passing a real password as a command argument.
4. Add `--json` when you need a machine-readable result.

## Before you begin

Run RPC with elevated privileges. On Linux, use `sudo`. On Windows, open an Administrator Command Prompt.

This guide is most useful when you need to confirm prerequisites before activation, validate an activated device, or troubleshoot a device that is not ready for normal management.

## Run the health checker

```console
rpc status
```

If the binary is not on `PATH`, use `./rpc` on Linux or `rpc.exe` on Windows.

The following command names are equivalent:

```console
rpc status
rpc health
rpc doctor
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

For `--acm`, a DNS mismatch warns; missing both suffixes or a down wired AMT link fails the corresponding check. In default mode, these conditions warn because CCM may still proceed.

```console
rpc status --acm
rpc status --ccm
```

## Test management endpoint reachability

Use `--host` to verify that a management endpoint is reachable from the device. If you do not specify a port, RPC uses port `443`. To check a different port, append it to the host name, such as `console.example.com:8443`.

```console
rpc status --host console.example.com
```

This check is optional. An unreachable host does not prevent provisioning, but the report warns that management operations may not work through that endpoint. Use it when a device must reach a specific Console or management service on a known host and port before continuing with provisioning or management operations.

## Post-activation checks and the AMT password

The command does not prompt for an AMT password. For an activated device, set `AMT_PASSWORD` when you want RPC to run the additional WSMAN checks that depend on it. The `--password` flag is available, but avoid using it with a real password because command arguments can be exposed in shell history and process listings.

```console
rpc status --password '<AMT-password>'
```

If `--password` and `AMT_PASSWORD` are absent, RPC attempts to retrieve the local system account credentials through HECI for WSMAN. If those credentials cannot be retrieved or authenticated, the local WSMAN session is unavailable and password-dependent checks are reported as **Not verified**; RPC still runs checks that do not require WSMAN.

When a password is supplied, RPC evaluates the WSMAN-dependent checks, including:

- local WSMAN session
- TLS configuration and trust inventory
- redirection and consent configuration
- KVM support and status
- CIRA configuration and connectivity, when applicable

Use a password only for the command you are running. The password is not persisted by the tool; it is only used to establish the local WSMAN session and run the additional checks. For automation or scripting, provide it through `AMT_PASSWORD` using your environment's secret-management mechanism.

On Linux, read the password without echoing it and forward it with `sudo -E`. This requires your `sudoers` policy to preserve `AMT_PASSWORD` (for example, `Defaults env_keep += "AMT_PASSWORD"`); ask an administrator to add this if it is not already configured:

=== "Linux"
    ```bash
    read -rsp 'AMT password: ' AMT_PASSWORD; echo
    export AMT_PASSWORD
    sudo -E ./rpc status
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
  ✓ Running as administrator/root
  ✓ MEI/HECI driver is responding (version 7.0.0-34-generic)
  ✓ AMT is in pre-provisioning mode
  ✓ Platform type: vPro
  ✓ AMT version 16.1.25 is supported
  ✓ AMT network link is available
  ✓ Local Manageability Service is listening (version 2406.0.0.0)
  ✓ OS adapter matching an AMT MAC is enabled; verify RPS/Console endpoint reachability

Warnings
  ! AMT DNS suffix (vprodemo.com) differs from host DNS suffix (iind.intel.com). Confirm this matches your provisioning setup

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
  AMT-reported network status: outside enterprise (CIRA)
  Remote access connection: not connected
  Remote access trigger: user initiated
  TLS mode: Unavailable (WSMAN data unavailable)
```

Depending on the selected mode, pre-activation checks can include administrator privileges, MEI availability, platform and AMT-version support, BIOS configuration, DNS suffix, wired-network availability, LMS, and optional management-endpoint reachability. Use `--acm` or `--ccm` to evaluate the requirements for one activation mode.

### Example: Activated Device Without a `--password` Argument

This example omits the `--password` argument and has no password in `AMT_PASSWORD`. RPC uses the local system account credentials retrieved through HECI to establish WSMAN. If that fallback is unavailable or fails authentication, WSMAN-dependent checks are reported as **Not verified**.

```text
AMT Health Check
  Detected state: Admin Control Mode
  Selected checks: post-activation

Passed
  ✓ Running as administrator/root
  ✓ MEI/HECI driver is responding (version 7.0.0-34-generic)
  ✓ AMT activated state: admin control mode
  ✓ Platform type: vPro
  ✓ AMT version 16.1.25 is supported
  ✓ AMT network link is available for remote management
  ✓ Local Manageability Service is listening (version 2406.0.0.0)
  ✓ AMT provisioning is complete
  ✓ Local WSMAN session available
  ✓ AMT Connection Mode: CIRA
  ✓ AMT control mode matches requested ACM
  ✓ CIRA MPS and remote-access policy are configured
  ✓ CIRA connection is connected
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
  OS: Ubuntu 24.04.1 LTS 7.0.0-34-generic

AMT Details
  Operational state: Not reported

AMT Connectivity
  AMT-reported network status: outside enterprise (CIRA)
  Remote access connection: connected
  Remote access trigger: periodic
  TLS mode: Server
```

### Example: Activated Device With a Password

With `AMT_PASSWORD`, RPC evaluates WSMAN-dependent checks. This ACM/CIRA example is fully configured for remote management, with warnings to review:

```text
AMT Health Check
  Detected state: Admin Control Mode
  Selected checks: post-activation

Passed
  ✓ Running as administrator/root
  ✓ MEI/HECI driver is responding (version 7.0.0-34-generic)
  ✓ AMT activated state: admin control mode
  ✓ Platform type: vPro
  ✓ AMT version 16.1.25 is supported
  ✓ AMT network link is available for remote management
  ✓ Local Manageability Service is listening (version 2406.0.0.0)
  ✓ AMT provisioning is complete
  ✓ Local WSMAN session available
  ✓ AMT Connection Mode: CIRA
  ✓ AMT control mode matches requested ACM
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
  OS: Ubuntu 24.04.1 LTS 7.0.0-34-generic

AMT Details
  Operational state: Not reported

AMT Connectivity
  AMT-reported network status: outside enterprise (CIRA)
  Remote access connection: connected
  Remote access trigger: periodic
  TLS mode: Server
```

Activated devices can also include control-mode alignment, CIRA configuration and connectivity, remote manageability, and management-endpoint reachability checks when applicable.

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

The `evaluation` object includes the detected device state, selected check set, overall result, a human-readable status summary, check counts by category, and the provisioning or manageability result.

Each item in `checks` contains an `id`, a display `name`, a `status`, and a `message`. Status values are `pass`, `warn`, `fail`, `skip`, or `unavailable`. The text report uses the equivalent human-readable labels: **Passed**, **Warning**, **Failed**, and **Not verified**.

### Example: Pre-Activation Status (JSON)

This corresponds to the [pre-activation status](#example-pre-activation-status) text example:

```json
{
  "metadata": {
    "command": "status",
    "timestamp": "2026-11-06T12:39:35+05:30",
    "rpcVersion": "Development Build",
    "elevated": true,
    "passwordProvided": false
  },
  "evaluation": {
    "detectedState": "pre_provisioning",
    "selectedCheckSet": "pre_activation",
    "deviceType": "AMT Pro Corporate",
    "amtVersion": "16.1.25",
    "amtDnsSuffix": "vprodemo.com",
    "osDnsSuffix": "iind.intel.com",
    "remoteAccess": {
      "networkStatus": "outside enterprise (CIRA)",
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
    { "id": "dns_suffix", "name": "DNS suffix", "status": "warn", "message": "AMT DNS suffix (vprodemo.com) differs from host DNS suffix (iind.intel.com). Confirm this matches your provisioning setup", "reason": "dns_suffix_mismatch" },
    { "id": "amt_network_link", "name": "AMT network link", "status": "pass", "message": "AMT network link is available" },
    { "id": "lms", "name": "LMS", "status": "pass", "message": "Local Manageability Service is listening (version 2406.0.0.0)" },
    { "id": "host_network_for_remote_activation", "name": "Host networking for remote activation", "status": "pass", "message": "OS adapter matching an AMT MAC is enabled; verify RPS/Console endpoint reachability" }
  ]
}
```

### Example: Activated Device Without a `--password` Argument (JSON)

Output from the ACM/CIRA run without a `--password` argument or `AMT_PASSWORD`. `passwordProvided` is `false`, but the WSMAN session succeeded using local system account credentials retrieved through HECI. If that fallback is unavailable or fails authentication, WSMAN-dependent checks are reported as **Not verified**.

```json
{
  "metadata": {
    "command": "status",
    "timestamp": "2026-11-06T12:27:02+05:30",
    "rpcVersion": "Development Build",
    "elevated": true,
    "passwordProvided": false
  },
  "evaluation": {
    "detectedState": "admin control mode",
    "selectedCheckSet": "post_activation",
    "deviceType": "AMT Pro Corporate",
    "amtVersion": "16.1.25",
    "amtDnsSuffix": "vprodemo.com",
    "osDnsSuffix": "iind.intel.com",
    "remoteAccess": {
      "networkStatus": "outside enterprise (CIRA)",
      "remoteStatus": "connected",
      "remoteTrigger": "periodic",
      "mpsHostname": "10.49.97.55",
      "mpsPort": 4433
    },
    "tlsMode": "Server",
    "processor": "12th Gen Intel(R) Core(TM) i5-1250P",
    "os": "Ubuntu 24.04.1 LTS 7.0.0-34-generic",
    "wiredAdapterName": "Ethernet controller: Intel Corporation Ethernet Controller I225-LM (rev 03)",
    "wirelessAdapterName": "No matching OS adapter",
    "wiredAdapterStatus": "AMT link up; OS state up",
    "wirelessAdapterStatus": "AMT link down; OS state not verified",
    "overallResult": "not_ready",
    "overallStatus": "Device is not ready for remote management",
    "totalChecks": 19,
    "passed": 16,
    "warned": 1,
    "failed": 2,
    "notVerified": 0,
    "readyToProvision": false,
    "readyForRemoteActivation": false
  },
  "checks": [
    { "id": "running_as_admin_root", "name": "Running as admin/root", "status": "pass", "message": "Running as administrator/root" },
    { "id": "mei_driver", "name": "MEI driver", "status": "pass", "message": "MEI/HECI driver is responding (version 7.0.0-34-generic)" },
    { "id": "amt_activated_state", "name": "AMT activated state", "status": "pass", "message": "AMT activated state: admin control mode" },
    { "id": "platform_type", "name": "Platform type", "status": "pass", "message": "Platform type: vPro" },
    { "id": "amt_version", "name": "AMT version", "status": "pass", "message": "AMT version 16.1.25 is supported" },
    { "id": "dns_suffix", "name": "DNS suffix", "status": "warn", "message": "AMT DNS suffix differs from the host DNS suffix; verify the intended management DNS configuration", "reason": "dns_suffix_mismatch" },
    { "id": "amt_network_link", "name": "AMT network link", "status": "pass", "message": "AMT network link is available for remote management" },
    { "id": "lms", "name": "LMS", "status": "pass", "message": "Local Manageability Service is listening (version 2406.0.0.0)" },
    { "id": "amt_provisioning_state", "name": "AMT provisioning state", "status": "pass", "message": "AMT provisioning is complete" },
    { "id": "wsman_session", "name": "Local WSMAN session", "status": "pass", "message": "Local WSMAN session available" },
    { "id": "amt_connection_mode", "name": "AMT connection mode", "status": "pass", "message": "AMT Connection Mode: CIRA" },
    { "id": "cira_configuration", "name": "CIRA configuration", "status": "pass", "message": "CIRA MPS and remote-access policy are configured" },
    { "id": "cira_connection", "name": "CIRA connection", "status": "pass", "message": "CIRA connection is connected" },
    { "id": "redirection_service", "name": "Redirection service", "status": "fail", "message": "Redirection listener is disabled; listener is disabled" },
    { "id": "sol_redirection", "name": "SOL redirection", "status": "fail", "message": "SOL is configured but the redirection listener is disabled" },
    { "id": "kvm_user_consent", "name": "KVM user consent", "status": "pass", "message": "KVM user consent: none" },
    { "id": "tls_mode", "name": "TLS mode", "status": "pass", "message": "TLS mode: Server" },
    { "id": "monitor_connected", "name": "Monitor", "status": "pass", "message": "Monitor connected" },
    { "id": "kvm_redirection", "name": "KVM redirection", "status": "pass", "message": "KVM is enabled but offline (EnabledState 6); an active KVM session is not verified" }
  ]
}
```

### Example: Activated Device with a Password (JSON)

Output from the ACM/CIRA run with a password provided:

```json
{
  "metadata": {
    "command": "status",
    "timestamp": "2026-11-06T12:26:44+05:30",
    "rpcVersion": "Development Build",
    "elevated": true,
    "passwordProvided": true
  },
  "evaluation": {
    "detectedState": "admin control mode",
    "selectedCheckSet": "post_activation",
    "deviceType": "AMT Pro Corporate",
    "amtVersion": "16.1.25",
    "amtDnsSuffix": "vprodemo.com",
    "osDnsSuffix": "iind.intel.com",
    "remoteAccess": {
      "networkStatus": "outside enterprise (CIRA)",
      "remoteStatus": "connected",
      "remoteTrigger": "periodic",
      "mpsHostname": "10.49.97.55",
      "mpsPort": 4433
    },
    "tlsMode": "Server",
    "processor": "12th Gen Intel(R) Core(TM) i5-1250P",
    "os": "Ubuntu 24.04.1 LTS 7.0.0-34-generic",
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
    { "id": "running_as_admin_root", "name": "Running as admin/root", "status": "pass", "message": "Running as administrator/root" },
    { "id": "mei_driver", "name": "MEI driver", "status": "pass", "message": "MEI/HECI driver is responding (version 7.0.0-34-generic)" },
    { "id": "amt_activated_state", "name": "AMT activated state", "status": "pass", "message": "AMT activated state: admin control mode" },
    { "id": "platform_type", "name": "Platform type", "status": "pass", "message": "Platform type: vPro" },
    { "id": "amt_version", "name": "AMT version", "status": "pass", "message": "AMT version 16.1.25 is supported" },
    { "id": "dns_suffix", "name": "DNS suffix", "status": "warn", "message": "AMT DNS suffix differs from the host DNS suffix; verify the intended management DNS configuration", "reason": "dns_suffix_mismatch" },
    { "id": "amt_network_link", "name": "AMT network link", "status": "pass", "message": "AMT network link is available for remote management" },
    { "id": "lms", "name": "LMS", "status": "pass", "message": "Local Manageability Service is listening (version 2406.0.0.0)" },
    { "id": "amt_provisioning_state", "name": "AMT provisioning state", "status": "pass", "message": "AMT provisioning is complete" },
    { "id": "wsman_session", "name": "Local WSMAN session", "status": "pass", "message": "Local WSMAN session available" },
    { "id": "amt_connection_mode", "name": "AMT connection mode", "status": "pass", "message": "AMT Connection Mode: CIRA" },
    { "id": "cira_configuration", "name": "CIRA configuration", "status": "pass", "message": "CIRA MPS and remote-access policy are configured" },
    { "id": "cira_connection", "name": "CIRA connection", "status": "pass", "message": "CIRA connection is connected" },
    { "id": "redirection_service", "name": "Redirection service", "status": "pass", "message": "Redirection listener is enabled; SOL and IDER are enabled" },
    { "id": "sol_redirection", "name": "SOL redirection", "status": "pass", "message": "SOL is enabled" },
    { "id": "kvm_user_consent", "name": "KVM user consent", "status": "pass", "message": "KVM user consent: none" },
    { "id": "tls_mode", "name": "TLS mode", "status": "pass", "message": "TLS mode: Server" },
    { "id": "monitor_connected", "name": "Monitor", "status": "pass", "message": "Monitor connected" },
    { "id": "kvm_redirection", "name": "KVM redirection", "status": "pass", "message": "KVM is enabled but offline (EnabledState 6); an active KVM session is not verified" }
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