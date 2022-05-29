abstract class IoManager {
  Future<void> write(String target, String value);
  Future<String> read(String target);
}
