import 'package:flutter/material.dart';
import 'package:game/settings/app_settings/scores_tracker_singleton.dart';
import 'package:game/start_screen/start_menu.dart';
import 'package:flutter/services.dart';
import 'online_game/online_game_create/online_game_create_state/online_game_create_state.dart';
import 'settings/user_settings/user_settings_option_state/user_settings_state.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ScoresTrackerSingleton().loadCSV();
  UserSettingsState.init();
  OnlineGameCreateState.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      const MaterialApp(
        title: 'Circle Shoot',
        debugShowCheckedModeBanner: false,
        home: StartMenu(),
      ),
    );
  });
}
