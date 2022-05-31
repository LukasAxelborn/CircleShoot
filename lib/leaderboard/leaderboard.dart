import 'package:flutter/material.dart';
import 'package:game/leaderboard/leaderboard_offline/leaderboard_local.dart';
import 'package:game/leaderboard/leaderboard_online/leaderboard_online.dart';

import '../settings/app_settings/scores_tracker_online_singleton.dart';

class LeaderBoard extends StatelessWidget {
  LeaderBoard({Key? key}) : super(key: key) {
    ScoresTrackerOnlineSingleton().instancetescoreListOnline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.people)),
              ],
            ),
            centerTitle: true,
            title: const Text("Leader Board"),
          ),
          body: const TabBarView(
            children: [
              LeaderBoardLocal(),
              LeaderBoardOnline(),
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
