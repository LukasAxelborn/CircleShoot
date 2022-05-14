import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/thegame/Component/button_gui.dart';
import 'package:game/thegame/enemy.dart';
import 'package:game/thegame/player.dart';
import 'package:game/thegame/ui_stats.dart';

class GameBoard extends FlameGame with HasTappables {
  late Size screenSize;
  late double tileSize;
  late Rect background =
      Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
  final Paint backgroundPaint = Paint()..color = Colors.white;
  final Color color = const Color.fromARGB(106, 17, 235, 53);
  late Player player;
  late List<Enemy> listEnemy;
  int counter = 0;
  bool goRight = false;
  bool goLeft = false;
  bool goStaight = false;

  late List<ButtonGUI> buttonGUIList;
  late Uistat uistat;

  double timeSurvieved = 0;

  GameBoard() {
    listEnemy = <Enemy>[];
  }

  @override
  Future<void> onLoad() async {
    resize(size.toSize());

    player = Player(
      Vector2((size[0] / 2), (size[1] / 2)),
      pi / 2, //pi / 4
      tileSize * 0.63,
      Paint()..color = Colors.red,
      size,
    );

    listEnemy.add(
      Enemy(
        Vector2(200, 200),
        pi / 2, //pi / 4
        tileSize * 0.63,
        Paint()..color = Colors.green,
        size,
        player,
      ),
    );

    listEnemy.add(
      Enemy(
        Vector2(100, 200),
        0, //pi / 4
        tileSize * 0.63,
        Paint()..color = Colors.grey,
        size,
        player,
      ),
    );

    add(uistat = Uistat(
      size: Vector2(0, 32.0),
      game: this,
    ));

    buttonGUIList = <ButtonGUI>[];

    //right
    buttonGUIList.add(ButtonGUI(
      screenSize.width * 0.75,
      screenSize.height * 0.85,
      tileSize * 1.5,
      color,
      () => {goRight = true},
      () => {goRight = false},
    ));

    //left
    buttonGUIList.add(ButtonGUI(
      size[0] * 0.25,
      size[1] * 0.85,
      tileSize * 1.5,
      color,
      () => {goLeft = true},
      () => {goLeft = false},
    ));
    //forward
    buttonGUIList.add(ButtonGUI(
      size[0] * 0.5,
      size[1] * 0.75,
      tileSize * 1.5,
      color,
      () => {goStaight = true},
      () => {goStaight = false},
    ));
    //shout
    buttonGUIList.add(ButtonGUI(
      size[0] * 0.5,
      size[1] * 0.90,
      tileSize * 1.5,
      color,
      () => {player.shoot()},
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

  @override
  void update(double dt) {
    super.update(dt);
    timeSurvieved += dt;

    for (var element in listEnemy) {
      element.update(dt);
    }
    player.update(dt);

    if (goRight) {
      player.setHeadning(0.1);
    }
    if (goLeft) {
      player.setHeadning(-0.1);
    }
    if (goStaight) {
      player.goForward();
    }

    for (var element in listEnemy) {
      if (player.hits(element)) {
        uistat.updateScore();
      }

      if (element.hits(player)) {
        uistat.reduceHealth();
      }
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(background, backgroundPaint);

    player.render(canvas);

    for (var element in listEnemy) {
      element.render(canvas);
    }
    for (var element in buttonGUIList) {
      element.render(canvas);
    }
    super.render(canvas);
  }

  void start() {
    resumeEngine();
    player.currentHealth = player.maxHealth;
    player.score = 0;
    timeSurvieved = 0;
  }

  void freeze() {
    pauseEngine();
  }

  int get getTimeSurvived => timeSurvieved.toInt();
}
