import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {

  static SharedPreferences _sharedPreferences;

  static const KEY_VERSION = "v1";
  static const KEY_LOCALE = "${KEY_VERSION}_locale";

  Future<SharedPreferences> get sharedPreferences async {

    if (_sharedPreferences != null) return _sharedPreferences;

    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences;
  }

  Future<String> getLocale() async {

    final sp = await sharedPreferences;
    return sp.getString(KEY_LOCALE);
  }

  Future<bool> setLocale(String locale) async {

    final sp = await sharedPreferences;
    return await sp.setString(KEY_LOCALE, locale);
  }
}

final preferencesRepository = PreferencesRepository();