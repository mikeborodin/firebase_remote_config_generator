# Firebase Remote Config Generator
(in early development)


Many Flutter apps use Firebase Remote Config to dynamically tweak app beahvior 
without releasing a new version and conduct A/B testing.

Examples can include:
* Feature flags
* Texts
* Colors
* Complex JSON objects

When the number of parameters grows quickly, maintaining the parsing code can become bottleneck and/or source of human errors. 

The package aims to automate Dart code generation based on your Remote Config.

This way you can provide an up-to-date Config object to the app and focus on using it your features.


# Installation

Globally
```
dart pub global activate firebase_remote_config_generator
```
Or as dev dependency:

```
dev_dependencies:
  firebase_remote_config_generator: ^0.0.1
```

## Usage


Generate your Config by running:

```flutter pub run firebase_remote_config_generator --help```

