
# Security Overview

Device Management Toolkit uses multiple layers of security to protect remote device management operations. This page provides an overview and links to detailed security information for each component.

## Authentication & Credentials

Device Management Toolkit uses multiple passwords to secure different layers of the system:

| Password | Purpose | Default | Where to Change |
| :-----------|:-------------- | :-------------- | :-------------- |
|**Intel MEBX Password** | Secures the Intel® MEBX / AMT BIOS menu on the device | `admin` | Set via a toolkit profile during activation, via RPC-Go, or manually in MEBX (Ctrl-P on older devices; integrated into BIOS on newer devices) |
|**Web UI / Console Password** | Authenticates admin access to the management interface | `standalone` / `G@ppm0ym` (or auto-generated) | `.env` file or `config.yml`. For production, use an OAuth provider (Auth0, Azure Entra AD, etc.) |
|**AMT Password** | Authenticates MPS/RPS/Console commands to Intel® AMT | Set during profile creation | Create a new profile or update via API |
|**Provisioning Certificate Password** | Protects the `.pfx` certificate used for ACM activation | Set during certificate export | Re-export certificate with new password |
|**MPS CIRA Credential** | Authenticates AMT devices connecting to MPS | Set during configuration | Create a new profile or update via API |

!!! warning "Change Default Credentials for Production"
    The default credentials shown above are for development and testing only. Always change default passwords before deploying to a production environment.

## Certificates

Certificates are used for secure communication and device provisioning:

- **[Provisioning Certificates](./remoteProvisioning.md)** — Used for ACM activation. Must be from a CA trusted by Intel® AMT.
- **[Custom Provisioning Certificates](../Reference/Certificates/generateProvisioningCert.md)** — For development environments using self-generated certificates.
- **[TLS Certificates](../Reference/Certificates/tls.md)** — Used for secure communication between components.
- **[Custom Certificate Enrollment via USB](../Reference/Certificates/enrollCustomCertAMT.md)** — Enroll certificates directly to AMT devices.

## Component Security

Each component has its own security considerations and configuration:

- **[MPS Security](../Reference/MPS/securityMPS.md)** — Allowlisting, API authentication, CIRA credential management
- **[RPS Security](../Reference/RPS/securityRPS.md)** — Profile security, provisioning certificate handling
- **[Console Security](../Reference/Console/securityConsole.md)** — Authentication, access control for the enterprise application

## Secrets Management

For production deployments, default secret storage should be replaced with enterprise-grade solutions:

- **[Production Vault Configuration](../Reference/productionVault.md)** — Configure HashiCorp Vault for production use
- **[Secrets Store Replacement](../Deployment/secrets.md)** — Replace the default Vault with Azure Key Vault, AWS KMS, or other providers

## Network Security

- **CIRA connections** use TLS encryption between AMT devices and MPS
- **Kong API Gateway** handles API authentication, rate limiting, and request validation
- **[SSL with Local Postgres](../Reference/sslpostgresLocal.md)** — Secure database connections

## Learn More

- [Architecture & Components](./architecture.md) — How the toolkit components work together
- [Control Modes](./controlModes.md) — ACM vs CCM security implications
- [Deployment Overview](../Deployment/overview.md) — Production deployment considerations
