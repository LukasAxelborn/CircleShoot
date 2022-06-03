import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/settings/app_settings/app_colors.dart';
import 'package:game/thegame/UI_common/button_gui.dart';
import 'package:game/thegame/game_online/UI_Online/ui_stats_online.dart';

import '../../settings/user_settings/user_settings_option_state/user_settings_state.dart';
import '../avatars/player.dart';

class GameBoardOnline extends FlameGame with HasTappables {
  late Size screenSize;
  late double tileSize;
  late Rect background = Rect.fromLTWH(
    0,
    0,
    screenSize.width,
    screenSize.height,
  );
  final Paint backgroundPaint = Paint()..color = AppColors.background;
  final Color color = AppColors.surface;
  late Player player;

  bool goRight = false;
  bool goLeft = false;
  bool goStaight = false;

  double buttonSizeMulti = 3;

  List<ButtonGUI> buttonGUIList = <ButtonGUI>[];
  late UistatOnline uistat;

  double timeSurvieved = 0;

  Map<String, Player> mapofPlayers = {};

  // ignore: prefer_typing_uninitialized_variables
  late final playerId;
  late DatabaseReference playerRef;
  //var lobby = FirebaseDatabase.instance.ref("lobby").child("time");
  late DatabaseReference allPlayersRef;
  late final bool isHost;

  late Map<dynamic, dynamic> mapofRulse = {};
  late final String lobby;

  GameBoardOnline(this.isHost, this.lobby) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
        debugPrint("$user");
        playerId = user.uid;
        playerRef = FirebaseDatabase.instance.ref(lobby).child("$playerId");
        getRules();
        inintilzegame();
        playerRef.onDisconnect().remove();
      }
    });

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

    allPlayersRef = FirebaseDatabase.instance.ref(lobby);

    allPlayersRef.onChildChanged.listen((DatabaseEvent event) {
      final changedPlayer = event.snapshot.value as Map<dynamic, dynamic>;

      //debugPrint("addedPlayer: $addedPlayer");
      if (changedPlayer["id"] != playerId) {
        var _player = mapofPlayers[changedPlayer["id"]];

        _player?.playerPosition = Vector2(
          changedPlayer["playerPositionX"],
          changedPlayer["playerPositionY"],
        );

        _player?.playerAngel = changedPlayer["playerAngel"];
        _player?.currentHealth = changedPlayer["playerHealth"];
        _player?.score = changedPlayer["playerScore"];

        if (changedPlayer["shoot"]) {
          _player?.shoot();
        }

        mapofPlayers[changedPlayer["id"]] = _player!;
      }
    });

    allPlayersRef.onChildAdded.listen((DatabaseEvent event) {
      //when player added

      final addedPlayer = event.snapshot.value as Map<dynamic, dynamic>;

      //debugPrint("onChildAdded:addedPlayer: $addedPlayer");

      mapofPlayers[addedPlayer["id"]] = Player(
          Vector2(
            addedPlayer["playerPositionX"],
            addedPlayer["playerPositionY"],
          ),
          addedPlayer["playerAngel"],
          tileSize * 0.63,
          Paint()..color = Color(addedPlayer["playerColor"]),
          size);
      mapofPlayers[addedPlayer["id"]]!.name = addedPlayer["Name"];
      mapofPlayers[addedPlayer["id"]]!.playerid = addedPlayer["id"];
    });

    allPlayersRef.onChildRemoved.listen((event) {
      final removedPlayer = event.snapshot.value as Map<dynamic, dynamic>;
      //debugPrint("onChildRemoved:removedPlayer: $removedPlayer");

      mapofPlayers.remove(removedPlayer["id"]);
    });
  }

  Future<Map> getRules() async {
    var rulsesnapshot =
        await FirebaseDatabase.instance.ref("Lobby").child(lobby).get();
    mapofRulse = rulsesnapshot.value as Map<dynamic, dynamic>;
    //debugPrint("what: $mapofRulse");
    return mapofRulse;
  }

  @override
  Future<void> onLoad() async {
    resize(size.toSize());

    add(uistat = UistatOnline(
      size: Vector2(0, 32.0),
      game: this,
    ));

    //right
    buttonGUIList.add(ButtonGUI(
      screenSize.width * 0.82,
      screenSize.height * 0.83,
      tileSize * buttonSizeMulti,
      color,
      () => {goRight = true},
      () => {goRight = false},
    ));

    //left
    buttonGUIList.add(ButtonGUI(
      size[0] * 0.18,
      size[1] * 0.83,
      tileSize * buttonSizeMulti,
      color,
      () => {goLeft = true},
      () => {goLeft = false},
    ));

    if (UserSettingsState().getMoveForwardAutomatic()) {
      goStaight = true;
    } else {
      //forward
      buttonGUIList.add(ButtonGUI(
        size[0] * 0.5,
        size[1] * 0.70,
        tileSize * buttonSizeMulti,
        color,
        () => {goStaight = true},
        () => {goStaight = false},
      ));
    }

    //shout
    buttonGUIList.add(ButtonGUI(
      size[0] * 0.5,
      size[1] * 0.90,
      tileSize * buttonSizeMulti,
      color,
      () => {
        mapofPlayers[playerId]?.shoot(),
        playerRef.update({'shoot': true})
      },
      () => {},
    ));

    for (var element in buttonGUIList) {
      add(element);
    }

    return super.onLoad();
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }

  void inintilzegame() {
    var _player = Player(
      Vector2((size[0] / 2), (size[1] / 2)),
      pi / 2, //pi / 4
      tileSize * 0.63,
      Paint()..color = UserSettingsState().getPlayerColor(),
      size,
    );
    _player.name = UserSettingsState().getUserName();
    _player.playerid = playerId;

    playerRef.set({
      'id': playerId,
      'Name': _player.name,
      'playerColor': _player.playerColor.color.value,
      'isHost': isHost,
      'playerPositionX': _player.playerPosition.x,
      'playerPositionY': _player.playerPosition.y,
      'playerAngel': _player.playerAngel,
      'playerHealth': _player.currentHealth,
      'playerScore': _player.score,
      'shoot': false,
    });
    mapofPlayers[playerId] = _player;
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeSurvieved += dt;

    for (var _player in mapofPlayers.values) {
      _player.update(dt);
    }
    var _playerTemp = mapofPlayers[playerId];

    if (goRight) {
      _playerTemp?.setHeadning(0.1);
    }
    if (goLeft) {
      _playerTemp?.setHeadning(-0.1);
    }
    if (goStaight) {
      _playerTemp?.goForward();
    }

    playerRef.update({
      'playerPositionX': _playerTemp?.playerPosition.x,
      'playerPositionY': _playerTemp?.playerPosition.y,
      'playerAngel': _playerTemp?.playerAngel,
      'playerHealth': _playerTemp?.currentHealth,
      'playerScore': _playerTemp?.score,
      'shoot': false,
    });

    for (var element in mapofPlayers.values) {
      if (element != _playerTemp) {
        if (_playerTemp!.hits(element)) {
          element.currentHealth--;
        }

        if (element.hits(_playerTemp)) {
          _playerTemp.currentHealth--;
        }
      }
    }

    mapofPlayers[playerId] = _playerTemp!;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(background, backgroundPaint);

    for (var _player in mapofPlayers.values) {
      _player.render(canvas);
    }

    for (var element in buttonGUIList) {
      element.render(canvas);
    }
    super.render(canvas);
  }

  void start() {
    resumeEngine();
    mapofPlayers[playerId]!.currentHealth = mapofPlayers[playerId]!.maxHealth;
    mapofPlayers[playerId]!.score = 0;
    timeSurvieved = 0;
    inintilzegame();
    uistat.initGameUI();
  }

  void freeze() {
    pauseEngine();
  }

  void playerdispose() {
    playerRef.remove();
  }

  int get getTimeSurvived => timeSurvieved.toInt();
}
