
The `version` command displays the installed RPC-Go version and the RPC protocol version. It runs locally and does not require RPS, Console, AMT, or administrator privileges.

## version

```bash
rpc version
```

Use `--json` when the version information will be consumed by another tool:

```bash
rpc version --json
```

### Common Flags

| Flag | Short | Description |
|:-----|:------|:------------|
| `--json` | `-j` | Output version information in JSON format. |
| `--table` | `-t` | Output version information in table format. |
| `--verbose` | `-v` | Enable verbose logging. |
