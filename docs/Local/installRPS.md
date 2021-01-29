The [Remote Provisioning Service (RPS)](../Glossary.md#r) is a microservice based on Node.js*. The RPS works with the [Remote Provisioning Client (RPC)](../Glossary.md#r) to activate Intel® AMT platforms using a pre-defined profile.

Figure 1 illustrates where RPS fits into the overall [microservice architecture.](../Glossary.md#m)

[![RPS](../assets/images/RPSDeployment.png)](../assets/images/RPSDeployment.png)

**Figure 1: Deploy Remote Provisioning Server (RPS) on a development system.**


## Clone OpenAMT Cloud Toolkit

**To clone the repositories:**

Note: Skip this step if the repositories are already cloned.

1. Open a Command Prompt or Terminal and navigate to a directory of your choice for development.
``` bash
git clone --recursive https://github.com/open-amt-cloud-toolkit/open-amt-cloud-toolkit
```
2. Navigate to the rps directory
``` bash
cd open-amt-cloud-toolkit\rps
```


!!! Warning
    Do not nest a microservice directory inside another microservice directory. The source code contains relative paths. The correct directory structure appears below, where *parent* is your installation directory.
    
```
📦parent
 ┣ 📂mps
 ┗ 📂rps
```


## Start the RPS Server

**To start the RPS:**

1. In the ```rps``` directory, run the install command to install all required dependencies. 

    ``` bash
    npm install
    ```

2. Then, start the server. By default, the RPS web port is 8080.

    ``` bash
    npm run dev
    ```

    !!! note
        Warning messages are okay and expected for optional dependencies.

    Example Output:

    [![RPS Output](../assets/images/RPS_npmrundev.png)](../assets/images/RPS_npmrundev.png)

**Figure 2: RPS reports successful deployment.**

## Next up
[**Login to RPS**](../General/loginToRPS.md)
