--8<-- "References/abbreviations.md"

This setup runs the MPS and RPS microservices as Docker* containers, standardized packages containing an application's source code, libraries, environment, and dependencies. 

## Get the Toolkit

**To clone the repositories:**

1. Open a Terminal or Command Prompt and navigate to a directory of your choice for development:

    ``` bash
    git clone https://github.com/device-management-toolkit/cloud-deployment --branch v{{ repoVersion.oamtct }} --recursive
    ```
  
2. Change to the cloned `device-management-toolkit` directory.
    ``` bash
    cd device-management-toolkit
    ```

## Set Environment Variables  

The  `.env.template` file is used by docker to set environment variables.

**To set the environment variables:**

1. Copy the `.env.template` file to `.env`:

    === "Linux/Powershell"
        ```
        cp .env.template .env
        ```
    
    === "Windows (Cmd Prompt)"
        ```
        copy .env.template .env
        ```

2. In a text editor or IDE of choice, open the new `.env` file to edit.

3. Update the following fields for configuring the MPS, Sample Web UI, Vault and Postgres. Save and keep track of the values you choose.

    | Field Name | Required | Usage |
    | -------------          | ------------------ | ------------ |
    | MPS_COMMON_NAME        | Development System IP Address. | For connecting to MPS server via UI or APIs. **WARNING: Do not use localhost. Use the development system IP Address.**|
    | MPS_WEB_ADMIN_USER     | Username of your choice            | For logging into the Sample Web UI |
    | MPS_WEB_ADMIN_PASSWORD | **Strong** password of your choice | For logging into the Sample Web UI |
    | MPS_JWT_SECRET         | A strong secret of your choice (Example: A unique, random 256-bit string. See another example in [code snippet below](#set-kong-json-web-token-jwt)).    | Used when generating a JSON Web Token (JWT) for authentication. This example implementation uses a symmetrical key and HS256 to create the signature. [Learn more about JWT](https://jwt.io/introduction){target=_blank}.|
    | POSTGRES_PASSWORD      | **Strong** password of your choice | For logging into the Postgres |
    | VAULT_TOKEN            | **Strong** token of your choice    | For logging into the vault |

    !!! important "Important - Using Strong Passwords"
        The MPS_WEB_ADMIN_PASSWORD must meet standard, **strong** password requirements:

        - 8 to 32 characters

        - One uppercase, one lowercase, one numerical digit, one special character

4. Save the file.

## Set Kong JSON Web Token (JWT)

Set the shared secret used in Kong for JWT authentication.

1. Open the `kong.yaml` file.

2. Update the *secret* field with your MPS_JWT_SECRET.

    ``` yaml hl_lines="4"
    jwt_secrets:
      - consumer: admin
        key: 9EmRJTbIiIb4bIeSsmgcWIjrR6HyETqc #sample key
        secret: "Yq3t6w9z6CbE3HRMcQfTjWnZr4u7x6AJ" #sample secret, DO NOT use for production
    ```

3. Save and close the file.


## <a name="Builddockerimages"></a>Pull and Run the Docker Images

1. Pull the Docker images from [Intel's Docker Hub repository](https://hub.docker.com/search?q=oact&type=image).

    ??? important "Important for Linux - Using `sudo` with Docker"
        The Docker daemon always runs as the root user and therefore requires `sudo`. If you do not want to preface all Docker commands with `sudo`, see [Linux post-installation steps for Docker Engine](https://docs.docker.com/engine/install/linux-postinstall/) in the Docker Documentation.

    ```
    docker compose pull
    ```

    ??? note "Note for ARM -  ARM-based Devices must Build Images"
        ARM-based devices (i.e. newer-generation Mac products and others) will need to build the images rather than use the prebuilt Dockerhub images.
        ```
        docker compose up -d --build
        ```

    ??? note "Note - Using SSL with Postgres Container"
        By default in the Getting Started Guide, we do not enable an SSL connection for Postgres for ease of development. See [SSL with Local Postgres](../../Reference/sslpostgresLocal.md) for how to enable SSL in your local Postgres container. For production environments, using a cloud-hosted database with an SSL connection to MPS/RPS is highly recommended as one step to maintain a secure deployment. Read more about cloud deployments for [Azure or AWS here](../../Tutorials/Scaling/overview.md).

2.  Start the containers.
    
    ```
    docker compose up -d
    ```

3. Check that all the containers are running and healthy.

    ```
    {% raw %}
    docker ps --format "table {{.Image}}\t{{.Status}}\t{{.Names}}"
    {% endraw %}
    ```

    **Because Vault is running in a dev mode, stored secrets will be lost upon a restart**, and profiles and configs must be recreated. They are not persistent in this mode. To persist data, run vault in production mode. See [Production Mode Vault](../../Reference/productionVault.md).
    
    !!! success
        ``` bash
        IMAGE                               STATUS                        NAMES
        intel/oact-rps:latest               Up 2 minutes (healthy)        open-amt-cloud-toolkit-rps-1      
        hashicorp/vault                     Up 2 minutes                  open-amt-cloud-toolkit-vault-1    
        intel/oact-mpsrouter:latest         Up 2 minutes (healthy)        open-amt-cloud-toolkit-mpsrouter-1
        postgres:15                         Up 2 minutes (healthy)        open-amt-cloud-toolkit-db-1       
        intel/oact-webui:latest             Up 2 minutes                  open-amt-cloud-toolkit-webui-1    
        kong:3.1                            Up 2 minutes (healthy)        open-amt-cloud-toolkit-kong-1     
        intel/oact-mps:latest               Up 2 minutes (healthy)        open-amt-cloud-toolkit-mps-1
        ```
  
    !!! warning "Warning - Container Issues" 

        If any of the above containers are not running, walk through the steps again or file a GitHub issue [here]( https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit/issues).

        If the Kong container reloads repeatedly, verify kong.yaml edits. Misconfiguration of this file will cause the container to reload.
    

## Next up
[**Login to Sample Web UI**](loginToUI.md)
