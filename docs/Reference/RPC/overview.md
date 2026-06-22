

The Remote Provisioning Client (RPC-Go) is a Go-based application that runs directly on a managed device and activates Intel® AMT.

RPC-Go supports two primary deployment models:

1. **Server-driven activation** – RPC-Go acts as a **proxy** between a server (Console or RPS) and Intel® AMT. All orchestration logic resides on the server — RPC-Go simply relays WSMAN commands between the server and AMT. This flow is commonly used to configure AMT so that the device can establish a Client Initiated Remote Access (CIRA) connection to the Management Presence Server (MPS).

2. **Local deployment** – RPC-Go applies configuration directly to Intel® AMT on the device, without requiring a server at runtime. RPC-Go consumes an exported AMT profile (YAML) and executes the provisioning sequence locally. This is well suited for flat networks or environments where cloud connectivity is not desired.

---

## Activation Flows

### 1. Server-Driven Activation (Console or RPS)

In this flow, RPC-Go acts purely as a **proxy** — all activation and configuration logic resides on the server:

1. RPC-Go connects to the server (Console or RPS) over a secure WebSocket connection.
2. The server orchestrates the WS-Management (WSMAN) sequence required to configure and activate Intel® AMT.
3. RPC-Go relays those commands to AMT through the MEI (HECI) driver or Intel® Local Management Service (LMS).
4. Once activated and configured, AMT establishes a CIRA tunnel to MPS.

<figure class="figure-image">
<img src="../../../assets/images/diagrams/RPC_Overview.svg" alt="Figure 1: RPC Configuration">
<figcaption>Figure 1: RPC Configuration</figcaption>
</figure>

---

### 2. Local Activation Using a Profile (`config.yaml` / profile YAML)

RPC-Go can also perform activation and configuration **locally**, without relying on RPS at runtime.

Typical flow:

1. A profile is created in the Console or RPS UI (e.g., ACM/CCM, network settings, CIRA config).
2. The profile is exported as YAML (encrypted profile).
3. RPC-Go is run on the managed device with that profile.
4. RPC-Go applies the profile to AMT through the MEI driver or Intel® LMS.

This model is useful for environments where profiles are pre-generated, RPS is **not required**, or a local-only provisioning workflow is preferred.

---

## Which Version Should I Use?

!!! tip "Version Guidance"
    **Use v2.x for production.** It is the current stable release with full documentation and support.

    **v3.x is in Beta** and available for early testing and feedback. It introduces a clearer configuration model, standardized CLI flags, and a faster local activation workflow. See [About v3](./v3/about-v3.md) for details.

    v2.x remains fully supported while v3.x is in Beta. All existing activation flows, encrypted profiles, and RPS interactions work in both versions.

| | v2.x | v3.x (Beta) |
|:--|:--|:--|
| **Status** | Stable, production-ready | Beta, subject to change |
| **CLI Flags** | `-configv2`, mixed flag styles | `--profile`, standardized `--`/`-` flags |
| **Activation** | RPS-driven and local profile | RPS-driven, local profile, and direct profile export from Console/RPS |
| **Documentation** | Complete | In progress |

## Related Topics

- [Build RPC-Go Manually](./buildRPC_Manual.md)
- For v2.x configuration details and CLI options: [v2.x CLI](./v2/commandsRPC.md)
- For v3.x CLI reference:
    - [About v3](./v3/about-v3.md) — What changed and migration guide
    - [Commands Overview](./v3/commands.md)
    - [Server Mode CLI](./v3/commandsServer.md) — RPS-driven activation, deactivation, maintenance 
    - [Local Mode CLI](./v3/commandsLocal.md) — Local activation, configure
    - [Info and Diagnostics](./v3/commandsInfo.md) — amtinfo, diagnostics, version
