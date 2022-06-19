import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class AppConfig {
  /// number description
  final double myNumberParameter;

  /// color description
  final String myColorParameter;

  /// json description
  final Map<String, dynamic> myJsonParameter;

  /// description
  final bool myFeatureFlagA;

  AppConfig({
    required this.myNumberParameter,
    required this.myColorParameter,
    required this.myJsonParameter,
    required this.myFeatureFlagA,
  });

  factory AppConfig.fromValues(Map<String, RemoteConfigValue> values) {
    return AppConfig(
      myNumberParameter: values['myNumberParameter']?.asDouble() ?? 42.0,
      myColorParameter: values['myColorParameter']?.asString() ?? '#00ff00',
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
