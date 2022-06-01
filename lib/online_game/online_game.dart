import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game/online_game/online_game_create/online_game_create.dart';
import 'package:game/online_game/online_game_join/online_game_join.dart';
import 'package:game/widgets/custum_menu_button.dart';

class OnlineGame extends StatefulWidget {
  const OnlineGame({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<OnlineGame> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OnlineGame> {
  late var _user;
  _MyHomePageState() {
    try {
      // ignore: unused_local_variable
      final userCredential = FirebaseAuth.instance.signInAnonymously();
      debugPrint("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          debugPrint("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          debugPrint("Unknown error.");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustumMenuButton(
              buttonText: "Join Game",
              fun: (context) => const OnlineGameJoin(),
            ),
            const SizedBox(height: 16),
            CustumMenuButton(
              buttonText: "Create Game",
              fun: (context) => const OnlineGameCreate(),
            ),
          ],
        ),
      ),
    );
  }
}
