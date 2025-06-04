--8<-- "References/abbreviations.md"

This sample deployment demonstrates the use of Docker* in swarm mode. The following conditions apply: 

- All images are built and tested with `docker compose`. To learn more about building the images with `docker compose`, refer to [**Express Setup**](../../GetStarted/Cloud/setup.md). 
- Push images to the registry to make them available for deployment on other systems.  
- Run the commands below from the `cloud-deployment` install directory. 


!!! important
    Not for production use. 

## Get the Toolkit

1. Open a Terminal or Command Prompt and navigate to a directory of your choice for development:

    ``` bash
    git clone --recursive https://github.com/device-management-toolkit/cloud-deployment --branch v{{ repoVersion.oamtct }}
    ```
  
2. Change to the cloned `cloud-deployment` directory.
    ``` bash
    cd cloud-deployment
    ```

## Deploy the stack to the swarm

!!! important "Important - For Linux"
    Before running the following commands on Linux, confirm that the user has been added to the docker group. For instructions, refer to [**Add docker group**](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user). Otherwise, prefix each command with `sudo`.


1. Initialize a swarm.
     ```
     docker swarm init
     ```      

2. Copy docker compose config to temporary `swarm.yml` file.
    ```
    docker compose -f .\docker-compose.yml config > swarm.yml
    ```

3. Set the network driver to overlay in the `swarm.yml` file.

    === "Linux"
        ``` bash
        sed -i "s|driver: bridge|driver: overlay|g" swarm.yml
        ```
    === "Windows"
        ``` powershell
        (Get-Content -Path './swarm.yml') -replace 'driver: bridge', 'driver: overlay' | Set-Content -Path './swarm.yml'
        ```

    !!! important
        Open the swarm.yml file to check that `driver: bridge` was replaced with `driver: overlay`. If the result is incorrect or corrupted, delete the swarm.yml file, rerun Step 2, and manually replace the string.


4. If you've run `docker compose` previously, as in the instructions in [**Express Setup**](../../GetStarted/Cloud/setup.md), run `docker compose down` to stop the device-management-toolkit services:
   ```
   docker compose down -v
   ```

5. Create the stack.
    ```
    docker stack deploy -c swarm.yml scalingdemo
    ```

6. Check all of the services are running.
    ```
    docker stack services scalingdemo
    ```

    !!! success
        The table below is an example of a services list: 
        
        |ID           |NAME                    |MODE             |REPLICAS         |IMAGE             |PORTS                              |
        | :-----------|:-----------------------| :-------------- | :-------------- | :--------------- | :-------------------------------  |
        |6dye78yg66zp |scalingdemo_db          |replicated       | 1/1             |postgres:latest   | *:5432->5432/tcp                  |
        |nahbub6fxrvu |scalingdemo_kong          |replicated       | 1/1            |kong:2.3  | *:443->8443/tcp, *:8001->8001/tcp                 |
        |nltp54asb8kz |scalingdemo_mps          |replicated       | 1/1             |mps:latest   |  *:4433->4433/tcp                  |
        |uc9jsf5554cv |scalingdemo_mpsrouter          |replicated       | 1/1       |mpsrouter:latest   |                  |
        |ojtcs8qjxct3 |scalingdemo_rps          |replicated       | 1/1             |rps:latest   |             |
        |wbk4of70do63  |scalingdemo_vault          |replicated      | 1/1             |vault:latest   | *:8200->8200/tcp                 |
        |pc143h8ml4ua  |scalingdemo_webui          |replicated      | 1/1             |webui:latest   |                 |   


7. Scale the mps service.
    ```
    docker service scale scalingdemo_mps=2
    ```

    !!! success
        The table below is an example of a services list after scaling the mps: 

        |ID           |NAME                    |MODE             |REPLICAS         |IMAGE             |PORTS                              |
        | :-----------|:-----------------------| :-------------- | :-------------- | :--------------- | :-------------------------------  |
        |6dye78yg66zp |scalingdemo_db          |replicated       | 1/1             |postgres:latest   | *:5432->5432/tcp                  |
        |nahbub6fxrvu |scalingdemo_kong          |replicated       | 1/1            |kong:2.3  | *:443->8443/tcp, *:8001->8001/tcp                 |
        |nltp54asb8kz |scalingdemo_mps          |replicated       | 2/2             |mps:latest   |  *:4433->4433/tcp                  |
        |uc9jsf5554cv |scalingdemo_mpsrouter          |replicated       | 1/1       |mpsrouter:latest   |                  |
        |ojtcs8qjxct3 |scalingdemo_rps          |replicated       | 1/1             |rps:latest   |             |
        |wbk4of70do63  |scalingdemo_vault          |replicated      | 1/1             |vault:latest   | *:8200->8200/tcp                 |
        |pc143h8ml4ua  |scalingdemo_webui          |replicated      | 1/1             |webui:latest   |                 |
   
8. Remove the stack:
    ```
    docker stack rm scalingdemo
    ```


