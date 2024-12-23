# FRC Generator

Many Flutter apps use Firebase Remote Config to fetch app config at runtime without releasing a new version.

As the number of parameters grows, updating Dart code can become tedious and/or source of human errors. 

The package aims to automate Dart code generation based on your Remote Config.

This way you can provide an up-to-date Config object to the app and focus on using it your features.

# Installation

add as dev dependency:

```
dev_dependencies:
  firebase_remote_config_generator: <latest version>
```

## Usage

```
dart run firebase_remote_config_generator generate \
--service-account-file local/service_account.json \
--also-print \
--format dart \
--class-name AppConfig
```

