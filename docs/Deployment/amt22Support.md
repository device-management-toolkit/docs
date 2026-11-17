# AMT 22 Support and Mixed Fleets

Intel® AMT 22 (Nova Lake) removes the weak cryptographic algorithms from the firmware: SHA-256, RSA 2048-bit keys, ECC-256 and AES-128 can no longer be used for TLS. Onboarding AMT 22 devices is a two-sided change, and the firmware does not tell you when one side is missing:

- **RPS side:** the provisioning certificate must be SHA-384 with RSA 3072-bit or larger keys.
- **MPS side:** the certificate MPS presents on the CIRA connection must have an RSA key of 3072 bits or more.

If you do only one of the two, the device still activates and the profile reports success, but the device never connects back to MPS. It is provisioned and unmanageable. This page lists what to prepare, how to convert an existing deployment, and how to run a fleet that includes older generations.

!!! important "Important - Activation is not the finish line"
    For AMT 22, a device is onboarded when its **CIRA connection is up** and the device shows as connected in MPS. An activation that ends with `PROVISIONED` is not enough. See [Confirm the Device Is Connected](#confirm-the-device-is-connected).

## What to Prepare

| # | What | Where | Why |
| :-- | :-- | :-- | :-- |
| 1 | Upgrade RPC-Go to a release that reports the firmware's crypto capability. For RPC-Go 2.x, use release `[2.x version to be confirmed]` or later. For RPC-Go 3.x, use a release later than `v3.0.0-beta.64` | Managed devices | RPC-Go tells RPS what the firmware requires. See [RPC-Go and RPS Versions](#rpc-go-and-rps-versions). |
| 2 | Use a SHA-384 provisioning certificate in the domain profile | RPS (ACM only) | The firmware refuses SHA-256 and RSA 2048-bit certificates. See [SHA-384 Provisioning Certificate](../Reference/Certificates/sha384ProvisioningCert.md). |
| 3 | Serve an MPS certificate with an RSA 3072-bit or larger key | MPS | The firmware validates the MPS certificate on the CIRA connection. See [MPS Certificate Key Size](#mps-certificate-key-size). |
| 4 | Decide how to handle AMT 11 devices | Fleet | One MPS certificate cannot serve AMT 11 and AMT 22. See [Mixed Fleets and AMT 11](#mixed-fleets-and-amt-11). |

CCM activation does not use a provisioning certificate, so step 2 applies to ACM only. Steps 1 and 3 apply to both modes.

## MPS Certificate Key Size

MPS creates two certificates for CIRA: a **root** certificate and a **leaf** certificate signed by it. The device keeps a copy of the root and checks the leaf that MPS presents on every connection.

- The **root** is created once, with an RSA 3072-bit key and a SHA-384 signature. It is never changed, because every provisioned device keeps a copy of it.
- The **leaf** can be replaced under the existing root at any time without touching a device, so its key size can be changed on a running deployment.

Set these in the `.env` file, or in the `.mpsrc` file inside `mps_tls_config`. A `.env` variable has priority.

```text title=".env"
MPS_MPS_TLS_CONFIG__MPS_CERT_KEY_SIZE=4096
MPS_MPS_TLS_CONFIG__MPS_CERT_REISSUE_ENABLED=false
MPS_MPS_TLS_CONFIG__LEGACY_COMPATIBLE_CIPHERS=true
```

```json title=".mpsrc"
"mps_tls_config": {
    "mps_cert_key_size": 4096,
    "mps_cert_reissue_enabled": false,
    "legacy_compatible_ciphers": true
}
```

| Setting | `.env` Variable Name | Values | Default | Description |
| :-- | :-- | :-- | :-- | :-- |
| `mps_cert_key_size` | `MPS_MPS_TLS_CONFIG__MPS_CERT_KEY_SIZE` | `2048`, `3072`, `4096` | `4096` | RSA key size of the leaf certificate that MPS presents on the CIRA port. |
| `mps_cert_reissue_enabled` | `MPS_MPS_TLS_CONFIG__MPS_CERT_REISSUE_ENABLED` | `true`, `false` | `false` | Lets MPS replace the stored leaf at startup when its size differs from `mps_cert_key_size`. With `false`, MPS never replaces a leaf it has already stored. |
| `legacy_compatible_ciphers` | `MPS_MPS_TLS_CONFIG__LEGACY_COMPATIBLE_CIPHERS` | `true`, `false` | `true` | Adds the `AES128-GCM-SHA256` cipher at the end of the cipher list, which AMT 12 needs. |

Other settings in `mps_tls_config` stay as they are. See [MPS Configuration](../Reference/MPS/configuration.md#cira-certificate-settings).

### Which Size to Choose

Testing with a SHA-384 provisioning certificate and a 3072-bit root showed which leaf sizes each generation accepts:

| AMT version | Leaf sizes that work |
| :-- | :-- |
| 22 | 3072, 4096 (2048 is refused) |
| 16, 18, 20, 21 | 2048, 3072, 4096 |
| 12 | 2048, 4096 (3072 fails the TLS handshake) |

A **4096-bit leaf works from AMT 12 to AMT 22**, so it is the default and the right choice for a fleet that has nothing older than AMT 12. Choose 2048 only for a deployment that never serves AMT 22.

### Fresh Deployment

On a first start, MPS finds no stored certificates and creates the root and the leaf together. The root is always 3072-bit. The leaf follows `mps_cert_key_size`, and `mps_cert_reissue_enabled` has no effect.

Set `mps_cert_key_size` **before the first start**. Changing it afterwards is a leaf reissue, described next.

### Existing Deployment

An existing deployment already has a stored root and leaf, and its leaf is probably 2048-bit. MPS does not change a stored leaf on its own. To move it to a size that AMT 22 accepts:

1. Set `MPS_MPS_TLS_CONFIG__MPS_CERT_KEY_SIZE` to `4096` (or `3072` if you serve no AMT 12 devices).

2. Set `MPS_MPS_TLS_CONFIG__MPS_CERT_REISSUE_ENABLED` to `true`.

3. Restart MPS.

4. Check the MPS log. It shows the reissue and the sizes now served.

    ```
    info: Reissuing MPS leaf certificate under existing root: 2048-bit -> 4096-bit
    info: MPS certificate key sizes at startup: leaf=4096-bit, root=3072-bit
    ```

5. Confirm what MPS serves on the CIRA port. Replace `[mps-address]` with the address your devices use.

    ``` bash
    openssl s_client -connect [mps-address]:4433 -servername [mps-address] </dev/null 2>/dev/null | openssl x509 -noout -text | grep "Public-Key"
    ```

6. Provisioned devices drop and re-establish their CIRA connection on their own. **No device is re-provisioned**, because the root did not change.

The reissue works in both directions. If a deployment later stops serving AMT 22, set the size back to 2048 with the switch on.

!!! note "Note - When the switch is off"
    If `mps_cert_reissue_enabled` is `false` and the stored leaf differs from `mps_cert_key_size`, MPS keeps serving the stored leaf and logs a warning that names both sizes. Use this when you supply your own certificates and rotate the leaf with your own process: replace the stored leaf with one of the size you want and MPS serves it.

!!! warning "Warning - MPS will not start if the stored certificates are unreadable or were soft-deleted"
    On an existing deployment, MPS never regenerates its certificates. If the stored certificate material is unreadable, or the secret was soft-deleted, MPS stops with an error. Restore the secret from your Vault backup, or undelete it. Regenerating the root would leave every provisioned device trusting a root that no longer exists.

!!! danger "Danger - Protect the certificate secret from permanent deletion"
    A secret that is absent altogether, for example one removed with a permanent delete in Vault, cannot be told apart from a first start. MPS then treats the deployment as a fresh installation and generates a new root, and provisioned devices no longer trust it. Use the Vault access policy to deny permanent deletion of the `MPSCerts` secret, and keep a backup of it.

## RPC-Go and RPS Versions

RPC-Go reads the firmware's crypto capability and sends it to RPS during activation. RPS uses it to pick the key types, digests and certificate sizes the firmware will accept, whatever the AMT version number is. This also covers a platform that gains the hardening through a firmware update.

Upgrade RPC-Go **before, or together with,** RPS. For RPC-Go 2.x, use release `[2.x version to be confirmed]` or later. For RPC-Go 3.x, use a release later than `v3.0.0-beta.64`.

| Situation | Result |
| :-- | :-- |
| AMT 22 device, current RPC-Go | Works. |
| AMT 22 device, older RPC-Go | Works. RPC-Go does not send the capability, so RPS treats AMT 22 and later as hardened. |
| Device below AMT 22 that has the hardening through a firmware update, older RPC-Go | Fails. RPS applies the older settings and the device refuses to bind its TLS credential (`HTTP 500`, `AMT-STATUS 1`). The message does not name the cause. Upgrade RPC-Go. |
| Any other device | Not affected. |

Check the RPC-Go version on a device with `rpc version`. See [Upgrade Toolkit Version](upgradeVersion.md) for the upgrade steps.

## Mixed Fleets and AMT 11

### What Works on One Port

MPS serves **AMT 12 through AMT 22 on one CIRA port**, with an RSA 4096-bit leaf signed by the 3072-bit SHA-384 root. One CIRA configuration works for all of those generations. AMT 12 also needs the `AES128-GCM-SHA256` cipher, which `legacy_compatible_ciphers` provides. If you serve no AMT 12 devices, set `legacy_compatible_ciphers` to `false` to leave the weakest cipher out of the list.

### AMT 11 Is Deprecated

AMT 11 is **no longer supported** with this change. The reason is the certificate MPS presents:

- AMT 22 refuses a 2048-bit leaf and needs 3072 or 4096.
- AMT 11 needs the 2048-bit leaf.

No single certificate satisfies both, so a single MPS endpoint cannot serve AMT 11 and AMT 22 together. AMT 12 to AMT 22 share one certificate, and AMT 11 does not. The toolkit does not provide a second certificate or a second port on the same MPS for AMT 11.

If your fleet contains AMT 11 devices, you have three choices:

1. **Retire or update them.** Replace the hardware or update the firmware to AMT 12 or later. This is the recommended path.

2. **Keep them on a separate MPS.** Run a second MPS instance with its own certificates and set `mps_cert_key_size` to `2048` on that instance. Use a separate CIRA configuration, with the address of that instance, and a separate profile for the AMT 11 devices.

3. **Do not move the leaf.** On a deployment that serves only AMT 11 to AMT 21, leave `mps_cert_key_size` at `2048` and `mps_cert_reissue_enabled` at `false`. Do not onboard AMT 22 to this deployment.

### Limits When You Keep AMT 11 Devices

- **No support commitment.** AMT 11 is outside the supported range of AMT 12 to AMT 22, and fixes are not planned for it. The known AMT 11.8.x CIRA problem in [Troubleshooting](../Reference/troubleshooting.md#amt-118x-not-connecting-to-sample-web-ui) is an example of what you manage yourself.
- **Two estates.** Device lists, the management API and the web UI are split between the two MPS instances. You manage and monitor each one separately.
- **Two sets of configuration.** Each MPS instance needs its own CIRA configuration, and each profile must point to the CIRA configuration of the MPS that matches the device generation.
- **A wrong match fails quietly.** A device activated with the profile for the other MPS is provisioned but never connects, because the TLS handshake fails on the certificate size. Activate AMT 11 devices only with the AMT 11 profile.
- **Weaker certificate.** The AMT 11 endpoint keeps the 2048-bit leaf, so it does not get the stronger key that AMT 12 to AMT 22 use.

## Confirm the Device Is Connected

1. Run the `activate` command and wait for it to finish.

2. Open the device list in the web UI. The device must show as **connected**.

3. If it does not connect within a few minutes, check the CIRA certificate. Compare the leaf size from the `openssl` command above with [the table of accepted sizes](#which-size-to-choose).

## Troubleshooting

| Symptom | Likely cause | What to do |
| :-- | :-- | :-- |
| AMT 22 device activates, but never shows as connected | MPS still serves a 2048-bit leaf, which AMT 22 refuses | Check the size with `openssl`. [Move the leaf to 3072 or 4096](#existing-deployment). |
| AMT 12 device stops connecting after the leaf changed to 3072 | AMT 12 refuses a 3072-bit leaf | Use 4096. |
| AMT 12 device cannot connect with `legacy_compatible_ciphers` off | AMT 12 needs `AES128-GCM-SHA256` | Set `legacy_compatible_ciphers` to `true`. |
| `Provisioning certificate rejected: ...` in the provisioning status | The provisioning certificate is SHA-256, has a small key, or has a certificate that cannot be read | See [SHA-384 Provisioning Certificate](../Reference/Certificates/sha384ProvisioningCert.md#what-happens-when-the-certificate-does-not-fit). |
| MPS does not start and reports unreadable or deleted certificates | The stored certificate secret is damaged or was soft-deleted | Restore the secret from backup, or undelete it. MPS does not regenerate it. |
