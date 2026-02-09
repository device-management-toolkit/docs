

The web portal is available for login after the deployment of the MPS, RPS, and Sample Web UI. Make sure all microservices are successfully running before attempting to login.


<div style="text-align:center;">
  <iframe width="600" height="337" src="https://www.youtube.com/embed/RYzrHHpMIas" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  <figcaption><b>Getting Started Part 2</b>: Follow along to learn about the Sample Web UI and the various profiles: CIRA Configs, AMT Profiles, and Domain Profiles. <b>Additional Resources: </b><a href="../../Concepts/security#authentication--credentials">Passwords and What They Mean</a>, <a href="../../Concepts/remoteProvisioning">Provisioning Certificates</a>, and <a href="../../Reference/MEBX/dnsSuffix">Setting a DNS Suffix via MEBX</a></figcaption>
</div>

## Log In

1. Open any modern web browser and navigate to the following link.

    ```
    https://<Development-IP-Address>
    ```

    !!! important "Important - URL of Sample Web UI"
        You **must use** the development system's IP address in the URL. **Localhost or 127.0.0.1 will NOT work**. [Read more about Kong API Gateway to find out why](https://konghq.com/kong/){target=_blank}. The development system's IP address is where the Docker containers are running.


2.  A warning screen will prompt because the MPS Server is using self-signed certificates for testing. Click **Advanced** and then **Proceed** to continue to connect to the Sample Web UI.

    !!! example "Example - Chrome* Browser Warning Message"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\selfSignedConnect.png" alt="Figure 1: MPS Warning Message">
        <figcaption>Figure 1: MPS warning message</figcaption>
        </figure>


3. Log in to the web portal with the login credentials set for the environment variables `MPS_WEB_ADMIN_USER` and `MPS_WEB_ADMIN_PASSWORD` in the `.env` file.


4. The home page is shown below in Figure 2.

    !!! example "Example - Sample Web UI Home Page"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\WebUI_Home.png" alt="Figure 2: Sample Web UI Home Page">
        <figcaption>Figure 2: Sample Web UI home page</figcaption>
        </figure>
    

## Next up
**[Create a CIRA Config](createCIRAConfig.md)**
