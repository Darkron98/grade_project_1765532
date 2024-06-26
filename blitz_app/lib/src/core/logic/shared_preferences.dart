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

  set user(String value) {
    _preferences.setString('user', value);
  }

  String get user {
    return _preferences.getString('user') ?? '';
  }

  set rol(int value) {
    _preferences.setInt('rol', value);
  }

  int get rol {
    return _preferences.getInt('rol') ?? 0;
  }

  set remain(bool value) {
    _preferences.setBool('remain', value);
  }

  bool get remain {
    return _preferences.getBool('remain') ?? false;
  }

  set remainUser(String value) {
    _preferences.setString('remainUser', value);
  }

  String get remainUser {
    return _preferences.getString('remainUser') ?? '';
  }

  set userContract(bool value) {
    _preferences.setBool('userContract', value);
  }

  bool get userContract {
    return _preferences.getBool('userContract') ?? false;
  }

  set requestNotiPerm(bool value) {
    _preferences.setBool('requestNotiPerm', value);
  }

  bool get requestNotiPerm {
    return _preferences.getBool('requestNotiPerm') ?? false;
  }
}
