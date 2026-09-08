

These commands query device status, collect diagnostics, and display version information. They run locally and do not require a server connection, with one exception: `amtinfo --sync` pushes collected device info to a remote server and requires [server credentials](#syncing-device-info-to-server).

!!! note "Elevated Privileges Required"
    RPC must run with elevated privileges. Commands require `sudo` on Linux or an Administrator Command Prompt on Windows.

!!! warning "AMT 19+: `--skip-amt-cert-check` Required"
    Starting with AMT 19, Intel® AMT uses TLS for local communication. The TLS certificate is **not** in the OS trust store. You must pass `--skip-amt-cert-check` on AMT 19+ platforms for `amtinfo` and `diagnostics`. A future release will remove this requirement.

---

## amtinfo

Query AMT status and configuration locally. This command reads device information directly from Intel® AMT through the MEI driver or LMS.

```bash
rpc amtinfo
```

Running `amtinfo` without options prints all available information.

### Status Flags

| Info | Flag | Short | Description |
|:-----|:-----|:------|:------------|
| Version | `--ver` | `-r` | Intel® AMT version. |
| Build Number | `--bld` | `-b` | Intel® AMT build number. |
| SKU | `--sku` | `-s` | Product SKU. |
| UUID | `--uuid` | `-u` | Unique Universal Identifier of the device. Used in device-specific MPS API calls. |
| UPID | `--upid` | | Intel Unique Platform ID. |
| Control Mode | `--mode` | `-m` | Managed device state: pre-provisioning, CCM, or ACM. |
| Provisioning State | `--provisioningState` | `-p` | Current provisioning state. |
| Operational State | `--operationalState` | | Enabled/Disabled. Returns AMT state for 13th Gen Raptor Lake (AMT 16.1) or newer. N/A for earlier generations. |
| DNS Suffix | `--dns` | `-d` | DNS suffix set via PKI DNS Suffix in Intel® MEBX or DHCP Option 15. Required for ACM activation. |
| Hostname (OS) | `--hostname` | | Device hostname as set in the OS. |
| RAS Status | `--ras` | `-a` | Remote Access Service status: connection state, trigger type, and MPS hostname. |
| LAN Settings | `--lan` | `-l` | Wired/wireless adapter info: DHCP, link status, IP addresses, MAC address. |
| System Certificates | `--cert` | `-c` | System certificate hashes. If `--password` is also provided, prints both system and user certificate hashes. |
| User Certificates | `--userCert` | | User certificate hashes. AMT password required. |
| All | `--all` | `-A` | Show all AMT information. |

### Syncing Device Info to Server

By default, `amtinfo` only prints locally. Adding `--sync` with `--url` makes it collect the same info and then push it to a remote server (e.g., Console or MPS) via HTTP PATCH. Authentication flags are required for the server connection.

```bash
rpc amtinfo --sync --url https://mps.example.com/api/v1/devices --auth-token eyJhbGci...
```

| Flag | Description | Env Var |
|:-----|:------------|:--------|
| `--sync` | After collecting device info, push it to the server via HTTP PATCH. | |
| `--url` | Endpoint URL for the PATCH request. **Required with `--sync`.** | |
| `--auth-token` | Bearer token for server authentication. | `AUTH_TOKEN` |
| `--auth-username` | Username for basic auth. | `AUTH_USERNAME` |
| `--auth-password` | Password for basic auth. | `AUTH_PASSWORD` |
| `--auth-endpoint` | Token endpoint URL. Default: `/api/v1/authorize`. | |
| `--skip-cert-check` | `-n` | Skip certificate verification for the server connection. **Insecure.** | |

### `amtinfo` Common Flags

| Flag | Short | Description | Env Var |
|:-----|:------|:------------|:--------|
| `--json` | `-j` | Output in JSON format. | |
| `--verbose` | `-v` | Enable verbose logging. | |
| `--log-level` | | Log level: `trace`, `debug`, `info`, `warn`, `error`, `fatal`, `panic`. Default: `info`. | |
| `--password` | | AMT admin password. Required for `--userCert`. | `AMT_PASSWORD` |
| `--skip-amt-cert-check` | | Skip AMT/LMS TLS certificate verification. **Required for AMT 19+.** | |
| `--lmsaddress` | | LMS address. Default: `localhost`. | |
| `--lmsport` | | LMS port. Default: `16992` for AMT ≤ v18, `16993` for AMT ≥ v19. | |

### Examples

```bash
# Show all AMT info
rpc amtinfo

# Show all AMT info on AMT 19+
rpc amtinfo --skip-amt-cert-check

# Show only version and control mode
rpc amtinfo --ver --mode

# Show LAN settings in JSON
rpc amtinfo --lan --json

# Show user certificates (requires password)
rpc amtinfo --userCert --password AMTPassword

# Sync device info to Console
rpc amtinfo --sync --url https://mps.example.com/api/v1/devices --auth-token eyJhbGci...
```

---

## diagnostics

Collect firmware-level diagnostics for platform debugging. Use this command to inspect CIRA tunnel state, query WSMAN objects, dump CSME flash logs, and generate diagnostic bundles when troubleshooting Intel® AMT issues. If you are working with the Intel support or debug team, they may request these logs to diagnose firmware-level problems.

```bash
rpc diagnostics <subcommand>
```

Aliases: `diag`.

### Subcommands

| Subcommand | Description |
|:-----------|:------------|
| [cira](#diagnostics-cira) | Dump CIRA-related diagnostics. |
| [csme](#diagnostics-csme) | Dump CSME / firmware flash diagnostics. |
| [ws-man](#diagnostics-wsman) | Dump AMT WSMAN class(es). |
| [bundle](#diagnostics-bundle) | Collect a full diagnostics bundle. |

### diagnostics cira

Dump CIRA-related diagnostics.

```bash
rpc diagnostics cira
rpc diagnostics cira -o cira_log.txt
```

| Flag | Short | Description |
|:-----|:------|:------------|
| `-o` | | Output file path for the CIRA log text data. |

### diagnostics csme

Dump CSME / firmware flash diagnostics.

```bash
rpc diagnostics csme
rpc diagnostics csme -o flash_log.bin
```

| Flag | Short | Description |
|:-----|:------|:------------|
| `-o` | | Output file path for the flash log binary data. |

### diagnostics wsman

Dump AMT WSMAN class(es).

```bash
rpc diagnostics ws-man --class AMT_GeneralSettings
```

### diagnostics bundle

Collect a full diagnostics bundle (combines all diagnostic subcommands).

```bash
rpc diagnostics bundle
```

---

## version

Display the current version of RPC-Go and the RPC Protocol version.

```bash
rpc version
```

Use `--json` for JSON-formatted output:

```bash
rpc version --json
```
