
The `diagnostics` command collects local Intel® AMT and firmware diagnostic data. It does not require RPS or Console. Some diagnostics require local AMT access and therefore require administrator privileges on Windows or `sudo` on Linux.

## diagnostics

```bash
rpc diagnostics <subcommand>
```

The command also has the `diag` alias.

### CIRA diagnostics

Dump CIRA-related diagnostics:

```bash
rpc diagnostics cira
rpc diagnostics cira --output cira_log.txt
```

| Flag | Short | Description |
|:-----|:------|:------------|
| `--output` | `-o` | Output file path for the CIRA log text data. |

### CSME diagnostics

Dump CSME or firmware flash diagnostics:

```bash
rpc diagnostics csme
rpc diagnostics csme --output flash_log.bin
```

| Flag | Short | Description |
|:-----|:------|:------------|
| `--output` | `-o` | Output file path for the flash log binary data. |

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

Use `--all` to retrieve all supported classes. The output format can be `json`, `xml`, or `table`:

```bash
rpc diagnostics wsman get --all --format json
```

| Flag | Short | Description | Default |
|:-----|:------|:------------|:--------|
| `--class` | `-c` | WSMAN class to retrieve. Repeat the flag to retrieve multiple classes. | |
| `--all` | `-a` | Retrieve all available WSMAN classes. | `false` |
| `--output` | `-o` | Output file path. | `stdout` |
| `--format` | `-f` | Output format: `json`, `xml`, or `table`. | `json` |

### Diagnostic bundle

Collect a full diagnostics bundle:

```bash
rpc diagnostics bundle
```
