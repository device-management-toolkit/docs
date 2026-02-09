

MPS can support NoSQL databases. This is an optional alternative to the existing SQL-based reference deployment that uses Postgres. RPS will still require a relational database such as PostgreSQL.

NoSQL databases come in a variety of types based on their data model. The main types are document, key-value, wide-column, and graph. They provide flexible schemas and scale easily with large amounts of data and high user loads.

NoSQL support is integrated using the MongoDB API. This does not just limit integration options to MongoDB itself, but can utilize other providers such as:

- [Azure Cosmos DB](https://azure.microsoft.com/en-us/products/cosmos-db)
- [Amazon DocumentDB](https://aws.amazon.com/documentdb/)
- [Oracle Autonomous JSON Database](https://www.oracle.com/autonomous-database/autonomous-json-database/)

## MongoDB Docker Deployment

The below steps will show how to modify the basic [Device Management Toolkit Getting Started Docker deployment](../../GetStarted/Cloud/setup.md) to integrate MongoDB for MPS to store and reference device data.

1. Stop any running containers. This will wipe all data and devices will have to be reprovisioned against the new RPS/MPS servers.

    ``` bash
    docker compose down -v
    ```
  
### Edit Environment Variables

1. Open the `.env` file.

2. Add a new environment variable in the MPS section.

    ``` hl_lines="5"
    ...
    MPS_JWT_SECRET=secret
    MPS_JWT_ISSUER=9EmRJTbIiIb4bIeSsmgcWIjrR6HyETqc
    MPS_MQTT_ADDRESS=
    MPS_DB_PROVIDER=mongo

    # MPS ROUTER
    PORT=8003
    ...
    ```

3. Save the file.

### Edit `docker-compose.yml`

1. Open the `docker-compose.yml` file.

2. Add the Mongo image and configuration. This guide reuses the preexisting `POSTGRES_USER` and `POSTGRES_PASSWORD` environment variables for the MongoDB credentials and connection strings for easy configuration and demonstration. 

    ``` yaml
    mongo:
      image: mongo
      restart: always
      ports:
        - 27017:27017
      networks:
        - openamtnetwork
      environment:
        MONGO_INITDB_ROOT_USERNAME: ${POSTGRES_USER}
        MONGO_INITDB_ROOT_PASSWORD: ${POSTGRES_PASSWORD}
    ```

3. Update connection strings of `mps` and `mpsrouter`.

    ``` yaml hl_lines="2" title="mpsrouter"
    environment:
      MPS_CONNECTION_STRING: mongodb://${POSTGRES_USER}:${POSTGRES_PASSWORD}@mongo:27017
      PORT: ${PORT}
      MPS_PORT: ${MPSWEBPORT}
    ```

    ``` yaml hl_lines="6" title="mps"
    environment: 
      MPS_INSTANCE_NAME: ''
      MPS_SECRETS_PATH: ${SECRETS_PATH}
      MPS_VAULT_TOKEN: ${VAULT_TOKEN}
      MPS_VAULT_ADDRESS: ${VAULT_ADDRESS}
      MPS_CONNECTION_STRING: mongodb://${POSTGRES_USER}:${POSTGRES_PASSWORD}@mongo:27017
      MPS_CONSUL_ENABLED: ${CONSUL_ENABLED}
      MPS_CONSUL_HOST: ${CONSUL_HOST} 
      MPS_CONSUL_PORT: ${CONSUL_PORT}
      MPS_DB_PROVIDER: ${MPS_DB_PROVIDER}
    ```

4. Save the file.

### Deploy Stack

1.  Start the containers.
    
    ```
    docker compose up -d
    ```

2. Check that all the containers are running and healthy.

    ```
    {% raw %}
    docker ps --format "table {{.Image}}\t{{.Status}}\t{{.Names}}"
    {% endraw %}
    ```
    
    !!! success
        ``` bash hl_lines="9"
        IMAGE                               STATUS                        NAMES
        intel/oact-rps:latest               Up 19 seconds (healthy)        device-management-toolkit-rps-1      
        hashicorp/vault                     Up 19 seconds                  device-management-toolkit-vault-1    
        intel/oact-mpsrouter:latest         Up 19 seconds (healthy)        device-management-toolkit-mpsrouter-1
        postgres:15                         Up 19 seconds (healthy)        device-management-toolkit-db-1       
        intel/oact-webui:latest             Up 19 seconds                  device-management-toolkit-webui-1    
        kong:3.1                            Up 19 seconds (healthy)        device-management-toolkit-kong-1     
        intel/oact-mps:latest               Up 19 seconds (healthy)        device-management-toolkit-mps-1
        mongo                               Up 19 seconds                  device-management-toolkit-mongo-1
        ```

3. Now, updates will be made to the `devices` collection when actions affecting an AMT device occur (e.g. Device Provisioning/Unprovisioning).

<br>