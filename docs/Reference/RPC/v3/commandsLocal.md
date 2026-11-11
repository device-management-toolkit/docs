
Local mode commands apply configuration directly to Intel® AMT through the MEI driver or Intel® Local Management Service (LMS), without server interaction. RPC-Go reads profiles and secrets from the local filesystem and drives the provisioning sequence entirely on the device.

Use local mode when a server (Console/RPS) is not required, when profiles are exported and applied on-device, or when configuring features like TLS, networking, CIRA, and AMT features.

!!! warning "OS Trust Assumption"
    Local mode assumes the operating system environment on the device is **trusted**. Profiles, secrets, certificates, and credentials are read from and processed on the local device. If the OS has been compromised, any secrets passed to RPC-Go (including AMT passwords, provisioning certificates, and 802.1x credentials) could be exposed. Ensure the integrity of the OS before using local mode commands.

!!! warning "AMT 19+: `--skip-amt-cert-check` Required"
    Starting with AMT 19, Intel® AMT uses TLS for local communication. The TLS certificate is **not** in the OS trust store, so RPC-Go cannot validate it. You must pass `--skip-amt-cert-check` on AMT 19+ platforms for **all** local mode commands (`activate`, `deactivate`, `configure`). A future release will remove this requirement.

Global options are listed in the [Commands Overview](commands.md#global-flags).

---

## activate

Activate an unprovisioned device locally. There are three approaches:

1. **[Encrypted profile](#1-encrypted-profile)** - Export an encrypted profile from Console, copy it to the device, and activate. The profile orchestrator applies the full device configuration automatically.
2. **[config.yaml](#2-configyaml)** - Create or adapt a `config.yaml` with the fields you need. Intended for debugging and development.
3. **[Flag-based](#3-flag-based-ccm-acm)** - Pass `--local` with `--ccm` or `--acm` and individual flags on the command line.

!!! info "Local Activation Scope"
    Local activation is only supported for activating unprovisioned (pre-provisioning state) devices.

### 1. Encrypted Profile

Export a profile from the Console UI or API, copy the encrypted profile file to the target AMT device, and run:

```bash
rpc activate --profile ./myprofile.yaml --key "myprofile_key" --skip-amt-cert-check
```

The `--profile` flag points to the encrypted YAML file and `--key` provides the 32-character decryption key. The profile contains the full device configuration (activation mode, networking, TLS, CIRA, redirection features, etc.) and the **profile orchestrator** applies each step automatically.

!!! tip "What the Profile Orchestrator Does"
    When a profile file is provided, RPC-Go runs the profile orchestrator which applies the full device configuration in sequence:

    1. **Activate** - CCM or ACM based on the profile's `controlMode` field
    2. **MEBx password** - Set MEBx password (ACM only, if specified)
    3. **AMT features** - Configure KVM, SOL, IDER, and User Consent
    4. **Wired network** - DHCP or Static IP settings
    5. **WiFi sync** - OS and UEFI WiFi sync settings
    6. **Wireless profiles** - Purge existing and add each configured profile
    7. **TLS** - Configure TLS mode and certificates
    8. **CIRA** - Configure MPS connection for remote access
    9. **HTTP Proxy** - Configure proxy access points

    Each step is only executed if the corresponding section is present in the profile. The orchestrator handles password rotation and retries automatically.

!!! info "How --profile and --key Work"
    The configuration file is encrypted using AES-256-GCM. The encryption key is generated from 24 bytes of cryptographically secure random data and encoded as a 32-character string, which is used directly as the AES key. For each encryption, a random nonce is generated and prefixed to the ciphertext, and the final output is base64-encoded. During decryption, the data is base64-decoded, the nonce is extracted, and AES-GCM verifies and decrypts the YAML content automatically.

!!! note "Profile flags cannot be combined with `--ccm`/`--acm`/`--stopConfig`"
    When `--profile` points to a file, the activation mode is determined by the profile's `controlMode` field. Passing `--ccm`, `--acm`, or `--stopConfig` with a file-based `--profile` is not allowed.

### 2. config.yaml

RPC-Go automatically loads a file named `config.yaml` from the working directory at startup and applies the values as flag defaults. To use this approach, create a `config.yaml` with the sections you need and run:

```bash
rpc activate --local --skip-amt-cert-check
```

!!! note "Debugging Use Only"
    The `config.yaml` approach stores configuration in **plaintext** and is intended for debugging and development. Do not use unencrypted profiles in production.

??? example "Full config.yaml Reference"

    This is the complete set of fields RPC-Go recognizes in `config.yaml`. Only populate the sections you need — unknown or unused fields are ignored.

    See the [source file on GitHub](https://github.com/device-management-toolkit/rpc-go/blob/main/config.yaml) for the latest version.

    ```yaml title="config.yaml"
    # ── Global Flags ──────────────────────────────────────────────────────────
    log-level: info              # trace|debug|info|warn|error|fatal|panic
    json: false                  # true => JSON output
    verbose: false               # true => force trace logging
    skip-cert-check: false       # true => skip TLS server cert verification (insecure)
    lmsaddress: localhost        # Local LMS host
    lmsport: "16992"             # Local LMS port (16992 HTTP / 16993 HTTPS)
    tenant-id: ""                # Multi-tenant identifier
    amt-password: ""             # Global AMT admin password

    # ── Server Auth ───────────────────────────────────────────────────────────
    auth-token: ""               # Bearer token (preferred)
    auth-username: ""            # Basic auth username (if no token)
    auth-password: ""            # Basic auth password (if no token)
    auth-endpoint: ""            # Optional token exchange endpoint override

    # ── amtinfo ───────────────────────────────────────────────────────────────
    amtinfo:
      userCert: false
      all: false
      ver: false
      bld: false
      sku: false
      uuid: false
      mode: false
      dns: false
      hostname: false
      lan: false
      ras: false
      operationalState: false
      sync: false               # Sync device info to server (requires url + auth)
      url: ""                   # Server endpoint for sync

    # ── activate ──────────────────────────────────────────────────────────────
    activate:
      local: false
      url: ""                   # Remote RPS or HTTP profile URL
      profile: ""               # Profile name (ws/wss) or file path
      proxy: ""                 # Proxy URL (ws/wss flows)
      key: ""                   # 32-character decryption key for encrypted profile
      dns: ""
      hostname: ""
      name: ""                  # Friendly name
      uuid: ""
      ccm: false
      acm: false
      stopConfig: false
      provisioningCert: ""      # Base64 provisioning cert (ACM)
      provisioningCertPwd: ""
      skipIPRenew: false        # Skip DHCP renew post activation

    # ── deactivate ────────────────────────────────────────────────────────────
    deactivate:
      url: ""
      profile: ""
      proxy: ""

    # ── configure ─────────────────────────────────────────────────────────────
    configure:
      amtpassword:
        newamtpassword: ""

      mebx:
        mebxpassword: ""

      amtfeatures:
        kvm: false
        sol: false
        ider: false
        userConsent: "all"      # kvm|all|none

      wired:
        dhcp: true
        ipsync: true
        ipaddress: ""
        subnetmask: ""
        gateway: ""
        primarydns: ""
        secondarydns: ""
        ieee8021xProfileName: ""
        ieee8021xUsername: ""
        ieee8021xPassword: ""
        ieee8021xAuthenticationProtocol: 0  # 0=EAP-TLS, 2=PEAPv0/EAP-MSCHAPv2
        ieee8021xPrivateKey: ""             # PEM
        ieee8021xClientCert: ""             # PEM
        ieee8021xCACert: ""                 # PEM
        eaAddress: ""                       # Enterprise Assistant
        eaUsername: ""
        eaPassword: ""

      wireless:
        purge: false
        profileName: ""
        ssid: ""
        priority: 1
        authenticationMethod: 6  # 4=WPA-PSK, 6=WPA2-PSK, 7=WPA2-IEEE8021x
        encryptionMethod: 4      # 3=TKIP, 4=CCMP
        pskPassphrase: ""
        ieee8021xProfileName: ""
        ieee8021xUsername: ""
        ieee8021xPassword: ""
        ieee8021xAuthenticationProtocol: 0
        ieee8021xPrivateKey: ""
        ieee8021xClientCert: ""
        ieee8021xCACert: ""

      tls:
        mode: "Server"          # Server|ServerAndNonTLS|Mutual|MutualAndNonTLS|None
        delay: 3
        eaAddress: ""
        eaUsername: ""
        eaPassword: ""

      proxy:
        list: false
        delete: false
        address: ""
        port: 80
        networkdnssuffix: ""

      sync-clock:

      sync-hostname:

      wifisync:
        oswifisync: true
        uefiwifisync: true
    ```

### 3. Flag-Based (CCM / ACM)

Pass `--local` with `--ccm` or `--acm` and provide the required flags directly on the command line.

#### CCM

```bash
rpc activate --local --ccm
```

You will be prompted for the AMT password, or provide it via `--password`.

#### ACM

```bash
rpc activate --local --acm --provisioningCert "{BASE64_PROV_CERT}" --provisioningCertPwd certPassword
```

### `activate` Flags

| Flag | Short | Description | Env Var |
|:-----|:------|:------------|:--------|
| `--local` | `-l` | Force local activation mode (flag-based). | |
| `--profile` | | Encrypted profile file path (`.yaml`) exported from Console. Requires `--key`. Triggers the profile orchestrator. | |
| `--ccm` | | Activate in Client Control Mode (flag-based only). | |
| `--acm` | | Activate in Admin Control Mode (flag-based only). | |
| `--provisioningCert` | | Provisioning certificate (base64 encoded). ACM only. | `PROVISIONING_CERT` |
| `--provisioningCertPwd` | | Provisioning certificate password. ACM only. | `PROVISIONING_CERT_PASSWORD` |
| `--mebxpassword` | | MEBx password for AMT 19+ TLS activation to ACM. | `MEBX_PASSWORD` |
| `--key` | `-k` | 32-character key to decrypt an encrypted profile file. Required with `--profile`. | `CONFIG_ENCRYPTION_KEY` |
| `--dns` | `-d` | DNS suffix override. | `DNS_SUFFIX` |
| `--hostname` | | Hostname override. | `RPC_HOSTNAME` |
| `--name` | | Friendly name to associate with this device. | |
| `--uuid` | | UUID override; prevents an MPS connection. | |
| `--skipIPRenew` | | Skip DHCP renewal after AMT is enabled. | |
| `--stopConfig` | | Transition AMT from in-provisioning to pre-provisioning state. Does not require AMT password. | |
| `--password` | | AMT admin password. If not provided, you are prompted when required. | `AMT_PASSWORD` |
| `--skip-amt-cert-check` | | Skip AMT/LMS TLS certificate verification. **Required for AMT 19+.** | |
| `--json` | `-j` | Output in JSON format. | |
| `--verbose` | `-v` | Enable verbose logging. | |
| `--log-level` | | Log level: `trace`, `debug`, `info`, `warn`, `error`, `fatal`, `panic`. Default: `info`. | |
| `--lmsaddress` | | LMS address. Default: `localhost`. | |
| `--lmsport` | | LMS port. Default: `16992`. | |

### Examples

=== "Linux/macOS"

    ```bash
    # ── Encrypted profile ────────────────────────────────────────────────────
    # Activate with encrypted profile
    rpc activate --profile ./myprofile.yaml --key "Jf3Q2nXJ+GZzN1dbVQms0wbB4+i/5PjL" --skip-amt-cert-check

    # Encrypted profile with key from env var
    export CONFIG_ENCRYPTION_KEY=Jf3Q2nXJ+GZzN1dbVQms0wbB4+i/5PjL
    rpc activate --profile ./myprofile.yaml --skip-amt-cert-check

    # ── config.yaml ──────────────────────────────────────────────────────────
    # Place config.yaml in the working directory, then:
    rpc activate --local --skip-amt-cert-check

    # ── Flag-based CCM ───────────────────────────────────────────────────────
    # CCM activation with password prompt
    rpc activate --local --ccm

    # CCM on AMT 19+ platform
    rpc activate --local --ccm --skip-amt-cert-check

    # CCM activation with inline password
    rpc activate --local --ccm --password NewAMTPassword

    # ── Flag-based ACM ───────────────────────────────────────────────────────
    # ACM activation with provisioning cert
    rpc activate --local --acm \
      --provisioningCert "{BASE64_PROV_CERT}" \
      --provisioningCertPwd certPassword

    # ACM activation with MEBx password (AMT 19+)
    rpc activate --local --acm \
      --provisioningCert "{BASE64_PROV_CERT}" \
      --provisioningCertPwd certPassword \
      --mebxpassword MEBxPassword

    # ── Other ────────────────────────────────────────────────────────────────
    # Stop in-provisioning state
    rpc activate --local --stopConfig
    ```

=== "Windows"

    ```powershell
    # ── Encrypted profile ────────────────────────────────────────────────────
    # Activate with encrypted profile
    rpc activate --profile .\myprofile.yaml --key "Jf3Q2nXJ+GZzN1dbVQms0wbB4+i/5PjL" --skip-amt-cert-check

    # Encrypted profile with key from env var
    $env:CONFIG_ENCRYPTION_KEY = "Jf3Q2nXJ+GZzN1dbVQms0wbB4+i/5PjL"
    rpc activate --profile .\myprofile.yaml --skip-amt-cert-check

    # ── config.yaml ──────────────────────────────────────────────────────────
    # Place config.yaml in the working directory, then:
    rpc activate --local --skip-amt-cert-check

    # ── Flag-based CCM ───────────────────────────────────────────────────────
    # CCM activation with password prompt
    rpc activate --local --ccm

    # CCM on AMT 19+ platform
    rpc activate --local --ccm --skip-amt-cert-check

    # CCM activation with inline password
    rpc activate --local --ccm --password NewAMTPassword

    # ── Flag-based ACM ───────────────────────────────────────────────────────
    # ACM activation with provisioning cert
    rpc activate --local --acm `
      --provisioningCert "{BASE64_PROV_CERT}" `
      --provisioningCertPwd certPassword

    # ACM activation with MEBx password (AMT 19+)
    rpc activate --local --acm `
      --provisioningCert "{BASE64_PROV_CERT}" `
      --provisioningCertPwd certPassword `
      --mebxpassword MEBxPassword

    # ── Other ────────────────────────────────────────────────────────────────
    # Stop in-provisioning state
    rpc activate --local --stopConfig
    ```

---

## deactivate

Deactivate the device locally.

```bash
rpc deactivate --local
```

### `deactivate` Flags

| Flag | Short | Description | Env Var |
|:-----|:------|:------------|:--------|
| `--local` | `-l` | Execute command to AMT directly without cloud interaction. | |
| `--partial` | | Partially unprovision the device. Only supported with `--local`. | |
| `--password` | | AMT admin password. If not provided, you are prompted when required. | `AMT_PASSWORD` |
| `--skip-amt-cert-check` | | Skip AMT/LMS TLS certificate verification. **Required for AMT v19+.** | |
| `--json` | `-j` | Output in JSON format. | |
| `--verbose` | `-v` | Enable verbose logging. | |
| `--log-level` | | Log level: `trace`, `debug`, `info`, `warn`, `error`, `fatal`, `panic`. Default: `info`. | |
| `--lmsaddress` | | LMS address. Default: `localhost`. | |
| `--lmsport` | | LMS port. Default: `16992`. | |

### Examples

```bash
# Full deactivation with password prompt
rpc deactivate --local

# Deactivation on AMT 19+ platform
rpc deactivate --local --skip-amt-cert-check

# Deactivation with inline password
rpc deactivate --local --password AMTPassword

# Partial unprovision
rpc deactivate --local --partial --password AMTPassword

# JSON output
rpc deactivate --local --password AMTPassword --json
```

---

## configure

Configure AMT settings on an activated device. All `configure` subcommands operate locally and no server connection is required. AMT password is required for all configure subcommands if AMT is already activated.

### Common Flags

These flags apply to all `configure` subcommands in addition to any subcommand-specific flags.

| Flag | Short | Description | Env Var |
|:-----|:------|:------------|:--------|
| `--password` | | AMT admin password. If not provided, you are prompted. | `AMT_PASSWORD` |
| `--skip-amt-cert-check` | | Skip AMT/LMS TLS certificate verification. **Required for AMT 19+.** | |
| `--json` | `-j` | Output in JSON format. | |
| `--verbose` | `-v` | Enable verbose logging. | |
| `--log-level` | | Log level: `trace`, `debug`, `info`, `warn`, `error`, `fatal`, `panic`. Default: `info`. | |
| `--lmsaddress` | | LMS address. Default: `localhost`. | |
| `--lmsport` | | LMS port. Default: `16992`. | |

### Subcommands

| Subcommand | Aliases | Description |
|:-----------|:--------|:------------|
| [amt-features](#amt-features) | `amtfeatures`, `setamtfeatures` | Configure AMT features (KVM, SOL, IDER, user consent). |
| [amt-password](#amt-password) | `amtpassword`, `changeamtpassword` | Change AMT password. |
| [mebx](#mebx) | `setmebx` | Configure MEBx password (ACM only). |
| [sync-clock](#sync-clock) | `syncclock`, `synctime` | Synchronize host OS clock to AMT locally or through RPS. |
| [wired](#wired) | `ethernet`, `addethernetsettings` | Configure wired ethernet settings. |
| [wireless](#wireless) | `addwifisettings` | Configure WiFi settings. |
| [tls](#tls) | `configuretls` | Configure TLS settings. |
| [cira](#cira) | | Configure Cloud-Initiated Remote Access (CIRA). |
| [wi-fi-sync](#wi-fi-sync) | `wifisync`, `wifi` | Control WiFi and local profile synchronization. |
| [proxy](#proxy) | `httpproxy` | Configure HTTP proxy access point for firmware-initiated connections. |
| [hostname](#hostname) | `synchostname`, `sethostname` | Synchronize host OS hostname and DNS suffix to AMT general settings. |
| [enable-amt](#enable-amt) | `enable-op-state`, `enable-operational-state` | Enable AMT operational state (requires unprovisioned state). |
| [disable-amt](#disable-amt) | `disable-op-state`, `disable-operational-state` | Disable AMT operational state (requires unprovisioned state). |

---

### amt-features

Configure AMT features: enable or disable redirection features (KVM, IDER, SOL) and set the user consent type.

!!! note "Control Mode and User Consent"
    User consent can only be configured if the device is activated in ACM mode. In CCM, user consent is set to `all` and cannot be changed.

```bash
rpc configure amt-features --kvm --sol --ider --userConsent none
```

| Flag | Description |
|:-----|:------------|
| `--kvm` | Enable KVM (Keyboard, Video, Mouse). If omitted, KVM will be disabled when other flags are also omitted. |
| `--sol` | Enable SOL (Serial-over-LAN). If omitted, SOL will be disabled when other flags are also omitted. |
| `--ider` | Enable IDER (IDE Redirection). If omitted, IDER will be disabled when other flags are also omitted. |
| `--userConsent` | User consent mode. Valid values: `kvm`, `all`, `none`. Default: `all`. **Only configurable if AMT is activated in ACM.** |

---

### amt-password

Change or update the AMT password locally. If `--newamtpassword` is not provided, you will be prompted.

!!! warning "`configure amt-password` vs server-based password change"
    `configure amt-password` is a **local-only** command. It does not update any centralized database. Make sure to take note of any changes made.

```bash
rpc configure amt-password --password CurrentAMTPassword --newamtpassword NewAMTPassword
```

| Flag | Description | Env Var |
|:-----|:------------|:--------|
| `--newamtpassword` | New AMT password to set. | `NEW_AMT_PASSWORD` |

---

### mebx

Configure the MEBx password. Only available for devices activated in ACM mode.

!!! warning "Local-Only: Store Passwords Securely"
    This is a local command. It does not communicate with a centralized database. Make sure to take note of any changes made.

!!! important "Strong Password Requirements"
    The MEBx password must meet strong password requirements:

    - 8 to 32 characters
    - At least one of each: uppercase letter, lowercase letter, numerical digit, and special character

```bash
rpc configure mebx --mebxpassword newMEBxPassword --password AMTPassword
```

| Flag | Description | Env Var |
|:-----|:------------|:--------|
| `--mebxpassword` | MEBx password to set. | `MEBX_PASSWORD` |

---

### sync-clock

Synchronize the host OS clock to AMT. Without `--url`, RPC synchronizes locally. With an RPS WebSocket URL, it requests remote time synchronization through RPS.

!!! note "Remote Synchronization"
  When `--url` is provided, the RPS server must be running and reachable. Omit `--url` to synchronize locally.

```bash
rpc configure sync-clock --password "$AMT_PASSWORD"
```

For remote synchronization, pass the RPS URL. The URL can also be set with `RPC_URL`.

```bash
sudo ./rpc configure sync-clock \
  --url wss://<rps-host>/activate \
  --password "$AMT_PASSWORD" \
  --log-level debug
```

| Flag | Short | Description | Env Var |
|:-----|:------|:------------|:--------|
| `--url` | `-u` | Server URL for remote time synchronization. Omit for local synchronization. | `RPC_URL` |

---

### hostname

Synchronize host OS hostname and DNS suffix to AMT general settings.

```bash
rpc configure hostname --password AMTPassword
```

No additional flags.

---

### tls

Configure TLS in AMT.

=== "Config File"

    RPC-Go loads `config.yaml` from the working directory. Put the TLS values under `configure.tls`.

    === "Using Enterprise Assistant"

        See [TLS Configuration using Enterprise Assistant and RPC-Go](../../EA/RPCConfiguration/localtlsconfig.md) for more details.

        === "YAML"

            ```yaml title="config.yaml"
            amt-password: AMTPassword
            configure:
              tls:
                mode: Server
                eaAddress: http://<YOUR-IPADDRESS-OR-FQDN>:8000
                eaUsername: eaUser
                eaPassword: eaPass
            ```

    === "Without Enterprise Assistant"

        A self-signed TLS certificate will be generated and used by AMT.

        === "YAML"

            ```yaml title="config.yaml"
            amt-password: AMTPassword
            configure:
              tls:
                mode: Server
            ```

    Run this command from the directory containing `config.yaml`:

    ```bash
    rpc configure tls
    ```

=== "Inline Flags"

    === "Using Enterprise Assistant"

        ```bash
        rpc configure tls --mode Server --password AMTPassword \
          --eaAddress http://<YOUR-IPADDRESS-OR-FQDN>:8000 \
          --eaUsername eaUser \
          --eaPassword eaPass
        ```

    === "Without Enterprise Assistant"

        ```bash
        rpc configure tls --mode Server --password AMTPassword
        ```

| Flag | Description |
|:-----|:------------|
| `--mode` | TLS authentication usage model. Valid values: `Server`, `ServerAndNonTLS`, `Mutual`, `MutualAndNonTLS`, `None`. Default: `Server`. |
| `--delay` | Delay time in seconds after applying remote TLS settings. Default: `3`. |
| `--eaAddress` | IP address or FQDN of Enterprise Assistant. |
| `--eaUsername` | Enterprise Assistant username. |
| `--eaPassword` | Enterprise Assistant password. |

---

### wired

Configure AMT wired ethernet settings for DHCP or Static IP. Optionally configure 802.1x.

=== "Config File"

    RPC-Go loads `config.yaml` from the working directory. Put the wired settings under `configure.wired`.

    === "DHCP"

        === "YAML"
            ```yaml title="config.yaml"
            amt-password: AMTPassword
            configure:
              wired:
                dhcp: true
                ipsync: true
            ```

    === "Static IP"

        === "YAML"
            ```yaml title="config.yaml"
            amt-password: AMTPassword
            configure:
              wired:
                dhcp: false
                ipaddress: 192.168.1.50
                subnetmask: 255.255.255.0
                gateway: 192.168.1.1
                primarydns: 8.8.8.8
                secondarydns: 4.4.4.4
            ```

    Run `rpc configure wired` from the directory containing `config.yaml`.

    #### with 802.1x

    !!! warning "Enterprise Assistant is not supported for wired 802.1x in v3"
        RPC-Go v3 does not retrieve wired 802.1x certificates from Enterprise Assistant. Supply the client certificate, CA certificate, and private key manually, as shown below.

    ```yaml title="config.yaml"
    amt-password: AMTPassword
    configure:
      wired:
        dhcp: true
        ipsync: true
        ieee8021xProfileName: exampleIeee8021xEAP-TLS
        ieee8021xUsername: exampleUserName
        ieee8021xAuthenticationProtocol: 0
        ieee8021xClientCert: "<client certificate PEM>"
        ieee8021xCACert: "<CA certificate PEM>"
        ieee8021xPrivateKey: "<private key PEM>"
    ```

=== "Inline Flags"

    !!! warning "Security: Inline Secrets"
        Passing secrets via command line is highly insecure and **NOT** recommended for production. Use environment variables or a config file instead. See the `Env Var` column in flag tables above for supported environment variables.

    ```bash
    # DHCP
    rpc configure wired --dhcp --ipsync --password AMTPassword

    # Static IP
    rpc configure wired \
      --ipaddress 192.168.1.50 \
      --subnetmask 255.255.255.0 \
      --gateway 192.168.1.1 \
      --primarydns 8.8.8.8 \
      --secondarydns 4.4.4.4 \
      --password AMTPassword
    ```

### `wired` Flags

| Flag | Description |
|:-----|:------------|
| `--dhcp` | Configure AMT wired settings to use DHCP. |
| `--ipsync` | Sync the IP configuration of the host OS to AMT network settings. |
| `--ipaddress` | Static IP address to assign to AMT. |
| `--subnetmask` | Subnet mask to assign to AMT. |
| `--gateway` | Default gateway to assign to AMT. |
| `--primarydns` | Primary DNS to assign to AMT. |
| `--secondarydns` | Secondary DNS to assign to AMT. |
| `--ieee8021xProfileName` | IEEE 802.1x profile name (alphanumeric). |
| `--ieee8021xAuthenticationProtocol` | 802.1x protocol. `0` = EAP-TLS, `2` = PEAPv0/EAP-MSCHAPv2. Alias: `--authenticationprotocol`. |
| `--ieee8021xUsername` | 802.1x username (must match Common Name of client cert). Alias: `--username`. |
| `--ieee8021xPassword` | 802.1x password (for PEAPv0/EAP-MSCHAPv2). |
| `--ieee8021xClientCert` | Client certificate (PEM format). Alias: `--clientcert`. |
| `--ieee8021xCACert` | CA certificate (PEM format). Alias: `--cacert`. |
| `--ieee8021xPrivateKey` | Private key (PEM format). Alias: `--privatekey`. |
| `--eaAddress` | IP address or FQDN of Enterprise Assistant. Wired 802.1x provisioning is not implemented. |
| `--eaUsername` | Enterprise Assistant username. Wired 802.1x provisioning is not implemented. |
| `--eaPassword` | Enterprise Assistant password. Wired 802.1x provisioning is not implemented. |

---

### wireless

Configure WiFi settings on an activated AMT device. On failure, certificates added before the error are rolled back.

=== "Config File"

    RPC-Go loads `config.yaml` from the working directory. Put the wireless settings under `configure.wireless`.

    ```yaml title="config.yaml"
    amt-password: AMTPassword
    configure:
      wireless:
        profileName: exampleWifiWPA2
        ssid: exampleSSID
        priority: 1
        authenticationMethod: 6
        encryptionMethod: 4
        pskPassphrase: "<WPA2 passphrase>"
    ```

    ```bash
    rpc configure wireless
    ```

    #### with 802.1x

    ```yaml title="config.yaml"
    amt-password: AMTPassword
    configure:
      wireless:
        profileName: exampleWifi8021x
        ssid: ssid
        priority: 1
        authenticationMethod: 7
        encryptionMethod: 4
        ieee8021xProfileName: exampleIeee8021xEAP-TLS
        ieee8021xAuthenticationProtocol: 0
        ieee8021xClientCert: "<client certificate PEM>"
        ieee8021xCACert: "<CA certificate PEM>"
        ieee8021xPrivateKey: "<private key PEM>"
    ```

    Run `rpc configure wireless` from the directory containing `config.yaml`.

=== "Inline Flags"

    !!! warning "Security: Inline Secrets"
        Passing secrets via command line is highly insecure and **NOT** recommended for production. Use environment variables or a config file instead. See the `Env Var` column in flag tables above for supported environment variables.

    ```bash
    # WPA2 PSK
    rpc configure wireless \
      --profileName myWifi \
      --ssid "networkSSID" \
      --authenticationMethod 6 \
      --encryptionMethod 4 \
      --pskPassphrase networkPass \
      --priority 1 \
      --password AMTPassword
    ```

### `wireless` Flags

| Flag | Description |
|:-----|:------------|
| `--profileName` | WiFi profile name (alphanumeric). |
| `--ssid` | WiFi SSID. |
| `--priority` | Ranked priority over other wireless profiles. Default: `1`. |
| `--authenticationMethod` | WiFi auth method. `4` = WPA-PSK, `6` = WPA2-PSK, `7` = WPA2-IEEE8021x. Default: `6`. |
| `--encryptionMethod` | WiFi encryption method. `3` = TKIP, `4` = CCMP. Default: `4`. |
| `--pskPassphrase` | WPA/WPA2 passphrase. |
| `--purge` | Purge all existing AMT wireless profiles and exit. |
| `--ieee8021xProfileName` | IEEE 802.1x profile name (alphanumeric). |
| `--ieee8021xAuthenticationProtocol` | 802.1x protocol. `0` = EAP-TLS, `2` = PEAPv0/EAP-MSCHAPv2. Alias: `--authenticationprotocol`. |
| `--ieee8021xUsername` | 802.1x username. Alias: `--username`. |
| `--ieee8021xPassword` | 802.1x password (for PEAPv0/EAP-MSCHAPv2). |
| `--ieee8021xClientCert` | Client certificate (PEM format). Alias: `--clientcert`. |
| `--ieee8021xCACert` | CA certificate (PEM format). Alias: `--cacert`. |
| `--ieee8021xPrivateKey` | Private key (PEM format). Alias: `--privatekey`. |

---

### cira

Configure Client-Initiated Remote Access (CIRA). This sets up a persistent TLS tunnel from AMT to the Management Presence Server (MPS).

```bash
rpc configure cira \
  --mpsaddress mps.example.com \
  --mpscert "BASE64_MPS_ROOT_CERT" \
  --password AMTPassword
```

| Flag | Description | Env Var |
|:-----|:------------|:--------|
| `--mpsaddress` | MPS address. **Required.** | `MPS_ADDRESS` |
| `--mpscert` | MPS root public certificate. **Required.** | `MPS_CERT` |
| `--mpspassword` | MPS password. | `MPS_PASSWORD` |
| `--envdetection` | Environment detection domains (comma separated). | `ENVIRONMENT_DETECTION` |
| `--generateRandomPassword` | Generate a random password for the MPS connection. | `GENERATE_RANDOM_PASSWORD` |

---

### wi-fi-sync

Control WiFi and local profile synchronization settings in AMT.

```bash
rpc configure wi-fi-sync --password AMTPassword
```

| Flag | Description | Default |
|:-----|:------------|:--------|
| `--oswifisync` | Enable/disable WiFi profile sync with the OS. | `true` |
| `--uefiwifisync` | Enable/disable UEFI WiFi profile share (if supported). | `true` |

---

### proxy

Configure HTTP proxy access point for firmware-initiated connections.

```bash
# Add a proxy
rpc configure proxy --address proxy.corp.com --port 8080 --networkdnssuffix corp.com --password AMTPassword

# List existing proxy settings
rpc configure proxy --list --password AMTPassword

# Delete a proxy by address
rpc configure proxy --delete --address proxy.corp.com --password AMTPassword
```

| Flag | Description | Default |
|:-----|:------------|:--------|
| `--list` | List existing HTTP proxy settings. | — |
| `--delete` | Delete a proxy access point by address. | — |
| `--address` | Proxy host or IP (IPv4/IPv6/FQDN). | — |
| `--port` | Proxy TCP port. | `80` |
| `--networkdnssuffix` | Network DNS suffix (domain) used for the access point. | — |

---

### enable-amt

Enable AMT operational state. Requires the device to be in pre-provisioning state.

```bash
rpc configure enable-amt
```

No additional flags. Aliases: `enable-op-state`, `enable-operational-state`.

---

### disable-amt

Disable AMT operational state. Requires the device to be in pre-provisioning state.

!!! warning "This command disables AMT"
    Running `disable-amt` turns off the AMT operational state entirely. If you later want to re-enable AMT using `enable-amt`, a **reboot** of the device may be required after running `disable-amt` before the enable command will take effect.

```bash
rpc configure disable-amt
```

No additional flags. Aliases: `disable-op-state`, `disable-operational-state`.
