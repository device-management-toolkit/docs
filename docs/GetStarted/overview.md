

There are two main ways to utilize the tools and services within Device Management Toolkit, **Cloud or Enterprise**.

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