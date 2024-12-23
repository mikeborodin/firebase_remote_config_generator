# Firebase Remote Config Generator

#StandwithUkraine! 💙💛


Many Flutter apps use Firebase Remote Config to fetch app config at runtime without releasing a new version.
As the number of parameters grows, updating Dart code can become tedious and/or source of human errors. 
The package aims to automate Dart code generation based on your Remote Config.
This way you can provide an up-to-date Config object to the app and focus on using it your features.

## Usage

1) add as dev dependency:

`dart pub add --dev firebase_remote_config_generator`


2) create service_account.json in Firebase web ui and download the file. Make sure it's in .gitignore.

3) generate Dart code based on your Remote Config, for example:
```
dart run firebase_remote_config_generator generate \
--service-account-file local/service_account.json \
--also-print \
--format dart \
--class-name AppConfig
```

Enloy!
