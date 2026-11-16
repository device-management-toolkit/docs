
The `diagnostics` command collects local Intel® AMT and firmware diagnostic data. It does not require RPS or Console. Some diagnostics require local AMT access and therefore require administrator privileges on Windows or `sudo` on Linux.

!!! warning "AMT 19+: `--skip-amt-cert-check` for WSMAN Data"
    On AMT 19+ devices, which enforce TLS on local ports, `cira` and `csme` work without extra flags. `wsman get` and the WSMAN part of `bundle` connect over TLS and fail with an x509 certificate error unless you pass `--skip-amt-cert-check`. Without it, `bundle` still creates the ZIP but reports that the WSMAN classes failed to retrieve.

## diagnostics

```bash
rpc diagnostics <subcommand>
```

The command also has the `diag` alias, and `wsman` has the `ws-man` alias.

### CIRA diagnostics

Dump CIRA-related diagnostics:

```bash
rpc diagnostics cira
rpc diagnostics cira --output cira_log.txt
```

If `--output` is omitted, the log is written to `<YYYYMMDD_HHMMSS>_ciralog.txt` in the current directory.

| Flag | Short | Description |
|:-----|:------|:------------|
| `--output` | `-o` | Output file path for the CIRA log text data. Env var: `RPC_OUTPUT`. |

### CSME diagnostics

Dump CSME or firmware flash diagnostics:

```bash
rpc diagnostics csme
rpc diagnostics csme --output flash_log.bin
```

If `--output` is omitted, the log is written to `<YYYYMMDD_HHMMSS>_csme_flash_log.bin` in the current directory.

| Flag | Short | Description |
|:-----|:------|:------------|
| `--output` | `-o` | Output file path for the flash log binary data. Env var: `RPC_OUTPUT`. |

### WSMAN diagnostics

List the WSMAN classes supported by the diagnostic command:

```bash
rpc diagnostics wsman list
```

??? note "Supported WSMAN classes"
    - **AMT:** `AMT_8021XProfile`, `AMT_AssetTable`, `AMT_AssetTableService`, `AMT_AuditLog`, `AMT_BootCapabilities`, `AMT_BootSettingData`, `AMT_CryptographicCapabilities`, `AMT_EnvironmentDetectionSettingData`, `AMT_EthernetPortSettings`, `AMT_EventLogEntry`, `AMT_GeneralSettings`, `AMT_Hdr8021Filter`, `AMT_ManagementPresenceRemoteSAP`, `AMT_MessageLog`, `AMT_RedirectionService`, `AMT_RemoteAccessCapabilities`, `AMT_RemoteAccessPolicyAppliesToMPS`, `AMT_RemoteAccessPolicyRule`, `AMT_SetupAndConfigurationService`, `AMT_SystemPowerScheme`, `AMT_TimeSynchronizationService`, `AMT_UserInitiatedConnectionService`, `AMT_WiFiPortConfigurationService`
    - **CIM:** `CIM_BIOSElement`, `CIM_BIOSFeature`, `CIM_Card`, `CIM_Chassis`, `CIM_ComputerSystemPackage`, `CIM_EthernetPort`, `CIM_KVMRedirectionSAP`, `CIM_PowerManagementCapabilities`, `CIM_PowerManagementService`, `CIM_Processor`, `CIM_RedirectionService`, `CIM_SoftwareIdentity`, `CIM_WiFiEndpoint`, `CIM_WiFiEndpointCapabilities`, `CIM_WiFiEndpointSettings`, `CIM_WiFiPort`, `CIM_WiFiPortCapabilities`
    - **IPS:** `IPS_HostBasedSetupService`, `IPS_HostBootReason`, `IPS_HostIPSettings`, `IPS_HTTPProxyAccessPoint`, `IPS_IEEE8021xSettings`, `IPS_IPv6PortSettings`, `IPS_KVMRedirectionSettingData`, `IPS_LANEndpoint`, `IPS_OptInService`, `IPS_ProvisioningRecordLog`, `IPS_ScreenSettingData`, `IPS_SecIOService`

Retrieve one or more WSMAN classes:

```bash
rpc diagnostics wsman get --class AMT_GeneralSettings
rpc diagnostics wsman get --class AMT_GeneralSettings --class AMT_UserInitiatedConnectionService
```

Use `--all` to retrieve all supported classes. Specify either `--all` or at least one `--class`, but not both; otherwise the command fails with `specify --all or at least one --class` or `--all cannot be used with --class`. Class names are case-sensitive and must match the output of `wsman list`; an unknown class fails with `unsupported WSMAN class: <name>`. Duplicate classes are retrieved once.

If only one class is requested and it cannot be retrieved, the command fails. When multiple classes are requested, classes that the device cannot return are reported as warnings and the command still succeeds. In `json` and `xml` output, each failed class is recorded with status `fetch_failed` and the error message. In `table` output, it appears as `No instances found for class: <name>`.

If `--password` is not provided, the command reads the local AMT system account credentials through the MEI driver, so no password prompt is shown. The command connects through LMS. On devices without TLS enforcement, it falls back to a direct MEI connection when LMS is not running.

The output format can be `json`, `xml`, or `table`. With `xml`, a single class is written as its raw XML, and multiple classes are wrapped in a `<WSMANClasses>` element. When `--output` is a file path, any missing parent directories are created, an existing file is overwritten, and the command prints `WSMAN class data written to <path>`:

```bash
rpc diagnostics wsman get --all --format json
rpc diagnostics wsman get --class AMT_AuditLog --output audit.json
rpc diagnostics wsman get --all --format xml --output all_classes.xml
rpc diagnostics wsman get -c AMT_GeneralSettings -c AMT_EthernetPortSettings
```

| Flag | Short | Description | Default |
|:-----|:------|:------------|:--------|
| `--class` | `-c` | WSMAN class to retrieve. Repeat the flag to retrieve multiple classes. Env var: `RPC_CLASS`. | |
| `--all` | `-a` | Retrieve all available WSMAN classes. | `false` |
| `--output` | `-o` | Output file path. | `stdout` |
| `--format` | `-f` | Output format: `json`, `xml`, or `table`. | `json` |

### Diagnostic bundle

Collect a full diagnostics bundle:

```bash
rpc diagnostics bundle
rpc diagnostics bundle --output my_bundle.zip
```

The bundle is written as a ZIP archive containing `manifest.json`, `cira.txt`, `csme_flash_log.bin`, and `wsman.json`. If a collector is incomplete, for example when some WSMAN classes fail to retrieve, the bundle is still created and the manifest records the details. If `--output` is omitted, a timestamped file named `<YYYYMMDD_HHMMSS>_diagnostics_bundle.zip` is created in the current directory. If the path has no extension, `.zip` is appended.

| Flag | Short | Description |
|:-----|:------|:------------|
| `--output` | `-o` | Output file path for the diagnostics bundle. Env var: `RPC_OUTPUT`. |
