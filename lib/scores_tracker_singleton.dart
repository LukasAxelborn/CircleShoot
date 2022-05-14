import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoresTrackerSingleton {
  ScoresTrackerSingleton._privateConstructor();

  static final ScoresTrackerSingleton _instance =
      ScoresTrackerSingleton._privateConstructor();

  int _id = 0;
  List<CsvFormat> scoreList = <CsvFormat>[];

  factory ScoresTrackerSingleton() {
    return _instance;
  }

  Future<String> _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final _userName = prefs.getString('USERNAME');
    if (_userName == null) {
      return "AAAAA";
    }
    return _userName;
  }

  Future<void> addNewGame(int score, int time) async {
    var name = await _getUserName();
    addScore(_id++, name, score, time);
  }

  void addScore(int id, String name, int score, int time) {
    scoreList.add(CsvFormat(id, name, score, time));
  }

  void removeScore(int id) {
    scoreList.removeWhere((element) => element.id == id);
  }

  List<CsvFormat> get getScoreList => scoreList;
  List<CsvFormat> getScoreListOrderByScore() {
    scoreList.sort((a, b) => b.score.compareTo(a.score));
    return scoreList;
  }

  List<CsvFormat> getScoreListOrderByTime() {
    scoreList.sort((a, b) => b.time.compareTo(a.time));
    return scoreList;
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

        if (_id < id) _id = id;

        addScore(
          id,
          score[1],
          int.parse(score[2]),
          int.parse(score[3]),
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
}

class CsvFormat {
  late int id;
  late String name;
  late int score;
  late int time;

  CsvFormat(this.id, this.name, this.score, this.time);
  @override
  String toString() {
    return '$id,$name,$score,$time';
  }
}
