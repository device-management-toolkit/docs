## Frequently Asked Questions

### How are releases managed for Cloud-Deployment services in Device Management Toolkit?

Cloud-Deployment services follows a Rolling Release model with the 2.x series, which also serves as our Long-Term Support (LTS) version. Each tagged release is kept up-to-date with the latest features, security fixes, and improvements. Customers benefit from continuous updates and support, ensuring a secure and feature-rich experience without the need to wait for separate release cycles. Currently, that is version 2.x.

We may decide to break off a 3.0 version at which point we will communicate support for 2.x at that time. 

<br>

### How does versioning work with Cloud-Deployment services in Device Management Toolkit?

Device Management Toolkit follows [SemVer](https://semver.org/) practices for versioning. This means:

- Major Version Increment - Breaking Changes (ex: 2.0.0 -> 3.0.0)
- Minor Version Increment - New Features (ex: 2.0.0 -> 2.1.0)
- Patch Version Increment - Security and Bug Fixes (ex: 2.0.0 -> 2.0.1)

All microservices with the same minor version should be compatible.

The separate repos for microservices and libraries are versioned individually. These versions are separate from the `cloud-deployment` repo version.  The `cloud-deployment` repo is where we have the monthly release. This repo might carry a higher version than some of the individual repos but is tagged as `{Month} {Year}`. All sub-repos referenced within `cloud-deployment` for a specific release are guaranteed to be compatible.

<br>

### What versions of Intel&reg; AMT are supported?

Device Management Toolkit aligns to the Intel Network and Edge (NEX) Group support roadmap for Intel vPro&reg; Platform and Intel&reg; AMT devices. This is currently calculated as `Latest AMT Version - 7`.

<br>

### How do I migrate to a new release of Cloud-Deployment?

Resources and information for migrating releases for either a Kubernetes deployment or local Docker deployment can be found in the [Upgrade Toolkit Version documentation](../Deployment/upgradeVersion.md).

<br>

### Will there be any changes to Cloud-Deployment services following the release of Console v1.0?

No changes are currently planned. We will continue supporting our Cloud-Deployment services.

<br>

### What is the long-term vision for MPS and RPS services following the release of Console v1.0?

- Our long-term vision is for Console to support both Enterprise and Cloud deployments, reducing the number of services we need to maintain.
- As part of this vision, Console will take on the functions of both MPS and RPS. It will handle AMT connections and expose REST APIs to enable AMT features, similar to MPS. It will also manage profile creation, similar to RPS.
- Furthermore, RPC-Go will be utilized for the configuration and activation of AMT, improving efficiency and reducing the need for a full provisioning service on the backend.
- Consolidating these services into Console reduces our codebase and simplifies maintenance now with a smaller team.

<br>

### What is a Pre-Release Feature?

Sometimes, newer features may be available as **pre-release**. These are features that are still in-development and subject to change. The team opts to make these available for early feedback. These may have limited functionality or potentially even bugs. When the feature is mature and fully validated, it will move from a **pre-release** state to a full release.

<br>

### How do I find more information about the MPS and RPS configuration files and security details?

Details and descriptions of configuration options can be found in [MPS Configuration](./MPS/configuration.md) and [RPS Configuration](./RPS/configuration.md).

Security information can be found in [MPS Security Information](./MPS/securityMPS.md) and [RPS Security Information](./RPS/securityRPS.md).

<br>