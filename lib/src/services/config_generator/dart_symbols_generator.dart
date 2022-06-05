import 'package:firebase_remote_config_generator/src/entites/parameter.dart';

class DartSymbolsGenerator {
  String generateParameterField(Parameter parameter) {
    return [
      if (parameter.description.isNotEmpty) '/// ${parameter.description}',
      '${_type(parameter.type)} ${parameter.name} = ${_defaultValue(parameter)};',
    ].join('\n');
  }

  String _type(ParameterType type) {
    switch (type) {
      case ParameterType.boolean:
        return 'bool';
      default:
        return '';
    }
  }

  String _defaultValue(Parameter parameter) {
    switch (parameter.type) {
      case ParameterType.boolean:
        return (parameter.defaultValue as bool).toString();
      default:
        return '';
    }
  }
}
