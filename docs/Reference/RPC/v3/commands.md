

The Remote Provisioning Client (RPC-Go) v3.x provides commands for activating, deactivating, configuring, diagnosing, and managing Intel® AMT devices. Commands operate in one of two modes:

- **Server mode** - RPC-Go acts as a **proxy** between a server (Console or RPS) and Intel® AMT. All orchestration logic resides on the server and RPC-Go relays WSMAN commands to AMT.
- **Local mode** - RPC-Go applies configuration directly to Intel® AMT on the device, without requiring a server at runtime. The device OS is trusted to handle secrets and provisioning data.

!!! note "Elevated Privileges Required"
    AMT operations may require elevated privileges (`sudo` on Linux or an Administrator Command Prompt on Windows). `version` does not require elevation, and `amtinfo` can return limited information without it.

## Commands

Run `rpc -h` to see all available commands:

=== "Linux/macOS"

    ```bash
    sudo ./rpc -h
    ```

=== "Windows"

    ```powershell
    .\rpc.exe -h
    ```

    If `rpc.exe` is on `PATH`, you can run `rpc.exe -h` instead.

| Command | Description | Modes | Reference |
|:--------|:------------|:------|:----------|
| [activate](commandsServer.md#activate) | Activate AMT on the local device or via remote server. | Server, Local | [Server](commandsServer.md#activate) &#124; [Local](commandsLocal.md#activate) |
| [deactivate](commandsServer.md#deactivate) | Deactivate AMT on the local device or via remote server. | Server, Local | [Server](commandsServer.md#deactivate) &#124; [Local](commandsLocal.md#deactivate) |
| [configure](commandsLocal.md#configure) | Configure AMT settings including ethernet, wireless, TLS, CIRA, and other features. | Local | [Local](commandsLocal.md#configure) |
| [diagnostics](commandsDiagnostics.md#diagnostics) | Collect local AMT and firmware diagnostic data. | Local | [Reference](commandsDiagnostics.md#diagnostics) |
| `status` | Check AMT activation readiness. Aliases: `health`, `doctor`. | Local | `rpc status --help` |
| [amtinfo](commandsInfo.md#amtinfo) | Display AMT status and configuration on the local device. | Local | [Reference](commandsInfo.md#amtinfo) |
| [version](commandsVersion.md#version) | Display RPC and protocol version. | Local | [Reference](commandsVersion.md#version) |

## Global Flags

These flags are available across commands. Command-specific options are listed in each reference.

| Flag | Short | Description | Env Var / Default |
|:-----|:------|:------------|:------------------|
| `--log-level` | | Set log level: `trace`, `debug`, `info`, `warn`, `error`, `fatal`, or `panic`. | `RPC_LOG_LEVEL`; default `info` |
| `--json` | `-j` | Output in JSON format. | `RPC_JSON` |
| `--table` | `-t` | Output in table format. | `RPC_TABLE` |
| `--no-color` | | Disable colored output. | `NO_COLOR` |
| `--verbose` | `-v` | Enable verbose logging. | `RPC_VERBOSE` |
| `--skip-cert-check` | `-n` | Skip remote HTTPS/WSS certificate verification. Insecure. | `RPC_SKIP_CERT_CHECK` |
| `--skip-amt-cert-check` | | Skip certificate verification when connecting to AMT/LMS over TLS (insecure). | `RPC_SKIP_AMT_CERT_CHECK` |
| `--tenantid` | | Tenant ID for multi-tenant RPS environments. | `TENANT_ID` |
| `--lmsaddress` | | LMS address. | `RPC_LMSADDRESS`; default `localhost` |
| `--lmsport` | | LMS port. | `RPC_LMSPORT`; default `16992` |
| `--password` | | AMT admin password. | `AMT_PASSWORD` |
| `--auth-token` | | Bearer token for server authentication. | `AUTH_TOKEN` |
| `--auth-username` | | Username for basic authentication. | `AUTH_USERNAME` |
| `--auth-password` | | Password for basic authentication. | `AUTH_PASSWORD` |
| `--auth-endpoint` | | Token exchange endpoint override. If unset, RPC tries `/api/v1/authorize` and `/mps/login/api/v1/authorize`. | `AUTH_ENDPOINT` |
| `--devices-endpoint` | | Absolute devices API URL. Defaults to `{console-url}/api/v1/devices`. | `DEVICES_ENDPOINT` |

## Mode Overview

### Server Mode

In server mode, RPC-Go acts as a **proxy**: it connects to a server (Console or RPS) over a secure WebSocket connection and relays WSMAN commands to Intel® AMT. All orchestration logic resides on the server; RPC-Go does not make provisioning decisions.

Use server mode when:

- Devices are managed centrally through Console and MPS.
- CIRA (Client Initiated Remote Access) connectivity is required.
- Profiles are managed on the server.

```bash
rpc activate --url wss://server/activate --profile profilename
```

See [Server Mode CLI Reference](commandsServer.md) for all server mode commands, flags, and examples.

### Local Mode

Local mode commands apply configuration directly to Intel® AMT through the MEI driver or LMS. No RPS or Console connection is needed at runtime. RPC-Go reads profiles and secrets from the local filesystem and drives the provisioning sequence itself.

!!! warning "OS Trust Assumption"
    Local mode assumes the operating system environment is trusted. Profiles, secrets, and credentials are read from and processed on the local device. Ensure the OS has not been compromised before using local mode commands.

Use local mode when:

- No RPS or Console service is available or required at runtime.
- A profile was exported from Console or RPS and is being applied on-device.

```bash

# Profile-based activation (exported from Console)
rpc activate --profile ./myprofile.yaml --key "myprofile_key"

# Flag-based activation
rpc activate --local --ccm
```

See [Local Mode CLI Reference](commandsLocal.md) for all local mode commands, flags, and examples.

### Information, Version, and Diagnostics

The `amtinfo`, `version`, and `diagnostics` commands are local utilities. They do not use RPS or Console.

See the [AMT information reference](commandsInfo.md), [version reference](commandsVersion.md), and [diagnostics reference](commandsDiagnostics.md) for details.
