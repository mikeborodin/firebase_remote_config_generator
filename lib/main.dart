library firebase_remote_config_generator;

import 'src/commands/generate_config.dart';
import 'src/services/config_downloader/googleapis_config_downloader.dart';

void main(List<String> arguments) {
  var downloader = GoogleapisConfigDownloader();
  final generate = GenerateConfigCommand(downloader);

  generate.execute();
}
