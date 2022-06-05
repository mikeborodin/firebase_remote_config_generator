import 'package:firebase_remote_config_generator/src/entites/parameter.dart';
import 'package:firebase_remote_config_generator/src/services/config_generator/config_generator.dart';
import 'package:firebase_remote_config_generator/src/services/config_generator/dart_config_generator.dart';
import 'package:test/test.dart';

void main() {
  final ConfigGenerator generator = DartConfigGenerator();
  test('should generate config class body', () {
    final code = generator.generate([
      Parameter(
        name: 'featureA',
        description: 'my feature A',
        type: ParameterType.boolean,
        defaultValue: false,
      )
    ]);

    expect(code, startsWith('class Config {'));
    expect(code, endsWith('}\n'));
  });

  test('should contain all parameters names', () async {
    var parameters = [
      Parameter(
        name: 'featureA',
        description: 'my feature A',
        type: ParameterType.boolean,
        defaultValue: false,
      ),
      Parameter(
        name: 'featureB',
        description: 'my feature A',
        type: ParameterType.boolean,
        defaultValue: false,
      ),
      Parameter(
        name: 'featureC',
        description: 'my feature A',
        type: ParameterType.boolean,
        defaultValue: false,
      ),
    ];
    final code = await generator.generate(parameters);

    parameters.map((parameter) => 'bool ${parameter.name} = false;').every(
          (expectedSymbol) => code.contains(expectedSymbol),
        );
  });
}
