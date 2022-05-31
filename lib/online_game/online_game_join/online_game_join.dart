import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:game/thegame/game_online/UI_Online/menu_game_online.dart';
import 'package:game/widgets/customs_options_row.dart';

class OnlineGameJoin extends StatefulWidget {
  const OnlineGameJoin({Key? key}) : super(key: key);

  @override
  State<OnlineGameJoin> createState() => _OnlineGameJoinState();
}

class _OnlineGameJoinState extends State<OnlineGameJoin> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            CustomsRow(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: "Host Address",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () => _textController.clear(),
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          JoinGame(context, _textController.text);
                        },
                        color: Colors.blue,
                        child: const Text(
                          'Join',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void JoinGame(BuildContext _context, String text) {
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("please type a server address"),
      ));
      return;
    }

    FirebaseDatabase.instance.ref("Lobby").child(text).once().then(
      (value) {
        if (value.snapshot.exists) {
          Navigator.push(
              _context,
              MaterialPageRoute(
                  builder: (_context) => MenugameOnline(false, text)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Server address dont exist")));
          return;
        }
      },
    );
  }
}
