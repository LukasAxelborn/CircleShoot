import 'package:shared_preferences/shared_preferences.dart';

class OnlineGameCreateState {
  static String serveraddress = "";
  static const String numberofplayers = "numberofplayers";
  static const String matchtime = "matchtime";
  static const String freeforallbool = "freeforallbool";
  static const String freeforallscore = "freeforallscore";
  static const String laststandingbool = "laststandingbool";
  static const String laststandingscore = "laststandingscore";

  static late final SharedPreferences preferences;

  static Future<SharedPreferences> init() async =>
      preferences = await SharedPreferences.getInstance();

  String getserveraddress() {
    return serveraddress;
  }

  void setserveraddress(String _serveraddress) {
    serveraddress = _serveraddress;
  }

  int getnumberofplayers() {
    return preferences.getInt(numberofplayers) ?? 2;
  }

  Future setnumberofplayers(int _numberofplayers) {
    return preferences.setInt(numberofplayers, _numberofplayers);
  }

  int getmatchtime() {
    return preferences.getInt(matchtime) ?? 60;
  }

  Future setmatchtime(int _matchtime) {
    return preferences.setInt(matchtime, _matchtime);
  }

  bool getfreeforallbool() {
    return preferences.getBool(freeforallbool) ?? true;
  }

  Future setfreeforallbool(bool _freeforallbool) {
    return preferences.setBool(freeforallbool, _freeforallbool);
  }

  Future setfreeforallscore(int _freeforallscore) {
    return preferences.setInt(freeforallscore, _freeforallscore);
  }

  int getfreeforallscore() {
    return preferences.getInt(freeforallscore) ?? 20;
  }

  bool getlaststandingbool() {
    return preferences.getBool(laststandingbool) ?? false;
  }

  Future setlaststandingbool(bool _laststandingbool) {
    return preferences.setBool(laststandingbool, _laststandingbool);
  }

  Future setlaststandingscore(int _laststandingscore) {
    return preferences.setInt(laststandingscore, _laststandingscore);
  }

  int getlaststandingscore() {
    return preferences.getInt(laststandingscore) ?? 20;
  }
}
