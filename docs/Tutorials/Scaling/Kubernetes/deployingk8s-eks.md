

# Amazon Elastic Kubernetes Service (EKS)

This tutorial demonstrates how to deploy the Device Management Toolkit on a Kubernetes cluster using EKS. To perform a simpler test deployment, use a single-mode cluster locally. See [Kubernetes (K8S)](./deployingk8s.md).

Amazon EKS offers serverless Kubernetes, an integrated continuous integration and continuous delivery (CI/CD) experience, and enterprise-grade security and governance. Learn more about EKS [here](https://aws.amazon.com/eks).

## Prerequisites

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [AWS CLI](https://aws.amazon.com/cli/)
- [eksctl CLI](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html)
- [Helm CLI](https://helm.sh/)
- [PSQL CLI](https://www.postgresql.org/download/)


## Get the Toolkit

1. Clone the cloud-deployment repository.

    ```
    git clone https://github.com/device-management-toolkit/cloud-deployment.git --branch v{{ repoVersion.oamtct }}
    ```

## Create a New EKS Cluster

1. Login or Authenticate to AWS. See [Configure AWS CLI for SSO](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html), if not setup yet.

    If your organization does not use SSO, see [Authentication and access credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-authentication.html) for all authentication options to choose from and how to configure the AWS CLI.

    ```
    aws sso login
    ```

2. Follow steps to [Create a key pair using Amazon EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html) to create a SSH key for accessing the cluster.

3. Create a new EKS cluster and supporting components.

    ```
    eksctl create cluster --name <cluster-name> --region <region> --with-oidc --ssh-access --ssh-public-key <ssh-keypair-name> --managed
    ```

    Where:

    - **&lt;cluster-name&gt;** is the name of the new EKS cluster.
    - **&lt;region&gt;** is the AWS region to deploy the stack (Ex: `us-west-2`).
    - **&lt;ssh-keypair-name&gt;** is the name of the SSH key from the previous step (Step 2).

## Configure EKS Instance

Ensure your `kubectl` is connected to the correct EKS cluster to manage.

1. Provide your region and cluster name.

    ```
    aws eks update-kubeconfig --region <region> --name <cluster-name>
    ```

    Where:

    - **&lt;cluster-name&gt;** is the name of your EKS cluster.
    - **&lt;region&gt;** is the AWS region where the cluster is (Ex: `us-west-2`).

### Add EBS CSI driver to Cluster

The Amazon EBS CSI plugin requires IAM permissions to make calls to Amazon APIs on your behalf. This is required for Vault. Without the driver, Vault will be stuck pending since its volume will be unable to be created.

1. Create a new IAM role. Follow the steps in [Creating the Amazon EBS CSI driver IAM role for service accounts](https://docs.amazonaws.cn/en_us/eks/latest/userguide/csi-iam-role.html).

2. Add the EBS CSI add-on to the cluster. Follow the steps in [Managing the Amazon EBS CSI driver as an Amazon EKS add-on](https://docs.aws.amazon.com/eks/latest/userguide/managing-ebs-csi.html#adding-ebs-csi-eks-add-on).

## Create Postgres DB in RDS

1. Create a Postgres DB by following the steps for [Creating an Amazon RDS DB instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Tutorials.WebServerDB.CreateDBInstance.html).

    **Make sure to set the following configuration settings:**

    | Field                         | Set to                                     | 
    | ----------------------------- | ------------------------------------------ |
    | Compute Resource              | Do not connect to an EC2 compute resource  |
    | Virtual private cloud (VPC)   | Choose the VPC created from your cluster.  It should follow the format: 'eksctl-**&lt;cluster-name&gt;**-cluster/VPC' |
    | Public access                 | Yes. In the next steps, we will create Security rules to limit access.         |
    | VPC security group            | Choose existing         |
    | Existing VPC security groups  | default                 |
    | Initial Database Name         | postgres                |


### Configure Virtual Private Cloud (VPC) for access

1. Go to [RDS home](https://console.aws.amazon.com/rds/home).
2. Select **Databases** from the left-hand side menu.
3. Select your created database (Ex: database-1).
4. Under **Security** in **Connectivity & security**, click on the VPC under **VPC security groups** (Ex: `default (sg-01b4767ggdcb52825)`).
5. Select the Security group ID (Ex: `sg-0e41dcdede3e2e584`).
6. Select **Edit Inbound rules**.

    #### Add Two New Rules
    Rule One:

    1. Select **Add rule**.
    2. Under 'Type' select **PostgresSQL**.
    3. Under 'Source' select **My IP**.

    Rule Two:

    1. Select **Add rule**.
    2. Under 'Type' select **PostgresSQL**.
    3. Under 'Source' select **Custom**.
    4. In the search box, select the security group starting with the label 'eks-cluster-sg'.

7. Select **Save rules**.


### Create Databases

1. Use the database schema files to initialize the hosted Postgres DB in the following steps.

    Where:

    - **&lt;SERVERURL&gt;** is the location of the Postgres database (Ex: `database-1.jotd7t2abapq.us-west-2.rds.amazonaws.com`).
    - **&lt;USERNAME&gt;** is the admin username for the Postgres database (Chosen in [Create Postgres DB in RDS](#create-postgres-db-in-rds)).

2. Create the MPS and RPS database and tables. Provide the database password when prompted.

    ```
    psql -h <SERVERURL> -p 5432 -d postgres -U <USERNAME> -W -f ./data/init.sql -f ./data/initMPS.sql
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

    ???+ warning "Warning - Using SSL/TLS with AWS RDS"
    
        By default, this tutorial uses the connection string setting of `no-verify` for ease of setup. To fully configure SSL, follow the links below. **For production, it is recommended to use a SSL connection.**

        Find more information at [Using SSL with a PostgreSQL DB instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/PostgreSQL.Concepts.General.SSL.html) and [Updating applications to connect to PostgreSQL DB instances using new SSL/TLS certificates](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/ssl-certificate-rotation-postgresql.html).
    
        Once setup, the SSL mode in the connection strings should be set to either `verify-full` or `verify-ca`.

    | Placeholder                 | Lines | Required                           | Usage                               |
    | --------------------------- | ----- | ---------------------------------- | ----------------------------------- |
    | &lt;WEBUI-USERNAME&gt;      | 7     | Username of your choice            | For logging into the Sample Web UI. |
    | &lt;WEBUI-PASSWORD&gt;      | 8     | **Strong** password of your choice | For logging into the Sample Web UI. |
    | &lt;DATABASE-USERNAME&gt;   | 16, 24, 32 | Database username chosen in [Create Postgres DB in RDS](#create-postgres-db-in-rds) | Credentials for the services to connect to the database.  |
    | &lt;DATABASE-PASSWORD&gt;   | 16, 24, 32 | Database password chosen in [Create Postgres DB in RDS](#create-postgres-db-in-rds) | Credentials for the services to connect to the database.  |
    | &lt;DATABASE-SERVER-URL&gt; | 16, 24, 32 | **Server URL Format:** `database-1.jotd7t2abapq.us-west-2.rds.amazonaws.com` | Credentials for the services to connect to the database.  |
    | &lt;SSL-MODE&gt;            | 16, 24<br><br> 32 | Lines 16 and 24: Set to `no-verify`<br><br>Line 32: Set to `disable` | Credentials for the services to connect to the database.  |
    | &lt;YOUR-SECRET&gt;         | 45    | A strong secret of your choice (Example: A unique, random 256-bit string).    | Used when generating a JSON Web Token (JWT) for authentication. This example implementation uses a symmetrical key and HS256 to create the signature. [Learn more about JWT](https://jwt.io/introduction){target=_blank}.|

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

1. Open the `values.yaml` file in the `./cloud-deployment/kubernetes/charts/` directory.

2. Remove the **annotations** section and `service.beta.kubernetes.io/azure-dns-label-name` key in the `kong:` section. These are Azure-specific implementations.

    ``` yaml hl_lines="3 4"
    kong:
      proxy:
        annotations: # Delete this line
          service.beta.kubernetes.io/azure-dns-label-name: "<your-domain-name>" # Delete this line
    ```

3. Save the file.


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

### Update commonName in values.yml

1. Get the `External-IP` for accessing the UI. Note and save the value under `EXTERNAL-IP`.

    ```
    kubectl get service devicemgmtstack-kong-proxy
    ```

2. Update the value for `commonName` in the **mps** section in the `values.yml` file with the `External-IP` from above.  Recall that `values.yml` is located in `./kubernetes/charts/`.

    ``` yaml hl_lines="2"
    mps:
        commonName: "" # update with External-IP from `kubectl get services`
        replicaCount: 1
        logLevel: "silly"
        jwtExpiration: 1440
    ```

3. Update the stack using helm.

    ```
    helm upgrade devicemgmtstack ./kubernetes/charts 
    ```


## Verify running pods

1. View the pods. All pods should now be Ready and Running.

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

2. Check that the MPS Certificate is correct in your browser. Go to your FQDN at port 4433.

    ```
    https://<Your-AWS-FQDN>:4433
    ```

3. Verify the MPS Certificate in your browser has the correct Issuer information and is Issued to your FQDN.

    ??? warning "Troubleshoot - `Issued to` field showing NaN or blank"

        **If your certificate is incorrect, the AMT device will not connect to the MPS server. See Figure 1.**

        Follow the steps below to correct the problem.

        !!! example "Example - Incorrect MPS Certificate"
            <figure class="figure-image">
                <img src="..\..\..\..\assets\images\screenshots\MPS_Certificate.png" alt="Figure 1: Incorrect Certificate">
                <figcaption>Figure 1: Incorrect Certificate</figcaption>
            </figure>
            
        1. Open and Login to Vault UI.

        2. Go to `kv/data/MPSCerts/` directory.

        3. Delete the existing MPS Certificate.

        4. In a terminal, run the following command.

            ```
            kubectl rollout restart deployment mps 
            ```

        5. A new, correct MPS Cert should be generated.

        6. Go back to the webserver in your browser.

            ```
            https://<Your-AWS-FQDN>:4433
            ```
        
        7. Verify the `Issued to:` field is no longer NaN/blank and now shows the correct FQDN.

        8. Continue to Next Steps section.


## Next Steps

Visit the Sample Web UI using the FQDN name and [**Continue from the Get Started steps**](../../../GetStarted/Cloud/loginToUI.md).