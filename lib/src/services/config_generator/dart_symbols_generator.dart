import 'package:firebase_remote_config_generator/src/entites/parameter.dart';

class DartSymbolsGenerator {
  final String className;

  DartSymbolsGenerator({
    required this.className,
  });

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
      case ParameterType.string:
        return 'String';
      case ParameterType.json:
        return 'Map<String, dynamic>';
      case ParameterType.number:
        return 'double';
    }
  }

  String generateFinalParameterField(Parameter parameter) {
    return [
      if (parameter.description.isNotEmpty) '/// ${parameter.description}',
      'final ${_type(parameter.type)} ${parameter.name};',
    ].join('\n');
  }

  String getAs(Parameter parameter) {
    switch (parameter.type) {
      case ParameterType.boolean:
        return 'asBool()';
      case ParameterType.number:
        return 'asDouble()';
      case ParameterType.json:
      case ParameterType.string:
        return 'asString()';
    }
  }

  String _getConstructorValueParsed(Parameter parameter) {
    var parsedAs = "values['${parameter.name}']?.${getAs(parameter)}";
    if (parameter.type != ParameterType.json) {
      return parsedAs;
    } else {
      return "jsonDecode(values['${parameter.name}']!.asString()) as Map<String, dynamic>?";
    }
  }

  String generateFactoryConstructor(List<Parameter> parameters) {
    final constructorParams = parameters
        .map(
          (param) =>
              '${param.name}: ${_getConstructorValueParsed(param)} ?? ${_defaultValue(param)},',
        )
        .join();
    return [
      'factory $className.fromValues(Map<String, RemoteConfigValue> values) {',
      'return $className($constructorParams);'
          '}',
    ].join('\n');
  }

  String generateDefaultConstructor(List<Parameter> parameters) {
    final constructorParams =
        parameters.map((param) => 'required this.${param.name},').join();
    return '$className({$constructorParams});';
  }

  String _defaultValue(Parameter parameter) {
    switch (parameter.type) {
      case ParameterType.boolean:
        return (parameter.defaultValue as bool).toString();
      case ParameterType.string:
        return "'${(parameter.defaultValue as String?) ?? ''}'";
      case ParameterType.json:
        final map = parameter.defaultValue as Map<String, dynamic>;
        return '{\n${map.keys.map((key) => "'$key': ${_symbolizeMapValue(map[key])}").join(',\n')}\n,\n}';
      case ParameterType.number:
        return parameter.defaultValue.toString();
    }
  }

  String _symbolizeMapValue(dynamic value) {
    switch (value.runtimeType) {
      case String:
        return "'$value'";
      case num:
      case bool:
      case int:
      case double:
        return '$value';
      default:
        if (value is Map) {
          print('map');
          final map = value;
          return '{\n${map.keys.map((key) => "'$key': ${_symbolizeMapValue(map[key])},").join('\n')}\n}';
        }
        print(value.runtimeType);
        return 'throw Exception()';
    }
  }
}
