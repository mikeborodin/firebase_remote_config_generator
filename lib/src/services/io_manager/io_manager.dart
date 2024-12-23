import 'dart:io';

abstract class IoManager {
  Future<void> write(String target, String value);
  Future<String> read(String target);
}

class FileIoManager implements IoManager {
  @override
  Future<void> write(String target, String value) {
    return File(target).writeAsString(value);
  }

  @override
  Future<String> read(String target) {
    return File(target).readAsString();
  }
}
