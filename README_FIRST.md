# Elevate Option Trading — Codemagic Android Wrapper

This is a native Android WebView wrapper for the Elevate Option Trading Flask application.

## Server URL

The wrapper currently points to:

`https://notrade.myelevateapps.com`

To change the server later, edit **one line** in:

`gradle.properties`

```properties
ELEVATE_BASE_URL=https://your-domain.example
```

No Java code needs to be changed.

## Fastest way to get an APK with Codemagic

1. Unzip this project.
2. Put the whole folder in a GitHub repository.
3. In Codemagic, choose **Add application** and connect that repository.
4. Select **codemagic.yaml** configuration.
5. Choose workflow **Elevate Android APK** (`android-debug`).
6. Start the build.
7. Download `app-debug.apk` from Codemagic Artifacts.

The debug APK is suitable for installing/testing on Android devices.

## What the wrapper supports

- Elevate login sessions and cookies persist inside the WebView.
- JavaScript and local/session storage are enabled.
- Zerodha/Kite web redirects can stay inside the app.
- Android Back navigates WebView history before closing the app.
- File upload chooser is supported.
- Authenticated downloads pass WebView cookies into Android DownloadManager.
- tel:, mailto:, tg:, intent: and other non-web links open in their Android apps.
- Invalid HTTPS certificates are rejected, not bypassed.
- Both portrait and landscape are allowed.
- Cleartext HTTP is disabled because Elevate uses HTTPS.

## HTTPS configuration

This build is configured for the live HTTPS service:

`https://notrade.myelevateapps.com`

Cleartext HTTP traffic is disabled in the Android manifest.

## Google Play release

The included `android-release-unsigned` workflow can create an AAB, but Google Play
distribution should use a proper Android signing keystore. Add the keystore in Codemagic
and wire the Codemagic `CM_KEYSTORE_*` environment values for a signed release build.

## Package name

`com.elevate.optiontrading`

## Visible app name

`Elevate Option Trading`
