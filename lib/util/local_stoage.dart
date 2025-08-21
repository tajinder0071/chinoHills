/*
import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal();

  final GetStorage _storage = GetStorage();

  /// Save data of any type
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  /// Read data of any type
  T? readData<T>(String key) {
    return _storage.read(key);
  }

  /// Remove a specific key
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  /// Clear all storage data
  Future<void> clearAllData() async {
    await _storage.erase();
  }
}
*/
