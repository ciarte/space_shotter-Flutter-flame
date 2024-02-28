import 'package:flutter/material.dart';
import 'package:space_shutter/flame_game/game_loose_dialog.dart';
import 'package:space_shutter/flame_game/game_win_dialog.dart';

import 'package:space_shutter/level_selection/levels.dart';
import 'package:space_shutter/flame_game/space_shooter_game.dart';

import 'package:flame/game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({
    required this.levels,
    super.key,
  });
  final GameLevel levels;
  static const String winDialogKey = 'win_dialog';
  static const String looseDialogKey = 'loose_dialog';
  static const String backButtonKey = 'back_button';

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: SpaceShooterGame(level: levels),
      overlayBuilderMap: {
        backButtonKey: (context, game) {
          return Positioned(
            top: 20,
            right: 10,
            child: Container(
              color: Colors.red,
              height: 20,
              width: 20,
            ),
          );
        },
        winDialogKey: (context, game) {
          return GameWinDialog(
            level: levels,
          );
        },
        looseDialogKey: (context, game) {
          return GameLooseDialog(
            level: levels,
          );
        },
      },
    );
  }
}
