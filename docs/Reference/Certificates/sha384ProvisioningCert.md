# SHA-384 Provisioning Certificate for Intel® AMT 22

Intel® AMT 22 (Nova Lake) removes the older, weaker cryptographic algorithms from the firmware. A provisioning certificate that was signed with SHA-256, or that uses RSA 2048-bit keys, can no longer be used to activate an AMT 22 device in Admin Control Mode (ACM). This page explains what the certificate must look like, how to get one, and how to check it before you upload it.

!!! note "Note - CCM does not need a provisioning certificate"
    Client Control Mode (CCM) activation does not use a provisioning certificate. This page applies only to ACM.

## What AMT 22 Requires

| | AMT 21 and earlier | AMT 22 |
| :-- | :-- | :-- |
| Signature digest of **every** certificate in the chain | SHA-256 or SHA-384 | **SHA-384 only** |
| RSA key size of **every** certificate in the chain | 2048-bit or larger | **3072-bit or larger** |
| Root hash the device lists as trusted | SHA-1, SHA-256 or SHA-384 | **SHA-384** |

"Every certificate" means the leaf (the provisioning certificate itself), each intermediate certificate, and the root. The AMT firmware checks each certificate as it is uploaded during activation, so one SHA-256 or RSA-2048 certificate anywhere in the chain is enough for AMT 22 to refuse it.

The rest of the requirements are the same as before: the certificate must carry the Intel® AMT extended key usage OID `2.16.840.1.113741.1.2.3`, its domain must match the DNS suffix of the managed device, and the `.pfx` file must contain the private key and the complete certificate chain.

!!! tip "Tip - One SHA-384 certificate can serve a mixed fleet"
    Older AMT generations accept a SHA-384 provisioning certificate as well as a SHA-256 one. If devices of different generations share a DNS suffix, a single SHA-384 certificate in one domain profile activates all of them. You do not need to keep a SHA-256 certificate for the older devices.

## Get a SHA-384 Provisioning Certificate

### Purchase One (Recommended for Production)

1. Order the Intel® AMT (vPro) provisioning certificate from a certificate authority (CA) that supports Intel® AMT. See the vendors listed in [Remote Provisioning](../../Concepts/remoteProvisioning.md#purchase).

2. State in the order that the device targets are **AMT 22** and that the whole chain must be **SHA-384 with RSA 3072-bit or larger keys**. Availability and ordering steps differ by CA, so confirm them with your CA before you buy.

3. Download the `.pfx` file. It must contain the leaf certificate, any intermediate certificates, the root certificate, and the private key.

4. [Check the certificate](#check-the-certificate-before-you-upload-it) before you upload it.

!!! important "Important - An existing SHA-256 certificate cannot be converted"
    The digest is part of each certificate's signature, so a SHA-256 certificate cannot be re-signed or re-exported as SHA-384. You need a newly issued certificate. Keep the existing certificate in its domain profile until the new one is in place and tested.

!!! note "Note - The root must be trusted by the AMT 22 firmware"
    AMT 22 compares the root of your chain with a list of trusted root hashes held in the firmware, and that list is SHA-384 only. A root that the firmware knows only by an older hash can never match, even if the chain itself is valid. Use a CA that supports Intel® AMT 22, and confirm it with the CA before you buy.

### Generate One (Development and Testing Only)

For testing, you can generate a SHA-384 certificate with OpenSSL. Follow [Custom Provisioning Certificate](generateProvisioningCert.md) and use the SHA-384 and RSA 3072-bit values described in [SHA-384 Values for AMT 22](generateProvisioningCert.md#sha-384-values-for-amt-22).

!!! warning "Warning - Custom Certificates Need a Trusted Hash on Every Device"
    The hash of a custom root certificate must be added to the AMT firmware of every device by hand. On AMT 22 the firmware lists trusted root hashes as SHA-384, so use the SHA-384 fingerprint of your root certificate. Starting remote configuration from MEBx is no longer available on AMT 22, so confirm that your hardware accepts your method of adding the hash before you plan a rollout. Use a purchased certificate for production.

## Check the Certificate Before You Upload It

Run these commands on the `.pfx` file. Replace `provisioning.pfx` with your file name. OpenSSL asks for the `.pfx` password.

1. Export the certificates in the file to a text file. The private key is not exported.

    ``` bash
    openssl pkcs12 -in provisioning.pfx -nokeys -out chain.pem
    ```

    !!! note "Note - OpenSSL 3 and older `.pfx` files"
        If OpenSSL 3 reports an unsupported algorithm for an older `.pfx` file, add the `-legacy` option to the command.

2. List the signature algorithm and key size of each certificate.

    ``` bash
    openssl crl2pkcs7 -nocrl -certfile chain.pem | openssl pkcs7 -print_certs -text -noout | grep -E "^ {8}Signature Algorithm|Subject:|Public-Key"
    ```

3. Confirm that **every** certificate shows `sha384WithRSAEncryption` and a `Public-Key` of 3072 bit or larger.

    !!! success "Success - Example Output"
        ```
                Signature Algorithm: sha384WithRSAEncryption
                Subject: C=US, O=Example, CN=test.example.com
                        Public-Key: (3072 bit)
                Signature Algorithm: sha384WithRSAEncryption
                Subject: CN=Example Root CA
                        Public-Key: (3072 bit)
        ```

    !!! failure "Failure - Example Output That AMT 22 Refuses"
        ```
                Signature Algorithm: sha256WithRSAEncryption
                Subject: C=US, O=Example, CN=test.example.com
                        Public-Key: (2048 bit)
        ```

4. Optional: get the SHA-384 fingerprint of the root certificate, the value the AMT 22 firmware compares.

    ``` bash
    openssl x509 -noout -fingerprint -sha384 -in rootCA.crt
    ```

## Upload the Certificate

Create a domain profile with the new `.pfx` file, the same way as before. See [Create a Domain Profile](../../GetStarted/Cloud/createProfileACM.md#create-a-domain-profile) for the Cloud solution or [Create a Domain Profile](../../GetStarted/Enterprise/createProfileACM.md#create-a-domain-profile) for the Enterprise solution.

!!! tip "Tip - Replace the certificate in an existing domain profile"
    A domain profile is identified by its DNS suffix. To move to a SHA-384 certificate, edit the existing domain profile and replace its certificate, so the ACM profiles that use it keep working.

## What Happens When the Certificate Does Not Fit

For an AMT 22 device, the toolkit checks every certificate in the chain **before** it starts to activate the device. If a certificate does not fit, activation stops, nothing is changed on the device, and the reason is reported as an activation failure. The check does not depend on the device trusting the root certificate, so you get the real reason and not a generic "no matching certificate hash" error.

| Message | What it means | What to do |
| :-- | :-- | :-- |
| `Provisioning certificate rejected: leaf "<name>" is signed with sha256, SHA-384 required` | The named certificate is signed with SHA-256. The role in the message is `leaf`, `intermediate` or `root`. | Get a certificate whose whole chain is SHA-384. |
| `Provisioning certificate rejected: intermediate "<name>" has a 2048-bit RSA key, 3072 bits required` | The named certificate has a key that is too small. | Get a certificate whose whole chain uses RSA 3072-bit or larger keys. |
| `Provisioning certificate rejected: <n> certificate(s) in the chain cannot be read, so SHA-384 and RSA-3072 cannot be confirmed` | The `.pfx` file holds a certificate that could not be read, for example one with an unsupported key type. | Export the `.pfx` again with only the leaf, the intermediate and the root certificates. |
| `Invalid domain certificate, hash does not exists in list of trusted root certificates on AMT` | The chain is acceptable, but the device does not trust its root. | Use a root certificate that the device trusts, or add the hash for a custom root. |

Devices that do not report the hardened firmware, such as AMT 21 and earlier, are not affected by this check. They keep activating with SHA-256 or SHA-384 certificates.

## Learn More

- [Remote Provisioning](../../Concepts/remoteProvisioning.md)
- [AMT 22 Support and Mixed Fleets](../../Deployment/amt22Support.md)
- [Troubleshooting](../troubleshooting.md)
