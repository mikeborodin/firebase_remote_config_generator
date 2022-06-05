import 'dart:io';

import 'package:firebase_remote_config_generator/src/services/io_manager/io_manager.dart';

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
