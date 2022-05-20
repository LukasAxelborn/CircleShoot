import 'dart:convert';

import '../user_settings/user_settings_option_state/user_settings_state.dart';
import 'csv_format.dart';
import 'package:http/http.dart' as http;

class ScoresTrackerOnlineSingleton {
  ScoresTrackerOnlineSingleton._privateConstructor();

  static final ScoresTrackerOnlineSingleton _instance =
      ScoresTrackerOnlineSingleton._privateConstructor();

  List<CsvFormat> scoreListOnline = <CsvFormat>[];

  // ignore: constant_identifier_names
  static const String DOMAIN = "hex.cse.kau.se";
  // ignore: constant_identifier_names
  static const String USER = "~lukaaxel100/CircleShoot/";

  factory ScoresTrackerOnlineSingleton() {
    return _instance;
  }

  Future<void> instancetescoreListOnline() async {
    if (UserSettingsState().getConnectOnline()) {
      scoreListOnline = <CsvFormat>[];
      var response =
          await http.get(Uri.https(DOMAIN, USER + 'GET/getLeaderBoard.php'));
      var jasonData = jsonDecode(response.body);

      for (var data in jasonData) {
        addScore(
          data['ID'],
          data['UserName'],
          data['Score'],
          data['timesurvived'],
          data['difficulty'],
        );
      }
    }
  }

  void addNewGame(int score, int time) {
    if (UserSettingsState().getConnectOnline()) {
      var name = UserSettingsState().getUserName();
      int difficulty = UserSettingsState().getDifficulty();

      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      var data =
          'username=$name&score=$score&time=$time&difficulty=$difficulty';

      var url = Uri.https(DOMAIN, USER + 'POST/addToLeaderboard.php');
      http.post(url, headers: headers, body: data);
    }
  }

  void addScore(int id, String name, int score, int time, int difficulty) {
    scoreListOnline.add(CsvFormat(id, name, score, time, difficulty));
  }

  void removeScore(int id) {
    scoreListOnline.removeWhere((element) => element.id == id);
  }

  List<CsvFormat> get getScoreListOnline => scoreListOnline;

  List<CsvFormat> getScoreListOnlineOrderByScore(int diff) {
    scoreListOnline.sort((a, b) => b.score.compareTo(a.score));

    var scoreListOnlineWithDiff = <CsvFormat>[];

    for (var el in scoreListOnline) {
      if (el.difficulty == diff) {
        scoreListOnlineWithDiff.add(el);
      }
    }
    return scoreListOnlineWithDiff;
  }

  List<CsvFormat> getScoreListOnlineOrderByTime(int diff) {
    scoreListOnline.sort((a, b) => b.time.compareTo(a.time));
    var scoreListOnlineWithDiff = <CsvFormat>[];

    for (var el in scoreListOnline) {
      if (el.difficulty == diff) {
        scoreListOnlineWithDiff.add(el);
      }
    }
    return scoreListOnlineWithDiff;
  }
}
