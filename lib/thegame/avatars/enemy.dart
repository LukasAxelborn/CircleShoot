import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'player.dart';

class Enemy extends Player {
  /*
    strat 1: random punker som enemy ska ta sig till,         | färdig

    strat 2: få den röra sig i olika mönster så som tetrisk


    för att skuta ta spelaren position med en error på 20%? skut åt det hållet
    för att göra den inte som en sniper

    för att unvika skott kollas att ifall spelaren har skjutit, och kollar ifall
    en skotten fårn riktingen använaren sköt kommer att interjectas men enemy

   */
  static int instanccounter = 0;
  late Player player;
  late Vector2 nextCordinate;
  late double size;
  double changeOfDirection = 0.1;

  bool huntPlayerMode = false;
  int shoots = 5;
  late Random rand;

  double sumdt = 0;

  double randIntervall = 2;

  Enemy(Vector2 playerPosition, double playerAngel, this.size,
      Paint playerColor, Vector2 gameBordSize, Player p)
      : super(playerPosition, playerAngel, size, playerColor, gameBordSize) {
    rand = Random(DateTime.now().millisecondsSinceEpoch * (++instanccounter));
    player = p;
    nextCordinate = generatePath();
    speed *= 0.8;
  }

  Vector2 generatePath() {
    double randX;
    double randY;
    int boarder = 20;
    while (true) {
      //  funkar inte efftersom dom går ner i högra hörnet :C
      //randX = playerPosition.x + rand.nextDouble() * 100;
      //randY = playerPosition.y + rand.nextDouble() * 100;

      randX = rand.nextDouble() * gameBordSize[0];
      randY = rand.nextDouble() * gameBordSize[1];

      if ((randX < gameBordSize[0] - boarder && randX > boarder) &&
          (randY < gameBordSize[1] - boarder && randY > boarder)) {
        return Vector2(randX, randY);
      }
    }
  }

  void moveToCordinate() {
    var dist = distance(playerPosition, nextCordinate);

    if (dist < size) {
      nextCordinate = generatePath();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    sumdt += dt;
    //debugPrint(sumdt.toString());

    //////AI
    /// random interval between 2 to 5 sek
    /// one interval hunt player
    /// another one move to nextCordinate
    ///
    /// hunt player
    ///   - shoot one or three burst at player
    ///
    /// nextCordinate
    ///   - just move between cordinates
    ///

    if (sumdt > randIntervall) {
      huntPlayerMode = !huntPlayerMode;
      randIntervall = rand.nextDouble() * 3 + 2;
      sumdt = 0;
    }

    if (huntPlayerMode) {
      huntplayer();
    } else {
      huntCordinate();
    }

/*
    aimAtTarget(playerPosition, nextCordinate);

    //playerAngel = getAngelToTarget(playerPosition, player);

*/
    moveToCordinate();
    goForward();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    //Rect nextCordinateRect =
    //    Rect.fromLTWH(nextCordinate.x, nextCordinate.y, 10, 10);
    //canvas.drawRect(nextCordinateRect, Paint()..color = Colors.black);
  }

  double getAngelToTarget(var p1, var p2) {
    if (p2 is Player) {
      p2 = p2.playerPosition;
    }

    double dx = (p1.x - p2.x);
    double dy = (p1.y - p2.y);
    var ddd = atan2(dy, dx) + pi;

    return ddd;

    //return acos((p1.x * p2.x + p1.y * p2.x) /
    //    (sqrt(p1.x * p1.x + p1.y * p1.y) * sqrt(p2.x * p2.x + p2.y * p2.y)));
  }

  double distance(var a, var b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;

    return sqrt(dx * dx + (dy * dy));
  }

  bool aimAtTarget(var a, var b) {
    var angelTarget = getAngelToTarget(a, b);
    if (!playerUpDirection()) {
      if ((angelTarget + changeOfDirection) > Player.pi2) {
        // ner funkar
        playerAngel = 0.01;
        return true;
      }
    } else {
      if ((angelTarget - changeOfDirection) <= 0) {
        // upp funkar
        playerAngel = Player.pi2;
        return true;
      }
    }

    double dAOriginal = (playerAngel - angelTarget).abs();

    double dANew = ((playerAngel + changeOfDirection) - angelTarget).abs();

    if (dAOriginal > changeOfDirection) {
      if (dANew < dAOriginal) {
        setHeadning(changeOfDirection);
      } else {
        setHeadning(-changeOfDirection);
      }
      return false;
    }

    return true;

    /*
    double dangel = playerAngel - angelTarget;


    double inversAngelTarget;
    if (angelTarget < pi) {
      inversAngelTarget = (angelTarget + pi).abs();
    } else {
      inversAngelTarget = (angelTarget - pi).abs();
    }

    //debugPrint("angle: " + agel.toString() + " dangel: " + dangel.toString());
    //ser till att bara göra stora kurs ändringar
    if (dangel.abs() > 0.1) {
      if (playerAngel < angelTarget || playerAngel < inversAngelTarget) {
        setHeadning(-0.1);
      } else if (playerAngel > inversAngelTarget) {
        setHeadning(0.1);
      }
      return false;
    }
    return true;

    */
  }

  bool playerUpDirection() {
    if (pi < player.playerAngel && player.playerAngel < Player.pi2) {
      return true;
    }
    return false;
  }

  void huntplayer() {
    bool aimFinish = aimAtTarget(playerPosition, player);

    if (sumdt.toInt() % 3 == 0) {
      if (aimFinish && rand.nextBool()) {
        shoot();
      }
    }
  }

  void huntCordinate() {
    aimAtTarget(playerPosition, nextCordinate);
  }
}
