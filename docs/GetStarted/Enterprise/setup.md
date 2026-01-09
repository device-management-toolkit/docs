


## What You'll Need

**Configure a network that includes:**

-  A development system (to run Console)
-  A provisioned or unprovisoned Intel® AMT device

## What You'll Do

<figure class="figure-image">
  <img src="..\..\..\assets\images\diagrams\Console_Deployment.svg" style="height:800px" alt="Figure 1: Get Started with Console">
  <figcaption>Figure 1: Get Started with Console</figcaption>
</figure>

**To complete a deployment:**

1. [Download and run Console](#download)
2. Create a [CCM Profile](createProfileCCM.md) or [ACM Profile](createProfileACM.md)
3. [Export Profile](exportProfile.md)
4. [Activate and configure an Intel® AMT device](activateDevice.md)
5. [Add the device to the Console](addDevice.md)
6. [Manage the device using Console](manageDevice.md)

!!! note "Note - For devices that are already activated in ACM or CCM"
    If your Intel AMT device is already activated in CCM or ACM, you can skip steps 2, 3 and 4 after completing step 1 and proceed directly to [Add a device to Console](addDevice.md).

## Download

1. Find the latest release of Console under [Github Releases](https://github.com/device-management-toolkit/console/releases/latest).


2. Download the appropriate binary assets for your OS and Architecture under the *Assets* dropdown section.

    !!! note "Note - Warnings when Downloading from Github"
        If downloading Console on Windows, a warning may appear and require approval to continue the download. 

## Configuration

1. Run the executable, and a terminal will open containing the Console process.
    <figure class="figure-image">
      <img src="..\..\..\assets\images\screenshots\Console_Configuration_FirstTime.png" alt="Figure 2: Console Start">
      <figcaption>Figure 2: Console Start</figcaption>
    </figure>

2. Type **Y** in the terminal and press **Enter** to store the Database Key in the Operating Systems Credentials Manager.

    !!! note "Note - Encryption Key Information"
        Console automatically stores this 32-character key in Operating System's credential manager, such as Windows Credential Manager, under the name *device-management-toolkit*. This key is used to encrypt sensitive data before it is stored in the database.

3. The executable automatically generates a `config.yml` file in the `/config` directory, relative to where the executable is run.. A default User Name and Password for the console login is stored in the `config.yml` file. To change the User Name and Password, edit the file and update `adminUsername` and `adminPassword` fields.

    ```yml hl_lines="6 8 9"
    app:
      name: console
      repo: device-management-toolkit/console
      version: DEVELOPMENT
      encryption_key: ""
      allow_insecure_ciphers: false
    http:
      host: localhost
      port: "8181"
      allowed_origins:
        - "*"
      allowed_headers:
        - "*"
    logger:
      log_level: info
    postgres:
      pool_max: 2
      url: ""
    ea:
      url: http://localhost:8000
      username: ""
      password: ""
    auth:
      disabled: false
      adminUsername: standalone
      adminPassword: G@ppm0ym
      jwtKey: your_secret_jwt_key
      jwtExpiration: 24h0m0s
      redirectionJWTExpiration: 5m0s
      clientId: ""
      issuer: ""
    ```

!!! important
    Using the default credentials is for TESTING ONLY. Not setting these values to your own values will result in an insecure deployment. For production deployments we recommended using an OAUTH provider (Auth0, Azure Entra AD, etc..) and configuring Console to use that instead. We may remove the default values in the future. `


## Run

1. Close the terminal if Console is already running, then rerun the executable for the configuration changes to take effect.

2. Console is now successfully running! A browser window will open running `http://localhost:8181` where you can access the Console UI and start adding devices.

    !!! success
        <figure class="figure-image">
          <img src="..\..\..\assets\images\screenshots\Console_Start.png" alt="Figure 3: Console Process Startup">
          <figcaption>Figure 3: Console Process Startup</figcaption>
        </figure>

## Login

1. Log in to Console using the set credentials, `adminUsername` and `adminPassword`.

    !!! example
        <figure class="figure-image">
          <img src="..\..\..\assets\images\screenshots\DMT_Console_Login.png" alt="Figure 4: Console UI Startup">
          <figcaption>Figure 4: Console UI Startup</figcaption>
        </figure>


## Next up

Profiles provide configuration information to the AMT Firmware during the activation process with the Remote Provisioning Client (RPC). Profiles also distinguish between activating in: 

**[Client Control Mode (CCM):](createProfileCCM.md)** This mode offers all manageability features including, but not limited to, power control, audit logs, and hardware info. Redirection features, such as KVM or SOL, **require user consent**. The managed device will display a 6-digit code that **must** be entered by the remote admin to access the remote device via redirection.

[Create a CCM Profile](createProfileCCM.md){: .md-button .md-button--primary }

**[Admin Control Mode (ACM):](createProfileACM.md)** ACM mode supports all manageability features **without requiring user consent**. This means it is **not necessary** to have a person on-site to remote in and manage an edge device. In most IoT use cases, edge devices such as digital signage or kiosks may not be easily accessible or have available employees nearby. ACM mode proves immensely helpful in these scenarios.

[Create an ACM Profile](createProfileACM.md){: .md-button .md-button--primary }