import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/app_colors.dart';
import 'package:game/scores_tracker_singleton.dart';
import 'package:game/thegame/game_board.dart';

const pauseMenu = 'pauseMenu';

class Menugame extends StatelessWidget {
  Menugame({Key? key}) : super(key: key);

  final gameBoard = GameBoard();

  @override
  Widget build(BuildContext context) {
    return GameWidget<GameBoard>(
      game: gameBoard,
      initialActiveOverlays: const [
        pauseMenu,
      ],
      overlayBuilderMap: {
        pauseMenu: (context, game) {
          return PauseMenuOverlay(gameBoard: game);
        }
      },
    );
  }
}

class PauseMenuOverlay extends StatelessWidget {
  final GameBoard gameBoard;

  PauseMenuOverlay({Key? key, required this.gameBoard}) : super(key: key) {
    gameBoard.freeze();
    if (gameBoard.timeSurvieved > 0) {
      ScoresTrackerSingleton().addNewGame(
        gameBoard.uistat.score,
        gameBoard.getTimeSurvived,
      );
    }
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
                      if (gameBoard.uistat.score > 0)
                        Text(
                          gameBoard.uistat.scoreComponent.text,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      if (gameBoard.getTimeSurvived > 0)
                        Text(
                          'Time survived: ${gameBoard.getTimeSurvived}',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
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
                    gameBoard.uistat.reset();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
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
                    gameBoard.start();

                    gameBoard.uistat.reset();
                  },
                  child: const Text(
                    'Start Game',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
