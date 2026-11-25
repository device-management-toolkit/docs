
The diagrams below illustrates the database schema and relationships for MPS and RPS. 

### MPS
  ```mermaid
  erDiagram
      DEVICE {
          guid uuid
          string[] tags
          string hostname
          string mpsinstance
          boolean connectionstatus
          string mpsusername
          string tenantid
          string friendlyname
          string dnssuffix
          json deviceInfo
          datetime lastconnected
          datetime lastseen
          datetime lastdisconnected
          int powerstate
          int ospowersavingstate
          datetime powerstateupdatedat
      }
  ```
  
The nullable `powerstate` and `ospowersavingstate` fields store the last successfully cached device observations. `powerstateupdatedat` records the read start time as PostgreSQL `timestamp with time zone`. The device API exposes these as `powerState`, `osPowerSavingState`, and `powerStateUpdatedAt`. The background refresher, successful live power-state reads, and successful reads following power actions can populate these fields. An unavailable optional OS power-saving state is stored as `0` (unknown). Failed primary reads preserve the previous values and timestamp. Writes with an older read-start timestamp are ignored, and disconnecting retains the last-known observation. Consumers should check the timestamp when assessing freshness.

Existing PostgreSQL databases require the [power-state cache migration](../upgradeVersion.md#upgrade-to-mps-with-the-device-power-state-cache) before upgrading MPS.
### RPS
  ```mermaid
  erDiagram
      DOMAIN {
          string name
          string domain_suffix
          string provisioning_cert
          string provisioning_cert_storage_format
          string provisioning_cert_key
          datetime creation_date
          datetime expiration_date
          string created_by
          string tenant_id
      }
  ```
  ``` mermaid 
  erDiagram
      PROFILE o|--o| CIRACONFIGS : has
      PROFILE ||--|{ PROFILES_WIRELESSCONFIGS : associated
      PROFILE ||--o| IEEE8021XCONFIGS : has
      PROFILE {
        string profile_name
        string activation
        string amt_password
        boolean generate_random_password
        string cira_config_name
        datetime creation_date
        string created_by
        string mebx_password
        boolean generate_random_mebx_password
        string[] tags
        boolean dhcp_enabled
        string tenant_id
        int tls_mode
        string user_consent
        boolean ider_enabled
        boolean kvm_enabled
        boolean sol_enabled
        string tls_signing_authority
        string ieee8021x_profile_name
      }
      CIRACONFIGS 
      CIRACONFIGS {
        string cira_config_name
        string mps_server_address
        int mps_port
        string user_name
        string password
        string common_name
        int server_address_format
        int auth_method
        string mps_root_certificate
        string proxydetails
        string tenant_id
      }

      WIRELESSCONFIGS ||--|{ PROFILES_WIRELESSCONFIGS : belongs
      WIRELESSCONFIGS ||--o| IEEE8021XCONFIGS : has
      WIRELESSCONFIGS {
        string wireless_profile_name
        int authentication_method
        int encryption_method
        string ssid
        int psk_value
        string psk_passphrase
        int[] link_policy
        datetime creation_date
        string created_by
        string tenant_id
        string ieee8021x_profile_name
      }
      PROFILES_WIRELESSCONFIGS {
        string wireless_profile_name
        string profile_name
        int priority
        datetime creation_date
        string created_by
        string tenant_id
      }
      IEEE8021XCONFIGS {
        string profile_name
        int auth_protocol
        string servername
        string domain
        string username
        string password
        string roaming_identity
        boolean active_in_s0
        int pxe_timeout
        boolean wired_interface
        string tenant_id
      }
  ```