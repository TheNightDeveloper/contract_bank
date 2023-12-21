import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late final SharedPreferences _prefs;
  Future<SharedPreferencesService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  Future<bool> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  bool getBool(String key) => _prefs.getBool(key) ?? false;

  String getString(String key) => _prefs.getString(key)!;
  Future<bool> clear() async => await _prefs.clear();
}
