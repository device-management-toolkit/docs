
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

Retrieve one or more WSMAN classes:

```bash
rpc diagnostics wsman get --class AMT_GeneralSettings
rpc diagnostics wsman get --class AMT_GeneralSettings --class AMT_UserInitiatedConnectionService
```

Use `--all` to retrieve all supported classes. Specify either `--all` or at least one `--class`; otherwise the command fails with `specify --all or at least one --class`. An unknown class fails with `unsupported WSMAN class: <name>`. Classes that the device cannot return are reported as warnings, and the remaining classes are still written. The output format can be `json`, `xml`, or `table`:

```bash
rpc diagnostics wsman get --all --format json
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
