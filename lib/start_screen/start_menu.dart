import 'package:flutter/material.dart';
import 'package:game/leaderboard/leaderboard.dart';
import 'package:game/settings/app_settings/scores_tracker_singleton.dart';
import 'package:game/settings/user_settings/settings_menu.dart';
import 'package:game/thegame/UI/menu_game.dart';

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
            fun: (context) => Menugame(),
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

 
}
*/

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class CustumMenuButton extends StatelessWidget {
  final String buttonText;
  final Widget Function(BuildContext) fun;
  const CustumMenuButton(
      {Key? key, required this.buttonText, required this.fun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButtonTheme(
        data: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(minimumSize: const Size(200, 60))),
        child: ElevatedButton(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: fun),
            );
          },
        ),
      ),
    );
  }
}
