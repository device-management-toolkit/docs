

The Remote Provisioning Client (RPC-Go) is a Go-based application that runs directly on a managed device and activates Intel® AMT.

RPC-Go supports two primary deployment models:

1. **Cloud deployment (RPS-driven activation)** – RPC-Go acts as a proxy between the Remote Provisioning Server (RPS) and Intel® AMT. This flow is commonly used to configure AMT so that the device can establish a Client Initiated Remote Access (CIRA) connection to the Management Presence Server (MPS).

2. **Local deployment** – RPC-Go consumes an exported AMT profile (YAML) and applies it directly on the device. This does not require RPS and is well suited for Console-based workflows, flat networks, or environments where cloud connectivity is not desired.

---

## Activation Flows

### 1. Activation via Remote Provisioning Server (RPS)

In this flow:

1. RPC-Go connects to RPS over a secure WebSocket connection.
2. RPS orchestrates the WS-Management (WSMAN) sequence required to configure and activate Intel® AMT.
3. RPC-Go relays those commands to AMT through the MEI (HECI) driver or Intel® Local Management Service (LMS).
4. Once activated and configured, AMT establishes a CIRA tunnel to MPS.

<figure class="figure-image">
<img src="../../../assets/images/RPC_Overview.png" alt="Figure 1: RPC Configuration">
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
- For v3.x configuration details and CLI options: [v3.x CLI – Work in Progress](./v3/about-v3.md)
