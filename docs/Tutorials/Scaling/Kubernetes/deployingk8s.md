--8<-- "References/abbreviations.md"

This tutorial demonstrates how to deploy the Device Management Toolkit on a local Kubernetes single-node cluster. Alternatively, you can also deploy using a managed service through a Cloud Service Provider such as Azure Kubernetes Service (AKS). See [AKS](./deployingk8s-aks.md).

Kubernetes, also known as K8s, is an open-source system for automating deployment, scaling, and management of containerized applications.  Learn more about Kubernetes [here](https://kubernetes.io/docs/home/).


## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop) with [Kubernetes Enabled](https://docs.docker.com/desktop/kubernetes/)

    !!!important "Important - For Linux"
        If deploying on a Linux machine, Docker Desktop is not available. You must use Docker Engine alongside a local Kubernetes cluster tool such as [minikube](https://minikube.sigs.k8s.io/docs/) or [kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/).

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm CLI)](https://helm.sh/)
- PostgreSQL Docker Container or [Local PostgreSQL server](https://www.postgresql.org/download/)

    !!! note "Note - Database Requirement and Setup Steps"
        
        This guide requires a standalone database for storage. This can be done either as a Docker container or as a local Postgres server on your local IP. For production, a managed database instance, either by a cloud service provider or your enterprise IT, is highly recommended.
  
        ??? note "Optional - How to Set up local PostgreSQL DB using Docker"
    
            ### Build and Start
    
            1. Clone the cloud-deployment repository.

                ```
                git clone https://github.com/device-management-toolkit/cloud-deployment --branch v{{ repoVersion.oamtct }}
                ```
    
            2. Copy the `.env.template` file to `.env`.

                ```
                copy .env.template .env
                ```

            3. Set the POSTGRES_USER and POSTGRES_PASSWORD to the credentials you want.

            4. Build and start the container.

                ```
                docker compose  -f "docker-compose.yml" up -d db
                ```

            5. Continue from [Create Kubernetes Secrets](#create-kubernetes-secrets).

        ??? note "Optional (Not Recommended) - How to Set up Local PostgreSQL server on local IP Address"
    
            ### Download and Configure
    
            1. [Download and Install PostgreSQL](https://www.postgresql.org/download/). You may have to add `.\bin` and `.\lib` to your PATH on Windows.
    
            2. Open the `pg_hba.conf` file under `.\PostgreSQL\14\data`.
    
            3. Add your device's IP Address under **IPv4 local connections**.
    
                ???+ example "Example - pg_hba.conf File"
    
                    ``` hl_lines="7"
    
                    # TYPE  DATABASE        USER            ADDRESS                 METHOD
    
                    # "local" is for Unix domain socket connections only
                    local   all             all                                             scram-sha-256
                    # IPv4 local connections:
                    host    all             all             127.0.0.1/32                    scram-sha-256
                    host    all             all             <Your-IP-Address>/24            scram-sha-256
                    # IPv6 local connections:
                    host    all             all             ::1/128                         scram-sha-256
                    # Allow replication connections from localhost, by a user with the
                    # replication privilege.
                    local   replication     all                                             scram-sha-256
                    host    replication     all             127.0.0.1/32                    scram-sha-256
                    host    replication     all             ::1/128                         scram-sha-256
                    ```
    
            4. Reload the configuration file to use the updated values.
    
                ```
                psql -U <user> -p 5432 -c "SELECT pg_reload_conf();"
                ```
    
            5. **From here, use your IP Address as the &lt;SERVERURL&gt;. DO NOT use localhost or 127.0.0.1. **

## Get the Toolkit

1. Clone the cloud-deployment repository.

    ```
    git clone https://github.com/device-management-toolkit/cloud-deployment.git --branch v{{ repoVersion.oamtct }}
    ```


## Create Kubernetes Secrets 

1. Open the `secrets.yaml` file in the `cloud-deployment/kubernetes/charts/` directory.

    ??? note "Note - Additional Information about Secrets Created"

        | Secret Name        | Usage                                                                      |
        | ------------------ | -------------------------------------------------------------------------- |
        | mpsweb             | Provides credentials used for requesting a JWT. These credentials are also used for logging into the Sample Web UI. |
        | rps                | RPS database connection string.                                            |
        | mps                | MPS database connection string.                                            |
        | mpsrouter          | MPS database connection string.                                            |
        | open-amt-admin-jwt | Provides secret used for generating and verifying JWTs for authentication. |
        | open-amt-admin-acl | Configures KONG with an Access Control List (ACL) to allow an admin user `open-amt-admin` to access endpoints using the JWT retrieved when logging in. |
        | vault              | Vault root token for MPS and RPS access to Vault secret store.             |

2. Replace the following placeholders.

    !!! warning "Warning - Using an SSL Connection"
        This tutorial uses the connection string setting of 'disable' for ease of setup. **For production, it is recommended to use a SSL connection.**

    | Placeholder                 | Lines      | Required                           | Usage                               |
    | --------------------------- | ---------- | ---------------------------------- | ----------------------------------- |
    | &lt;WEBUI-USERNAME&gt;      | 7          | Username of your choice            | For logging into the Sample Web UI. |
    | &lt;WEBUI-PASSWORD&gt;      | 8          | **Strong** password of your choice | For logging into the Sample Web UI. |
    | &lt;DATABASE-USERNAME&gt;   | 16, 24, 32 | Database username | Credentials for the services to connect to the database.  |
    | &lt;DATABASE-PASSWORD&gt;   | 16, 24, 32 | Database password | Credentials for the services to connect to the database.  |
    | &lt;DATABASE-SERVER-URL&gt; | 16, 24, 32 | Database server   | Credentials for the services to connect to the database.  |
    | &lt;SSL-MODE&gt;            | 16, 24, 32 | Set to `disable`  | Credentials for the services to connect to the database.  |
    | &lt;YOUR-SECRET&gt;         | 45         | A strong secret of your choice (Example: A unique, random 256-bit string).    | Used when generating a JSON Web Token (JWT) for authentication. This example implementation uses a symmetrical key and HS256 to create the signature. [Learn more about JWT](https://jwt.io/introduction){target=_blank}.|

    !!! important "Important - Using Strong Passwords"
        The **&lt;WEBUI-PASSWORD&gt;** must meet standard, **strong** password requirements:

        - 8 to 32 characters

        - One uppercase, one lowercase, one numerical digit, one special character

3. Save the file.

4. Apply the configuration file to create the secrets.

    ```
    kubectl apply -f ./kubernetes/charts/secrets.yaml
    ```

## Update Configuration

### Edit values.yaml

1. Open the `values.yaml` file in `./cloud-deployment/kubernetes/charts/`.

2. Update the `commonName` key in the **mps** section with the IP Address of your development device.

    ``` yaml hl_lines="2"
    mps:
        commonName: "<your-ip-address>"
        replicaCount: 1
        logLevel: "silly"
        jwtExpiration: 1440
    ```

3. Save and close the file.

## Create Databases 

1. Use the database schema files to initialize the hosted Postgres DB in the following steps.

    Where:

    - **&lt;SERVERURL&gt;** is the location of the Postgres database.
    - **&lt;USERNAME&gt;** is the username for the Postgres database.

2. Create the MPS and RPS database and tables. Provide the database password when prompted.

    ```
    psql -h <SERVERURL> -p 5432 -d postgres -U <USERNAME> -W -f ./data/init.sql -f ./data/initMPS.sql
    ```

## Deploy Device Management Toolkit Using Helm

1. Deploy using Helm.
    ```
    helm install devicemgmtstack ./kubernetes/charts
    ```

    !!! success
        ```
        NAME: devicemgmtstack
        LAST DEPLOYED: Wed Jul 14 12:59:29 2021
        NAMESPACE: default
        STATUS: deployed
        REVISION: 1
        TEST SUITE: None
        ```

2. View the pods. You might notice `mps`, `rps`, and `devicemgmtstack-vault-0` are not ready. This will change after we initialize and unseal Vault. All others should be Ready and Running.

    ```
    kubectl get pods
    ```

    !!! success
        ``` hl_lines="2 5 7"
        NAME                                                 READY   STATUS                       RESTARTS   AGE
        mps-6984b7c69d-8d5gf                                 0/1     CreateContainerConfigError   0          5m
        mpsrouter-9b9bc499b-pwn9j                            1/1     Running                      0          5m
        devicemgmtstack-kong-55b65d558c-gzv4d                   2/2     Running                      0          5m
        devicemgmtstack-vault-0                                 0/1     Running                      0          5m
        devicemgmtstack-vault-agent-injector-7fb7dcfcbd-dlqqg   1/1     Running                      0          5m
        rps-79877bf5c5-hnv8t                                 0/1     CreateContainerConfigError   0          5m
        webui-784cd49976-bj7z5                               1/1     Running                      0          5m
        ```

## Initialize and Unseal Vault

!!! danger - "Danger - Download and Save Vault Keys"
    **Make sure to download your Vault credentials** and save them in a secure location when unsealing Vault.  If the keys are lost, a new Vault will need to be started and any stored data will be lost.

1. Connect to the Vault UI using a web browser.

    ```
    http://localhost:8200
    ```

    !!!note "Troubleshoot - Vault UI External IP"
        If you cannot connect, verify the External IP Address by running:
        ```
        kubectl get services devicemgmtstack-vault-ui
        ```

2. Please refer to HashiCorp documentation on how to [Initialize and unseal Vault](https://learn.hashicorp.com/tutorials/vault/kubernetes-azure-aks?in=vault/kubernetes#initialize-and-unseal-vault). **Stop and return here after signing in to Vault with the `root_token`.**

3. After initializing and unsealing the vault, you need to enable the Key Value engine.

4. On the left-hand side menu, select **Secrets engines**.

5. Click **Enable New Engine +**.

6. Choose **KV**.

7. Click **Enable Engine**.
  
### Vault Token Secret

Add the root token as a secret to the cluster so that the services can access Vault.

1. Open the `secrets.yaml` file again in the `cloud-deployment/kubernetes/charts/` directory.

2. Replace `<VAULT-ROOT-TOKEN>` in the `vaultKey:` field (line 66) with the actual Vault root token.

3. Save the file.

4. Update the Kubernetes `vault` secret.

    ```
    kubectl apply -f ./kubernetes/charts/secrets.yaml -l app=vault
    ```

5. View the pods. All pods should now be Ready and Running.
    ```
    kubectl get pods
    ```

    !!! success
        ```
        NAME                                                 READY   STATUS    RESTARTS   AGE
        mps-6984b7c69d-8d5gf                                 1/1     Running   0          7m
        mpsrouter-9b9bc499b-pwn9j                            1/1     Running   0          7m
        devicemgmtstack-kong-55b65d558c-gzv4d                   2/2     Running   0          7m
        devicemgmtstack-vault-0                                 1/1     Running   0          7m
        devicemgmtstack-vault-agent-injector-7fb7dcfcbd-dlqqg   1/1     Running   0          7m
        rps-79877bf5c5-hnv8t                                 1/1     Running   0          7m
        webui-784cd49976-bj7z5                               1/1     Running   0          7m
        ```

## Next Steps

[**Continue from the Get Started steps**](../../../GetStarted/Cloud/loginToUI.md)
