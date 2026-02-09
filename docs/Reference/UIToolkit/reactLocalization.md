

React supports localization of applications into different languages through the use of i18n. This example below will walk through how to add support for the language, Kannada. These steps can be applied to a language that fits your desired requirements.

## Localize the Strings

1. Navigate to the `ui-toolkit-react/src/public/locales/` directory.

2. Create a new `kn/` directory within the `ui-toolkit-react/src/public/locales/` directory.

	The directory name must match one of the [codes listed](https://developers.google.com/admin-sdk/directory/v1/languages).


3. Copy the `translation.json` file in the `/locales/en/` directory to the new `/locales/kn/` language directory. 

4. Translate the strings in the copied `translation.json` file to the new language. 

5. Save and close the file.

## Add to Bundle

1. Open the `i18n.ts` file in the `ui-toolkit-react/src/public/` directory.

2. Import the new `public/locales/kn/translation.json` file.

	``` ts hl_lines="6"
	import i18n from 'i18next'
	import LanguageDetector from 'i18next-browser-languagedetector'
	import { initReactI18next } from 'react-i18next'

	import translationEN from './public/locales/en/translation.json'
	import translationKN from './public/locales/kn/translation.json'
	...
	```

3. Edit the `resources` const to include the new translation.

	``` ts hl_lines="8-10"
	...
	import translationEN from './public/locales/en/translation.json'
	import translationKN from './public/locales/kn/translation.json';

	const resources = {
	  en: {
		translations: translationEN
	  },
	  kn: {
		translations: translationKN
	  }
	};
	...
	```

4. Save the file.

5. Rebuild and generate a new bundle before testing the changes.

Language can be changed in the browser under language section of the browser settings. English is the default language if no customized translation file is provided for an alternative language.

## Get Localized Strings for Web Consoles with Localization Enabled

If your web console already has localization enabled, make sure to add the [translations](https://github.com/device-management-toolkit/ui-toolkit-react/tree/main/src/public/locales) of the UI-controls into your web console's translations file.

<br><br>