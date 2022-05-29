import 'package:firebase_remote_config_generator/src/services/config_downloader/config_downloader.dart';

class GenerateConfigCommand {
  final ConfigDownloader downloader;

  GenerateConfigCommand(this.downloader);

  Future<void> execute() async {
    await downloader.download();
  }
}
