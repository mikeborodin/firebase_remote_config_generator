import 'package:firebase_remote_config_generator/src/services/config_generator/config_generator.dart';
import 'package:firebase_remote_config_generator/src/services/config_generator/dart_symbols_generator.dart';

import '../../entites/parameter.dart';

class DartConfigGenerator implements ConfigGenerator {
  @override
  Future<String> generate(List<Parameter> parameters) async {
    final symbol = DartSymbolsGenerator();

    return [
      'class Config {',
      for (final parameter in parameters) ...[symbol.generateParameterField(parameter), '\n'],
      '}\n',
    ].join('\n');
  }
}
