

# Enroll a Custom Provisioning Certificate in an AMT Device using USBFile

This tutorial explains how to load and enable a custom certificate using USB Config based on [Intel AMT SDK](https://www.intel.com/content/www/us/en/download/704388/intel-active-management-technology-intel-amt-software-development-kit-sdk.html) in an AMT device.

For production deployments, we highly recommend purchasing a 3rd party provisioning certificate. [See all available vendors here.](../../Concepts/remoteProvisioning.md#purchase)

!!! warning "Warning - Custom Provisioning Certificates in Production Deployments"
    The hash of custom provisioning certificates requires manual adding to all devices configured into ACM. It can be done through MEBx or USB Configuration. However, adding a Hash for AMT 16 or newer may require USB Configuration because of OEM restrictions.
    Both options require manual, hands-on configuration of each AMT device. In this tutorial, we will focus on the USB-based approach. Details about MEBX activation are available [here](./generateProvisioningCert.md#upload-provisioning-certificate).
    **Please be aware that adding the hash to AMT's trusted list is a mandatory requirement for the device to activate successfully.**

However, some developers opt to use a custom provisioning certificate for testing and validation purposes.

## What You'll Need

You will need to:

- Download the latest [Intel AMT SDK](https://www.intel.com/content/www/us/en/download/704388/intel-active-management-technology-intel-amt-software-development-kit-sdk.html).
- The rpc-go utility [Available Releases](https://github.com/device-management-toolkit/rpc-go/releases).
- Have the custom certificate ([Tutorial](./generateProvisioningCert.md#generate-custom-provisioning-certificate))
- The libcrypto.dll file (You can find it from an OpenSSL installation).

Once downloaded the Intel AMT SDK zip file, check and follow the next steps:

1. Uncompress it (for example, *amt-sdk-18-0-1-1.zip*) into a directory where you have enough reading and writing permissions.
2. Go into the directory and find the USB_File_Module.zip file. It contains the USB utility to create the setup.bin file using the provided certificate. Uncompress it.
3. Go to the new USB_File_Module folder. It contains the utility source code (the Src folder), binaries (the Bin folder), and a readme file indicating how to use the utility. This utility should be run from a directory reachable by Administrators only to maintain the security.
4. Find and Copy the libcrypto.dll file to the same directory as USBFile.exe (Default: *"<AMT_dir>/USB_File_Module/Bin"*). For example, you can use "OpenSSL-Win32 1.1 Light"; however, once installed, you could see a similar library name like "libcrypto-1_1.dll". If that is the case, please copy it from the pertinent directory and paste the file into the mentioned directory, and once done, rename it to "libcrypto.dll." This detail is important because the USBFile utility is expecting to find that file name in the same directory to calculate sha256 and sha384 hashes.

## What You'll Do

You will create the setup.bin file based on the custom certificate, indicating how to use it through AMT devices. You will put the setup.bin file in a USB device prepared for the AMT reading. You will boot your AMT device with the prepared boot device to incorporate the certificate and verify that the custom certificate has been incorporated into the AMT device and is ready to enable it.

## Steps

You will walk-through the following steps:

- Check the CA Certificates in the AMT device
- Create a setup.bin file
- Install the Custom Certificate using a USB drive
- Verify the Custom Certificate availability

### Check the CA certificates in the AMT Device

The rpc-go utility allow you verify the installed certificates in the AMT device.

1. Please ensure you installed the [rpc-go utility](https://github.com/device-management-toolkit/rpc-go/releases) in the AMT target device
2. Open a console with administrative permissions and run the following command:

    ```bash
    rpc_windows_x64.exe amtinfo -cert
    ```

    Note: The rpc-go binary could have a different name depending on the target OS. You can update the "rpc_windows_64.exe" in the command with the corresponding binary file name without concern.

    <figure class="figure-image">
    <img src="..\..\..\assets\images\screenshots\usbenroll_fig01_amtcertverification.png" alt="Figure 1: Available Certificates in the AMT Device">
    <figcaption>Figure 1: Available Certificates in the AMT Device</figcaption>
    </figure>

    For this tutorial, it continues the example initiated with the certificate for example.com (See details [here](./generateProvisioningCert.md#create-the-certificate-and-hash)). Thus, it would be expected to see the example.com with the corresponding hash as the previous command's output. However, it is not present in the output, indicating that we must install it before enabling the AMT device.

### Create the setup.bin file

The setup.bin file is created using the USBFile utility. It is provided as part of the Intel AMT SDK. Remember that It needs the libcrypto.dll file with this name located in the same directory as the utility.

1. Copy and Paste the rootCA.crt file in the utility directory (for example, *"<AMT_dir>/USB_File_Module/Bin"*)
2. Go into the Bin directory. Create the setup.bin file running the following command:

    ```bash
    USBFile.exe -create setup.bin <old_MEBx_password> <new_MEBx_password> -dns example.com -ztc 1 -consume 1 -hash rootCA.crt example.com sha256
    ```

    Where:
    - **setup.bin** is the generated file using the utility. Please keep this name.
    - **<old_MEBx_password>** represents the current password to access MEBx in the device.
    - **<new_MEBX_password>** represents the new password to access MEBx in the device. If you do not want to change the password, it is possible to indicate both (old and new) with the same values.
    - **-dns example.com** sets the PKI dns suffix name (up to length 255).
    - **-ztc 1** enables PKI configuration.
    - **-consume 1** indicates that the record is consumable.
    - **-hash rootCA.crt example.com sha256** computes and adds the hash of the rootCA.srt certificate file according to the sha256 hash algorithm. example.com is the certificate's friendly name.

3. Visualize the setup.bin file content for verification:

    ```bash
    USBFile.exe -view setup.bin
    ```

    You should see an output similar to the following figure.

    <figure class="figure-image">
    <img src="..\..\..\assets\images\screenshots\usbenroll_fig02_setupbin.png" alt="Figure 2: Generation and View of the setup.bin file">
    <figcaption>Figure 2: Generation and View of the setup.bin file</figcaption>
    </figure>

### Install the Custom Certificate using a USB drive

This pase is simpler but there are a few important details to consider:

- You should keep the setup.bin file name (Do not change it)
- Use an USB drive suitable for the FAT file system.

Thus, you will follow these steps to install the certificate in the target AMT device:

1. Prepare the USB drive.
   1. Take a USB drive with enough capacity and format it using FAT.
   2. Copy the setup.bin file from the binary directory and paste it into the USB drive.
   3. Unmount and securely unplug the USB drive.
2. Plug the USB drive into the AMT target device and power it on.
3. Enter the UEFI boot menu. Select the "Intel(R) Management Engine BIOS Extension (MEBx)" entry. If the entry is unavailable, ensure MEBx access is not limited to the UEFI setup.
4. The AMT will detect the file in the USB drive and prompt whether to incorporate the PKI record. You will see a message similar to the following one:

    ```bash
    Found USB Key for provisioning.
    Continue with Auto Provisioning (Y/N) ?
    ```

5. Press "Y" to confirm. If the prompt does not appear or an error message about disabled USB provisioning appears, enable Intel AMT USB Provisioning in UEFI Setup and try again.

### Verify the Custom Certificate availability

It uses the rpc-go utility to check the available certificates on the AMT target device after the installment.

```bash
rpc_windows_x64.exe amtinfo -cert
```

It provides an output similar to the following, which describes the trust CA certificates installed locally in the AMT device.

<figure class="figure-image">
<img src="..\..\..\assets\images\screenshots\usbenroll_fig03_certready.png" alt="Figure 3: Checking the Custom Certificate  in the AMT Device">
<figcaption>Figure 3: Checking the Custom Certificate  in the AMT Device</figcaption>
</figure>

The previous figure shows the recently installed certificate and its status between parenthesis (i.e., Active). Thus, based on this CA certificate, it is possible to advance with the device activation according to the desired profile.
