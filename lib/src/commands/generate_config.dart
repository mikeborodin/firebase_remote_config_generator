import 'dart:io';

import 'package:firebase_remote_config_generator/src/services/config_downloader/config_downloader.dart';
import 'package:firebase_remote_config_generator/src/services/config_generator/config_generator.dart';
import 'package:firebase_remote_config_generator/src/services/io_manager/io_manager.dart';

class GenerateConfigCommand {
  final ConfigDownloader downloader;
  final ConfigGenerator generator;
  final IoManager ioManager;

  GenerateConfigCommand(
    this.downloader,
    this.generator,
    this.ioManager,
  );

  Future<void> execute() async {
    final parameters = await downloader.download();
    final code = await generator.generate(parameters, 'AppConfig');
    await ioManager.write('lib/config.dart', code);
    await Process.run('dart', [
      'format',
      'lib/config.dart',
    ]);
    print('wrote to file lib/config.dart');
    print(code);
  }
}
