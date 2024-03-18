// import 'package:flame/components.dart';
// import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';
import 'package:space_shutter/flame_game/components/bullets/bullet.dart';
import 'package:space_shutter/flame_game/components/enemy/enemy.dart';
import 'package:space_shutter/flame_game/components/explosion/explosion.dart';
import 'package:space_shutter/flame_game/game_screen.dart';
import 'package:space_shutter/flame_game/space_shooter_game.dart';
import 'package:space_shutter/level_selection/levels.dart';
import 'package:space_shutter/style/style.dart';

/// This dialog is shown when a level is loosed.
class GameLooseDialog extends StatelessWidget {
  const GameLooseDialog({
    super.key,
    required this.level,
    required this.game,
  });

  /// The properties of the level
  final GameLevels level;
  final SpaceShooterGame game;
  static const _gap = SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final palette = context.read<Palette>();
    return Center(
      child: NesContainer(
        width: size.width - 80,
        height: size.height / 2.5,
        backgroundColor: palette.backgroundDialog.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'It was not good!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            _gap,
            Text(
              'You did not completed level',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            _gap,
            NesButton(
              onPressed: () {
                game.overlays.remove(GameScreen.pauseMenu);

                game.player.reset();

                // Elimina todos los enemigos del juego
                game.children
                    .whereType<Enemy>()
                    .forEach((enemy) => enemy.removeFromParent());
                game.children
                    .whereType<Bullet>()
                    .forEach((bullet) => bullet.removeFromParent());
                game.children
                    .whereType<Explosion>()
                    .forEach((explosion) => explosion.removeFromParent());
                //reanuda el juego
                game.resumeEngine();
              },
              type: NesButtonType.primary,
              child: const Text('Retry'),
            ),
            _gap,
            NesButton(
              onPressed: () {
                context.go('/play');
              },
              type: NesButtonType.normal,
              child: const Text('Level selection'),
            ),
          ],
        ),
      ),
    );
  }
}
