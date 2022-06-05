import 'package:firebase_remote_config_generator/src/entites/parameter.dart';
import 'package:firebase_remote_config_generator/src/services/config_generator/dart_symbols_generator.dart';
import 'package:test/test.dart';

void main() {
  final generator = DartSymbolsGenerator();
  test('should generate boolean config field', () {
    var code = generator.generateParameterField(Parameter(
      name: 'flag',
      description: 'my feature flag',
      type: ParameterType.boolean,
      defaultValue: true,
    ));
    expect(
      code,
      '''
/// my feature flag
bool flag = true;'''
          .trim(),
    );
  });

  test('should generate boolean config field with false default value', () {
    var code = generator.generateParameterField(Parameter(
      name: 'flag',
      description: 'my feature flag',
      type: ParameterType.boolean,
      defaultValue: false,
    ));
    expect(
      code,
      '''
/// my feature flag
bool flag = false;'''
          .trim(),
    );
  });
}
