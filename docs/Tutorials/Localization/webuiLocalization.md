--8<-- "References/abbreviations.md"

# Sample Web UI Localization

The Sample Web UI is based on Angular. Angular supports localization for additional languages using i18n. This tutorial will show how support for a new language, French, can be added to the Sample Web UI.

## What You'll Need

**Software on the Development System** 

- [git*](https://git-scm.com/downloads)
- [Docker* for Windows*](https://docs.docker.com/desktop/install/windows-install/) or [Docker* for Linux*](https://docs.docker.com/desktop/install/linux-install/)
  
## What You'll Do
The following sections describe how to:

- Create a Translation File
- Update the Sample Web UI Configuration
- Deploy the translated Sample Web UI using Docker

These steps highlight how to serve the Sample Web UI in both English and a newly added language, French.

## Clone the Sample Web UI

1. If you do not have the repository, clone the latest Sample Web UI.

    ```
    git clone https://github.com/device-management-toolkit/sample-web-ui.git --branch v{{ repoVersion.webui }}
    ```

## Translate Strings

1. Open the `messages.xlf` file in `sample-web-ui/src/locale/`.

    This file contains all of the strings and their locations within the Sample UI. These need to be translated.

2. Make a copy of the `messages.xlf` source language file.

3. Rename the copy to `messages.fr.xlf` for our target French translation.

4. Translate the file using a text editor or XLIFF editor tool. [See the Angular Translation Documentation for more information.](https://v17.angular.io/guide/i18n-common-translation-files#translate-each-translation-file)

5. Save the file.

## Update Sample Web UI Configuration

Now that we have a translated `.xlf` file, we can modify the Sample Web UI configuration to utilize it when building the bundle and image.

### Update `angular.json`

1. Open the `angular.json` file in the `/sample-web-ui/` directory

2. Add the below `i18n:` block to the `openamtui:` section. Additional locales can be appended for each additional language to support.

    ```json hl_lines="14-22"
    ...
    "openamtui": {
      "projectType": "application",
      "schematics": {
        "@schematics/angular:component": {
          "style": "scss"
        },
        "@schematics/angular:application": {
          "strict": true
        }
      },
      "root": "",
      "sourceRoot": "src",
      "i18n": {
        "sourceLocale": "en-US",
        "locales": {
          "fr": {
            "translation": "src/locale/messages.fr.xlf",
            "baseHref": "/fr/"
          }
        }
      },
    ...
    ```

3. Add `localize:` field to the `build:` section.

    !!! note "Note - Using `localize:` on Angular Development Server"
        `localize: true` will build application variants for all locales defined in the build configuration. This is ideal for production. If you want to build and serve on the Angular development server for testing, this will cause errors. Angular development server can only support localizing a single locale at a time.

        To build only one locale, see [Apply specific build options for just one locale](https://angular.dev/guide/i18n/merge#apply-specific-build-options-for-just-one-locale) Angular Documentation.

    ```json hl_lines="9"
    ...
    "build": {
      "builder": "@angular-devkit/build-angular:browser",
      "options": {
        "outputPath": "dist/openamtui",
        "index": "src/index.html",
        "main": "src/main.ts",
        "polyfills": "src/polyfills.ts",
        "localize": true,
        "tsConfig": "tsconfig.app.json",
    ...
    ```

4. Save the file.

### Update `init.sh`

1. Open the `init.sh` file in the `/sample-web-ui/` directory.

2. Modify the last line of the file to the following.

    ```sh hl_lines="6"
    sed -i \
    -e "s|##RPS_SERVER##|$RPS_SERVER|g" \
    -e "s|##MPS_SERVER##|$MPS_SERVER|g" \
    -e "s|##VAULT_SERVER##|$VAULT_SERVER|g" \
    -e "s|##AUTH_MODE_ENABLED##|$AUTH_MODE_ENABLED|g" \
     /usr/share/nginx/html/*/*.js
    ```

3. Save the file.

### Update `nginx.conf`

1. Open the `nginx.conf` file in the `/sample-web-ui/` directory.

2. Copy and paste the new configuration below.
    
    ```conf
    server {
        listen 80 default_server;
        listen [::]:80 default_server;
        server_name _;

        root   /usr/share/nginx/html;
        index  index.html index.htm;

        # Set default language to en-US
        if ($accept_language ~ "^$") {
            set $accept_language "en-US";
        }

        # Redirect "/" to Angular application in the preferred language of the browser
        rewrite ^/$ /$accept_language;

        # Everything under the Angular application is always redirected to Angular in the correct language
        location ~ ^/(fr|en-US) {
            try_files $uri /$1/index.html?$args;
        }

        error_page  404              /index.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }
    }
    ```

3. Save the file.

### Update `Dockerfile`

1. Open the `Dockerfile` file in the `/sample-web-ui/` directory.

2. Update the following lines in Stage 2.

    ```dockerfile hl_lines="9-10"
    ### STAGE 2: Run ###
    FROM nginx:mainline-alpine-slim@sha256:a529900d9252ce5d04531a4a594f93736dbbe3ec155a692d10484be82aaa159a

    LABEL license='SPDX-License-Identifier: Apache-2.0' \
          copyright='Copyright (c) 2021: Intel'

    RUN apk update && apk upgrade --no-cache

    COPY --from=build /usr/src/app/dist/openamtui/en-US /usr/share/nginx/html/en-US
    COPY --from=build /usr/src/app/dist/openamtui/fr /usr/share/nginx/html/fr
    COPY --from=build /usr/src/app/init.sh /docker-entrypoint.d/init.sh
    EXPOSE 80
    ```

3. Save the file.

## Deploy Translated Sample Web UI

Now that the strings are translated and the deployment configurations are updated, we can build and start the Sample Web UI.

1. Build the image and start the container.

    ```
    docker compose up -d
    ```

2. Navigate to the Sample Web UI in a browser.

    ```
    http://localhost:8089
    ```

    With no path provided, it should default to `/en-US/` and display the English page.

    !!! example "Example - Sample Web UI Home Page"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\SampleUI_EnglishTranslation.png" alt="Figure 1: Sample Web UI English Login Page">
        <figcaption>Figure 1: Sample Web UI English Login page</figcaption>
        </figure>

3. Change the URL path to `/fr`.

    ```
    http://localhost:8089/fr
    ```

    The page should now be displaying the French translated site.

    !!! note "Note - File Structure"
        Adding languages adds an additional nesting to the file structure. It is important to verify all images and other assets are still working. Some assets may need minor tweaks to file paths to ensure they work correctly.

    !!! example "Example - Sample Web UI Home Page"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\SampleUI_FrenchTranslation.png" alt="Figure 2: Sample Web UI French Login Page">
        <figcaption>Figure 2: Sample Web UI French Login page</figcaption>
        </figure>

<br><br>