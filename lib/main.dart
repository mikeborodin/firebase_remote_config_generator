library firebase_remote_config_generator;

import 'package:firebase_remote_config_generator/src/services/config_generator/dart_config_generator.dart';
import 'package:firebase_remote_config_generator/src/services/io_manager/file_io_manager.dart';

import 'src/commands/generate_config.dart';
import 'src/services/config_downloader/googleapis_config_downloader.dart';

void main(List<String> arguments) {
  final command = GenerateConfigCommand(
    GoogleapisConfigDownloader(),
    DartConfigGenerator(),
    FileIoManager(),
  );

  print('starting');
  command.execute();
}
