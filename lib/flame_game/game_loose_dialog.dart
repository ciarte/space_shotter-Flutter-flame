// import 'package:flame/components.dart';
// import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';
import 'package:space_shutter/level_selection/levels.dart';
import 'package:space_shutter/style/style.dart';

/// This dialog is shown when a level is loosed.
class GameLooseDialog extends StatelessWidget {
  const GameLooseDialog({
    super.key,
    required this.level,
  });

  /// The properties of the level
  final GameLevels level;

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();
    return Center(
      child: NesContainer(
        width: 420,
        height: 400,
        backgroundColor: palette.backgroundPlaySession.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'It was not good!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'You did not completed level',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            NesButton(
              onPressed: () {
                context.go('/level/2');
              },
              type: NesButtonType.primary,
              child: const Text('Retry'),
            ),
            const SizedBox(height: 16),
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
