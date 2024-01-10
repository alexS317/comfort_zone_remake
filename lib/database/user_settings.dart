import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  final String _defaultAffirmationsPrefs = "allowDefaults";

  Future<bool> setIncludeDefaultAffirmations(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(value);

    return prefs.setBool(_defaultAffirmationsPrefs, value);
  }

  Future<bool> getIncludeDefaultAffirmations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Return false if the function result is null
    return prefs.getBool(_defaultAffirmationsPrefs) ?? false;
  }
}
