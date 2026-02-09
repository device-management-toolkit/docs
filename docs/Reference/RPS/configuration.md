

## RPS Configuration 

The `.env` variables set have priority and overwrite the corresponding `.rpsrc` variables.

| `.env` Variable Name         | `.rpsrc` Variable Name   | Default                  | Description                                                                                      |
| :----------------------------| :------------------------| :------------------------| :------------------------------------------------------------------------------------------------|
| RPS_WEBSOCKETTLS             |                          |`true`                    | Enable/disable TLS on Websocket Connection                                                       |
| RPSWEBPORT                   | web_port                 |`8081`                    | Web API port to listen on                                                                        |
| RPSWEBSOCKETPORT             | websocketport            |`8080`                    | Websocket port to listen on                                                                      |
| RPS_LOG_LEVEL                |                          |`info`                    | Controls the level of logging provided in the service. Options are (in order of increasing detail): `error`, `warn`, `info`, `verbose`, `debug`, and `silly`  |
| RPS_DELAY_TIMER              | delay_timer              |`12`                      | Sets the number of seconds to wait after activation but before proceeding with final steps. By default it is set to 12 seconds. During this waiting period, RPS sends heartbeats to RPC to keep the connection alive. |
| RPS_MQTT_ADDRESS             | mqtt_address             |No Value                  | Address of where the mqtt broker is hosted. Mqtt container is named `mosquitto` and is open to port `8883`. Thus unless setting are changed the value should be either empty (off) or `mqtt://mosquitto:8883` (on) |
| RPS_SECRETS_PATH             | secrets_path             | `secret/data/`           | Path for where secrets are stored in the vault                                                    |
| RPS_VAULT_ADDRESS            | vault_address            | `http://localhost:8200`  | Address of where the vault is hosted                                                              |
| RPS_VAULT_TOKEN              | vault_token              | `myroot`                 | Token used to access the vault                                                                    |
| RPS_DB_PROVIDER              | db_provider              | `postgres`               | Database provider used (`postgres`)                                                               |
| RPS_SECRETS_PROVIDER         | secrets_provider         | `vault`                  | Secret provider used (`vault`)                                                                    |
| RPS_CONNECTION_STRING        | connection_string        | `postgresql://<USERNAME>:<PASSWORD>@localhost:5432/rpsdb` | The database connection string                                   | 
| RPS_CORS_ORIGIN              | cors_origin              | `http://localhost:4200`  | (NOT USED) Allowed origin for CORS policy                                                         |
| RPS_CORS_HEADER              | cors_header              | `Origin, X-Requested-With, Accept, Content-Type, csrf-token, authorization`  | (NOT USED) Allowed headers                    |
| RPS_CORS_METHODS             | cors_methods             | `*`                      | (NOT USED) Allowed methods                                                                        |
| RPS_MPS_SERVER               | mps_server               | `http://localhost:3000`  | Specifies where the MPS is hosted -- required for metadata registration (i.e. hostname, and tags) |
| RPS_DISABLE_CIRA_DOMAIN_NAME | disable_cira_domain_name | No Value                 | When AMT is on a network that matches the specified domain name, CIRA is disabled. If not set, a random domain name is generated to ensure CIRA connection on any network.   |
| RPS_CONSUL_ENABLED           | consul_enabled           | `false`                  | Enable/disable use of Consul for centralized configuration                                        |
| RPS_CONSUL_HOST              | consul_host              | `localhost`              | Address of where Consul is hosted                                                                 |
| RPS_CONSUL_PORT              | consul_port              | `8500`                   | Consul Port to listen on                                                                          |
| RPS_CONSUL_KEY_PREFIX        | consul_key_prefix        | `RPS`                    | Default prefix key for Consul data structure                                                      |
