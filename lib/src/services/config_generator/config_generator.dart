import '../../entites/parameter.dart';

abstract class ConfigGenerator {
  Future<String> generate(List<Parameter> parameters);
}
