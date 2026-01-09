

This guide will walk through how to enable an SSL connection in the Postgres Docker container. By default in the Getting Started Guide, we disable it to ease the setup process and environment for development.

For production environments, using a cloud-hosted database with an SSL connection to MPS/RPS is highly recommended as one step to maintain a secure deployment. Read more about cloud deployments for [Azure or AWS here](../Tutorials/Scaling/overview.md).

## Edit 'docker-compose.yml'

1. Update the RPS and MPS connection strings to `no-verify` instead of `disable`.

    ```yaml hl_lines="7"
    ...
    environment: 
      RPS_MPS_SERVER: http://mps:3000
      RPS_SECRETS_PATH: ${SECRETS_PATH}
      RPS_VAULT_TOKEN: ${VAULT_TOKEN}
      RPS_VAULT_ADDRESS: ${VAULT_ADDRESS}
      RPS_CONNECTION_STRING: postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@db:5432/rpsdb?sslmode=no-verify
    ...
    ```

    ```yaml hl_lines="7"
    {% raw %}
    ...
    environment: 
      MPS_INSTANCE_NAME: '{{.Task.Name}}'
      MPS_SECRETS_PATH: ${SECRETS_PATH}
      MPS_VAULT_TOKEN: ${VAULT_TOKEN}
      MPS_VAULT_ADDRESS: ${VAULT_ADDRESS}
      MPS_CONNECTION_STRING: postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@db:5432/mpsdb?sslmode=no-verify
    ...
    {% endraw %}
    ```

2. Uncomment the `command:` line in the `db` section.

    ```yaml hl_lines="5"
    ...
    build:
      context: ./pg
      dockerfile: ./Dockerfile
    command: -c ssl=on -c ssl_cert_file=/var/lib/postgresql/server.crt -c ssl_key_file=/var/lib/postgresql/server.key
    networks:
      - openamtnetwork
    ...
    ```

## Build Image

1. Build the new Postgres image with SSL enabled. 

    ```
    docker compose up -d --build
    ```