import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/settings/app_settings/app_colors.dart';
import 'package:flame_audio/flame_audio.dart';

import '../../settings/user_settings/user_settings_option_state/user_settings_state.dart';
import '../UI_common/button_gui.dart';
import '../avatars/enemy.dart';
import '../avatars/player.dart';
import 'UI_Offline/ui_stats_offline.dart';

class GameBoard extends FlameGame with HasTappables {
  late Size screenSize;
  late double tileSize;
  late Rect background =
      Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
  final Paint backgroundPaint = Paint()..color = AppColors.background;
  final Color color = AppColors.surface;
  late Player player;

  bool goRight = false;
  bool goLeft = false;
  bool goStaight = false;
  double buttonSizeMulti = 3;

  List<Enemy> listEnemy = <Enemy>[];
  late UistatOffline uistat;

  double timeSurvieved = 0;

  static const preEnemyColors = <Color>[
    Colors.white, //wont be reach
    Colors.green,
    Colors.grey,
    Colors.black,
  ];
  Future<void> loadAssets() async {}

  @override
  Future<void> onLoad() async {
    resize(size.toSize());
    inintilzegame();
    FlameAudio.bgm.initialize();

    await FlameAudio.audioCache.loadAll([
      '163441__under7dude__man-getting-hit.wav',
      '444407__mootmcnoodles__slap.wav',
      'stomping-rock-four-shots-111444.mp3',
    ]);

    add(uistat = UistatOffline(
      size: Vector2(0, 32.0),
      game: this,
    ));

    //right
    add(ButtonGUI(
      size[0] * 1.10,
      size[1] * 1.0,
      tileSize * buttonSizeMulti,
      color,
      pi / 2,
      () => {goRight = true},
      () => {goRight = false},
    ));

    //left
    add(ButtonGUI(
      size[0] * 0.50,
      size[1] * 1.0,
      tileSize * buttonSizeMulti,
      color,
      (pi / 2) * 3,
      () => {goLeft = true},
      () => {goLeft = false},
    ));

    if (UserSettingsState().getMoveForwardAutomatic()) {
      goStaight = true;
    } else {
      //forward
      add(ButtonGUI(
        size[0] * 0.8,
        size[1] * 0.90,
        tileSize * buttonSizeMulti,
        color,
        0,
        () => {goStaight = true},
        () => {goStaight = false},
      ));
    }
    //shout
    add(ButtonGUI(
      size[0] * 0.5,
      size[1] * 0.90,
      tileSize * buttonSizeMulti,
      color,
      pi,
      () => {player.shoot()},
      () => {},
    ));

    return super.onLoad();
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }

  void inintilzegame() {
    player = Player(
      Vector2((size[0] / 2), (size[1] / 2)),
      pi / 2, //pi / 4
      tileSize * 0.63,
      Paint()..color = UserSettingsState().getPlayerColor(),
      size,
    );

    listEnemy = <Enemy>[];

    for (int i = 1; i <= UserSettingsState().getDifficulty() + 1; i++) {
      listEnemy.add(
        Enemy(
          Vector2(i * 100, 200),
          pi / i, //pi / 4
          tileSize * 0.63,
          Paint()..color = preEnemyColors[i],
          size,
          player,
        ),
      );
    }
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
        FlameAudio.play('444407__mootmcnoodles__slap.wav', volume: 1);
      }

      if (element.hits(player)) {
        uistat.reduceHealth();
        FlameAudio.play('163441__under7dude__man-getting-hit.wav', volume: 1);
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

    super.render(canvas);
  }

  void start() {
    resumeEngine();

    player.currentHealth = player.maxHealth;
    player.score = 0;
    timeSurvieved = 0;
    inintilzegame();
    if (!FlameAudio.bgm.isPlaying) {
      FlameAudio.bgm.play('stomping-rock-four-shots-111444.mp3', volume: 0.3);
    }
  }

  void freeze() {
    pauseEngine();
  }

  @override
  void onDetach() {
    FlameAudio.bgm.stop();

    FlameAudio.bgm.dispose();
    super.onDetach();
  }

  int get getTimeSurvived => timeSurvieved.toInt();
}
