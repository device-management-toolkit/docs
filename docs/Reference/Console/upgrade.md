# Upgrading Console

## Overview
We plan to provide a seamless upgrade path from the v1.0 release, ensuring that no database deletion is required.

### Upgrading from Beta to v1.x

When upgrading from Beta to v1.x, the `config.yml` file has undergone changes. You will need to either create a new one or let Console generate it for you automatically.

#### Steps to upgrade from Beta to v1.x

1. Stop the Beta Console: <br>
    Close the terminal running the Console executable. Simply closing the browser window will not stop the Console.

2. Locate the Existing `config.yml` File: <br>
    The `config.yml` file is typically located at `~/config/config.yml`, relative to the path where `console` application is located.

3. Rename or Delete the Existing `config.yml`:
    - If you don't need the old configuration, delete the `config.yml` file.
    - If you want to keep your old configuration, rename config.yml to something like `config_old.yml` as an example.

4. Download and Run the New v1.x Console: <br>
    1. Download the latest `v1.x` executable.
    2. Copy the downloaded executable to the same directory where the Beta executable is located.
    3. Run the new `v1.x` Console executable.

5. Confirm the New `config.yml` Is Generated: <br>
    A fresh `config.yml` will automatically be generated in the same directory.

6. Make Changes to `config.yml` (Optional): <br>
    1. Stop the Console.
    2. Edit the `config.yml` file to update fields like the username, password, or any other necessary settings based on the values from your old configuration file (e.g., `config_old.yml`).
    3. After making the changes, run the new Console executable for them to take effect.
<br>

### Upgrading from Alpha to Beta

Starting from Beta release, all sensitive data in the SQLite database will be encrypted using an encryption key. Due to this security enhancement, you'll need to delete the existing database file before upgrading.

#### Steps to Delete Database

1. Navigate to the directory where the `console` database file is stored:

    === "Windows"
        ```
        %APPDATA%\device-management-toolkit
        ```

    === "Ubuntu"
        ```
        ~/.config/device-management-toolkit
        ```
    
    === "Mac"
        ```
        ~/Library/Application Support/device-management-toolkit
        ```

2. Delete the `console` database file.


#### Add all the devices
After deleting the database and running the Console executable, you'll need to reconfigure or add all your devices again, as the previous data cannot be migrated due to the encryption changes.
