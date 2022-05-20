import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsState {
  static const String difficulty = "difficulty";
  static const String moveforwardAutomatic = "MoveForward";
  static const String connectonline = "ConnectOnline";
  static const String username = "UserName";

  static late final SharedPreferences preferences;

  static Future<SharedPreferences> init() async =>
      preferences = await SharedPreferences.getInstance();

  int getDifficulty() {
    return preferences.getInt(difficulty) ?? 0;
    // this 1 in the end is a default value
  }

  Future setDifficulty(int _difficulty) {
    return preferences.setInt(difficulty, _difficulty);
  }

  bool getMoveForwardAutomatic() {
    return preferences.getBool(moveforwardAutomatic) ?? false;
    // defult is error
  }

  Future setMoveForwardAutomatic(bool _moveforwardAutomatic) {
    return preferences.setBool(moveforwardAutomatic, _moveforwardAutomatic);
  }

  bool getConnectOnline() {
    return preferences.getBool(connectonline) ?? true;
    // defult is error
  }

  Future setConnectOnline(bool _connectonline) {
    return preferences.setBool(connectonline, _connectonline);
  }

  String getUserName() {
    return preferences.getString(username) ?? "AAAAAA";
  }

  Future setUserName(String _username) {
    return preferences.setString(username, _username);
  }
}
