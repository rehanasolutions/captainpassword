# CaptainPassword

Flutter based Password Management Application.

# Upgrade

You can upgrade Flutter by running the following command:

```bash
flutter upgrade
```

# List devices

```bash
flutter devices
```

# Run

- Current device:

```bash
flutter run
```

- Web:

```bash
flutter run -d chrome
```

- Mac OS:

```bash
flutter run -d macos
```

# Build

- Android:

```bash
flutter build appbundle --target-platform android-arm,android-arm64,android-x64
flutter build apk --target-platform android-arm64
```

# Configuration

- Create credentials.dart in /lib/ with the following details

```dart
class Credentials {
  static const String AES_IV = "xxxxxxxxxxxxxxxx";
}
```

- Create environment.dart in /lib/ with the following details

```dart
class Environment {
  static const String APIUrl = "host:port";
}
```

- Web:

```bash
flutter build web
```

- Mac OS:

```bash
flutter build macos
```

# Plugins:

- There is plugin called flutter_launcher_icons which can be used to create icons for Android, iOS automatically.

  - Install:

    - Add the following in pubspec.yaml

      ```yaml
      dependencies:
        flutter_launcher_icons: ^0.7.5

      flutter_icons:
        image_path: "icons/icon.png"
        android: true
        ios: true
      ```

    - Run the following commands:

    ```bash
    flutter pub get
    flutter pub pub run flutter_launcher_icons:main
    ```

# Issues:

- [DataTransport] By default, Mac OSX apps are sandboxed. If you get this error: Code=1 "Operation not permitted"
  - Open project/macos/Runner/DebugProfile.entitlements and add this key:
  ```xml
    <key>com.apple.security.network.client</key>
    <true/>
  ```
