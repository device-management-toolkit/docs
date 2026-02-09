

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

## Component Summary

1. **MPS** - A cloud-hosted microservice that acts as the server for CIRA connections. Remote AMT devices call home to MPS and maintain a persistent, encrypted connection, enabling out-of-band manageability features such as power control and Keyboard, Video, Mouse (KVM) control — even when devices are behind firewalls or NAT.
2. **RPS** - A microservice that activates Intel® AMT platforms using predefined profiles and connects them to the MPS for manageability use cases.
3. **RPC** - A lightweight client application that communicates with the RPS server to activate Intel® AMT.
4. **UI Toolkit** - A toolkit that includes prebuilt React components and a reference implementation web console. The React-based snippets simplify the task of adding complex manageability-related UI controls, such as the KVM, to a console.
5. **Sample Web UI** - A web based UI that demonstrates how to use the UI-Toolkit. It also provides a way to interact with the microservices and to help provide context as to how each microservice is used.
6. **Console** - A standalone application for the Enterprise deployment path. Console connects directly to AMT devices on a trusted local or private network, providing device management features including activation, KVM, SOL, and power control without requiring MPS or RPS.

## Learn More

For detailed explanations of the concepts behind Device Management Toolkit:

- **[OOB Management](../Concepts/oobManagement.md)** — What out-of-band management is, in-band vs OOB, power control, KVM
- **[Control Modes](../Concepts/controlModes.md)** — ACM vs CCM, domains, user consent
- **[Security](../Concepts/security.md)** — Passwords, certificates, secrets management, and hardening
- **[Logging](./logging.md)** — Log levels and Docker log access
