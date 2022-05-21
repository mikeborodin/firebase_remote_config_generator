void main(List<String> arguments) {
  if (arguments.contains('--help')) {
    print(
      '''
      FRC Generator
        usage:
        --credentials : Path to JSON file containing Firebase credentials
        --output-path : Path to resulting file
        --class-name : Name of Dart classname of parsed Config.
      ''',
    );
  } else {}
}
