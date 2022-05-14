import 'package:flutter/material.dart';
import 'package:game/scores_tracker_singleton.dart';

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

  ScorePosisionCard({
    Key? key,
    required List<CsvFormat> data,
    required int index,
  })  : _data = data,
        index = index,
        super(key: key);
  int index;
  final List<CsvFormat> _data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(3),
      color: index == 0
          ? Colors.amber
          : index == 1
              ? Colors.blueGrey
              : index == 2
                  ? Colors.brown
                  : Colors.white,
      child: ListTile(
        leading: Text(
          _data[index].name,
          style: textStyle,
        ),
        title: Text(
          _data[index].score.toString(),
          style: textStyle,
        ),
        trailing: Text(
          _data[index].time.toString(),
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
