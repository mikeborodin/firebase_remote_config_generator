import 'dart:io';

abstract class Logger {
  void log(String message);
}

class ConsoleLogger implements Logger {
  @override
  void log(String message) {
    stdout.writeln(message);
  }
}
