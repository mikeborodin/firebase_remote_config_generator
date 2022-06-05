import 'package:firebase_remote_config_generator/src/entites/parameter.dart';

abstract class ConfigDownloader {
  Future<List<Parameter>> download();
}
