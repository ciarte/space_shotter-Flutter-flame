import 'package:flutter/material.dart';
import 'package:space_shutter/flame_game/game_screen.dart';

import 'package:space_shutter/flame_game/space_shooter_game.dart';

class PauseButton extends StatelessWidget {
  final SpaceShooterGame gameRef;

  const PauseButton({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.pause, size: 30, color: Colors.white),
      onPressed: () =>
          {gameRef.pauseEngine(), gameRef.overlays.add(GameScreen.pauseMenu)},
    );
  }
}
