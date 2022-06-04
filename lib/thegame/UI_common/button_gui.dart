import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class ButtonGUI extends Component {
  ///Sprite and position of our button
  ///

  late double _x, _y, buttonSize;
  late final Color _color;
  late VoidCallback onPressed;
  late VoidCallback onRelease;
  late double direction;
  ButtonGUI(this._x, this._y, this.buttonSize, this._color, this.direction,
      this.onPressed, this.onRelease) {
    _x -= buttonSize / 2;
    _y -= buttonSize / 2;
  }

  @override
  Future<void> onLoad() async {
    late Sprite sprite;
    if (direction == 0) {
      sprite = await Sprite.load(
        "—Pngtree—left arrow line black icon_3746329-transparent.png",
      );
    } else if (direction == pi / 2) {
      sprite = await Sprite.load(
        "—Pngtree—arrow left vector icon_3876251-transparent - flip.png",
      );
      direction = 0;
    } else if (direction == pi) {
      sprite = await Sprite.load(
        "Aim-PNG-Clipart.png",
      );
    } else if (direction == (pi / 2) * 3) {
      sprite = await Sprite.load(
        "—Pngtree—arrow left vector icon_3876251-transparent.png",
      );
      direction = 0;
    }

    add(HudButtonComponent(
      button: SpriteComponent(
        paint: Paint()..color = _color,
        sprite: sprite,
        size: Vector2.all(buttonSize),
        scale: Vector2.all(1),
      ),
      angle: direction,
      position: Vector2(_x, _y),
      size: Vector2.all(buttonSize),
      onPressed: onPressed,
      onReleased: onRelease,
      anchor: Anchor.bottomRight,
    ));
  }
}
