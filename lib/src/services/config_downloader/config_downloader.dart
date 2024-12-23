import 'dart:io';

import 'package:firebase_remote_config_generator/src/entites/parameter.dart';
import 'dart:convert';

import 'package:googleapis/firebaseremoteconfig/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

abstract class ConfigDownloader {
  Future<List<Parameter>> download(File serviceAccount);
}

class GoogleapisConfigDownloader implements ConfigDownloader {
  @override
  Future<List<Parameter>> download(File serviceAccount) async {
    final content = await serviceAccount.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    final project = json['project_id']! as String;

    final httpClient = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(json),
      [
        FirebaseRemoteConfigApi.cloudPlatformScope,
      ],
    );

    try {
      final config = await FirebaseRemoteConfigApi(httpClient)
          .projects
          .getRemoteConfig('projects/$project');

      return config.parameters?.entries.map((entry) {
            return Parameter(
              name: entry.key,
              description: entry.value.description ?? '',
              type: _mapType(entry.value.valueType!),
              defaultValue: _mapDefaultValue(entry),
            );
          }).toList() ??
          [];
    } finally {
      httpClient.close();
    }
  }

  dynamic _mapDefaultValue(MapEntry<String, RemoteConfigParameter> entry) {
    final type = _mapType(entry.value.valueType!);

    switch (type) {
      case ParameterType.boolean:
        return entry.value.defaultValue?.value == 'true';
      case ParameterType.string:
        return entry.value.defaultValue?.value ?? '';
      case ParameterType.json:
        return jsonDecode(entry.value.defaultValue?.value ?? '{}');
      case ParameterType.number:
        return double.tryParse(entry.value.defaultValue?.value ?? '') ?? 0;
    }
  }

  ParameterType _mapType(String string) {
    switch (string) {
      case 'NUMBER':
        return ParameterType.number;
      case 'STRING':
        return ParameterType.string;
      case 'BOOLEAN':
        return ParameterType.boolean;
      case 'JSON':
        return ParameterType.json;
      default:
        throw Exception('unsupported value type');
    }
  }
}
