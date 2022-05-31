import 'package:flutter/material.dart';
import 'package:game/leaderboard/leaderboard.dart';
import 'package:game/settings/app_settings/scores_tracker_singleton.dart';
import 'package:game/settings/user_settings/settings_menu.dart';
import 'package:game/thegame/game_offline/UI_Offline/menu_game_offline.dart';

import '../online_game/online_game.dart';
import '../widgets/custum_menu_button.dart';

class StartMenu extends StatefulWidget {
  const StartMenu({Key? key}) : super(key: key);

  @override
  State<StartMenu> createState() => _StartMenuState();
}

class _StartMenuState extends State<StartMenu> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive) {
      return;
    }
    if (state == AppLifecycleState.paused) {
      ScoresTrackerSingleton().writeCSV();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Circle Shoot'),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustumMenuButton(
            buttonText: "Start Game",
            fun: (context) => MenugameOffline(),
          ),
          const SizedBox(height: 16),
          CustumMenuButton(
            buttonText: "Start Online Game",
            fun: (context) => const OnlineGame(
              title: 'ONLINE GAME',
            ),
          ),
          const SizedBox(height: 16),
          CustumMenuButton(
            buttonText: "Leader Board",
            fun: (context) => LeaderBoard(),
          ),
          const SizedBox(height: 16),
          CustumMenuButton(
            buttonText: "Settings",
            fun: (context) => const SettingsMenu(),
          ),
        ],
      ),
    );
  }
}
/*
class StartMenu extends StatelessWidget with WidgetsBindingObserver {
  const StartMenu({Key? key}) : super(key: key);

  @override
  initState() {
    super.initState();
  }
OnlineGame
 
}
*/

