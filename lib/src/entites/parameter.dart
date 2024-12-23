
enum ParameterType {
  boolean,
  string,
  json,
  number,
}

class Parameter {
  final String name;
  final String description;
  final ParameterType type;
  final dynamic defaultValue;

  Parameter({
    required this.name,
    required this.description,
    required this.type,
    required this.defaultValue,
  });
}
