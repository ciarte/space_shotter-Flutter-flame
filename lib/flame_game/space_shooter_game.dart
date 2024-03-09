import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/input.dart';
import 'package:space_shutter/audio/flame_audio.dart';

import 'package:space_shutter/flame_game/components/bacground/background.dart';
import 'package:space_shutter/flame_game/components/enemy/enemy.dart';
import 'package:space_shutter/flame_game/components/player_component/life_bar.dart';
import 'package:space_shutter/flame_game/components/player_component/player.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:space_shutter/flame_game/game_screen.dart';

import 'package:space_shutter/level_selection/levels.dart';
import 'package:space_shutter/player_progress/player_progress.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, HasCollisionDetection, TapDetector {
  SpaceShooterGame({
    required this.level,
    required PlayerProgress playerProgress,
    required this.audioController,
    Random? random,
  }) : _random = random ?? Random();

  late Player player;
  final Random _random;

  final GameLevels level;
  late ValueNotifier<int> scoreNotifier;
  late ValueNotifier<int> playerLifeNotifier;

  /// A helper for playing sound effects and background audio.
  final AudioGame audioController;

  @override
  Future<void> onLoad() async {
    /// Gives the player points, with a default value +1 points.
    void addScore({int amount = 1}) {
      scoreNotifier.value += amount;
    }

    /// Sets the player's score to 0 again.
    void resetScore() {
      scoreNotifier.value = 0;
    }

    add(Background(
        speed: level.number.toDouble(), backGround: level.bacground));

    final joystick = JoystickComponent(
      anchor: Anchor.bottomLeft,
      margin: const EdgeInsets.only(left: 40, bottom: 80),
      background: CircleComponent(
        radius: 55,
        paint: Paint()..color = Colors.white.withOpacity(0.3),
      ),
      knob: CircleComponent(
        radius: 20,
        paint: Paint()..color = Colors.white.withOpacity(0.4),
      ),
    );

    add(joystick);

    //player
    player = Player(
      joystick,
      addScore: addScore,
      resetScore: resetScore,
    );
    add(player);
    final hudButton = HudButtonComponent(
      margin: const EdgeInsets.only(right: 40, bottom: 80),
      button: CircleComponent(
        paint: Paint()..color = Colors.red.withOpacity(0.4),
        // children: [SpriteComponent(sprite: sp, size: Vector2(120, 120))],
        // Tamaño del botón
        radius: 40,
        // size: Vector2(120, 120),
      ),
      anchor: Anchor.bottomRight,
      onPressed: player.startShooting,
      // onCancelled: player.stopShooting
    );
    add(hudButton);

    //mejorar logica enemigos por nivel
    add(SpawnComponent(
        factory: (index) => Enemy.random(
            speed: level.number,
            random: _random,
            canSpawnTall: level.canSpawnTall),
        period: 1,
        area: Rectangle.fromLTWH(20, 0, size.x - 40, -Enemy.enemySize)));

    playerLifeNotifier = ValueNotifier<int>(player.life);
    scoreNotifier = ValueNotifier(0);
    final scoreText = 'Enemies: ${scoreNotifier.value} / ${level.winScore}';

    final textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontFamily: 'Press Start 2P',
      ),
    );

    final scoreComponent = TextComponent(
        text: scoreText, position: Vector2.all(30), textRenderer: textRenderer);

    scoreNotifier = ValueNotifier<int>(Enemy.hard().count);

    scoreNotifier.addListener(() {
      scoreComponent.text =
          scoreText.replaceFirst('0', '${scoreNotifier.value} ');

      if (scoreNotifier.value >= level.winScore) {
        pauseEngine();

        overlays.add(GameScreen.winDialogKey);
      }
    });

    overlays.addAll([GameScreen.backButtonKey]);
    final lifeComponent = TextComponent(
        text: 'Life: ${player.life}',
        position: Vector2(30, size.y - 30),
        textRenderer: textRenderer);

    playerLifeNotifier.addListener(() {
      lifeComponent.text = 'Life: ${playerLifeNotifier.value}';

      // if (playerLifeNotifier.value < 0) {
      //   pauseEngine();

      //   overlays.add(GameScreen.looseDialogKey);
      // }
    });

    camera.viewport.add(lifeComponent);

    camera.viewport.add(scoreComponent);
    // print(playerNotifier.single!.life);
    final lifeBar = LifeBarComponent(player, size);
    add(lifeBar);
  }
}
