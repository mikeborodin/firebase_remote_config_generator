import 'dart:convert';

import '../../entites/parameter.dart';
import 'config_generator.dart';

class JsonConfigGenerator implements ConfigGenerator {
  @override
  Future<String> generate(
    List<Parameter> parameters,
    String className,
  ) async {
    final params = [
      for (final item in parameters)
        {
          'name': item.name,
          'type': item.type.toString(),
          'description': item.description,
          'defaultValue': item.defaultValue,
        }
    ];

    return jsonEncode(params);
  }
}
