import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game/thegame/Interface/colition.dart';

class Bullet implements Colition {
  double speed = 150;
  double _speeddt = 0;
  double widthBox = 8;
  late Vector2 bulletPos;
  late double bulletAngle;
  late Paint bulletPaint;

  @override
  late double xHitbox;

  @override
  late double yHitbox;

  @override
  late double sizeHitbox;

  late Vector2 gameBordSize;

  Bullet(
    this.bulletPos,
    this.bulletAngle,
    this.bulletPaint,
    this.gameBordSize,
  ) {
    xHitbox = bulletPos.x - widthBox / 2;
    yHitbox = bulletPos.y - widthBox / 2;
    sizeHitbox = widthBox;
  }

  void update(double dt) {
    _speeddt = speed * dt;

    bulletPos += Vector2(
      _speeddt * cos(bulletAngle),
      _speeddt * sin(bulletAngle),
    );

    xHitbox = bulletPos.x - widthBox / 2;
    yHitbox = bulletPos.y - widthBox / 2;
  }

  void render(Canvas canvas) {
    canvas.save();

    canvas.translate(bulletPos.x, bulletPos.y);
    canvas.rotate(bulletAngle);
    //Rect playerRect = Rect.fromLTWH(0, 0, widthBox, widthBox);
    Rect playerRect =
        Rect.fromLTWH(-widthBox / 2, -widthBox / 2, widthBox, widthBox);

    canvas.drawRect(playerRect, bulletPaint);

    canvas.restore();
  }

  @override
  bool isColiding(var opponent) {
    var dx = bulletPos.x - opponent.playerPosition.x;
    var dy = bulletPos.y - opponent.playerPosition.y;

    var dist = sqrt(dx * dx + (dy * dy));

    ///if (dist < opponent.with) {
    ///  return true;
    ///}

    if (dist < widthBox * 2) {
      return true;
    }

    return false;
  }

  bool outOfBound() {
    if (bulletPos.x > gameBordSize[0] || bulletPos.x < 0) {
      return true;
    }
    if (bulletPos.y > gameBordSize[1] || bulletPos.y < 0) {
      return true;
    }
    return false;
  }
}
