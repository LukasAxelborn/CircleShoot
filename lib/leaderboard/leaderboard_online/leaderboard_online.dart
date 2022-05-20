import 'package:flutter/material.dart';

import '../../settings/app_settings/app_colors.dart';
import '../../settings/app_settings/scores_tracker_singleton.dart';

class LeaderBoardOnline extends StatelessWidget {
  const LeaderBoardOnline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              tabs: [
                difficultytext("Hard"),
                difficultytext("Middel"),
                difficultytext("Easy"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  LeaderBoard(
                    data: ScoresTrackerSingleton().getScoreListOrderByScore(2),
                  ),
                  LeaderBoard(
                    data: ScoresTrackerSingleton().getScoreListOrderByScore(1),
                  ),
                  LeaderBoard(
                    data: ScoresTrackerSingleton().getScoreListOrderByScore(0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget difficultytext(String data) => Container(
        //padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        child: Text(
          data,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      );
}

class LeaderBoard extends StatelessWidget {
  final List<CsvFormat> data;

  const LeaderBoard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 24);
    return Column(
      children: <Widget>[
        const Card(
          margin: EdgeInsets.all(3),
          color: Colors.green,
          child: ListTile(
            leading: Text(
              "Name",
              style: textStyle,
            ),
            title: Text(
              "score",
              style: textStyle,
            ),
            trailing: Text(
              "Time",
              style: textStyle,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return ScorePosisionCard(data: data, index: index);
            },
          ),
        ),
      ],
    );
  }
}

class ScorePosisionCard extends StatelessWidget {
  static const textStyle = TextStyle(fontSize: 24);
  final List<CsvFormat> data;

  const ScorePosisionCard({Key? key, required this.data, required this.index})
      : super(key: key);
  final int index;

  Color getColorofIndex(int index) {
    switch (index) {
      case 0:
        return AppColors.firstplace;
      case 1:
        return AppColors.secondplace;
      case 2:
        return AppColors.thirdplace;
      default:
        return AppColors.outsideplace;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(3),
      color: getColorofIndex(index),
      child: ListTile(
        leading: Text(
          data[index].name,
          style: textStyle,
        ),
        title: Text(
          data[index].score.toString(),
          style: textStyle,
        ),
        trailing: Text(
          data[index].time.toString(),
          style: textStyle,
        ),
      ),
    );
  }
}
