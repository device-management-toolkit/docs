

The `amtinfo` command queries device status and configuration locally. It does not require RPS or Console unless `--sync` is used; `amtinfo --sync` pushes collected device information to a remote server and requires [server credentials](#syncing-device-info-to-server).

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

| Info | Flag | Short | Description | Env Var |
|:-----|:-----|:------|:------------|:--------|
| Version | `--ver` | `-r` | Intel® AMT version. | `RPC_VER` |
| Build Number | `--bld` | `-b` | Intel® AMT build number. | `RPC_BLD` |
| SKU | `--sku` | `-s` | Product SKU. | `RPC_SKU` |
| UUID | `--uuid` | `-u` | Unique Universal Identifier of the device. Used in device-specific MPS API calls. | `RPC_UUID` |
| UPID | `--upid` | | Intel Unique Platform ID. | `RPC_UPID` |
| TEP | `--tep` | | Intel Trusted Endpoint Provisioning (TEP) status. | `RPC_TEP` |
| Control Mode | `--mode` | `-m` | Managed device state: pre-provisioning, CCM, or ACM. | `RPC_MODE` |
| Provisioning State | `--provisioningState` | `-p` | Current provisioning state. | `RPC_PROVISIONING_STATE` |
| Operational State | `--operationalState` | | Enabled/Disabled. Returns AMT state for 13th Gen Raptor Lake (AMT 16.1) or newer. N/A for earlier generations. | `RPC_OPERATIONAL_STATE` |
| DNS Suffix | `--dns` | `-d` | DNS suffix set via PKI DNS Suffix in Intel® MEBX or DHCP Option 15. Required for ACM activation. Also shows the OS DNS suffix. | `RPC_DNS` |
| Hostname (OS) | `--hostname` | | Device hostname as set in the OS. | `RPC_HOSTNAME` |
| RAS Status | `--ras` | `-a` | Remote Access Service status: connection state, trigger type, and MPS hostname. See [RAS details](#ras-details). | `RPC_RAS` |
| LAN Settings | `--lan` | `-l` | Wired/wireless adapter info: DHCP, link status, IP addresses, MAC address. See [LAN details](#lan-details). | `RPC_LAN` |
| System Certificates | `--cert` | `-c` | System certificate hashes. | `RPC_CERT` |
| User Certificates | `--userCert` | | User certificate hashes. No AMT password is required; RPC uses Local System Account credentials when no password is supplied. | `RPC_USER_CERT` |
| HTTP Proxy | `--proxy` | | HTTP proxy access points configured in AMT. Requires WSMAN. | `RPC_PROXY` |
| All | `--all` | `-A` | Show all AMT information. | `RPC_ALL` |

!!! note "Control Mode Values"
    The control mode indicates the managed device's state: (a) pre-provisioning, (b) activated in client control mode (CCM), or (c) activated in admin control mode (ACM).

#### RAS Details

| Field | Description |
|:------|:------------|
| RAS Network | Network state of the Remote Access Service. |
| RAS Remote Status | Unconnected or connected. State of the connection to a management server. |
| RAS Trigger | User initiated or periodic. When activated, periodic signifies CIRA is established. By default, CIRA sends a heartbeat to the server every 30 seconds to verify and maintain the connection. |
| RAS MPS Hostname | IP address or FQDN of the MPS server. |

#### LAN Details

| Field | Description |
|:------|:------------|
| DHCP Enabled | True/False. Whether the network is using DHCP or static IPs. |
| DHCP Mode | DHCP mode in use. |
| Link Status | Up/Down. Shows whether this adapter is being used by Intel® AMT. |
| AMT IP Address | If using CIRA or the device is unactivated, this field shows `0.0.0.0`. |
| OS IP Address | IP address of the device as set in the operating system. |
| MAC Address | MAC address of the device. |

For more information, see [Wireless Activation](../../../Tutorials/createWiFiConfig.md).

### Syncing Device Info to Server

By default, `amtinfo` only prints locally. Adding `--sync` with `--url` makes it collect the same info and then push it to a remote server (e.g., Console or MPS) via HTTP PATCH. Authentication flags are required for the server connection.

```bash
rpc amtinfo --sync --url https://mps.example.com/api/v1/devices --auth-token eyJhbGci...
```

| Flag | Description | Env Var |
|:-----|:------------|:--------|
| `--sync` | After collecting device info, push it to the server via HTTP PATCH. Aliases: `--discover`, `--register`. | `RPC_SYNC` |
| `--url` | Endpoint URL of the devices API for the PATCH request. **Required with `--sync`.** | `RPC_URL` |
| `--auth-token` | Bearer token for server authentication. | `AUTH_TOKEN` |
| `--auth-username` | Username for basic auth. | `AUTH_USERNAME` |
| `--auth-password` | Password for basic auth. | `AUTH_PASSWORD` |
| `--auth-endpoint` | Token exchange endpoint. Requires `--auth-token` or `--auth-username`/`--auth-password`. Resolved relative to the server host unless absolute. | `AUTH_ENDPOINT` |
| `--devices-endpoint` | Absolute devices API URL. Defaults to `{console-url}/api/v1/devices`. | `DEVICES_ENDPOINT` |
| `--skip-cert-check` (`-n`) | Skip certificate verification for the server connection. **Insecure.** | `RPC_SKIP_CERT_CHECK` |

### `amtinfo` Common Flags

| Flag | Short | Description | Env Var |
|:-----|:------|:------------|:--------|
| `--json` | `-j` | Output in JSON format. | `RPC_JSON` |
| `--table` | `-t` | Output in table format. | `RPC_TABLE` |
| `--verbose` | `-v` | Enable verbose logging. | `RPC_VERBOSE` |
| `--log-level` | | Log level: `trace`, `debug`, `info`, `warn`, `error`, `fatal`, `panic`. Default: `info`. | `RPC_LOG_LEVEL` |
| `--password` | | AMT admin password, when required by an operation. | `AMT_PASSWORD` |
| `--skip-amt-cert-check` | | Skip AMT/LMS TLS certificate verification. **Required for AMT 19+.** | `RPC_SKIP_AMT_CERT_CHECK` |
| `--lmsaddress` | | LMS address. Default: `localhost`. | `RPC_LMSADDRESS` |
| `--lmsport` | | LMS port. Default: `16992`. | `RPC_LMSPORT` |

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

# Show user certificates
rpc amtinfo --userCert

# Show Intel TEP status and HTTP proxy access points
rpc amtinfo --tep --proxy

# Sync device info to Console
rpc amtinfo --sync --url https://mps.example.com/api/v1/devices --auth-token eyJhbGci...
```
