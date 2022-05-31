import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class ButtonGUI extends HudButtonComponent {
  ///Sprite and position of our button
  late double _x, _y, buttonSize;
  late final Color _color;
  ButtonGUI(this._x, this._y, this.buttonSize, this._color,
      VoidCallback onPressed, VoidCallback onRelease)
      : super(
          button: PositionComponent(
            position: Vector2(_x, _y),
            size: Vector2.all(buttonSize),
            anchor: Anchor.center,
          ),
          //margin: const EdgeInsets.all(8.0),
          position: Vector2(_x, _y),
          size: Vector2.all(buttonSize),
          onPressed: onPressed,
          onReleased: onRelease,
          anchor: Anchor.center,
        ) {
    _x -= buttonSize / 2;
    _y -= buttonSize / 2;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromLTWH(_x, _y, buttonSize, buttonSize),
      Paint()..color = _color,
    );
  }
}
