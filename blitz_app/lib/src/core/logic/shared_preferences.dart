import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  factory Preferences() {
    return _instance;
  }

  Preferences._internal();

  static final Preferences _instance = Preferences._internal();

  late SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  set token(String value) {
    _preferences.setString('token', value);
  }

  String get token {
    return _preferences.getString('token') ?? '0';
  }
}
