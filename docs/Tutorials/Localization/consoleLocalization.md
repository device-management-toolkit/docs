--8<-- "References/abbreviations.md"

# Console Localization

Console is based on an implementation of the Sample Web UI. By modifying the Sample Web UI, we can build a translated Console application.

The Sample Web UI is built on Angular which supports localization for additional languages using i18n. This tutorial will show how Console can be built in a new language, French.

## What You'll Need

**Software on the Development System** 

- [git*](https://git-scm.com/downloads)
- [Node.js](https://nodejs.org/en/download/package-manager)
- [Angular](https://angular.dev/installation)
- [Go* Programming Language](https://go.dev/)
  
## What You'll Do
The following sections describe how to:

- Create a Translation File
- Update the Sample Web UI Configuration
- Build Console Application

These steps highlight how to build Console in a French translation.

## Clone the Sample Web UI and Console

1. If you do not have the Sample Web UI repository, clone the latest version.

    ```
    git clone https://github.com/device-management-toolkit/sample-web-ui.git --branch v{{ repoVersion.webui }}
    ```

2. If you do not have the Console repository, clone the latest version.

    ```
    git clone https://github.com/device-management-toolkit/console.git
    ```

## Translate Strings

1. Open the `messages.xlf` file in `sample-web-ui/src/locale/`.

    This file contains all of the strings and their locations within the Sample UI. These need to be translated.

2. Make a copy of the `messages.xlf` source language file.

3. Rename the copy to `messages.fr.xlf` for our target French translation.

4. Translate the file using a text editor or XLIFF editor tool. [See the Angular Translation Documentation for more information.](https://v17.angular.io/guide/i18n-common-translation-files#translate-each-translation-file)

5. Save the file.

## Update Sample Web UI Configuration

Now that we have a translated `.xlf` file, we can modify the Sample Web UI configuration to utilize it when building the bundle.

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
            "baseHref": "/"
          }
        }
      },
    ...
    ```

3. Add `localize:` field to the `build:` section.

    ```json hl_lines="9"
    ...
    "build": {
      "builder": "@angular-devkit/build-angular:browser",
      "options": {
        "outputPath": "dist/openamtui",
        "index": "src/index.html",
        "main": "src/main.ts",
        "polyfills": "src/polyfills.ts",
        "localize": ["fr"],
        "tsConfig": "tsconfig.app.json",
    ...
    ```

4. Save the file.

## Build Translated Console

Now that the strings are translated and the deployment configurations are updated, we can build and run Console.

1. Build the Sample Web UI.

    ```
    npm run build-enterprise
    ```

2. Copy the newly generated `sample-web-ui/ui/` directory.

3. Paste the directory into the `console/internal/app/controller/http/ui/` directory.

4. Build the Console application.

    === "Windows"
        ``` bash
        go build -o console_windows_x64.exe ./cmd/app/main.go
        ```
    === "Linux"
        ``` bash
        go build -o console_linux_x64 ./cmd/app/main.go
        ```

5. Run the executable.

    !!! example "Example - Console Home Page"
        <figure class="figure-image">
        <img src="..\..\..\assets\images\Console_FrenchTranslation.png" alt="Figure 1: Console English Login Page">
        <figcaption>Figure 1: Console English Login page</figcaption>
        </figure>

<br><br>