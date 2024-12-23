# FRC Generator

Many Flutter apps use Firebase Remote Config to fetch app config at runtime without releasing a new version.

As the number of parameters grows, updating Dart code can become tedious and/or source of human errors. 

The package aims to automate Dart code generation based on your Remote Config.

This way you can provide an up-to-date Config object to the app and focus on using it your features.


Examples include:
* Feature flags
* Texts
* Colors
* Complex JSON objects

# Installation

Dev dependency:

```
dev_dependencies:
  firebase_remote_config_generator: <latest version>
```

## Usage

Generate your Config by running:

```dart pub run firebase_remote_config_generator generate```

