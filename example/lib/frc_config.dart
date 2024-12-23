import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class AppConfig {
  /// some hex
  final String someHex;

  /// color description
  final String myColorParameter;

  /// number description
  final double myNumberParameter;

  /// json description
  final Map<String, dynamic> myJsonParameter;

  /// description
  final bool myFeatureFlagA;

  AppConfig({
    required this.someHex,
    required this.myColorParameter,
    required this.myNumberParameter,
    required this.myJsonParameter,
    required this.myFeatureFlagA,
  });

  factory AppConfig.fromValues(Map<String, RemoteConfigValue> values) {
    return AppConfig(
      someHex: values['someHex']?.asString() ?? '#332244',
      myColorParameter: values['myColorParameter']?.asString() ?? '#00ff00',
      myNumberParameter: values['myNumberParameter']?.asDouble() ?? 42.0,
      myJsonParameter: jsonDecode(values['myJsonParameter']!.asString())
              as Map<String, dynamic>? ??
          {
            'a': 'b',
            'c': 1,
            'd': true,
            'e': {
              'aa': 'bb',
            },
          },
      myFeatureFlagA: values['myFeatureFlagA']?.asBool() ?? true,
    );
  }
}

