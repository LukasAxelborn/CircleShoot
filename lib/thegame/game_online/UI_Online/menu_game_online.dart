// ignore_for_file: must_be_immutable, no_logic_in_create_state, duplicate_ignore

import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/settings/app_settings/app_colors.dart';
import 'package:game/thegame/game_online/game_board_online.dart';

const pauseMenu = 'pauseMenu';
const lsMenuWin = 'lsMenuWin';
const lsMenulost = 'lsMenulost';
const ffaMenuWin = 'ffaMenuWin';
const ffaMenulost = 'ffaMenulost';
late GameBoardOnline gameBoard;

class MenugameOnline extends StatelessWidget {
  MenugameOnline(bool _isHost, String _lobby, {Key? key}) : super(key: key) {
    gameBoard = GameBoardOnline(_isHost, _lobby);
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget<GameBoardOnline>(
      game: gameBoard,
      initialActiveOverlays: const [
        pauseMenu,
      ],
      overlayBuilderMap: {
        pauseMenu: (context, game) => const GameStartMenuOverlay(),
        lsMenuWin: (context, game) => LSGameMenuOverlay(won: true),
        lsMenulost: (context, game) => LSGameMenuOverlay(won: false),
        ffaMenuWin: (context, game) => FFAGameMenuOverlay(won: true),
        ffaMenulost: (context, game) => FFAGameMenuOverlay(won: false),
      },
    );
  }
}

class GameStartMenuOverlay extends StatefulWidget {
  //final GameBoardOnline gameBoard;

  const GameStartMenuOverlay({Key? key}) : super(key: key);

  @override
  State<GameStartMenuOverlay> createState() => _GameStartMenuOverlayState();
}

class _GameStartMenuOverlayState extends State<GameStartMenuOverlay> {
  var totalplayers = 0;
  //late Timer _timer;
  int gamestatcountdown = 5;
  bool showcounter = false;
  String serveraddress = "";
  @override
  void initState() {
    super.initState();
    gameBoard.freeze();
    gameBoard.getRules().then((data) {
      totalplayers = data["NumberofPlayers"];
      serveraddress = data["Server Address"];
    });

    Timer.periodic(const Duration(milliseconds: 500), ((timer) {
      gameBoard.getRules().then((data) {
        if (mounted) {
          setState(() {
            totalplayers = data["NumberofPlayers"];
            if (gameBoard.mapofPlayers.length == totalplayers) {
              showcounter = true;
              startGameCountdown();
              timer.cancel();
            }
          });
        } else {
          timer.cancel();
        }
      });
    }));
  }

  void startGameCountdown() {
    Timer.periodic(const Duration(seconds: 1), ((timer) {
      if (mounted) {
        setState(() {
          if (gamestatcountdown == 0) {
            //_timer.cancel();
            gameBoard.overlays.remove(pauseMenu);
            gameBoard.start();
            showcounter = false;
            timer.cancel();
          } else {
            gamestatcountdown--;
          }
        });
      } else {
        timer.cancel();
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 400,
        height: 340,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextStyle(
                style: const TextStyle(),
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Circle Shoot',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Server address: $serveraddress',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${gameBoard.mapofPlayers.length} / $totalplayers',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Visibility(
                        visible: showcounter,
                        child: Text(
                          'Game starting in.. $gamestatcountdown',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButtonTheme(
                data: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 60),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    gameBoard.overlays.remove(pauseMenu);
                    gameBoard.playerdispose();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Leave',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class LSGameMenuOverlay extends StatefulWidget {
  late bool won;
  LSGameMenuOverlay({Key? key, required this.won}) : super(key: key);

  @override
  State<LSGameMenuOverlay> createState() {
    return _LSGameMenuOverlayState(won);
  }
}

class _LSGameMenuOverlayState extends State<LSGameMenuOverlay> {
  late bool won;
  List result = [];
  _LSGameMenuOverlayState(this.won) {
    result = gameBoard.uistat.playersDead;

    result.sort((a, b) => b[1].compareTo(a[1]));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 400,
        height: 340,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextStyle(
                style: const TextStyle(),
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Circle Shoot',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                      Visibility(
                        visible: won,
                        child: const Text(
                          "Winner Winner Chiken dinner",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !won,
                        child: const Text(
                          "Lost",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButtonTheme(
                data: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 60),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    if (won) {
                      gameBoard.overlays.remove(ffaMenuWin);
                    } else {
                      gameBoard.overlays.remove(ffaMenulost);
                    }
                    //gameBoard.uistat.reset();
                    gameBoard.playerdispose();
                    //_timer.cancel();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Leave',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                width: 400,
                child: ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (_, index) {
                    return ScorePosisionCard(data: result, index: index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FFAGameMenuOverlay extends StatefulWidget {
  late bool won;
  FFAGameMenuOverlay({Key? key, required this.won}) : super(key: key);

  @override
  State<FFAGameMenuOverlay> createState() {
    // ignore: no_logic_in_create_state
    return _FFAGameMenuOverlay(won);
  }
}

class _FFAGameMenuOverlay extends State<FFAGameMenuOverlay> {
  List result = [];
  late bool won;

  _FFAGameMenuOverlay(this.won) {
    for (var p in gameBoard.mapofPlayers.values) {
      result.add([p.name, p.score]);
    }
    result.sort((a, b) => b[1].compareTo(a[1]));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 400,
        height: 340,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextStyle(
                style: const TextStyle(),
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Circle Shoot',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                      Visibility(
                        visible: won,
                        child: const Text(
                          "Winner Winner Chiken dinner",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !won,
                        child: const Text(
                          "Lost",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButtonTheme(
                data: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 60),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    if (won) {
                      gameBoard.overlays.remove(ffaMenuWin);
                    } else {
                      gameBoard.overlays.remove(ffaMenulost);
                    }
                    //gameBoard.uistat.reset();
                    gameBoard.playerdispose();
                    //_timer.cancel();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Leave',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                width: 400,
                child: ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (_, index) {
                    return ScorePosisionCard(data: result, index: index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScorePosisionCard extends StatelessWidget {
  static const textStyle = TextStyle(fontSize: 24);
  final List data;

  const ScorePosisionCard({Key? key, required this.data, required this.index})
      : super(key: key);
  final int index;

  Color getColorofIndex(int index) {
    switch (index) {
      case 0:
        return AppColors.firstplace;
      case 1:
        return AppColors.secondplace;
      case 2:
        return AppColors.thirdplace;
      default:
        return AppColors.outsideplace;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(3),
      color: getColorofIndex(index),
      child: ListTile(
        leading: Text(
          data[index][0],
          style: textStyle,
        ),
        title: Text(
          data[index][1].toString(),
          style: textStyle,
        ),
      ),
    );
  }
}
