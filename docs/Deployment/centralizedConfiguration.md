
!!! warning "Centralized Configuration (Consul) is a Preview Feature"
    The Consul implementation feature is a Preview Feature and is subject to change. This means it has not been fully validated and cannot be guaranteed to work. There are still potential bugs and tweaks needed for a production-level feature standard. Interested in this feature and helping us test it? Reach out via GitHub.

Consul is a service networking solution and service mesh providing a wide variety of features to handle key networking or service management use cases. Read more about Consul [in their documentation](https://developer.hashicorp.com/consul).

Consul Use Cases:

- mTLS Encryption between Services
- Dynamic Load Balancing
- Observability (Health and Metrics)
- **Centralized Configuration of Services**

## Consul and Device Management Toolkit

As part of Device Management Toolkit, we are currently focused on the last bullet point. We've introduced Hashicorp Consul as an optional deployable service to centralize and ease configuration of the MPS and RPS services. In the future, we may expand and incorporate other capabilities offered by Consul.

MPS/RPS Startup Flows:

- If Consul exists on startup and empty, copy local configs into Consul.
- If Consul exists on startup and not empty, copy Consul configs down locally.
- If Consul does not exist on startup, load local configs into MPS/RPS.

The two configuration files are stored as K/V pairs within Consul under:

- /MPS/config
- /RPS/config

### Consul Configuration

By default, Consul is deployed as part of the local Docker deployment in the `docker-compose.yml` file.  This is the default configuration. Currently, we do not provide a Kubernetes deployment example.

The Consul configurations are stored in a local volume. When cleaning up containers, make sure to delete existing volumes.

``` yaml
  consul:
    restart: always
    image: hashicorp/consul
    networks:
      - openamtnetwork
    ports: 
      - 8500:8500
    volumes: 
       - type: volume 
         source: consul-config 
         target: /consul/config 
         volume: {} 
       - type: volume 
         source: consul-data 
         target: /consul/data 
         volume: {}    
    command: "agent -server -ui -node=OACT-1 -bootstrap-expect=1 -client=0.0.0.0"
```

## Enable Consul

1. This guide assumes you have completed the [Getting Started Guide](../GetStarted/Cloud/setup.md) and have Device Management Toolkit currently running in Docker containers.  If not, follow the [Get Started Guide Setup page](../GetStarted/Cloud/setup.md). Stop and return here after the your services are running.

2. In the `.env`, enable Consul and Save.

    ``` yaml
    # CONSUL
    CONSUL_ENABLED=true #update from false to true
    CONSUL_HOST=consul
    CONSUL_PORT=8500
    ```

3. Pull the Consul image. Read more about profiles in the Docker docs at [Using profiles with Compose](https://docs.docker.com/compose/profiles/).

    ```
    docker compose --profile consul pull
    ```

4.  Start the Consul container.
    
    ```
    docker compose --profile consul up -d
    ```

5. To view the Consul UI, visit `http://localhost:8500`.

6. Click **Key/Value** from the left-hand menu.

    <figure class="figure-image">
    <img src="..\..\assets\images\screenshots\Consul_KV_Overview.png" alt="Figure 1: Consul K/V Overview Page">
    <figcaption>Figure 1: Consul K/V Overview Page</figcaption>
    </figure>

7. Choose either the `/MPS` or `/RPS` directory, then `/config`.

    <figure class="figure-image">
    <img src="..\..\assets\images\screenshots\Consul_KV_MPS.png" alt="Figure 2: Consul K/V MPS Configuration">
    <figcaption>Figure 2: Consul K/V MPS Configuration</figcaption>
    </figure>

8. From here, users can make edits to the config files and save.

    !!! note "Note - Cleaning up Consul Container"
        When stopping and cleaning up containers deployed using the `consul` profile, you must also use that profile when running `docker compose down` in order to remove all resources.

        Example:
        ``` bash
        docker compose --profile consul down -v
        ```

Today, the current preview implementation does not update the MPS or RPS services realtime. They must be restarted manually to apply the new configurations.  

[Follow along with any new updates and features using Consul in our Feature Backlog.](https://github.com/orgs/device-managment-toolkit/projects/10)

<br>