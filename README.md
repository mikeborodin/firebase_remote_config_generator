# Firebase Remote Config Generator

#StandwithUkraine! 💙💛


Many Flutter apps use 🔥 Firebase Remote Config and this it's great!
Yet as the number of parameters grows, updating Dart code can become tedious and/or source of human errors. 
This package aims to automate code generation based on your Remote Config so that your code will always reflect your state in the Firebase console.


## Workflow:
* Add new FRC parameters in Firebase
* Run generate
* Use the added parameters in Dart

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
