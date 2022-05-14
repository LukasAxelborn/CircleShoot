import 'package:flutter/material.dart';
import 'package:game/scores_tracker_singleton.dart';
import 'package:game/start_menu.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ScoresTrackerSingleton().loadCSV();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      const MaterialApp(
        title: 'Navigation Basics',
        debugShowCheckedModeBanner: false,
        home: StartMenu(),
      ),
    );
  });
}
