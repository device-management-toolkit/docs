# Configure TLS in Console

This guide shows how to use your own HTTPS certificate with Console.
This is the certificate your browser receives and checks when you open the Console UI over HTTPS.

By default, when Console runs with TLS enabled and no certificate files are configured, Console generates a self-signed certificate and stores it in the OS temp directory as `console_selfsigned.crt` and `console_selfsigned.key`.


For customer deployments, use certificates your organization manages and owns, then configure Console to use those certificates.

!!! info "What this changes"
    After configuration, Console serves HTTPS with your certificate and key instead of a generated self-signed certificate.

## What you need

1. A certificate file in PEM format.
2. A private key file in PEM format that matches that certificate.
3. File paths that Console can access.

!!! note "Scope"
    This page currently applies to users running the Console executable (`.exe`).
    TLS guidance for Docker deployments will be added in the future.

## Option 1: Set certificate paths in config.yml

1. Close the Console application.
2. Open your Console `config.yml` file and set:

    ```yaml hl_lines="4 5"
    http:
      tls:
        enabled: true
        certFile: "C:/console/tls/server-cert.pem"
        keyFile: "C:/console/tls/server-key.pem"
    ```

3. Save `config.yml`.
4. Start Console again (for example, double-click the Console `.exe` on Windows).

!!! warning "Apply changes correctly"
    You must restart the Console application itself. Closing and reopening the browser is not enough.

## Option 2: Set certificate paths with environment variables

1. Close the Console application.
2. Open the same terminal you will use to start Console.
3. Set these environment variables:

    === "PowerShell"
        ```powershell
        $env:HTTP_TLS_ENABLED="true"
        $env:HTTP_TLS_CERT_FILE="C:/console/tls/server-cert.pem"
        $env:HTTP_TLS_KEY_FILE="C:/console/tls/server-key.pem"
        ```

    === "Command Prompt"
        ```cmd
        set HTTP_TLS_ENABLED=true
        set HTTP_TLS_CERT_FILE=C:\console\tls\server-cert.pem
        set HTTP_TLS_KEY_FILE=C:\console\tls\server-key.pem
        ```

4. Start Console from that same terminal/session.

!!! important "Important note about environment variables"
    Console only sees environment variables from where it is started.
    Set the variables and start Console in the same PowerShell window, Command Prompt, service, or tool.

## How Console behaves

1. If `certFile` and `keyFile` are both set, Console uses your files.
2. If both are empty and TLS is enabled, Console creates or reuses a self-signed certificate from the OS temp directory (`console_selfsigned.crt` and `console_selfsigned.key`).
3. If only one is set, Console fails to start TLS because both are required.

## Troubleshooting

1. TLS does not start: confirm both cert and key paths are set.
2. File not found errors: confirm the paths are correct and readable by Console.
3. Browser warning for self-signed cert: expected; use a CA-issued cert for production.

!!! note "Certificate and key ownership"
    Console does not manage your certificate or private key lifecycle.
    Customers should store these files securely and limit read access to authorized users and the Console service account.
