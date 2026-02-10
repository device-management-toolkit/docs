
# Tutorials

Get hands-on with Device Management Toolkit through guided tutorials. Each tutorial walks through a specific feature or integration scenario.

## Device Features

### UI Toolkit Redirection Modules
Add prebuilt React components for redirection features like Keyboard, Video, Mouse (KVM) and Serial-over-LAN (SOL) to your own web console.

[Get Started with the UI Toolkit](./uitoolkitReact.md){: .md-button .md-button--primary }

### IDE-Redirection (IDER)
Remotely mount disk images on Intel AMT devices for tasks like OS recovery and re-installation.

!!! note
    IDER requires ACM activation. The toolkit provides IDER support through the Sample Web UI.

[Explore IDE-Redirection](./ideRedirection.md){: .md-button .md-button--primary }

### One Click Recovery (OCR)
Configure and use One Click Recovery to reimage devices remotely.

[Explore OCR](./ocrTutorial.md){: .md-button .md-button--primary }

## Integration

### REST API Call
Learn how to generate a JWT token for Authorization and construct API calls to manage devices using curl.

!!! note "Prerequisite"
    Requires the Cloud deployment path (MPS and RPS).

[Get Started with REST APIs](./apiTutorial.md){: .md-button .md-button--primary }

### Modify User Authentication
Customize the authentication flow for the Sample Web UI and MPS APIs.

[Modify User Auth](./modifyUserAuth.md){: .md-button .md-button--primary }

### Localization
Add language support to Console or the Sample Web UI.

- [Console Localization](./Localization/consoleLocalization.md)
- [Sample Web UI Localization](./Localization/webuiLocalization.md)

## Network Configuration

### Wireless Activation
Configure wireless (WiFi) profiles for AMT devices, including 802.1x enterprise wireless.

[Set Up Wireless](./createWiFiConfig.md){: .md-button .md-button--primary }

## Infrastructure & Scaling

### Scaling Overview
Deploy Device Management Toolkit at scale using Docker Swarm, Kubernetes (local, AKS, EKS), or service mesh configurations.

!!! note "Prerequisite"
    Requires the Cloud deployment path.

[Explore Scaling Options](./Scaling/overview.md){: .md-button .md-button--primary }
