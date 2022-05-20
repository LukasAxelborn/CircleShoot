import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../user_settings/user_settings_option_state/user_settings_state.dart';

class ScoresTrackerSingleton {
  ScoresTrackerSingleton._privateConstructor();

  static final ScoresTrackerSingleton _instance =
      ScoresTrackerSingleton._privateConstructor();

  int _id = 0;
  List<CsvFormat> scoreList = <CsvFormat>[];

  factory ScoresTrackerSingleton() {
    return _instance;
  }

  Future<void> addNewGame(int score, int time) async {
    var name = UserSettingsState().getUserName();
    int difficulty = UserSettingsState().getDifficulty();
    addScore(_id++, name, score, time, difficulty);
  }

  void addScore(int id, String name, int score, int time, int difficulty) {
    scoreList.add(CsvFormat(id, name, score, time, difficulty));
  }

  void removeScore(int id) {
    scoreList.removeWhere((element) => element.id == id);
  }

  List<CsvFormat> get getScoreList => scoreList;

  List<CsvFormat> getScoreListOrderByScore(int diff) {
    scoreList.sort((a, b) => b.score.compareTo(a.score));

    var scoreListWithDiff = <CsvFormat>[];

    for (var el in scoreList) {
      if (el.difficulty == diff) {
        scoreListWithDiff.add(el);
      }
    }
    return scoreListWithDiff;
  }

  List<CsvFormat> getScoreListOrderByTime(int diff) {
    scoreList.sort((a, b) => b.time.compareTo(a.time));
    var scoreListWithDiff = <CsvFormat>[];

    for (var el in scoreList) {
      if (el.difficulty == diff) {
        scoreListWithDiff.add(el);
      }
    }
    return scoreListWithDiff;
  }

  Future<void> loadCSV() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      var lineList =
          File('${directory.path}/leaderboard.csv').readAsLinesSync();
      var line = lineList[0];
      // tar bort början och slitet [... .... ...] och sen gör mellan rum till sepparata listor
      var lines = line.replaceAll('[', '').replaceAll(']', '').split(' ');

      for (var line in lines) {
        var score = line.split(',');

        var id = int.parse(score[0]);

        _id = max(_id, id);

        addScore(
          id,
          score[1],
          int.parse(score[2]),
          int.parse(score[3]),
          int.parse(score[4]),
        );
      }
    } catch (e) {
      debugPrint('New scoreboard.');
    }
  }

  Future<void> writeCSV() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/leaderboard.csv');
    var ttt = scoreList.toString();
    await file.writeAsString(ttt);
  }

  void clearList() {
    scoreList.clear();
  }
}

class CsvFormat {
  late int id;
  late String name;
  late int score;
  late int time;
  late int difficulty;

  CsvFormat(this.id, this.name, this.score, this.time, this.difficulty);
  @override
  String toString() {
    return '$id,$name,$score,$time,$difficulty';
  }
}
