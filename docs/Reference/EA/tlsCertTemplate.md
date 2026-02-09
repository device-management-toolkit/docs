

This template is used by EA to request certificates on behalf of your AMT devices. These certificates will be installed into the AMT device firmware and used for traffic authentication.

## Create AMT TLS Certificate Template

1. On your Enterprise Subordinate CA server, open the Start menu.

2. Choose Run, then enter `certtmpl.msc`.

3. Right-click the certificate template named **Web Server** and choose **Duplicate**.

4. Right-click and rename the new template **AMT TLS Certificate**.

5. Right-click the template and open the **Properties** menu.

6. Navigate to the **Request Handling** tab, and check the box labeled **Allow private key to be exported**.

7. Navigate to the **Subject Name** tab, and ensure that the radio button **Supply in the request** is selected.

8. Click **OK** to save the template.

## Enable the Template

1. On the Enterprise Subordinate CA server, run the **Certification Authority** tool.

2. Navigate to the **Certificate Templates** folder on the left pane.

3. Right-click the **Certificate Templates** folder and choose **New** -> **Certificate Template to Issue**.

4. Choose the **AMT TLS Certificate** template.

5. Click **OK**.


## Select the Template in Enterprise Assistant

When configuring the Settings menu of Enterprise Assistant, choose the **AMT TLS Certificate** from the **TLS Template** drop down menu under **Certificate Authority**. 

!!! example "Example - Configured TLS Template in Settings"
    <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\EA_RPCSettings_TLSTemplate.png" alt="Figure 1: Enterprise Assistant Settings Example">
        <figcaption>Figure 1: Enterprise Assistant Settings Example</figcaption>
    </figure>