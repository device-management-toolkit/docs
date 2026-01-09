
## MPS Configuration

The `.env` variables set have priority and overwrite the corresponding `.mpsrc` variables.

| `.env` Variable Name            | `.mpsrc` Variable Name       | Default                           | Description                                                                       |
| :-------------------------------| :----------------------------| :---------------------------------| :-------------------------------------------------------------------------------- |
| MPS_VAULT_ADDRESS               | vault_address                |`http://vault:8200` or `http://localhost:8200`| Address of where the vault is hosted                                   |
| MPS_GENERATE_CERTS              | generate_certificates        |`true`                             | Enables/Disables generation of self signed certificates based on MPS_COMMON_NAME  |
| MPS_COMMON_NAME                 | common_name                  |`localhost`                        | Common Name of MPS server. May be an IP or FQDN. Used when generating self-signed CIRA certificate.     |
| MPSPORT                         | port                         |`4433`                             | CIRA connection port to listen on                                                 |
| MPSWEBPORT                      | web_port                     |`3000`                             | Web API port to listen on                                                         |
| MPS_DEBUG                       |                              |`true`                             | NOT USED                                                                          |
| MPS_WEB_ADMIN_USER              | web_admin_user               |No Value                           | Username for Sample Web UI and API authentication                                 |
| MPS_WEB_ADMIN_PASSWORD          | web_admin_password           |No Value                           | Password for Sample Web UI and API authentication                                 |
| MPS_HTTPS                       |                              |`true`                             | Specifies whether or not to enable https                                          |
| MPS_TLS_OFFLOAD                 |                              |`false`                            | NOT USED                                                                          |
| MPS_LOG_LEVEL                   |                              |`info`                             | Controls the level of logging provided in the service. Options are (in order of increasing detail): `error`, `warn`, `info`, `verbose`, `debug`, and `silly`. |
| MPS_JWT_EXPIRATION              | jwt_expiration               |`1440`                             | The default expiration in minutes for the JWT Token. Default is 24 hours.         |
| MPS_JWT_SECRET                  | jwt_secret                   |No Value                           | Secret used for generating a JWT Token. IMPORTANT: This must match the `secret` in your `Kong.yaml` file for the jwt plugin configuration. |
| MPS_JWT_ISSUER                  | jwt_issuer                   |`9EmRJTbIiIb4bIeSsmgcWIjrR6HyETqc` | The issuer that will be populated in the token. This is a not considered a secret. IMPORTANT: This must match the `key:` property in the `Kong.yaml` file for the jwt plugin configuration. |
| MPS_MQTT_ADDRESS                | mqtt_address                 |No Value                           | Address of where the mqtt broker is hosted. Mqtt container is named `mosquitto` and is open to port `8883`. Thus unless setting are changed the value should be either empty (off) or `mqtt://mosquitto:8883` (on) |
| MPS_COUNTRY                     | country                      | `US`                              | Country for Self-Signed Certificate                             |
| MPS_COMPANY                     | company                      | `NoCorp`                          | Company for Self-Signed Certificate                             |
| MPS_WEB_AUTH_ENABLED            | web_auth_enabled             | `true`                            | MPS provides a simple auth using `web_admin_user` and `web_admin_password`. Set web_auth_enabled to `false` to disable this auth mechanism.  |
| MPS_VAULT_TOKEN                 | vault_token                  | `myroot`                          | Token used to access the vault                                  |
| MPS_SECRETS_PATH                | secrets_path                 | `secret/data/`                    | Path for where secrets are stored in the vault                  |
| MPS_SECRETS_PROVIDER            | secrets_provider             | `vault`                           | Secret provider used (`vault`)                                  |
| MPS_CERT_FORMAT                 | cert_format                  | `file`                            | Format to store certificates to Vault                           |
| MPS_DATA_PATH                   | data_path                    | `../private/data.json`            | File path to store Vault data locally                           |
| MPS_CERT_PATH                   | cert_path                    | `../private`                      | File path to store certificates in Vault locally                |
| MPS_CORS_ORIGIN                 | cors_origin                  | `*`                               | (NOT USED) Allowed origin for CORS policy                       |
| MPS_CORS_HEADER                 | cors_header                  | `*`                               | (NOT USED) Allowed headers                                      |
| MPS_CORS_METHODS                | cors_methods                 | `*`                               | (NOT USED) Allowed methods                                      |
| MPS_DB_PROVIDER                 | db_provider                  | `postgres`                        | Database provider used (`postgres`, `nosql`)                    |
| MPS_CONNECTION_STRING           | connection_string            | `postgresql://<USERNAME>:<PASSWORD>@localhost:5432/mpsdb?sslmode=no-verify` | The database connection string          | 
| MPS_INSTANCE_NAME               | instance_name                | `localhost`                       | Value used to record and address specific mps instances. (i.e containerIp in k8s) |
| MPS_TLS_CONFIG                  | mps_tls_config               |                                   | Used only if `generate_certificates = false` Cert settings for CIRA connection    |
| MPS_WEB_TLS_CONFIG              | web_tls_config               |                                   | NOT USED                                                        |
| MPS_REDIRECTION_EXPIRATION_TIME | redirection_expiration_time  | `5`                               | Default expiration for redirection token                        |
| MPS_CONSUL_ENABLED              | consul_enabled               | `false`                           | Enable/disable use of Consul for centralized configuration      |
| MPS_CONSUL_HOST                 | consul_host                  | `localhost`                       | Address of where Consul is hosted                               |
| MPS_CONSUL_PORT                 | consul_port                  | `8500`                            | Consul Port to listen on                                        |
| MPS_CONSUL_KEY_PREFIX           | consul_key_prefix            | `MPS`                             | Default prefix key for Consul data structure                    |


