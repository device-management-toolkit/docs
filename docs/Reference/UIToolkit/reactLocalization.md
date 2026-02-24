

React supports localization of applications into different languages through the use of i18n.

## Supported Languages

The UI Toolkit React ships with the following languages built-in:

| Language | Code |
| :------- | :--- |
| English | `en` |
| Spanish | `es` |
| French | `fr` |
| German | `de` |
| Japanese | `ja` |
| Chinese | `zh` |

## Adding a New Language

This example walks through how to add support for a new language (e.g. Kannada). These steps can be applied to any language that fits your desired requirements.

### Localize the Strings

1. Navigate to the `ui-toolkit-react/src/i18n/locales/` directory.

2. Copy an existing translation file (e.g. `en.json`) to a new file named with the appropriate language code (e.g. `kn.json`).

	The file name must match one of the [codes listed](https://developers.google.com/admin-sdk/directory/v1/languages).

3. Translate the strings in the copied JSON file to the new language.

4. Save and close the file.

### Add to i18n Configuration

1. Open the `config.ts` file in the `ui-toolkit-react/src/i18n/` directory.

2. Import the new locale file.

	``` ts hl_lines="7"
	import i18next from 'i18next'
	import { initReactI18next } from 'react-i18next'

	import en from './locales/en.json'
	import es from './locales/es.json'
	import fr from './locales/fr.json'
	import kn from './locales/kn.json'
	...
	```

3. Add the new translation to the `resources` object.

	``` ts hl_lines="8-10"
	...
	const resources = {
	  en: { translation: en },
	  es: { translation: es },
	  fr: { translation: fr },
	  de: { translation: de },
	  ja: { translation: ja },
	  zh: { translation: zh },
	  kn: { translation: kn }
	}
	...
	```

4. Save the file.

5. Rebuild the package before testing the changes.

### Translation File Structure

Translation files use a flat namespace structure organized by component:

``` json
{
  "kvm": {
    "connect": "Connect KVM",
    "disconnect": "Disconnect KVM",
    "encoding": "Encoding",
    ...
  },
  "sol": {
    "connect": "Connect",
    "disconnect": "Disconnect",
    ...
  },
  "ider": {
    "start": "Start IDER",
    "stop": "Stop IDER",
    "selectFile": "Choose File",
    ...
  }
}
```

## Setting the Language

The default language is English (`en`). To change the language programmatically:

``` typescript
import { i18n } from '@device-management-toolkit/ui-toolkit-react'

i18n.changeLanguage('fr') // Switch to French
```

!!! note
    Browser language auto-detection is no longer supported. The language must be set explicitly using `i18n.changeLanguage()`.

## Get Localized Strings for Web Consoles with Localization Enabled

If your web console already has localization enabled, make sure to add the [translations](https://github.com/device-management-toolkit/ui-toolkit-react/tree/main/src/i18n/locales) of the UI-controls into your web console's translations file.
