import 'package:firebase_remote_config_generator/src/services/config_downloader/config_downloader.dart';

class GenerateConfigInteractor {
  final ConfigDownloader downloader;

  GenerateConfigInteractor(this.downloader);

  Future<void> execute() async {
    await downloader.download();
  }
}
