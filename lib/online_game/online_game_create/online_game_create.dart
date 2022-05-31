import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:game/online_game/online_game_create/online_game_create_options/online_game_create_gamemods/online_game_settings_gamemode_ffa.dart';
import 'package:game/online_game/online_game_create/online_game_create_options/online_game_settings_match_time.dart';
import 'package:game/online_game/online_game_create/online_game_create_options/online_game_settings_server_address.dart';
import 'package:game/thegame/game_online/UI_Online/menu_game_online.dart';
import 'package:game/widgets/customs_options_row.dart';

import '../../widgets/good_text_style.dart';
import 'online_game_create_options/online_game_create_gamemods/online_game_settings_gamemode_ls.dart';
import 'online_game_create_options/online_game_settings_player_number.dart';
import 'online_game_create_state/online_game_create_state.dart';

class OnlineGameCreate extends StatefulWidget {
  const OnlineGameCreate({Key? key}) : super(key: key);

  @override
  State<OnlineGameCreate> createState() => _OnlineGameCreateState();
}

class _OnlineGameCreateState extends State<OnlineGameCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Multiplayer Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const CustomsRow(widget: OnlineGameSettingServerAddress()),
            const CustomsRow(widget: OnlineGameSettingsNumberofPlayers()),
            const CustomsRow(widget: OnlineGameSettingsMatchTime()),

            CustomsRow(widget: goodTextStyle("Game Mode")),
            //free for all
            //first to 30 score or somthing else
            const CustomsRow(widget: OnlineGameSettingsGamemodeFfa()),
            //last standing
            //last alive
            const CustomsRow(widget: OnlineGameSettingsGamemodels()),

            CustomsRow(
              widget: MaterialButton(
                onPressed: () {
                  createGame(context);
                },
                color: Colors.blue,
                child: const Text(
                  'Create Game',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void createGame(BuildContext _context) {
    if (serverAddressExist(_context)) {
      String text = OnlineGameCreateState().getserveraddress();
      var gameLobby = FirebaseDatabase.instance.ref("Lobby").child(text);

      bool ffa = OnlineGameCreateState().getfreeforallbool();
      bool ls = OnlineGameCreateState().getlaststandingbool();

      if (ffa && ls || !ffa && !ls) {
        //Please choice ONE Game Mode
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please choice ONE Game Mode"),
        ));
        return;
      }

      String gamemode = "";
      int _value = 0;

      if (ffa) {
        gamemode = "FreeForAll";
        _value = OnlineGameCreateState().getfreeforallscore();
      } else {
        gamemode = "LastStanding";
        _value = OnlineGameCreateState().getlaststandingscore();
      }

      gameLobby.set({
        "Server Address": text,
        "NumberofPlayers": OnlineGameCreateState().getnumberofplayers(),
        "GameTimer": OnlineGameCreateState().getmatchtime(),
        "GameMode": gamemode,
        "Value": _value,
      });

      Navigator.push(
        _context,
        MaterialPageRoute(builder: (_context) => MenugameOnline(true, text)),
      );
    }
  }

  bool serverAddressExist(BuildContext _context) {
    if (OnlineGameCreateState().getserveraddress() == "") {
      //please type a server address
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("please type a server address"),
      ));
      return false;
    } else {
      return true;
    }
  }
}
