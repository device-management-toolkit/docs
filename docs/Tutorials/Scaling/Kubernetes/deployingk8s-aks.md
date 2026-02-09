

# Azure Kubernetes Service (AKS)

This tutorial demonstrates how to deploy the Device Management Toolkit on a Kubernetes cluster using AKS. Alternatively, you can also perform a simpler, test deployment using a single-node cluster locally. See [Kubernetes (K8s)](./deployingk8s.md).

Azure Kubernetes Service (AKS) offers serverless Kubernetes, an integrated continuous integration and continuous delivery (CI/CD) experience, and enterprise-grade security and governance. Learn more about AKS [here](https://docs.microsoft.com/en-us/azure/aks/).

## Prerequisites

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Helm CLI](https://helm.sh/)
- [PSQL CLI](https://www.postgresql.org/download/)

## Get the Toolkit

1. Clone the cloud-deployment repository.

    ```
    git clone https://github.com/device-management-toolkit/cloud-deployment.git --branch v{{ repoVersion.oamtct }}
    ```

## Create SSH Key
This key is required by Azure to create VMs that use SSH keys for authentication. For more details, see [Detailed steps: Create and manage SSH keys](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-ssh-keys-detailed).

1. Create a new ssh key.

    ```
    ssh-keygen -m PEM -t rsa -b 4096
    ```

2. Take note of the location it was saved at. You will need the public key (`.pub` file) in a following step. 

## Deploy AKS

1. Login to Azure.
    
    ``` bash
    az login
    ``` 

2. Provide a name and region to create a new resource group.

    ``` bash
    az group create --name <your-resource-group-name> --location <region>
    ```

3. Provide the name of your new resource group from the last step and start a deployment at that resource group based on `aks.json` in the `./cloud-deployment` directory.

    ``` bash
    az deployment group create --resource-group <your-resource-group-name> --template-file aks.json
    ```

4. After running the previous command, you will be prompted for 5 different strings. After the final prompt, it will take about 5-10 minutes for Azure to finish creating resources.
    - A name for the AKS Cluster.
    - A name (e.g. your name) for the linux user admin name.
    - The string of the ssh key from the `.pub` file generated in [Create SSH Key](#create-ssh-key).
    - A username for the new Postgres Database.
    - A password for the new Postgres Database.

5. Take note of the `fqdnSuffix` in the `outputs` section of the JSON response (e.g. `eastus.cloudapp.azure.com`)

    ```json hl_lines="8"
    "outputs": {
      "controlPlaneFQDN": {
        "type": "String",
        "value": "bwcluster-9c68035a.hcp.westus.azmk8s.io"
      },
      "fqdnSuffix": {
        "type": "String",
        "value": "eastus.cloudapp.azure.com"
      }
    },
    ```

## Connect to AKS Instance

Ensure your `kubectl` is connected to the Kubernetes cluster you wish to deploy/manage.

1. Provide your resource group name and cluster name, respectively.

    ``` bash
    az aks get-credentials --resource-group <your-resource-group-name> --name <your-cluster-name>
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

    | Placeholder                 | Lines | Required                           | Usage                               |
    | --------------------------- | ----- | ---------------------------------- | ----------------------------------- |
    | &lt;WEBUI-USERNAME&gt;      | 7     | Username of your choice            | For logging into the Sample Web UI. |
    | &lt;WEBUI-PASSWORD&gt;      | 8     | **Strong** password of your choice | For logging into the Sample Web UI. |
    | &lt;DATABASE-USERNAME&gt;   | 16, 24, 32 | Database username chosen in [Deploy AKS Step 4](#deploy-aks) | Credentials for the services to connect to the database.  |
    | &lt;DATABASE-PASSWORD&gt;   | 16, 24, 32 | Database password chosen in [Deploy AKS Step 4](#deploy-aks) | Credentials for the services to connect to the database.  |
    | &lt;DATABASE-SERVER-URL&gt; | 16, 24, 32 | **Server URL Format:** `<your-cluster-name>-sql.postgres.database.azure.com` | Credentials for the services to connect to the database.  |
    | &lt;SSL-MODE&gt;            | 16, 24, 32 | Set to `require` | Credentials for the services to connect to the database.  |
    | &lt;YOUR-SECRET&gt;         | 45    | A strong secret of your choice (Example: A unique, random 256-bit string).    | Used when generating a JSON Web Token (JWT) for authentication. This example implementation uses a symmetrical key and HS256 to create the signature. [Learn more about JWT](https://jwt.io/introduction){target=_blank}.|

    !!! important "Important - Using Strong Passwords"
        The **&lt;WEBUI-PASSWORD&gt;** must meet standard, **strong** password requirements:

        - 8 to 32 characters

        - One uppercase, one lowercase, one numerical digit, one special character

3. Save the file.

4. Apply the configuration file to create the secrets.

    ``` bash
    kubectl apply -f ./kubernetes/charts/secrets.yaml
    ```

## Update Configuration

### Edit values.yaml

1. Open the `values.yaml` file in `./cloud-deployment/kubernetes/charts/`.

2. Update the `service.beta.kubernetes.io/azure-dns-label-name` key in the **kong** section with a desired subdomain name for the URL that you would like for your cluster (i.e. myopenamtk8s).

    ``` yaml hl_lines="4"
    kong:
      proxy:
        annotations:
          service.beta.kubernetes.io/azure-dns-label-name: "<your-subdomain-name>"
    ```

3. Update the `commonName` key to your FQDN in the `mps` section.  For AKS, the default format is `<your-subdomain-name>.<location>.cloudapp.azure.com`. This is the `fqdnSuffix` provided in the `outputs` section when you [Deploy AKS](#deploy-aks).

    ``` yaml hl_lines="2"
    mps:
        commonName: "<your-subdomain-name>.<location>.cloudapp.azure.com"
        replicaCount: 1
        logLevel: "silly"
        jwtExpiration: 1440
    ```

4. Save and close the file.

## Create Databases and Schema 

### Enable Access to Database

1. Navigate to `Home > Resource Groups > Resource Group Name` using Microsoft Azure via online.

2. Select the Postgres DB. It will have a Type of `Azure Database for PostgreSQL Flexible Server`.

3. Under Settings in the left-hand menu, select **Networking**.

4. Under Firewall rules, select **Add current client IP address**.

5. Click Save.

    !!! note
        For security, remember to delete this firewall rule when finished.

### Create Databases

1. Use the database schema files to initialize the hosted Postgres DB in the following steps.

    Where:

    - **&lt;SERVERURL&gt;** is the location of the Postgres database (Ex: `<your-cluster-name>-sql.postgres.database.azure.com`).
    - **&lt;USERNAME&gt;** is the admin username for the Postgres database (Chosen in [Deploy AKS Step 4](#deploy-aks)).

2. Create the MPS and RPS database and tables. Provide the database password when prompted.

    ```
    psql -h <SERVERURL> -p 5432 -d postgres -U <USERNAME> -W -f ./data/init.sql -f ./data/initMPS.sql
    ```

## Deploy Device Management Toolkit using Helm

1. Deploy using Helm.
    ```
    helm install devicemgmtstack ./kubernetes/charts
    ```

    !!! success
        ```
        NAME: devicemgmtstack
        LAST DEPLOYED: Thu Jul 15 11:17:38 2021
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
        mps-69786bfb47-92mpc                                 0/1     CreateContainerConfigError   0          2m6s
        mpsrouter-9b9bc499b-2tkb2                            1/1     Running                      0          2m6s
        devicemgmtstack-kong-68d6c84bcc-fp8dl                   2/2     Running                      0          2m6s
        devicemgmtstack-vault-0                                 0/1     Running                      0          2m6s
        devicemgmtstack-vault-agent-injector-6b564845db-zss78   1/1     Running                      0          2m6s
        rps-79877bf5c5-dsg5p                                 0/1     CreateContainerConfigError   0          2m6s
        webui-6cc48f4d68-6r8b5                               1/1     Running                      0          2m6s
        ```

## Initialize and Unseal Vault

!!! danger - "Danger - Download and Save Vault Keys"
    **Make sure to download your Vault credentials** and save them in a secure location when unsealing Vault.  If the keys are lost, a new Vault will need to be started and any stored data will be lost.

!!! tip "Tip - Finding the Vault UI External IP Address"
    The external IP of your Vault UI service can be found by running:

    ```
    kubectl get services devicemgmtstack-vault-ui
    ```

1. Please refer to HashiCorp documentation on how to [Initialize and unseal Vault](https://learn.hashicorp.com/tutorials/vault/kubernetes-azure-aks?in=vault/kubernetes#initialize-and-unseal-vault). **Stop and return here after signing in to Vault with the `root_token`.**

2. After initializing and unsealing the vault, you need to enable the Key Value engine.

3. On the left-hand side menu, select **Secrets engines**.

4. Click **Enable New Engine +**.

5. Choose **KV**.

7. Click **Enable Engine**.
  
### Vault Token Secret

Add the root token as a secret to the AKS cluster so that the services can access Vault.

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
        NAME                                                 READY   STATUS      RESTARTS   AGE
        mps-69786bfb47-92mpc                                 1/1     Running     0          4m5s
        mpsrouter-9b9bc499b-2tkb2                            1/1     Running     0          4m5s
        devicemgmtstack-kong-68d6c84bcc-fp8dl                   2/2     Running     0          4m5s
        devicemgmtstack-vault-0                                 1/1     Running     0          4m5s
        devicemgmtstack-vault-agent-injector-6b564845db-zss78   1/1     Running     0          4m5s
        rps-79877bf5c5-dsg5p                                 1/1     Running     0          4m5s
        webui-6cc48f4d68-6r8b5                               1/1     Running     0          4m5s
        ```

## Next Steps

Visit the Sample Web UI using the FQDN name and [**Continue from the Get Started steps**](../../../GetStarted/Cloud/loginToUI.md)

