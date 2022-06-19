import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config_generator/src/entites/parameter.dart';
import 'package:firebase_remote_config_generator/src/services/config_downloader/config_downloader.dart';

import 'package:googleapis/firebaseremoteconfig/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleapisConfigDownloader implements ConfigDownloader {
  @override
  Future<List<Parameter>> download() async {
    var serviceAccountRelativePath = '/../local/service_account.json';
    final path = Directory.current.path + serviceAccountRelativePath;
    final string = await File(path).readAsString();
    final json = jsonDecode(string) as Map<String, dynamic>;
    final project = json['project_id']! as String;
    final httpClient = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(json),
      [
        FirebaseRemoteConfigApi.cloudPlatformScope,
      ],
    );

    try {
      final config =
          await FirebaseRemoteConfigApi(httpClient).projects.getRemoteConfig('projects/$project');

      config.parameters?.forEach((key, value) {
        print('$key ${value.valueType}\n');
      });

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
        print(entry.value.defaultValue?.value);
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
