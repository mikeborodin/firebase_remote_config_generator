import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config_generator/src/services/config_downloader/config_downloader.dart';

import 'package:googleapis/firebaseremoteconfig/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleapisConfigDownloader implements ConfigDownloader {
  @override
  Future<Map<String, dynamic>> download() async {
    var serviceAccountRelativePath = '/local/service_account.json';
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
        print('$key $value\n');
      });

      return {};
    } finally {
      httpClient.close();
    }
  }
}
