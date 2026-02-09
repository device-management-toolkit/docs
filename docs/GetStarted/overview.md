

There are two main ways to utilize the tools and services within Device Management Toolkit, **Cloud or Enterprise**.

## Which Path Should I Choose?

| | Cloud | Enterprise |
|:--|:--|:--|
| **Best for** | Developers integrating AMT into existing management consoles via APIs | IT admins managing devices directly through a standalone application |
| **Connection Model** | CIRA — AMT devices initiate outbound connections to MPS in the cloud (works through firewalls/NAT) | Direct — Console connects to AMT devices on a trusted local/private network |
| **Components** | MPS + RPS + Sample Web UI (microservices) | Console (single application) |
| **API Access** | Full REST APIs for MPS and RPS | REST APIs + UI + headless mode |
| **Network** | Devices can be remote/distributed across networks | Devices typically on the same network or reachable directly |
| **Scaling** | Supports Docker Swarm, Kubernetes (AKS, EKS) | Designed for direct device management |
| **Deployment** | Docker containers, Kubernetes, or native | Single application download |

**Choose Cloud if** you want to integrate AMT capabilities into your own software, need to manage devices behind firewalls or across distributed networks (e.g., ATMs, kiosks, edge devices), or plan to scale to many devices.

**Choose Enterprise if** you want a ready-to-use management application for devices on your trusted local or private network without needing to build custom integrations.

## Cloud

The recommended cloud deployment deploys services with exposed APIs that can be used for device management (MPS) and device activation and configuration (RPS). Using these APIs, developers can integrate Intel® AMT features into their own management console solution. These services can be deployed as containers, Kubernetes pods/clusters, or natively.

For the cloud, AMT devices use a feature called CIRA, or **C**lient **I**nitiated **R**emote **A**ccess. With CIRA, AMT devices will securely reach out to a management server and maintain a persistent connection to the cloud-based server.

[Read more about the services and the Cloud type of deployment here.](../Reference/architectureOverview.md)

[Get Started Now](./Cloud/prerequisites.md){: .md-button .md-button--primary }

<figure class="figure-image">
  <img src="..\..\assets\images\diagrams\CloudArchitecturalFlow.svg" style="width:100%;height:1000px;" alt="Figure 1: Cloud Architecture Overview">
  <figcaption>Figure 1: Cloud Architecture Overview</figcaption>
</figure>

<br>

## Enterprise

The recommended enterprise deployment utilizes Console, an application that provides a 1:1, direct connection for AMT devices. Users can add activated AMT devices to access device information and device management features.

An edge application, RPC-Go, can perform activation and configuration of Intel AMT locally. Using Enterprise Assistant, RPC-Go can also securely configure 802.1x and TLS, if required, based on existing network requirements.

[Read more about Console and the Enterprise type of deployment here.](../Reference/Console/overview.md)

[Get Started Now](./Enterprise/setup.md){: .md-button .md-button--primary }

<figure class="figure-image">
  <img src="..\..\assets\images\diagrams\Console.svg" style="height:800px;" alt="Figure 2: Enterprise Architecture Overview">
  <figcaption>Figure 2: Enterprise Architecture Overview</figcaption>
</figure>

<br>