import 'package:flutter/material.dart';
import 'package:game/settings/app_settings/scores_tracker_singleton.dart';

import '../settings/app_settings/app_colors.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  final _data = ScoresTrackerSingleton().getScoreListOrderByScore();

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 24);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Leader Board"),
      ),
      // Display the contents from the CSV file
      body: Column(
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
              itemCount: _data.length,
              itemBuilder: (_, index) {
                return ScorePosisionCard(data: _data, index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ScorePosisionCard extends StatelessWidget {
  static const textStyle = TextStyle(fontSize: 24);

  const ScorePosisionCard({Key? key, required this.data, required this.index})
      : super(key: key);
  final int index;
  final List<CsvFormat> data;

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

class TableRowScore extends StatelessWidget {
  const TableRowScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
