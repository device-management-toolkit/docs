

RPC-Go v3.x introduces a faster activation workflow and a clearer configuration model.  
In addition to the existing RPS-driven proxy flow, v3.x adds support for retrieving an encrypted AMT profile directly from the Console or RPS and applying it locally on the device. This significantly improves activation speed, especially in environments where RPS is not required. See the **What Changed in v3.x** section below for more details.

v3.x also addresses several long-standing inconsistencies in the configuration and CLI structure:

- The terms `config`, `configv2`, and `profile` were often confused.
- CLI flags were not fully consistent.
- Application configuration and provisioning configuration were mixed together.

The goal of v3.x is clarity, consistency, and ease of use—improving how RPC-Go is configured and executed without changing its underlying activation and configuration capabilities.

!!! important "v2.x is fully supported — no immediate action required"
    RPC-Go v2.x continues to work exactly as before.  
    All existing activation flows, encrypted profiles, and RPS interactions remain fully supported.  
    You may stay on v2.x without upgrading until you are ready.

    This guide is only relevant if you want to understand the improvements in v3.x or plan to adopt it.

## What Changed in v3.x

v3.x introduces a set of targeted improvements designed to simplify configuration and improve usability.

### 1. Improved Activation Workflow (Faster Local Activation)

In earlier versions, RPC-Go (and before that, the C-based RPC) primarily acted as a proxy between the Remote Provisioning Server (RPS) and Intel® AMT. RPS determined the sequence of WSMAN messages required for activation, and RPC-Go relayed them to Intel® AMT over a secure WebSocket connection. This RPS-driven flow remains fully supported in v3.x.

What v3.x adds is the ability for RPC-Go to directly call the encrypted profile export endpoint:

```
https://<RPS or Console Host>/api/v1/admin/profiles/export/<profile-name>?domainName=<domain-profile-name>
```

RPC-Go can authenticate using either username/password or an auth-token, retrieve the encrypted profile, and orchestrate Intel® AMT activation **locally on the device**.  
This results in **faster and more efficient activation** compared to the legacy proxy model.

This new workflow currently requires some additional configuration (endpoints, tokens, auth settings), and we plan to simplify it in future releases. This is also why v3.x remains in Beta—we want to incorporate customer feedback and ensure the workflow becomes easier as it evolves.

If you prefer the traditional RPS-driven model, you can continue using it in both v2.x and v3.x.

### 2. Clear Separation of “Application Config” vs “Provisioning Profile”

- `config.yaml` → now used **only** for application/runtime settings  
  (endpoints, authentication, logging, defaults, etc.)
- `profile` → now the explicit name for provisioning configuration  
  (AMT activation, CIRA, CCM/ACM, network settings)

### 3. Standardized CLI Flags

Long flags now use `--`  
Short flags use `-`

Examples:

```bash
--profile
--config
-p
-c
```

This brings RPC-Go in line with modern CLI conventions and makes scripts cleaner.

### 4. Removal of Legacy `configv2`

The old provisioning flag:

```
--configv2
```

has been removed.

Use:

```
--profile
```

instead.

## Migration Guide (v2.x → v3.x)

### Before (v2.x)

```bash
rpc-go configure --configv2 ./profile.yaml
```

### After (v3.x)

```bash
rpc-go configure --profile ./profile.yaml
```

Short form:

```bash
rpc-go configure -p ./profile.yaml
```

## What Stays the Same in v3.x

- Encrypted profiles remain supported (same format as v2.x).
- RPS-driven activation works the same as in v2.x.
- Local profile-driven activation works the same, with clearer terminology.

## Support Policy

- **v2.x remains supported** while v3.x is in Beta.  
- All v2.x documentation and workflows remain valid.  
- New enhancements will primarily target v3.x going forward.

