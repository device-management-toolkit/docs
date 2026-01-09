

RPS and MPS microservices can publish event messages through an MQTT Broker. The following instructions demonstrate how to add, remove, or edit the events published by the server. To learn more about subscribing to these events, see [Viewing MQTT Events](./viewMqttEvents.md).

Three main components can be manipulated within the MQTT event flow:

- Individual events throughout MPS and RPS
- MqttProvider class 
- MQTT broker

### Individual Events

#### Add Events

**To add an event:**

1. Import MqttProvider class.
2. Use the `publishEvent` method to add RPS or MPS events. 

Example:
   
``` ts
import { MqttProvider } from '../../utils/mqttProvider'

MqttProvider.publishEvent('success', ['Example'], 'Hello World', guid)
```
The `publishEvent` method parameters:

| Parameter    | Description                                        |
| :----------- | :------------------------------------------------- |
| message type | string designating the message type                |
| array of methods | methods associated with the message                |
| message    | string message to be published by the event broker |
| GUID         | device GUID (optional)                             |

!!! Note
    Learn more about `publishEvent` in the [MqttProvider Class](#mqttprovider-class).

#### Edit or Delete Events

A number of default events have been added to RPS and MPS, such as API calls and action events. Edit or delete any events that are unnecessary or irrelevant for your deployment. 

!!! Note
    Event publishing operates independently of the microservices. It will function normally with the addition, adaptation, or deletion of any individual events.

### MqttProvider Class

#### Connect

The `MqttProvider` class handles the interactions with the MQTT Broker.

**To establish a connection with the broker:** 

1. Open the `index.ts` file of RPS or MPS.
2. Add the following:

``` ts
  const mqtt: MqttProvider = new MqttProvider(config)
  mqtt.connectBroker()
```
The `connectBroker` method creates the connection between a client, stored in the class, and the `mosquitto` docker container, which acts as the MQTT Broker. The instance of the class, after it has been created and connected, is stored as a static object within the class. This storage enables access to the methods in the class with a simple import rather than passing the instance to MPS or RPS.

The config parameter contains the config types of MPS and RPS. `MqttProvider` uses the `MQTT_ADDRESS` environment variable to establish a connection. 

!!! Important
    The `MQTT_ADDRESS` environment variables for MPS and RPS are left blank in the .env.template file. This corresponds to the **OFF** state. To turn event logging with mosquitto **ON** provide the address of the MQTT Broker, `mqtt://mosquitto:8883`, to the `MPS_MQTT_ADDRESS` and `RPS_MQTT_ADDRESS` environment variables.

#### Usage <a name="MQTTUsage"></>

The `publishEvent` method publishes events to the MQTT Broker where subscribers can access event data. The method accepts information about an event, organizes it, adds a timestamp, and sends it to the MQTT Broker. 

Expand the setup by changing the parameters and the elements within `OpenAMTEvent`, the interface used to organize the message, or by adding new methods. Indicate information you'd like to receive by subscribing to Topics, which are organized in a directory-like structure. Topics enable administrators to narrow eventing to subjects of interest. 

!!! Example
    message type 'success'

    message: 'CarStarted'

    topic: `cars/ford`

Subscribers of `#`, `cars` or `cars/ford` receive the above message while subscribers of `trucks` or `cars/ferrari` will not. 

Use `publish` to send a message to the MQTT Broker and supply a topic as the first argument. Currently, the topic is hard-coded to a default value. Alter this value by adding a parameter, tying the topic to existing parameters, or create different publishEvent methods that correspond to different topics.

### MQTT Broker

The Broker for MQTT messages runs as the Docker* container `mosquitto` with the image `eclipse-mosquitto:latest`. Make changes to the functionality of the Broker through `mosquitto.conf`. Most of the Broker setup has been left in its default state but more information about customizing the broker can be found [here](https://mosquitto.org/man/mosquitto-conf-5.html).
