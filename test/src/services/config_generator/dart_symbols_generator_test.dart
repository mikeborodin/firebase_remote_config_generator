import 'package:firebase_remote_config_generator/src/entites/parameter.dart';
import 'package:firebase_remote_config_generator/src/services/config_generator/dart_symbols_generator.dart';
import 'package:test/test.dart';

void main() {
  final generator = DartSymbolsGenerator(className: 'Config');
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

  test('should generate String config field', () {
    var code = generator.generateParameterField(Parameter(
      name: 'flag',
      description: 'my String parameter',
      type: ParameterType.string,
      defaultValue: 'ABC',
    ));
    expect(
      code,
      '''
/// my String parameter
String flag = 'ABC';'''
          .trim(),
    );
  });

  test('should generate Map config field', () {
    var code = generator.generateParameterField(Parameter(
      name: 'flag',
      description: 'my JSON parameter',
      type: ParameterType.json,
      defaultValue: {
        'a': 'b',
        'c': 1,
        'd': true,
        'e': {'aa': 'bb'}
      },
    ));
    expect(
      code.replaceAll('\n', '').replaceAll(' ', '').trim(),
      '''
/// my JSON parameter
Map<String, dynamic> flag = {
        'a': 'b',
        'c': 1,
        'd': true,
        'e': {'aa': 'bb',},
      };'''
          .replaceAll(' ', '')
          .replaceAll('\n', '')
          .trim(),
    );
  });
}
