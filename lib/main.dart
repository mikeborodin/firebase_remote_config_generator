library;

import 'package:args/command_runner.dart';
import 'package:firebase_remote_config_generator/src/services/config_generator/dart_config_generator.dart';
import 'src/commands/generate_config.dart';
import 'src/services/config_generator/json_generator.dart';
import 'src/services/services.dart';

Future<void> main(List<String> arguments) async {
  final runner = CommandRunner(
      'firebase_remote_config_generator', 'Create Dart code based on FRC')
    ..addCommand(
      GenerateConfigCommand(
        GoogleapisConfigDownloader(),
        DartConfigGenerator(),
        JsonConfigGenerator(),
        FileIoManager(),
        ConsoleLogger(),
      ),
    );

  return runner.run(arguments);
}
