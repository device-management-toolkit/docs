--8<-- "References/abbreviations.md"
To prepare for a production environment, replace Hashicorp Vault* with a secrets management provider. 

To replace secrets management, update these services:

- MPS
- RPS 

## What You'll Do
This guide focuses on updating the secrets management with Azure Key Vault*. 

Here are the main tasks:

- Review Vault Schema
- Add Secret Provider Dependency (if necessary)
- Update Configuration
- Implement the Code

!!! warning "Secrets Management Recipe"
    The example implementation below provides a step-by-step outline of secrets management deployment. However, it is intended as a general guideline. You will need to write specific source code to support your custom solution. 

!!! note
    This guide will assume Azure Key Vault is already configured and ready for use as it focuses on the code that needs to be implemented in the microservices.

## Review Vault Schema

Below are the paths/keys in the vault that are used by the Device Management Toolkit.

```
# RPS
CIRAConfigs/[cira_config_name]/MPS_PASSWORD

certs/[domain_profile_name]/CERT
certs/[domain_profile_name]/CERT_PASSWORD

profiles/[profile_name]/AMT_PASSWORD
profiles/[profile_name]/MEBX_PASSWORD

wireless/[wireless_profile_name]/PSK_PASSPHRASE

# MPS
devices/[device_guid]/AMT_PASSWORD
devices/[device_guid]/MEBX_PASSWORD
devices/[device_guid]/MPS_PASSWORD
```

## Add Dependency

**To install the required dependencies:**

Open a Terminal or Command Prompt and navigate to a directory of your choice for development:

   ```
   npm install @azure/keyvault-secrets
   ```

   ```
   npm install @azure/identity
   ```

!!! note 
    To read more about this dependency, check out [Azure Key Value Secret Client library for JavaScript](https://www.npmjs.com/package/@azure/keyvault-secrets). 



## Update Configuration

**To modify the configuration:**

1. Modify the properties for Hashicorp Vault:

     **Before:**

     ``` json
     {
        "secrets_path": "secret/data/",
        "vault_address": "http://localhost:8200",
        "vault_token": "myroot",
     }
     ```

     **After:**

     For Azure Key Vault, you only need the address:

     ```json
     {
        "secrets_path": "",
        "vault_address": "https://<YOUR KEYVAULT NAME>.vault.azure.net",
        "vault_token": "",
     }
     ```

2. Set these three ENV variables:

     ``` bash 
     AZURE_TENANT_ID=<YOUR-TENANT-ID>
     AZURE_CLIENT_ID=<YOUR-CLIENT-ID>
     AZURE_CLIENT_SECRET=<YOUR-CLIENT-SECRET>
     ```


## Implement the Code

**To support secrets management:**

1. Consider the exported interface `ISecretManagerService`.  

    ``` typescript
    export interface ISecretManagerService 
    {
      getSecretFromKey: (path: string, key: string) => Promise<string>
      getSecretAtPath: (path: string) => Promise<any>
      listSecretsAtPath: (path: string) => Promise<any>
      readJsonFromKey: (path: string, key: string) => Promise<string>
      writeSecretWithKey: (path: string, key: string, keyvalue: any) => Promise<void>
      writeSecretWithObject: (path: string, data: any) => Promise<void>
      deleteSecretWithPath: (path: string) => Promise<void>
    }
    ```

2. This example focuses on `getSecretFromKey`, set up and implemented below:


     ``` typescript
       const { DefaultAzureCredential } = require("@azure/identity")
       const { SecretClient } = require("@azure/keyvault-secrets")

       export class AzureSecretManagerService implements ISecretManagerService 
       {
            vaultClient: SecretClient
            logger: ILogger

            constructor (logger: ILogger) 
            {
               // DefaultAzureCredential expects the following three environment variables:
               // * AZURE_TENANT_ID: The tenant ID in Azure Active Directory
               // * AZURE_CLIENT_ID: The application (client) ID registered in the AAD tenant
               // * AZURE_CLIENT_SECRET: The client secret for the registered application
               const credential = new DefaultAzureCredential()

               // Lastly, create our secrets client and connect to the service
               const client = new SecretClient(EnvReader.GlobalEnvConfig.VaultConfig.address, credential);
            }

            async getSecretFromKey (path: string, key: string): Promise<string> 
            {
               try
               {
                this.logger.verbose(`getting secret from vault: ${path}, ${key}`)
                 const latestSecret = await client.getSecret(key);
                 this.logger.debug(`got data back from vault: ${path}, ${key}`)
                 return latestSecret
               } 
               catch (error) 
               {
                 this.logger.error('getSecretFromKey error \r\n')
                 this.logger.error(error)
                 return null
               }
            }
       }
     ```
   
     The example above is for one interface. You'll need to implement each interface defined in `ISecretManagerService`. 
   
3. After all the functions have been implemented, finish up by instantiating the `AzureSecretManagerService` in the `src/Configurator.ts` file.

     ``` typescript
       constructor()
       {
        //existing
        //this.secretsManager = new SecretManagerService(new Logger('SecretManagerService'))
        //new implementation
        this.secretsManager = new AzureSecretManagerService(new Logger('AzureSecretManagerService'))
       }
     ```

!!! tip "Best Practice"
    That's it! Deployment complete.

    After replacing the secrets management, ensure all the APIs are working as expected by running the API Tests with the Postman* application. You'll find the tests in the `./src/test/collections` folder.

