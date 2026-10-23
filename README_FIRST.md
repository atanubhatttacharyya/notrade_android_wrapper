# Elevate Android WebView Wrapper with Native Google Sign-In

This is a replacement Android wrapper project for `https://notrade.myelevateapps.com` using a native Android WebView for the app UI and Google Play Services for Google account authentication. It keeps the existing package ID `com.elevate.optiontrading`.

## Why Google sign-in is native
Google blocks/limits Google Identity Services sign-in inside embedded WebViews. This wrapper intercepts the existing Elevate Welcome-page Google buttons, opens the native Google account chooser, obtains an ID token, and submits that token to Elevate's existing server endpoints. The WebView remains the main app UI. It does not embed Google's sign-in page inside the WebView.

## Required configuration before building

1. In Elevate Admin Settings, find the Google OAuth **Web application Client ID** already configured for Elevate.
2. Replace `REPLACE_WITH_WEB_CLIENT_ID.apps.googleusercontent.com` in `app/src/main/res/values/strings.xml` with that exact Web Client ID.
3. In Google Cloud Console, ensure there is an Android OAuth client for package `com.elevate.optiontrading` and the SHA-1 signing fingerprint used by the APK. The Web Client ID is used for the ID token audience; the Android OAuth client must match the package and signing certificate. Debug and release signing certificates may have different SHA-1 fingerprints.
4. Commit the contents of this folder to a new branch in `atanubhatttacharyya/twa_android_wrapper` (or build from a separate branch/repository). The Codemagic workflow can use the existing Gradle build configuration; build with `gradle --no-daemon assembleDebug`.
5. Install and test the new APK. Do not overwrite the working APK until native Google sign-in, login, registration, account modification, session handling, and sign-out have been tested.

## Important implementation notes

- Website: `https://notrade.myelevateapps.com`
- Android application ID: `com.elevate.optiontrading`
- App label: `Elevate Option Trading`
- Minimum SDK: 23; compile/target SDK: 35; Java 17.
- The wrapper calls the existing server endpoints `/login`, `/auth/google/register`, `/auth/google/modify/verify`, and `/auth/google/modify/update` using the Google ID token. It transfers the returned Elevate session cookie into the WebView for login.
- The wrapper does not change AWS or Flask code.
- Google OAuth configuration and Android signing fingerprints must be correct for the native Google sign-in flow to work.
- This source ZIP has not been built in Codemagic or tested on a physical phone in this environment. Test it on a separate build before replacing the current app.

## Google authentication blocker (must be completed before a working APK)

The included source deliberately does not invent OAuth credentials. The current `strings.xml` contains a placeholder Web Client ID, so Google authentication cannot complete until the real Web application Client ID used by the Elevate backend is inserted. Also register the Android OAuth client for package `com.elevate.optiontrading` and the signing certificate SHA-1 used by the build. A wrong/missing ID or fingerprint commonly causes the Google account picker/token flow to fail. This is an OAuth configuration dependency, not a WebView permission issue.

The native bridge now validates the configured ID before attempting sign-in and displays a clear message if it is missing; it also handles devices where Google Play Services sign-in cannot be launched. Do not publish this placeholder-configured build as a working Google-auth build.
