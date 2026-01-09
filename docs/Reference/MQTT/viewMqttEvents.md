

# Event Monitoring with MQTT (MQTT Eventing) 

Device Management Toolkit supports Eventing using Message Queuing Telemetry Transport (MQTT), an IoT publish-and-subscribe network protocol. With MQTT Eventing, administrators can subscribe to specific topics, categories of events, for server event monitoring. This eliminates the need to query or poll MPS to determine network events, such as a device's activation or deactivation. Administrators can subscribe to events and respond proactively. 

!!! important
    Currently, the implementation publishes all MPS and RPS REST API call events to the MQTT Broker. 

<figure class="figure-image">
<img src="..\..\..\assets\images\diagrams\MQTT.png" alt="Figure 1: MQTT Eventing Examples">
<figcaption>Figure 1: MQTT Eventing Examples</figcaption>
</figure>

MPS and RPS send JSON events to a Mosquitto* broker deployed as a Docker container. Administrators subscribe to the broker. As shown in Figure 1, proactive notifications are published in the MQTT Broker container.  


## Set Up MQTT Support

**To enable support:**

1. This guide assumes you have completed the [Getting Started Guide](../../GetStarted/Cloud/setup.md) and have Device Management Toolkit currently running in Docker containers.  If not, follow the [Get Started Guide Setup page](../../GetStarted/Cloud/setup.md). Stop and return here after the your services are running.

2. In a text editor or IDE of choice, open the `.env` file to edit.

3. Update the following fields. The `mqtt:` prefix indicates an MQTT broker is being used. Kong* will now route event messages to port 8883.

    | Field Name            | Set to:               | 
    | -------------         | ------------------    |
    | RPS_MQTT_ADDRESS      | mqtt://mosquitto:8883 | 
    | MPS_MQTT_ADDRESS      | mqtt://mosquitto:8883 |
   
4. Save and close the file.
    
5. Pull the Mosquitto image. Read more about profiles in the Docker docs at [Using profiles with Compose](https://docs.docker.com/compose/profiles/).

    ```
    docker compose --profile mqtt pull
    ```

6.  Start the Mosquitto container.
    
    ```
    docker compose --profile mqtt up -d
    ```        

    !!! note "Note - Cleaning up Mosquitto Container"
        When stopping and cleaning up containers deployed using the `mqtt` profile, you must also use that profile when running `docker compose down` in order to remove all resources.

        Example:
        ``` bash
        docker compose --profile mqtt down -v
        ```
<!-- **View in the Sample Web UI:**

1. Select MQTT Events from the left-hand menu.

2. Change the **Hostname**  to your IP Address from Localhost.
   
3. Do not set a port.

4. Verify the **Path** is `/mosquitto`.
    <figure class="figure-image">
    <img src="..\..\..\assets\images\screenshots\MQTTEvents_View.png" alt="Figure 2: MQTT Events Connection">
    <figcaption>Figure 2: MQTT Events Connection</figcaption>
    </figure>

    !!! troubleshooting
        If successful, the Connect circle should update to blue. If it is red, verify your Hostname and `.env` file is correct.

5. In the Sample Web UI, click on a different menu option, issue a command to a managed device from the **Devices** list, or make an API call to see an event appear in MQTT Events.

    MQTT Events can be customized to add, edit, or remove events. Read more in [Customizing MQTT Events](./customMqttEvents.md).

    !!! example "Example MQTT Events"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\/MQTTEvents_View_Example.png" alt="Figure 3: MQTT Events Connection">
        <figcaption>Figure 3: MQTT Events Connection</figcaption>
        </figure>

<br><br> -->