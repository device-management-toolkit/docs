
# Control Modes

Managed devices featuring Intel® AMT support two control modes that determine the level of access and user consent requirements.

## Admin Control Mode (ACM)

In this mode, there are no limitations to Intel® AMT functionality. This reflects the higher level of trust associated with these setup methods. No user consent is required.

**Key characteristics:**

- Full access to all Intel® AMT features
- User consent is optional (can be configured to none, KVM only, or all)
- Requires a provisioning certificate from a trusted Certificate Authority
- Requires a Domain Profile with matching DNS suffix
- Recommended for production environments, especially IoT/edge devices without physical access

**Available features without user consent:**

- Keyboard, Video, Mouse (KVM) Control
- Serial-over-LAN (SOL)
- IDE-Redirection (IDER)
- All power actions

## Client Control Mode (CCM)

This mode limits some of Intel® AMT functionality, reflecting the lower level of trust. CCM is simpler to set up as it does not require a provisioning certificate.

**Key characteristics:**

- Most Intel® AMT features are available
- User consent is **required** for redirection features
- No provisioning certificate needed
- Simpler setup process
- Suitable for development, testing, and environments where physical access is available

**Features requiring user consent in CCM:**

- Keyboard, Video, Mouse (KVM) Control
- Serial-over-LAN (SOL)
- IDE-Redirection (IDER)

When performing a KVM or SOL action for a device activated in CCM, a user consent code is displayed on the managed device's screen that must be entered to proceed.

## Choosing a Control Mode

| | ACM | CCM |
|:--|:--|:--|
| **Setup complexity** | Higher — requires provisioning certificate and domain profile | Lower — no certificate required |
| **User consent** | Optional | Required for KVM, SOL, IDER |
| **Best for** | Production, unattended devices, IoT/edge | Development, testing, attended devices |
| **Certificate** | Required from a [trusted CA](./remoteProvisioning.md) | Not required |
| **Domain Profile** | Required | Not required |

## Domains

In addition to a CIRA Config and an ACM Profile, ACM requires the creation of a Domain Profile.

Intel® AMT checks the network DNS suffix against the provisioning certificate as a security check. During provisioning, the trusted certificate chain is injected into the AMT firmware. Intel® AMT verifies that the certificate chain is complete and is signed by a trusted certificate authority.

For more information on DNS suffix configuration, see [MEBx DNS Suffix](../Reference/MEBX/dnsSuffix.md).

## Learn More

- [Create an ACM Profile (Cloud)](../GetStarted/Cloud/createProfileACM.md)
- [Create a CCM Profile (Cloud)](../GetStarted/Cloud/createProfileCCM.md)
- [Create an ACM Profile (Enterprise)](../GetStarted/Enterprise/createProfileACM.md)
- [Create a CCM Profile (Enterprise)](../GetStarted/Enterprise/createProfileCCM.md)
