# CIRA (Client Initiated Remote Access)

CIRA lets a CIRA-capable AMT device open and maintain a persistent connection to Console, so it can be managed even when it is behind NAT or a firewall. Console can run with CIRA enabled or disabled.

## Configure CIRA

CIRA is controlled by two settings. Change them in `.env` (or `config.yml`) and restart Console:

| `.env` Variable | Default | Purpose |
|---|---|---|
| `APP_DISABLE_CIRA` | `true` | `true` disables CIRA; set to `false` to enable it. |
| `APP_COMMON_NAME` | Host IP | Address devices use to reach Console; becomes the Common Name on the CIRA certificate. |

```bash
APP_DISABLE_CIRA=false
APP_COMMON_NAME=192.168.69.253
```

!!! note "Defaults"
    CIRA is **disabled by default**. When enabled, Console listens on TCP `:4433` (a fixed port, not configurable) and presents a certificate whose Common Name is `APP_COMMON_NAME`, so the device's MPS address must match it.

## When CIRA is disabled

- The CIRA Configs and certificate endpoints return **404**. Clients can check `GET /api/v1/server/features` (`ciraEnabled`).
- A profile that uses CIRA cannot be created, updated, or exported (**400**).
- The web UI hides the CIRA Configs tab and the CIRA connection mode for new profiles.

## Existing CIRA profiles

A profile created while CIRA was enabled is kept, but it cannot be exported or activated while CIRA is disabled. Re-enable CIRA, or change the profile's connection mode to TLS or Direct, to use it again.
