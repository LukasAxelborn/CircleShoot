import 'package:flutter/material.dart';
import 'package:game/leaderboard/leaderboard_offline/leaderboard_local.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.people)),
                Tab(icon: Icon(Icons.person)),
              ],
            ),
            title: const Text("Leader Board"),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.people),
              LeaderBoardLocal(),
            ],
          ),
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
