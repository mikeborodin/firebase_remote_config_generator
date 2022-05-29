import 'package:firebase_remote_config_generator/src/services/io_manager/io_manager.dart';

class FileIoManager implements IoManager {
  @override
  Future<void> write(String target, String value) {
    throw UnimplementedError();
  }

  @override
  Future<String> read(String target) {
    throw UnimplementedError();
  }
}
