import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalAuthStorageService {
  final FlutterSecureStorage storage;

  LocalAuthStorageService(this.storage);

  Future<bool> setValue(String key, String value) async {
    await storage.write(key: key, value: value);
    return true;
  }

  Future<dynamic> getValue(String key) async {
    return await storage.read(key: key);
  }

  Future<bool> deleteValue(String key) async {
    await storage.delete(key: key);
    return true;
  }

  Future<bool> deleteAllValue() async {
    await storage.deleteAll();
    return true;
  }
}
