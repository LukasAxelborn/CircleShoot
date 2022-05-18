import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsState {
  static const String difficulty = "difficulty";
  static const String moveforwardAutomatic = "MoveForward";
  static const String connectonline = "ConnectOnline";

  static late final SharedPreferences preferences;

  static Future<SharedPreferences> init() async =>
      preferences = await SharedPreferences.getInstance();

  int getDifficulty() {
    return preferences.getInt(difficulty) ?? 0;
    // this 1 in the end is a default value
  }

  Future setDifficulty(int _difficulty) {
    print(_difficulty);
    return preferences.setInt(difficulty, _difficulty);
  }

  bool? getMoveForwardAutomatic() {
    return preferences.getBool(moveforwardAutomatic);
    // defult is error
  }

  Future setMoveForwardAutomatic(bool _moveforwardAutomatic) {
    return preferences.setBool(moveforwardAutomatic, _moveforwardAutomatic);
  }

  bool? getConnectOnline() {
    return preferences.getBool(connectonline);
    // defult is error
  }

  Future setConnectOnline(bool _connectonline) {
    return preferences.setBool(connectonline, _connectonline);
  }
}
