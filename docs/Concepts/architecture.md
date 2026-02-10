
# Architecture & Components

Figure 1 illustrates the high-level architecture of Device Management Toolkit microservice architecture.

<figure class="figure-image">
  <img src="..\..\assets\images\diagrams\CloudArchitecturalFlow.svg" style="height:800px" alt="Figure 1: Deploy Device Management Toolkit">
  <figcaption>Figure 1: Deploy Device Management Toolkit</figcaption>
</figure>

## Deployment Flow

1. **Deploy Microservices** - Install the microservices on a development system as Docker* containers, which can run locally or on the cloud.
2. **Deploy RPC Architecture** - Transfer the lightweight clients to managed devices.
3. **Configure AMT** - Through the RPS, configure AMT by creating control mode profile(s).
4. **Connect AMT** - Use the MPS to manage connectivity, as this microservice listens for the call home messaging of managed devices.
5. **Issue AMT Command** - Send power commands (e.g., power off) through the MPS.
6. **Add AMT functionality** - Explore the additional functionality provided by Device Management Toolkit to develop your own web console or application.

## Components

1. **MPS (Management Presence Server)** - A cloud-hosted microservice that acts as the server for CIRA connections. Remote AMT devices call home to MPS and maintain a persistent, encrypted connection, enabling out-of-band manageability features such as power control and Keyboard, Video, Mouse (KVM) control — even when devices are behind firewalls or NAT.
2. **RPS (Remote Provisioning Server)** - A microservice that activates Intel® AMT platforms using predefined profiles and connects them to the MPS for manageability use cases.
3. **RPC (Remote Provisioning Client)** - A lightweight client application that communicates with the RPS server to activate Intel® AMT.
4. **UI Toolkit** - A toolkit that includes prebuilt React components and a reference implementation web console. The React-based snippets simplify the task of adding complex manageability-related UI controls, such as the KVM, to a console.
5. **Sample Web UI** - A web based UI that demonstrates how to use the UI-Toolkit. It also provides a way to interact with the microservices and to help provide context as to how each microservice is used.
6. **Console** - A standalone application for the Enterprise deployment path. Console connects directly to AMT devices on a trusted local or private network, providing device management features including activation, KVM, SOL, and power control without requiring MPS or RPS.

## Connection Models

Device Management Toolkit supports two connection models depending on your deployment path.

### CIRA (Client Initiated Remote Access) — Cloud Path

CIRA is designed for managing devices that are behind firewalls, NAT, or otherwise unreachable from the internet — such as ATMs, kiosks, digital signage, and other edge devices in the field. With CIRA, the **AMT device is the client** — it initiates an outbound connection to the MPS server in the cloud.

The following steps occur via a CIRA channel:

1. A remote Intel vPro® Platform featuring Intel® AMT is activated and a CIRA configuration is applied. The remote platform is referred to as the managed device.

2. The managed device initiates a connection to MPS and establishes an encrypted tunnel using Transport Layer Security (TLS).

3. The Intel vPro® Platform maintains a persistent connection with MPS through small *keep-alive* messages, ensuring the device is always reachable.

4. A management console sends a command to MPS via its RESTful APIs, indicating that the managed device should take some action.

5. MPS authenticates the request and proxies the command through the established CIRA tunnel to the managed device.

### Direct Connection — Enterprise Path

With Console, the connection model is reversed: **AMT is the server** and **Console is the client**. Console connects directly to the AMT device over a trusted local or private network. This is suited for on-premises environments where devices are on the same network and directly reachable.

## Learn More

- [OOB Management](./oobManagement.md) — What out-of-band management is and why it matters
- [Control Modes](./controlModes.md) — ACM vs CCM and their implications
- [Security](./security.md) — Passwords, certificates, and hardening
