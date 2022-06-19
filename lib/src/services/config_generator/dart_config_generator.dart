import 'package:firebase_remote_config_generator/src/services/config_generator/config_generator.dart';
import 'package:firebase_remote_config_generator/src/services/config_generator/dart_symbols_generator.dart';

import '../../entites/parameter.dart';

class DartConfigGenerator implements ConfigGenerator {
  @override
  Future<String> generate(
    List<Parameter> parameters,
    String className,
  ) async {
    final symbol = DartSymbolsGenerator(className: className);

    return [
      "import 'dart:convert';"
          '\n',
      "import 'package:firebase_remote_config/firebase_remote_config.dart';"
          '\n',
      'class $className {',
      for (final parameter in parameters) ...[
        symbol.generateFinalParameterField(parameter),
        '\n',
      ],
      symbol.generateDefaultConstructor(parameters),
      '\n',
      symbol.generateFactoryConstructor(parameters),
      '}',
    ].join('\n');
  }
}
