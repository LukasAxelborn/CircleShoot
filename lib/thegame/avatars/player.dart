import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game/thegame/avatars/weapon/bullet.dart';
import 'package:game/thegame/Interface/colition.dart';

import 'weapon/bullet.dart';

class Player extends Colition {
  late Vector2 playerPosition;
  late double playerAngel;
  late Paint playerColor;
  late final double _size;
  int maxHealth = 50;
  late int currentHealth;
  double speed = 100.0;
  double speeddt = 0;
  int score = 0;
  String name = "";
  double timeAlive = 0;
  String playerid = "";

  bool snapshotofdeadtime = false;

  late double _sizeOfSmallerRect;

  late List<Bullet> bullets;

  @override
  // ignore: overridden_fields
  late double xHitbox;

  @override
  // ignore: overridden_fields
  late double yHitbox;

  @override
  // ignore: overridden_fields
  late double sizeHitbox;

  late Rect playerCenter =
      Rect.fromLTWH(playerPosition.x, playerPosition.y, sizeHitbox, sizeHitbox);

  late Vector2 gameBordSize;
  //Rect playerRect = Rect.fromLTWH(-_size / 2, -_size / 2, _size, _size);
  static const double pi2 = 2 * pi;

  Player(this.playerPosition, this.playerAngel, this._size, this.playerColor,
      this.gameBordSize) {
    currentHealth = maxHealth;

    bullets = <Bullet>[];

    xHitbox = playerPosition.x - _size / 2;
    yHitbox = playerPosition.y - _size / 2;
    sizeHitbox = _size;
    _sizeOfSmallerRect = _size / 2.5;
  }

  /*
    för att få en riktning för skoten och väg 
    får cos och sin användas. 

    position += Vector2(speed * dt * cos(angel),speed * dt * sin(angel))
  */
  void update(double dt) {
    for (int i = 0; i < bullets.length; i++) {
      bullets[i].update(dt);
      if (bullets[i].outOfBound()) {
        bullets.removeAt(i);
      }
    }
    xHitbox = playerPosition.x - _size / 2;
    yHitbox = playerPosition.y - _size / 2;

    speeddt = speed * dt;

    playerAngel = playerAngel > pi2 ? 0.001 : playerAngel;
    playerAngel = playerAngel <= 0 ? pi2 : playerAngel;

    if (!isDead()) {
      timeAlive += dt;
    } else {
      playerPosition = Vector2.all(-100.1);
    }
  }

  void render(Canvas canvas) {
    for (var element in bullets) {
      element.render(canvas);
    }

    canvas.save();

    canvas.translate(playerPosition.x, playerPosition.y);
    canvas.rotate(playerAngel);
    Rect playerRect = Rect.fromLTWH(-_size / 2, -_size / 2, _size, _size);
    canvas.drawRect(playerRect, playerColor);

    Rect re = Rect.fromLTWH(
      (-_size / 2) + _sizeOfSmallerRect + 5,
      (-_size / 2) + _sizeOfSmallerRect / 1.5,
      _sizeOfSmallerRect,
      _sizeOfSmallerRect,
    );
    canvas.drawRect(re, Paint()..color = Colors.blue);

    canvas.restore();
  }

  void setHeadning(double headning) => playerAngel += headning;

  void goForward() {
    if (isDead()) {
      playerPosition = Vector2.all(-100.1);
    } else {
      if (playerPosition.x - sizeHitbox / 2 <= 0) {
        playerPosition = Vector2(
          playerPosition.x + 0.01,
          playerPosition.y + 0.01,
        );
      } else if (playerPosition.x + sizeHitbox / 2 >= gameBordSize.x) {
        playerPosition = Vector2(
          playerPosition.x - 0.01,
          playerPosition.y - 0.01,
        );
      } else if (playerPosition.y - sizeHitbox / 2 <= 0) {
        playerPosition = Vector2(
          playerPosition.x - 0.01,
          playerPosition.y + 0.01,
        );
      } else if (playerPosition.y + sizeHitbox / 2 >= gameBordSize.y) {
        playerPosition = Vector2(
          playerPosition.x - 0.01,
          playerPosition.y - 0.01,
        );
      } else {
        playerPosition += Vector2(
          speeddt * cos(playerAngel),
          speeddt * sin(playerAngel),
        );
      }
    }
  }

  void shoot() {
    Bullet bt = Bullet(
      playerPosition,
      playerAngel,
      Paint()..color = Colors.amber,
      gameBordSize,
    );

    bullets.add(bt);
  }

  bool hits(Player opponent) {
    for (int i = 0; i < bullets.length; i++) {
      if (bullets[i].isColiding(opponent)) {
        bullets.removeAt(i); // ta bort ifall
        score++;
        return true;
      }
    }
    return false;
  }

  void gotHit() => currentHealth--;
  bool isDead() => currentHealth <= 0 ? true : false;

  @override
  bool isColiding(opponent) {
    return true;
  }

  get gettimeAlive => timeAlive.toInt();
  get getPlayerPosision => playerPosition;
  get getPlayerAngle => playerAngel;
}
