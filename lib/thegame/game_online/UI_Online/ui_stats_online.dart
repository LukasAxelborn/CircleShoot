import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:game/thegame/game_online/game_board_online.dart';

class UistatOnline extends HudMarginComponent {
  // ignore: prefer_typing_uninitialized_variables
  final GameBoardOnline game;
  late Vector2 sized;
  List<TextComponent> listofscore = <TextComponent>[];
  late TextComponent uiTimeCountdown;
  late int _value;

  bool ffa = false;
  bool ls = false;
  List playersDead = [];
  int _gameRuleTime = 100;
  UistatOnline({required Vector2 size, required this.game})
      : super(position: size, anchor: Anchor.center) {
    sized = size;

    game.getRules().then((data) {
      String _gameMode = data["GameMode"];
      _value = data["Value"];
      _gameRuleTime = data["GameTimer"];

      if (_gameMode == "FreeForAll") {
        ffa = true;
        ls = false;
      } else {
        ffa = false;
        ls = true;
      }
    });
  }

  void initGameUI() {
    for (var p in game.mapofPlayers.values) {
      p.maxHealth = _value;
      p.currentHealth = _value;
    }

    for (var _player in game.mapofPlayers.values) {
      TextPaint regular = TextPaint(
        style: TextStyle(
          color: _player.playerColor.color,
          fontSize: 18.0,
          fontFamily: 'Awesome Font',
          fontWeight: FontWeight.bold,
        ),
      );

      listofscore.add(TextComponent(
              text: uiText(_player.name, _player.currentHealth, _player.score),
              textRenderer: regular)
            ..anchor = Anchor.topCenter
            ..x = sized.x / 1.7 // size is a property from game
            ..y = 70.0
          //..position.y = 70,
          );
    }
    add(
      uiTimeCountdown = TextComponent(
          text: "Time remaning: ",
          textRenderer: TextPaint(
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 18.0,
              fontFamily: 'Awesome Font',
              fontWeight: FontWeight.bold,
            ),
          ))
        ..anchor = Anchor.topCenter
        ..x = game.screenSize.width / 2
        ..y = 32.0,
    );

    //..position.y = 70;

    for (var element in listofscore) {
      add(element);
    }
  }

  @override
  void onGameResize(Vector2 gameSize) {
    double spazing = gameSize.x / (listofscore.length + 1);
    for (int i = 0; i < listofscore.length; i++) {
      listofscore[i].x = spazing * (i + 1);
    }

    //scoreComponent.x = gameSize.x * 0.3; // size is a property from game
    super.onGameResize(gameSize);
  }

  @override
  void update(double dt) {
    super.update(dt);
    int gameover = _gameRuleTime - game.getTimeSurvived;
    uiTimeCountdown.text = uiTextTime(gameover);

    int index = 0;
    for (var _player in game.mapofPlayers.values) {
      listofscore[index++].text =
          uiText(_player.name, _player.currentHealth, _player.score);
    }
    if (ffa) {
      for (var _player in game.mapofPlayers.values) {
        if (_player.score >= _value) {
          if (game.mapofPlayers[game.playerId]!.score >= _value) {
            game.overlays.add('ffaMenuWin');
          } else {
            game.overlays.add('ffaMenulost');
          }
          //game.overlays.add('pauseMenu');
          game.pauseEngine();
        }
      }
      if (gameover == 0) {
        var _tmpplayer = game.mapofPlayers.values.first;
        for (var __player in game.mapofPlayers.values) {
          if (_tmpplayer.score <= __player.score) {
            _tmpplayer = __player;
          }
        }
        if (_tmpplayer.playerid == game.playerId) {
          game.overlays.add('ffaMenuWin');
        } else {
          game.overlays.add('ffaMenulost');
        }
        game.pauseEngine();
      }
    }

    if (ls) {
      int amountofdead = 0;

      for (var _player in game.mapofPlayers.values) {
        if (_player.isDead()) {
          amountofdead++;
        }
      }

      if ((game.mapofPlayers.length - 1) == amountofdead) {
        for (var _player in game.mapofPlayers.values) {
          playersDead.add([_player.name, _player.gettimeAlive]);
        }

        if (game.mapofPlayers[game.playerId]!.isDead()) {
          game.overlays.add('lsMenulost');
        } else {
          game.overlays.add('lsMenuWin');
        }

        game.pauseEngine();
      }

      if (gameover == 0) {
        var player = game.mapofPlayers.values.first;
        for (var _player in game.mapofPlayers.values) {
          if (player.currentHealth < _player.currentHealth) {
            player = _player;
          }
        }
        for (var _player in game.mapofPlayers.values) {
          playersDead.add([_player.name, _player.currentHealth]);
        }
        if (player.playerid == game.playerId) {
          game.overlays.add('lsMenuWin');
        } else {
          game.overlays.add('lsMenulost');
        }
        //game.overlays.add('pauseMenu');
        game.pauseEngine();
      }
    }
  }

  String uiText(String name, int health, int score) {
    if (ffa) {
      return '$name\nScore: $score';
    } else {
      return '$name\nHealth: $health';
    }
  }

  String uiTextTime(int time) {
    return "Time remaning: $time";
  }
}
