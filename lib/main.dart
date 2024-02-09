import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:space_shutter/player_component/player.dart';

void main() {
  runApp(GameWidget(game: SpaceShooterGame()));
}

class SpaceShooterGame extends FlameGame with PanDetector {
  late Player player;

  @override
  Future<void> onLoad() async {
    final parallax = await loadParallaxComponent([
      ParallaxImageData('stars.png'),
      ParallaxImageData('stars.png'),
      ParallaxImageData('stars.png')
    ],
        baseVelocity: Vector2(0, -5),
        repeat: ImageRepeat.repeat,
        velocityMultiplierDelta: Vector2(0, 5));
    add(parallax);

    player = Player();
    add(player);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }
}
