import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_shutter/audio/audio_controller.dart';
import 'package:space_shutter/audio/flame_audio.dart';
import 'package:space_shutter/flame_game/game_loose_dialog.dart';
import 'package:space_shutter/flame_game/game_win_dialog.dart';

import 'package:space_shutter/level_selection/levels.dart';
import 'package:space_shutter/flame_game/space_shooter_game.dart';

import 'package:flame/game.dart';
import 'package:space_shutter/player_progress/player_progress.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({
    required this.level,
    required this.world,
    super.key,
  });
  final GameLevels level;
  final GameWorld world;

  static const String winDialogKey = 'win_dialog';
  static const String looseDialogKey = 'loose_dialog';
  static const String backButtonKey = 'back_button';

  @override
  Widget build(BuildContext context) {
    // final audioController = context.read<AudioController>();
    AudioGame audioGame = AudioGame();
    return GameWidget(
      game: SpaceShooterGame(
        level: level,
        playerProgress: context.read<PlayerProgress>(),
        audioController: audioGame,
      ),
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
          return GameWinDialog(level: level, world: world);
        },
        looseDialogKey: (context, game) {
          return GameLooseDialog(
            level: level,
          );
        },
      },
    );
  }
}
