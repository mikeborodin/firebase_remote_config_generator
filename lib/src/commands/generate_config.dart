import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:firebase_remote_config_generator/src/services/config_downloader/config_downloader.dart';
import 'package:firebase_remote_config_generator/src/services/config_generator/config_generator.dart';
import 'package:firebase_remote_config_generator/src/services/io_manager/io_manager.dart';

import '../services/logger/logger.dart';

final serviceAccountFileOpt = 'service-account-file';
final printConsoleOpt = 'also-print';
final outputOpt = 'output';
final formatOpt = 'format';
final classNameOpt = 'class-name';

class GenerateConfigCommand extends Command {
  final ConfigDownloader downloader;
  final ConfigGenerator dartGenerator;
  final IoManager ioManager;
  final Logger logger;

  GenerateConfigCommand(
    this.downloader,
    this.dartGenerator,
    this.ioManager,
    this.logger,
  ) {
    argParser.addOption(
      serviceAccountFileOpt,
      help: 'Path to Service Account file to be used by googleapis',
      mandatory: true,
    );
    argParser.addFlag(
      printConsoleOpt,
      defaultsTo: false,
      help: 'Print outputs to stdout',
      abbr: 'p',
    );
    argParser.addOption(
      outputOpt,
      defaultsTo: 'lib/frc_config.dart',
      help: 'Path to write the generated Dart code to',
      abbr: 'o',
    );
    argParser.addOption(
      formatOpt,
      help: 'Format to use',
      allowed: ['dart', 'json'],
      defaultsTo: 'dart',
      abbr: 'f',
    );
    argParser.addOption(
      classNameOpt,
      defaultsTo: 'AppConfig',
      help: 'Name of the class to be used',
    );
  }

  @override
  Future<void> run() async {
    final results = argResults;
    if (results == null) return;

    final className = results[classNameOpt] as String;
    final serviceAccountPath = results[serviceAccountFileOpt] as String;
    final output = results[outputOpt] as String;
    final format = results[formatOpt] as String;
    final printConsole = results[printConsoleOpt] as bool;

    final file = File(serviceAccountPath);
    if (!file.existsSync()) {
      logger.log('Service Account File  "$serviceAccountPath" does not exist');
      return;
    }

    final parameters = await downloader.download(file);

    final code = await dartGenerator.generate(parameters, className);

    ioManager.write(output, code);

    if (printConsole) {
      logger.log(code);
    } else {
      logger.log('wrote $output');
    }
  }

  @override
  String get description =>
      'Creates Dart configuration based on current state in Firebase Remote Config';

  @override
  String get name => 'generate';
}
