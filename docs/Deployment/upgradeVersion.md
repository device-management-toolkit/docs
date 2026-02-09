
## Specific Changes Required for Version Upgrades

!!! important Upgrade Notice
    Every deployment environment is unique. The prerequisites and setup steps provided here serve as general guidance for running the latest published images.
    Please ensure you follow your organization’s internal deployment, security, and validation procedures when upgrading or updating your environment.

### Upgrade to 2.28 (Sep 25) from 2.18 (Dec 23) or later

The 2.28 release of DMT Cloud Deployment requires updates to the `rpsdb` database. If upgrading from **2.18 (Dec 23)** or any later version, run the following SQL scripts to add or modify tables before continuing with the upgrade

1. Run the following SQL scripts to alter constraints and add new tables before upgrading the services.

    ```sql title="rpsdb - Add new column to Profiles table"
    ALTER TABLE IF EXISTS profiles
    ADD COLUMN IF NOT EXISTS uefi_wifi_sync_enabled BOOLEAN NULL;
    ```

    ```sql title="rpsdb - Create proxyconfigs table"
    CREATE TABLE IF NOT EXISTS proxyconfigs(
        proxy_config_name citext,
        address citext NOT NULL,
        info_format integer NOT NULL,
        port integer NOT NULL,
        network_dns_suffix varchar(192),
        creation_date timestamp,
        tenant_id varchar(36),
        CONSTRAINT address_port_tenant_id UNIQUE (address, port, tenant_id),
        PRIMARY KEY (proxy_config_name, tenant_id)
    );
    ```

    ```sql title="rpsdb - Create profiles_proxyconfigs table"
    CREATE TABLE IF NOT EXISTS profiles_proxyconfigs(
        proxy_config_name citext,
        profile_name citext,
        FOREIGN KEY (proxy_config_name,tenant_id)  REFERENCES proxyconfigs(proxy_config_name,tenant_id),
        FOREIGN KEY (profile_name,tenant_id)  REFERENCES profiles(profile_name,tenant_id),
        priority integer,
        creation_date timestamp,
        created_by varchar(40),
        tenant_id varchar(36),
        PRIMARY KEY (proxy_config_name, profile_name, priority, tenant_id)
    );
    ```

    ???+ example "Example - Adding Columns and Tables to PostgresDB using psql"
        This example walks through one potential option to update a Postgres Database using psql.

        1. Open a Command Prompt or Terminal.

        2. Connect to your Postgres instance and `rpsdb` database. Provide the hostname of the database, the port (Postgres default is 5432), the database `rpsdb`, and your database user.
                ```
                psql -h [HOSTNAME] -p 5432 -d rpsdb -U [DATABASE USER]
                ```

                ??? example "Example Commands"
                        ```
                        Azure:
                        psql -h myazuredb-sql.postgres.database.azure.com -p 5432 -d rpsdb -U postgresadmin@myazuredb-sql

                        AWS:
                        psql -h myawsdb-1.jotd7t2abapq.us-west-2.rds.amazonaws.com -p 5432 -d rpsdb -U postgresadmin
                        ```

        3. Provide your Postgres user password.

        4. Run the SQL Statements.

        5. Verify the changes were applied correctly.
                ```sql
                \d profiles
                \d proxyconfigs
                \d profiles_proxyconfigs
                ```

2. Continue with [Upgrade a Minor Version](#upgrade-a-minor-version-ie-2x-to-2y) steps below.

### Upgrade to 2.18 (Dec 23) from 2.17 (Nov 23)

The 2.17 release of Open AMT requires an upgrade to the `rpsdb` database.

1. Run the following SQL script to alter constraints before upgrading the services.

    ``` sql title="rpsdb"
    ALTER TABLE IF EXISTS profiles
    ADD COLUMN IF NOT EXISTS local_wifi_sync_enabled BOOLEAN NULL;
    ```

    ???+ example "Example - Adding Columns to PostgresDB using psql"
        This example walks through one potential option to update a Postgres Database using psql. 

        1. Open a Command Prompt or Terminal.

        2. Connect to your Postgres instance and `rpsdb` database. Provide the hostname of the database, the port (Postgres default is 5432), the database `rpsdb`, and your database user.
            ```
            psql -h [HOSTNAME] -p 5432 -d rpsdb -U [DATABASE USER]
            ```

            ??? example "Example Commands"
                ```
                Azure:
                psql -h myazuredb-sql.postgres.database.azure.com -p 5432 -d rpsdb -U postgresadmin@myazuredb-sql

                AWS:
                psql -h myawsdb-1.jotd7t2abapq.us-west-2.rds.amazonaws.com -p 5432 -d rpsdb -U postgresadmin
                ```

        3. Provide your Postgres user password.

        4. Run the SQL Statements.

        5. Verify the constraints were modified correctly.
            ``` sql
            SELECT * FROM profiles;
            ```

### Upgrade to 2.17 (Nov 23) from 2.16 (Oct 23)

The 2.17 release of Open AMT requires an upgrade to the `mpsdb` database.

1. Run the following SQL script to alter constraints before upgrading the services.

    ``` sql title="mpsdb"
    ALTER TABLE devices
    ADD COLUMN IF NOT EXISTS lastconnected timestamp with time zone,
    ADD COLUMN IF NOT EXISTS lastseen timestamp with time zone,
    ADD COLUMN IF NOT EXISTS lastdisconnected timestamp with time zone;
    ```

    ??? example "Example - Adding Columns to PostgresDB using psql"
        This example walks through one potential option to update a Postgres Database using psql. 

        1. Open a Command Prompt or Terminal.

        2. Connect to your Postgres instance and `mpsdb` database. Provide the hostname of the database, the port (Postgres default is 5432), the database `mpsdb`, and your database user.
            ```
            psql -h [HOSTNAME] -p 5432 -d mpsdb -U [DATABASE USER]
            ```

            ??? example "Example Commands"
                ```
                Azure:
                psql -h myazuredb-sql.postgres.database.azure.com -p 5432 -d mpsdb -U postgresadmin@myazuredb-sql

                AWS:
                psql -h myawsdb-1.jotd7t2abapq.us-west-2.rds.amazonaws.com -p 5432 -d mpsdb -U postgresadmin
                ```

        3. Provide your Postgres user password.

        4. Run the SQL Statements.

        5. Verify the constraints were modified correctly.
            ``` sql
            SELECT * FROM devices;
            ```

2. Continue with [Upgrade a Minor Version](#upgrade-a-minor-version-ie-2x-to-2y) steps below.

### Upgrade to 2.16 (Oct 23) from 2.15 (Sep 23)

The 2.16 release of Open AMT requires an upgrade to both the `mpsdb` and `rpsdb` databases. More information about why we've made this change can be found in the [October 2023 Release Notes](https://device-managment-toolkit.github.io/docs/2.16/release-notes/#whats-new).

1. Run the following SQL script to alter constraints before upgrading the services.

    ``` sql title="mpsdb"
    ALTER TABLE devices
    ADD COLUMN IF NOT EXISTS deviceInfo json;
    ```

    ``` sql title="rpsdb"
    ALTER TABLE domains
    ADD COLUMN IF NOT EXISTS expiration_date timestamp;
    ```

    ??? example "Example - Adding Columns to PostgresDB using psql"
        This example walks through one potential option to update a Postgres Database using psql. Change the database passed using the `-d` flag to either `mpsdb` or `rpsdb` as needed.

        1. Open a Command Prompt or Terminal.

        2. Connect to your Postgres instance and `mpsdb` database. Provide the hostname of the database, the port (Postgres default is 5432), the database `mpsdb`, and your database user.
            ```
            psql -h [HOSTNAME] -p 5432 -d mpsdb -U [DATABASE USER]
            ```

            ??? example "Example Commands"
                ```
                Azure:
                psql -h myazuredb-sql.postgres.database.azure.com -p 5432 -d mpsdb -U postgresadmin@myazuredb-sql

                AWS:
                psql -h myawsdb-1.jotd7t2abapq.us-west-2.rds.amazonaws.com -p 5432 -d mpsdb -U postgresadmin
                ```

        3. Provide your Postgres user password.

        4. Run the SQL Statements.

        5. Verify the constraints were modified correctly.
            ``` sql
            SELECT * FROM devices;
            ```

2. Continue with [Upgrade a Minor Version](#upgrade-a-minor-version-ie-2x-to-2y) steps below.

### Upgrade to 2.15 (Sep 23) from 2.14 (Aug 23)

The 2.15 release of Open AMT requires an upgrade to the `rpsdb` database. More information about why we've made this change can be found in the [September 2023 Release Notes](https://device-managment-toolkit.github.io/docs/2.15/release-notes/#whats-new).

1. Run the following SQL script to alter constraints before upgrading the services.

    ``` sql
    ALTER TABLE domains
    DROP CONSTRAINT IF EXISTS domains_pkey;
    DROP INDEX CONCURRENTLY IF EXISTS lower_name_suffix_idx;
    ALTER TABLE domains
    ADD CONSTRAINT domainname UNIQUE (name, tenant_id);
    ALTER TABLE domains
    ADD PRIMARY KEY (name, domain_suffix, tenant_id);
    ```

    ??? example "Example - Adding Columns to PostgresDB using psql"
        This example walks through one potential option to update a Postgres Database using psql.

        1. Open a Command Prompt or Terminal.

        2. Connect to your Postgres instance and `rpsdb` database. Provide the hostname of the database, the port (Postgres default is 5432), the database `rpsdb`, and your database user.
            ```
            psql -h [HOSTNAME] -p 5432 -d rpsdb -U [DATABASE USER]
            ```

            ??? example "Example Commands"
                ```
                Azure:
                psql -h myazuredb-sql.postgres.database.azure.com -p 5432 -d rpsdb -U postgresadmin@myazuredb-sql

                AWS:
                psql -h myawsdb-1.jotd7t2abapq.us-west-2.rds.amazonaws.com -p 5432 -d rpsdb -U postgresadmin
                ```

        3. Provide your Postgres user password.

        4. Run the SQL Statements.

        5. Verify the constraints were modified correctly.
            ``` sql
            \d domains;
            ```

2. Continue with [Upgrade a Minor Version](#upgrade-a-minor-version-ie-2x-to-2y) steps below.

### No Extra Changes Required between 2.14 (Aug 23) and 2.11 (May 23)

### Upgrade to 2.11 from 2.10

The 2.11 release of RPS requires an upgrade to the `rpsdb` database.

1. Run the following SQL script to add the new table before upgrading the services.

    ``` sql
    ALTER TABLE IF EXISTS profiles
    ADD COLUMN IF NOT EXISTS ip_sync_enabled BOOLEAN NULL;
    ```

    ??? example "Example - Adding Columns to PostgresDB using psql"
        This example walks through one potential option to update a Postgres Database using psql.

        1. Open a Command Prompt or Terminal.

        2. Connect to your Postgres instance and `rpsdb` database. Provide the hostname of the database, the port (Postgres default is 5432), the database `rpsdb`, and your database user.
            ```
            psql -h [HOSTNAME] -p 5432 -d rpsdb -U [DATABASE USER]
            ```

            ??? example "Example Commands"
                ```
                Azure:
                psql -h myazuredb-sql.postgres.database.azure.com -p 5432 -d rpsdb -U postgresadmin@myazuredb-sql

                AWS:
                psql -h myawsdb-1.jotd7t2abapq.us-west-2.rds.amazonaws.com -p 5432 -d rpsdb -U postgresadmin
                ```

        3. Provide your Postgres user password.

        4. Run the SQL Statements.

        5. Verify the column was added to the table.
            ``` sql
            SELECT * FROM profiles;
            ```

2. Continue with general upgrade steps below.

### Upgrade to 2.10 from 2.9

The 2.10 release of RPS requires an upgrade to the `rpsdb` database.

1. Run the following SQL script to add the new table before upgrading the services.

    ``` sql
    ALTER TABLE IF EXISTS wirelessconfigs
    ADD COLUMN IF NOT EXISTS ieee8021x_profile_name citext,
    ADD CONSTRAINT ieee8021xconfigs_fk FOREIGN KEY (ieee8021x_profile_name, tenant_id)  REFERENCES ieee8021xconfigs (profile_name, tenant_id);
    ```

    ??? example "Example - Adding Columns to PostgresDB using psql"
        This example walks through one potential option to update a Postgres Database using psql.

        1. Open a Command Prompt or Terminal.

        2. Connect to your Postgres instance and `rpsdb` database. Provide the hostname of the database, the port (Postgres default is 5432), the database `rpsdb`, and your database user.
            ```
            psql -h [HOSTNAME] -p 5432 -d rpsdb -U [DATABASE USER]
            ```

            ??? example "Example Commands"
                ```
                Azure:
                psql -h myazuredb-sql.postgres.database.azure.com -p 5432 -d rpsdb -U postgresadmin@myazuredb-sql

                AWS:
                psql -h myawsdb-1.jotd7t2abapq.us-west-2.rds.amazonaws.com -p 5432 -d rpsdb -U postgresadmin
                ```

        3. Provide your Postgres user password.

        4. Run the SQL Statements.

        5. Verify the column was added to the table.
            ``` sql
            SELECT * FROM wirelessconfigs;
            ```

2. Continue with general upgrade steps below.

### Upgrade to 2.9 from 2.8

The 2.9 release of RPS requires an upgrade to the `rpsdb` database.

1. Run the following SQL script to add the new table before upgrading the services.

    ``` sql
    CREATE TABLE IF NOT EXISTS ieee8021xconfigs(
        profile_name citext,
        auth_protocol integer,
        servername VARCHAR(255),
        domain VARCHAR(255),
        username VARCHAR(255),
        password VARCHAR(255),
        roaming_identity VARCHAR(255),
        active_in_s0 BOOLEAN,
        pxe_timeout integer,
        wired_interface BOOLEAN NOT NULL,
        tenant_id varchar(36) NOT NULL,
        PRIMARY KEY (profile_name, tenant_id),
    );
    ```

2. Update the Profiles table.

    ``` sql
    ALTER TABLE IF EXISTS profiles
    ADD COLUMN IF NOT EXISTS ieee8021x_profile_name citext,
    ADD CONSTRAINT ieee8021xconfigs_fk FOREIGN KEY (ieee8021x_profile_name, tenant_id)  REFERENCES ieee8021xconfigs (profile_name, tenant_id);
    ```

    ??? example "Example - Adding Columns to PostgresDB using psql"
        This example walks through one potential option to update a Postgres Database using psql.

        1. Open a Command Prompt or Terminal.

        2. Connect to your Postgres instance and `rpsdb` database. Provide the hostname of the database, the port (Postgres default is 5432), the database `rpsdb`, and your database user.
            ```
            psql -h [HOSTNAME] -p 5432 -d rpsdb -U [DATABASE USER]
            ```

            ??? example "Example Commands"
                ```
                Azure:
                psql -h myazuredb-sql.postgres.database.azure.com -p 5432 -d rpsdb -U postgresadmin@myazuredb-sql

                AWS:
                psql -h myawsdb-1.jotd7t2abapq.us-west-2.rds.amazonaws.com -p 5432 -d rpsdb -U postgresadmin
                ```

        3. Provide your Postgres user password.

        4. Run the SQL Statements.

        5. Verify the column was added to the table.
            ``` sql
            SELECT * FROM ieee8021xconfigs;
            ```

3. Continue with general upgrade steps below.

### Upgrade to 2.8 from 2.7

The 2.8 release of RPS requires an upgrade to the `rpsdb` database.

1. Run the following SQL script to add the new column before upgrading the services.

    ``` sql
    ALTER TABLE IF EXISTS profiles
    ADD COLUMN IF NOT EXISTS tls_signing_authority varchar(40) NULL;
    ```

    ??? example "Example - Adding Columns to PostgresDB using psql"
        This example walks through one potential option to update a Postgres Database using psql.

        1. Open a Command Prompt or Terminal.

        2. Connect to your Postgres instance and `rpsdb` database. Provide the hostname of the database, the port (Postgres default is 5432), the database `rpsdb`, and your database user.
            ```
            psql -h [HOSTNAME] -p 5432 -d rpsdb -U [DATABASE USER]
            ```

            ??? example "Example Commands"
                ```
                Azure:
                psql -h myazuredb-sql.postgres.database.azure.com -p 5432 -d rpsdb -U postgresadmin@myazuredb-sql

                AWS:
                psql -h myawsdb-1.jotd7t2abapq.us-west-2.rds.amazonaws.com -p 5432 -d rpsdb -U postgresadmin
                ```

        3. Provide your Postgres user password.

        4. Run the SQL Statement.

        5. Verify the column was added to the table.
            ``` sql
            SELECT * FROM profiles;
            ```

2. Continue with general upgrade steps below.

### Upgrade to 2.7 from 2.6

The 2.7 release of MPS requires an upgrade to the `mpsdb` database.

1. Run the following SQL script to add two new columns before upgrading the services.

    ``` sql
    ALTER TABLE devices 
    ADD COLUMN IF NOT EXISTS friendlyname varchar(256),
    ADD COLUMN IF NOT EXISTS dnssuffix varchar(256);
    ```

    ??? example "Example - Adding Columns to PostgresDB using psql"
        This example walks through one potential option to update a Postgres Database using psql.

        1. Open a Command Prompt or Terminal.

        2. Connect to your Postgres instance and `mpsdb` database. Provide the hostname of the database, the port (Postgres default is 5432), the database `mpsdb`, and your database user.
            ```
            psql -h [HOSTNAME] -p 5432 -d mpsdb -U [DATABASE USER]
            ```

            ??? example "Example Commands"
                ```
                Azure:
                psql -h myazuredb-sql.postgres.database.azure.com -p 5432 -d mpsdb -U postgresadmin@myazuredb-sql

                AWS:
                psql -h myawsdb-1.jotd7t2abapq.us-west-2.rds.amazonaws.com -p 5432 -d mpsdb -U postgresadmin
                ```

        3. Provide your Postgres user password.

        4. Run the SQL Statement.

        5. Verify the columns were added to the table.
            ``` sql
            SELECT * FROM devices;
            ```

2. Continue with general upgrade steps below.


## Upgrade a Minor Version (i.e. 2.X to 2.Y)

### Kubernetes Upgrade

Upgrading from a previous minor version to a new minor version release is simple using Helm. By updating your image tags and upgrading through Helm, a seamless transition can be made. Stored profiles and secrets will be unaffected and any connected devices will transition over to the new MPS pod.

??? note "Note - Using Private Images"
    The steps are the same if using your own images built and stored on a platform like Azure Container Registry (ACR) or Elastic Container Registry (ECR). Simply point to the new private images rather than the public Intel Dockerhub.

1. Pull the latest release within `.\cloud-deployment` directory.

    ```
    git pull
    ```

2. Merge the latest changes into your existing branch.

    ```
    git merge v{{ repoVersion.oamtct }}
    ```

3. In the values.yaml file, update the images to the new version wanted. Alternatively, you can use the `latest` tags.

    !!! example "Example - values.yaml File"
        ```yaml hl_lines="2-5"
        images:
          mps: "intel/oact-mps:latest"
          rps: "intel/oact-rps:latest"
          webui: "intel/oact-webui:latest"
          mpsrouter: "intel/oact-mpsrouter:latest"
        mps:
          ...
        ```

4. In Terminal or Command Prompt, go to the deployed cloud-deployment repository directory.

    ```
    cd ./YOUR-DIRECTORY-PATH/cloud-deployment
    ```

5. Use Helm to upgrade and deploy the new images.

    ```
    helm upgrade devicemgmtstack ./kubernetes/charts
    ```

    !!! success "Successful Helm Upgrade"
        ```
        Release "devicemgmtstack" has been upgraded. Happy Helming!
        NAME: devicemgmtstack
        LAST DEPLOYED: Wed Mar 23 09:36:10 2022
        NAMESPACE: default
        STATUS: deployed
        REVISION: 2
        ```

6. Verify the new pods are running. Notice the only restarted and recreated pods are MPS, RPS, and the WebUI.

    ```
    kubectl get pods
    ```

    !!! example "Example - Upgraded Running Pods"
        ```
        NAME                                                 READY   STATUS    RESTARTS   AGE
        mps-55f558666b-5m9bq                                 1/1     Running   0          2m47s
        mpsrouter-6975577696-wn8wm                           1/1     Running   0          27d
        devicemgmtstack-kong-5999cc6b97-wbmdw                   2/2     Running   0          27d
        devicemgmtstack-vault-0                                 1/1     Running   0          27d
        devicemgmtstack-vault-agent-injector-6d6c75f7d5-sh5nm   1/1     Running   0          27d
        rps-597d7894b5-mbdz5                                 1/1     Running   0          2m47s
        webui-6d9b96c989-29r9z                               1/1     Running   0          2m47s
        ```

#### Rollback a Version

Is the functionality not working as expected? Rollback to the previous deployment using Helm.

1. Use the Helm rollback command with the Revision you want to rollback to. In this example deployment, we would rollback to the original deployment revision which would be 1.

    ```
    helm rollback devicemgmtstack [Revision-Number]
    ```
    
    !!! success - "Successful Rollback" 
        ```
        Rollback was a success! Happy Helming!
        ```

### Local Docker Upgrade

The following steps outline how to upgrade using the public Docker Hub images. Data will not be lost unless Postgres or Vault need to be upgraded and restarted.

1. From the `.\cloud-deployment\` directory, pull the latest branches.
    ```
    git pull
    ```

2. Checkout the new release.
    ```
    git checkout v{{ repoVersion.oamtct }}
    ```

    ??? note "Note - Rebuilding New Images Locally"
        If building your own images, you will also have to checkout the newer release from each repo within `.\cloud-deployment\`.

        1. Pull the new releases of the submodules.
            ```
            git submodule update --recursive
            ```

        2. Checkout the release for each of the services you want to upgrade.
            ```
            cd mps
            git checkout v{{ repoVersion.mpsAPI }}
            ```

        3. Repeat for other services.

        4. Build the new images.
            ```
            docker compose up -d --build
            ```

3. Pull the new release Docker Hub images.
    ```
    docker compose pull
    ```

4. Start the new containers.
    ```
    docker compose up -d --remove-orphans
    ```

5. OPTIONAL. If using versioned tags rather than `latest`, you can delete older tagged images using the following. **This will delete all unused images**. If you have other non Device Management Toolkit images you wish to keep, **do NOT** run this command.
    ```
    docker image prune -a
    ```

<!-- ## Upgrade LTS or Major Versions (i.e. 2.X to 3.Y) -->
