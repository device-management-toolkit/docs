## Frequently Asked Questions

### Why was the `cloud-deployment` repository renamed to `deployment`?

The repository was renamed to better reflect its long-term direction.

While the original focus was cloud deployments, the repository is evolving to support multiple deployment models, including both on-premises and cloud deployments, from a common deployment framework.

The current production deployment assets remain available on the [`v2` branch](https://github.com/device-management-toolkit/deployment/tree/v2), while new deployment capabilities are actively being developed on the `main` branch.


### How are releases managed for the Deployment repository?

The `deployment` repository follows a rolling release model.

The current production deployment assets are maintained on the [`v2` branch](https://github.com/device-management-toolkit/deployment/tree/v2), which continues to receive updates, bug fixes, security improvements, and support for existing deployment scenarios.

Development of the next generation deployment experience takes place on the `main` branch, where we are expanding support for both on-premises and cloud deployment models. As new capabilities mature, they will become part of future monthly releases.

If we introduce a future major version, we will communicate the support lifecycle and migration guidance for existing deployments at that time.


### How does versioning work with the Deployment repository?

Device Management Toolkit follows [SemVer](https://semver.org/) practices for versioning. This means:

-   **Major Version Increment** - Breaking Changes (ex: 2.0.0 → 3.0.0)
-   **Minor Version Increment** - New Features (ex: 2.0.0 → 2.1.0)
-   **Patch Version Increment** - Security and Bug Fixes (ex: 2.0.0 → 2.0.1)

All microservices with the same minor version should be compatible.

Individual microservices and libraries continue to be versioned independently.

The `deployment` repository itself is released monthly and tagged using the `{Month} {Year}` format. Each monthly release references a validated set of compatible component versions, ensuring all services work together as a supported deployment.


### What versions of Intel® AMT are supported?

Device Management Toolkit aligns with the Intel Edge Computing Group support roadmap for Intel vPro® Platform and Intel® AMT devices. This is currently calculated as **Latest AMT Version - 7**.


### How do I migrate to a new Deployment release?

Migration resources for both Kubernetes and local Docker deployments can be found in the [Upgrade Toolkit Version documentation](../Deployment/upgradeVersion.md).

The current production deployment assets are available on the [`v2` branch](https://github.com/device-management-toolkit/deployment/tree/v2). Future deployment capabilities will continue to be introduced through the `main` branch as they become available.


### What is the difference between the `v2` and `main` branches in the Deployment repository?

The [`v2` branch](https://github.com/device-management-toolkit/deployment/tree/v2) contains the current supported deployment assets and continues to receive updates, bug fixes, security improvements, and ongoing support.

The `main` branch is where new deployment capabilities are actively being developed, including support for both on-premises and cloud deployment scenarios. As these capabilities mature, they will become part of future monthly releases.

Existing deployments should continue using the `v2` branch unless you are evaluating new functionality under active development.


### What is the long-term vision for MPS and RPS services?

Our long-term vision is to simplify deployment by reducing the number of backend services required to manage Intel® AMT devices.

Over time, Console will continue to absorb functionality currently provided by standalone services where it makes architectural and operational sense, while maintaining compatibility with existing deployment models during the transition.

RPC-Go will continue evolving as the primary endpoint orchestration tool for Intel® AMT configuration, activation, and management, further simplifying deployment architectures and reducing the need for dedicated backend provisioning services.


### What is a Pre-Release Feature?

Sometimes, newer features may be available as **pre-release**. These are features that are still under development and subject to change. We make these available early to gather customer feedback and validate new functionality.

Pre-release features may have limited functionality or known issues. Once they have matured and completed validation, they will transition to fully supported features.


### How do I find more information about the MPS and RPS configuration files and security details?

Configuration documentation can be found here:

-   [MPS Configuration](./MPS/configuration.md)
-   [RPS Configuration](./RPS/configuration.md)

Security documentation can be found here:

-   [MPS Security Information](./MPS/securityMPS.md)
-   [RPS Security Information](./RPS/securityRPS.md)