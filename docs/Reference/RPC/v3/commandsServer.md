

In server mode, RPC-Go acts as a **proxy** between a server and Intel® AMT. The server (either Console or RPS) holds all orchestration logic and determines the WSMAN message sequence required to activate, deactivate, or maintain Intel® AMT. RPC-Go simply relays those commands to AMT and returns the responses.

Use server mode when devices are managed centrally through Console, RPS, and MPS, or when CIRA connectivity is required. Global options are listed in the [Commands Overview](commands.md#global-flags).

!!! warning "AMT 19+: `--skip-amt-cert-check` Required"
    Starting with AMT 19, Intel® AMT uses TLS for local communication (via LMS). The TLS certificate is **not** in the OS trust store. Even in server mode, RPC-Go communicates with AMT locally to relay commands. You must pass `--skip-amt-cert-check` on AMT 19+ platforms. A future release will remove this requirement.

---

## activate

Activate the device with a specified profile through Console or RPS.

The `--url` flag determines the activation mode:

- **`wss://`** — RPS-driven activation via WebSocket. Requires `--profile`.
- **`https://`** — HTTP profile fetch from Console or RPS. RPC-Go fetches the encrypted profile and activates locally.

### WebSocket Activation (RPS)

```bash
rpc activate --url wss://server/activate --profile profilename
```

### HTTP Profile Activation (Console/RPS)

```bash
rpc activate --url https://console.example.com/api/v1/admin/profiles/export/myProfile?domainName=myDomain \
  --auth-username admin --auth-password P@ssw0rd
```

### `activate` Flags

| Flag | Short | Description | Env Var |
|:-----|:------|:------------|:--------|
| `--url` | `-u` | Server URL: WebSocket (`wss://`, `ws://`) for RPS, or HTTP (`https://`, `http://`) for profile fetch. **Required.** | `RPC_URL` |
| `--profile` | | Profile name for WebSocket activation. For HTTP profile activation, pass a profile file path instead. **Required for WebSocket mode.** | `RPC_PROFILE` |
| `--skip-cert-check` | `-n` | Skip certificate verification for remote HTTPS/WSS (Console/RPS) connections. **Insecure.** | `RPC_SKIP_CERT_CHECK` |
| `--skip-amt-cert-check` | | Skip AMT/LMS TLS certificate verification. **Required for AMT 19+.** | `RPC_SKIP_AMT_CERT_CHECK` |
| `--password` | | AMT admin password. If not provided, you are prompted when required. | `AMT_PASSWORD` |
| `--key` | `-k` | Key for decrypting an encrypted local or HTTP-delivered profile. | `CONFIG_ENCRYPTION_KEY` |
| `--hostname` | | Hostname override. | `RPC_HOSTNAME` |
| `--dns` | `-d` | DNS suffix override. | `DNS_SUFFIX` |
| `--name` | | Friendly name to associate with this device. | `RPC_NAME` |
| `--uuid` | | UUID override; prevents an MPS connection. | `RPC_UUID` |
| `--proxy` | | Proxy server URL. RPC-Go routes its connection to Console or RPS through this proxy. | `RPC_PROXY` |
| `--tls-tunnel` | | Provision TLS on AMT 11-18 devices and switch to the encrypted channel. | `RPC_TLS_TUNNEL` |
| `--tenantid` | | Tenant ID for multi-tenant environments. | `TENANT_ID` |
| `--json` | `-j` | Output in JSON format. | |
| `--verbose` | `-v` | Enable verbose logging. | |
| `--log-level` | | Log level: `trace`, `debug`, `info`, `warn`, `error`, `fatal`, `panic`. Default: `info`. | |
| `--auth-token` | | Bearer token for server authentication. | `AUTH_TOKEN` |
| `--auth-username` | | Username for basic auth. | `AUTH_USERNAME` |
| `--auth-password` | | Password for basic auth. | `AUTH_PASSWORD` |
| `--auth-endpoint` | | Token exchange endpoint override. If unset, RPC tries `/api/v1/authorize` and `/mps/login/api/v1/authorize`. | `AUTH_ENDPOINT` |
| `--devices-endpoint` | | Absolute devices API URL. Defaults to `{console-url}/api/v1/devices`. | `DEVICES_ENDPOINT` |
| `--lmsaddress` | | LMS address. Default: `localhost`. | |
| `--lmsport` | | LMS port. Default: `16992`. | |

### Examples

```bash
# RPS activation via WebSocket
rpc activate --url wss://server/activate --profile myProfile

# AMT 19+ platform
rpc activate --url wss://server/activate --profile myProfile --skip-amt-cert-check

# With DNS suffix override and friendly name
rpc activate --url wss://server/activate --profile myProfile --dns corp.example.com --name "Lab Device 01"

# HTTP profile fetch from Console with basic auth
rpc activate --url https://console.example.com/api/v1/admin/profiles/export/myProfile?domainName=myDomain \
  --auth-username admin --auth-password P@ssw0rd

# HTTP profile fetch with bearer token
rpc activate --url https://console.example.com/api/v1/admin/profiles/export/myProfile?domainName=myDomain \
  --auth-token eyJhbGci...

# With proxy and skip cert verification
rpc activate --url wss://server/activate --profile myProfile --proxy http://proxy:8080 -n

# With multitenancy
rpc activate --url wss://server/activate --profile myProfile --tenantid tenant123
```

---

## deactivate

Deactivate the device through Console or RPS.

```bash
rpc deactivate --url wss://server/deactivate
```

### `deactivate` Flags

| Flag | Short | Description | Env Var |
|:-----|:------|:------------|:--------|
| `--url` | `-u` | Server URL for remote deactivation. **Required.** | `RPC_URL` |
| `--skip-cert-check` | `-n` | Skip certificate verification for remote HTTPS/WSS (Console/RPS) connections. **Insecure.** | |
| `--skip-amt-cert-check` | | Skip AMT/LMS TLS certificate verification. **Required for AMT 19+.** | |
| `--password` | | AMT admin password. If not provided, you are prompted when required. | `AMT_PASSWORD` |
| `--tenantid` | | Tenant ID for multi-tenant environments. | `TENANT_ID` |
| `--json` | `-j` | Output in JSON format. | |
| `--verbose` | `-v` | Enable verbose logging. | |
| `--log-level` | | Log level: `trace`, `debug`, `info`, `warn`, `error`, `fatal`, `panic`. Default: `info`. | |
| `--auth-token` | | Bearer token for server authentication. | `AUTH_TOKEN` |
| `--auth-username` | | Username for basic auth. | `AUTH_USERNAME` |
| `--auth-password` | | Password for basic auth. | `AUTH_PASSWORD` |
| `--auth-endpoint` | | Token exchange endpoint. Requires `--auth-token` or `--auth-username`/`--auth-password`. Resolved relative to the server host unless absolute. | `AUTH_ENDPOINT` |
| `--devices-endpoint` | | Absolute devices API URL. Defaults to `{console-url}/api/v1/devices`. | `DEVICES_ENDPOINT` |
| `--lmsaddress` | | LMS address. Default: `localhost`. | |
| `--lmsport` | | LMS port. Default: `16992`. | |
| `--force` | `-f` | Force deactivate even if the device is not matched in MPS. | `RPC_FORCE` |
| `--uuid` | | UUID override for Console device lookup and cleanup. | `RPC_UUID` |
| `--tls-tunnel` | | Tunnel TLS to AMT through RPS (RPC-Go forwards plain bytes on the TLS port). | `RPC_TLS_TUNNEL` |

### Examples

```bash
# Basic deactivation
rpc deactivate --url wss://server/deactivate

# Deactivation on AMT 19+ platform
rpc deactivate --url wss://server/deactivate --skip-amt-cert-check

# Force deactivate unregistered device
rpc deactivate --url wss://server/deactivate --force

# With bearer token auth
rpc deactivate --url wss://server/deactivate --auth-token eyJhbGci...

# Skip certificate verification
rpc deactivate --url wss://server/deactivate -n
```
