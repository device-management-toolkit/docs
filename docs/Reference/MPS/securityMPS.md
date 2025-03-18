--8<-- "References/abbreviations.md"
# MPS Security Considerations

The cloud agnostic microservice Management Presence Server (MPS) enables platforms featuring Intel&reg; AMT to connect over the internet securely to manageability consoles. Secrets are used to ensure the security of the MPS REST APIs. In a deployment environment, consider these security assets:

* Intel&reg; AMT remote admin credentials
* Intel&reg; AMT CIRA credentials
* Authorize API end point
* Server Configuration
* Web User Credentials

In addition to the above assets, there are best practices that are recommended to help secure these assets as they are used within the system.  The following sections will cover each asset and the recommended practices to use to protect the assets.


## Security Assets

### 1. Intel&reg; AMT remote admin credentials
Intel&reg; AMT remote admin credentials enable a user to remotely control a device featuring Intel&reg; AMT. These credentials are configured in AMT Firmware by a configuration server (e.g., RPS). When an administrator performs a REST API call, such as a power off action to the managed device, MPS fetches the corresponding credentials of that device from the configured secrets store (e.g., Vault). MPS uses the fetched secret as part of digest authentication with Intel&reg; AMT. 

Intel discourages reuse of passwords among managed devices. Use a strong, unique password for each device to enhance security.

### 2. Intel&reg; AMT CIRA credentials
When a managed device attempts to establish a connection to the MPS, the MPS performs two checks prior to allowing the connection:  
1. **The Intel&reg; AMT device's GUID:** This GUID must be stored in the MPS database and is typically added by using the [devices](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/{{ repoVersion.mpsAPI }}#/Devices/post_api_v1_devices) POST API.  
2. **MPS CIRA Credential:** The Intel&reg; AMT device needs to supply the correct credentials to MPS.  These credentials are checked against the username, stored in the database, and password, stored in Vault.

Use a strong, unique password for each device to enhance security.

### 3. Authorize API end point
MPS supports basic user authentication to the REST APIs with an Authorize API endpoint for issuing a JSON Web Token (JWT). This eliminates the need to set up a full user authentication service before evaluating the software and enables developers to use the microservices right away.

However, in a production deployment, use a robust user authentication service (e.g., OAuth2, OpenID, LDAP) and disable the Authorize API endpoint by leaving the MPS Web User credentials blank in the MPS configuration file.

### 4. Server Configuration
To use secure protocols, MPS requires configured certificates and securely stored certificate keys. If the keys are compromised, an attacker will be able to decrypt messages that are encrypted with these certificates. For evaluation purposes, MPS will generate self-signed certificates used for encryption.

For production deployment, purchase CA-signed certificates whose signatures can be independently verified.

### 5. Web User Credentials
The Device Management Toolkit is designed to operate behind an API gateway, such as Kong API Gateway. The API Gateway validates the Auth Tokens provided by an administrator who is requesting access to an API end point. Once verified, the API Gateway will forward the request to the appropriate microservice, MPS or RPS. To make evaluation easy, MPS has implemented an [Authorize](https://app.swaggerhub.com/apis-docs/rbheopenamt/mps/{{ repoVersion.mpsAPI }}#/Auth/post_api_v1_authorize) API end point that will issue a JWT when the proper web user credentials are provided. The Web User credentials are global credentials that are configured in the MPS configuration file and do not provide any fine-grain permissions.  Integration with other user authentication models and fine-grain endpoint permissions are supported through Kong [plug-ins](https://konghq.com/products/kong-gateway/kong-plugins/) and modification of the Kong API Gateway configuration file, respectively.


## Best Known Security Methods

### 1. Enable TLS on Network Connections
There are three potential places where TLS could be enabled to protect the security assets:

* HTTPS/WSS connection between Web UI and MPS (recommended)
* Connection between MPS and Vault - If communication between MPS and Vault is outside a secure container environment (not recommended deployment, see item 2 below)
* Connection between MPS and Intel® AMT device (required and done automatically by MPS)

Securing these communication routes will help prevent security assets being exposed through network based attacks intercepting messages between components. It is recommended that the most modern version of TLS be used when encrypting communication.

### 2. Secure and Isolate Execution Environment
MPS holds several security assets in memory during execution. To protect these assets while in the memory of MPS, run MPS in a secure execution environment such as a dedicated container. Deploying into a secure container environment eases the burden of individually securing the assets while in memory or in transit between Device Management Toolkit services. Running MPS, RPS, API Gateway, MPS Router, Vault, and Database all within the same secure container instance will help ensure that the communication between these services remains secure.

### 3. Use Vault for Storing Credentials
Vault is a tool used to secure, store, and tightly control access to secrets. Utilizing Vault to store passwords used by MPS will greatly increase the security of these assets.

### 4. Use Kubernetes Secrets for Storing Dynamic Configuration Values
Kubernetes Secrets help you to store and manage sensitive information like Tokens. Use Kubernetes secrets for storing environment variables required for configuring MPS rather than putting them in the image/pod. Vault token, Session secret key, and Server configuration assets required for MPS should be stored in Kubernetes secrets.

<br>
