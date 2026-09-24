# RPC Health and Readiness Checker

Use the RPC Health and Readiness Checker to assess an Intel® AMT device before or after activation. The report identifies configured prerequisites, outstanding requirements, and conditions that may prevent AMT management operations from working as expected.

## Run the health checker

Run RPC with elevated privileges. On Linux, use `sudo`. On Windows, open an Administrator Command Prompt.

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

RPC automatically selects the appropriate checks based on the device state:

- **Before activation:** evaluates whether the device is ready to be provisioned.
- **After activation:** evaluates the device's manageability and whether AMT management operations can proceed.

## Select an activation profile

Without a profile flag, RPC reports general device readiness. Use one of the following flags to evaluate readiness for a specific activation mode:

| Flag | Purpose |
|------|---------|
| `--acm` | Evaluate Admin Control Mode (ACM) prerequisites. |
| `--ccm` | Evaluate Client Control Mode (CCM) prerequisites. |

Select only one profile flag for each command.

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

In automatic mode, DNS suffix and wired-network issues that affect only ACM are reported as warnings because CCM may still proceed. With `--acm`, those requirements are treated as blockers.

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

This check is optional. An unreachable host does not prevent provisioning, but the report warns that management operations may not work through that endpoint.

## Post-activation checks and the AMT password

The checker does not prompt for an AMT password. For an activated device, provide `--password` when you want RPC to run the additional WSMAN checks that require the password:

=== "Linux"
    ```bash
    sudo ./rpc status --password '<AMT-password>'
    ```

=== "Windows"
    ```cmd
    rpc.exe status --password "<AMT-password>"
    ```

Without a password, RPC still runs checks that do not require WSMAN. Password-dependent checks are reported as **Not verified**, and the report indicates that the evaluation is incomplete.

To avoid placing the password directly in shell history, use the `AMT_PASSWORD` environment variable when appropriate:

=== "Linux"
    ```bash
    sudo AMT_PASSWORD='<AMT-password>' ./rpc status
    ```

=== "Windows"
    ```cmd
    set AMT_PASSWORD=<AMT-password>
    rpc.exe status
    ```


## Health check results

The text report groups checks into four categories:

| Category | Meaning |
|----------|---------|
| **Passed** | The requirement was satisfied. |
| **Warnings** | The check found a concern that may not prevent the selected operation. |
| **Failed** | The check found a condition that prevents the selected operation. |
| **Not verified** | The check was not applicable or a required component, such as MEI or WSMAN, was unavailable. |

The final summary recommends the next action. Before activation, it reports whether the device is ready for ACM or CCM. After activation, it reports whether AMT management operations can proceed, whether some checks could not be completed, or whether remediation is required.

Some checks apply only in specific configurations. For example, CIRA checks apply only when the device uses CIRA, and features that are not supported by the device are not treated as failures.

### Example: Pre-Activation Status

Before activation, the report evaluates local prerequisites and will produce output similar to the following:

<figure class="figure-image">
    <img src="../../assets/images/screenshots/RPC_Health_PreActivation.png" alt="RPC health check report showing a device ready for activation">
    <figcaption>Example pre-activation status for a device ready for activation.</figcaption>
</figure>

Depending on the selected profile, pre-activation checks can include administrator privileges, MEI availability, platform and AMT-version support, BIOS configuration, DNS suffix, wired-network availability, LMS, and optional management-endpoint reachability. Use `--acm` or `--ccm` to evaluate the requirements for one activation mode.

### Example: Activated Device without a password

After activation, RPC verifies the AMT state and management configuration. Without an AMT password, checks that need a local WSMAN session are listed as **Not verified**:

<figure class="figure-image">
    <img src="../../assets/images/screenshots/RPC_Health_PostActivation_NoPassword.png" alt="RPC health check report showing an activated device without an AMT password">
    <figcaption>Example post-activation status when no AMT password is provided.</figcaption>
</figure>

### Example: Activated Device with a password

With `--password` or `AMT_PASSWORD`, RPC can evaluate WSMAN-dependent checks and reports them under **Passed**, **Warnings**, or **Failed**:

<figure class="figure-image">
    <img src="../../assets/images/screenshots/RPC_Health_PostActivation_WithPassword.png" alt="RPC health check report showing an activated device with an AMT password">
    <figcaption>Example post-activation status when an AMT password is provided.</figcaption>
</figure>

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

The JSON document contains `metadata`, `evaluation`, and `checks` objects. Use these structured results in scripts instead of parsing the formatted text report.

The `evaluation` object includes the detected device state, checks performed, overall result, check counts, and provisioning or manageability result. When a required component is unavailable, it also includes a reason that the evaluation could not be completed.

Each item in `checks` contains a check name, status, and optional message. Status values are `pass`, `warn`, `fail`, `skip`, or `unavailable`.

Example:

```json
{
  "evaluation": {
    "detectedState": "pre_provisioning",
    "overallResult": "ready",
    "readyToProvision": true
  },
  "checks": [
    {
      "name": "MEI driver",
      "status": "pass",
      "message": "Intel MEI driver installed and responding"
    }
  ]
}
```

## Troubleshooting

### LMS is not running or not installed

The checker tests the local LMS ports and reports whether LMS is not installed or installed but not running. It does not start the service. Install or start LMS, then run the checker again.

### WSMAN checks are not verified

For an activated device, provide the AMT password and run the command again. RPC uses the local LMS service to establish the WSMAN session. If WSMAN remains unavailable, verify the password, LMS service, and local AMT/WSMAN connection.

### DNS suffix or wired-link warning

These checks are especially important for ACM. Verify that the AMT DNS suffix is configured, matches the provisioning certificate or profile domain, and that the wired AMT interface is available. CCM may still proceed when the report identifies the issue as ACM-only.


## Related RPC documentation

- [RPC CLI commands and flags](v2/commandsRPC.md)
- [RPC overview](overview.md)
- [Build RPC-Go manually](buildRPC_Manual.md)
- [Transition an activated device](transitionDeviceRPC.md)