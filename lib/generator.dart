library firebase_remote_config_generator;

import 'package:firebase_remote_config_generator/src/interactors/generate_config.dart';
import 'package:firebase_remote_config_generator/src/services/config_downloader/googleapis_config_downloader.dart';

void main() {
  var downloader = GoogleapisConfigDownloader();
  final interactor = GenerateConfigInteractor(downloader);

  interactor.execute();
}
