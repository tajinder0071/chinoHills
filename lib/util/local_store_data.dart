import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal();

  SharedPreferences? _prefs;

  /// Initialize SharedPreferences
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Save data of any type
  Future<void> saveData<T>(String key, T value) async {
    await init();
    if (value is int) {
      print("int=>$value");
      await _prefs!.setInt(key, value);
    } else if (value is double) {
      print("double=>$value");
      await _prefs!.setDouble(key, value);
    } else if (value is bool) {
      print("bool=>$value");
      await _prefs!.setBool(key, value);
    } else if (value is String) {
      print("String=>$value");
      await _prefs!.setString(key, value);
    } else {
      print("value=>$value");
      // Save custom/complex object as JSON string
      await _prefs!.setString(key, jsonEncode(value));
    }
  }

  /// Read data of any type

  Future<int?> getindex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('shopIndex');
  }

  Future<String?> getCId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('client_id');
  }

  Future<String?> getUId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_uuid');
  }

  Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name');
  }

  Future<String?> getOId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('order_id');
  }


  /// Remove a specific key
  Future<void> removeData(String key) async {
    await init();
    await _prefs?.remove(key);
  }

  /// Clear all storage data
  Future<void> clearAllData() async {
    await init();
    await _prefs?.clear();
  }
}
