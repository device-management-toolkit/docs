
# Prerequisites

This section contains prerequisites for deploying Device Management Toolkit's MPS and RPS microservices on a local development system as Docker* containers. 

<div style="text-align:center;">
  <iframe width="600" height="337" src="https://www.youtube.com/embed/Nuwm4SxbvjA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  <figcaption><b>Getting Started Part 1</b>: Follow along to learn about the prerequisites, environment configuration, and using Docker to get your stack started. <b>Additional Resources: </b><a href="https://www.intel.com/content/www/us/en/developer/topic-technology/edge-5g/hardware/vpro-platform-retail.html">Intel vPro Platform</a></figcaption>
</div>

## What You'll Need

### Hardware

**Configure a network that includes:**

-  A development system 
-  At least one Intel vPro® Platform
-  A flash drive or equivalent means to transfer files between

Both systems must use a wired (i.e., cable) connection on the same network.

### Development System Software

**Before MPS and RPS installation, install the following software on your development system:**

- [git*](https://git-scm.com/downloads)
- [Docker* for Windows*](https://docs.docker.com/desktop/install/windows-install/) or [Docker* for Linux*](https://docs.docker.com/desktop/install/linux-install/)

**For RPC setup, install the following software on your development system:**

* [Go* Programming Language](https://go.dev/)

<br>

## What You'll Do

<figure class="figure-image">
  <img width="800" height="450" src="..\..\..\assets\images\diagrams\LocalDockerWorkflow.svg" alt="Figure 1: Deploy microservices on a local development system as Docker containers">
  <figcaption>Figure 1: Deploy microservices on a local development system as Docker containers</figcaption>
</figure>

**To complete a deployment:**

- Install the prerequisites.
- Pull and deploy microservices with Docker.
- Login to the Sample Web UI and configure profiles.
- Download RPC.
- Copy RPC to a managed device.


**To connect the managed device:**

- Run RPC on a managed device.
- Manage the device with MPS through the Sample Web UI.

These sections include instructions for Windows and Linux* environments. Run instructions in a terminal window, the Windows Command Prompt in Administrator mode or the Linux shell/terminal.

## Why Docker*?

A Docker container is the instantiation of a Docker image as a virtualized unit that separates the application from the environment. Docker containers start and run reliably, securely, and portably inside different environments, eliminating some of the problems that occur with software deployment on varying platforms. Docker streamlines installation to get you up and running faster.

Get more information about Docker images and containers at [Docker resources.](https://www.docker.com/resources/what-container)   

## Next up
[**Setup - Pull Docker* Images**](setup.md)

