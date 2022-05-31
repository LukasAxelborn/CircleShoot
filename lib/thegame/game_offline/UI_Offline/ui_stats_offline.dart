import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:game/thegame/game_offline/game_board.dart';

class UistatOffline extends HudMarginComponent {
  int _score = 0;
  int get score => _score;
  late TextComponent scoreComponent;

  int _healthLeft = 50;
  late TextComponent healthLeftComponent;

  final GameBoard game;

  UistatOffline({required Vector2 size, required this.game})
      : super(position: size, anchor: Anchor.center) {
    TextPaint regular = TextPaint(
      style: const TextStyle(
        color: Color.fromARGB(157, 0, 0, 0),
        fontSize: 24.0,
        fontFamily: 'Awesome Font',
      ),
    );

    scoreComponent =
        TextComponent(text: 'Score: $_score', textRenderer: regular)
          ..anchor = Anchor.topCenter
          ..x = size.x / 1.7 // size is a property from game
          ..y = 32.0;

    healthLeftComponent =
        TextComponent(text: 'Health: $_healthLeft', textRenderer: regular)
          ..anchor = Anchor.topCenter
          ..x = size.x / 2.5 // size is a property from game
          ..y = 32.0;
    //_game = game;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(scoreComponent);
    add(healthLeftComponent);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    healthLeftComponent.x = gameSize.x * 0.3;
    scoreComponent.x = gameSize.x * 0.7; // size is a property from game
    super.onGameResize(gameSize);
  }

  @override
  void update(double dt) {
    scoreComponent.text = 'Score: $_score';
    healthLeftComponent.text = 'Health: $_healthLeft';

    if (_healthLeft <= 0) {
      game.overlays.add('pauseMenu');
      game.pauseEngine();
    }
    super.update(dt);
  }

  void reset() {
    _score = 0;
    _healthLeft = 50;
  }

  void updateScore() {
    _score++;
  }

  void reduceHealth() {
    _healthLeft--;
  }
}
