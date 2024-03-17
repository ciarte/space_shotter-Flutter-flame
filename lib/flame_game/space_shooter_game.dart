import 'dart:math';

import 'package:flame/components.dart';

import 'package:flame/experimental.dart';
import 'package:flame/input.dart';
import 'package:provider/provider.dart';
import 'package:space_shutter/audio/flame_audio.dart';

import 'package:space_shutter/flame_game/components/bacground/background.dart';
import 'package:space_shutter/flame_game/components/enemy/enemy.dart';
import 'package:space_shutter/flame_game/components/player_component/life_bar.dart';
import 'package:space_shutter/flame_game/components/player_component/player.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:space_shutter/flame_game/game_screen.dart';

import 'package:space_shutter/level_selection/levels.dart';
import 'package:space_shutter/models/player_ships_model.dart';
import 'package:space_shutter/player_progress/player_data.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, HasCollisionDetection, TapDetector {
  SpaceShooterGame({
    required this.level,
    // required PlayerProgress playerProgress,
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

  // @override
  // void onAttach() {
  //   if (buildContext != null) {
  //     final playerData = Provider.of<PlayerData>(buildContext!, listen: false);
  //     player.setPlayerShip(playerData.spaceShipType);
  //   }
  //   super.onAttach();
  // }

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

    const spaceShipType = SpaceShipsTypes.primary;
    // final spaceShip = SpaceShips.getSpaceShipspByType(spaceShipType);

    player = Player(
      joystick,
      addScore: addScore,
      resetScore: resetScore,
      spaceShipsType: spaceShipType,
    );

    add(player);

    final hudButton = HudButtonComponent(
      margin: const EdgeInsets.only(right: 40, bottom: 80),
      button: CircleComponent(
        paint: Paint()..color = Colors.red.withOpacity(0.4),

        // Tamaño del botón
        radius: 40,
        // size: Vector2(120, 120),
      ),
      anchor: Anchor.bottomRight,
      onPressed: player.startShooting,
    );
    add(hudButton);

    //mejorar logica enemigos por nivel
    final spawnEnemy = SpawnComponent(
        factory: (index) => Enemy.random(
            speed: level.number,
            random: _random,
            canSpawnTall: level.canSpawnTall),
        period: 1,
        area: Rectangle.fromLTWH(20, 0, size.x - 40, -Enemy.enemySize));

    add(spawnEnemy);

    playerLifeNotifier = ValueNotifier<int>(player.life);
    scoreNotifier = ValueNotifier(0);
    final scoreText = 'Score: ${scoreNotifier.value}';

    final textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontFamily: 'Press Start 2P',
      ),
    );

    final scoreComponent = TextComponent(
        text: scoreText, position: Vector2.all(30), textRenderer: textRenderer);

    scoreNotifier = ValueNotifier<int>(Enemy.hard().point);

    scoreNotifier.addListener(() {
      scoreComponent.text =
          scoreText.replaceFirst('0', '${scoreNotifier.value} ');

      // if (scoreNotifier.value >= level.winScore) {
      //   pauseEngine();

      //   overlays.add(GameScreen.winDialogKey);
      // }
    });

    overlays.addAll([GameScreen.backButtonKey]);
    // final lifeComponent = TextComponent(
    //     text: 'Life: ${player.life}',
    //     position: Vector2(30, size.y - 30),
    //     textRenderer: textRenderer);

    // playerLifeNotifier.addListener(() {
    //   lifeComponent.text = 'Life: ${playerLifeNotifier.value}';

    //   // if (playerLifeNotifier.value < 0) {
    //   //   pauseEngine();

    //   //   overlays.add(GameScreen.looseDialogKey);
    //   // }
    // });

    // camera.viewport.add(lifeComponent);

    // final sprite1 = await Sprite.load('heart.png');
    // final lifeComponent1 = SpriteComponent(
    //   sprite: sprite1,
    //   size: Vector2.all(28),
    //   position: Vector2(size.x - 34, size.y - 260),
    // );

    // camera.viewport.add(lifeComponent1);

    camera.viewport.add(scoreComponent);
    final lifeBar = LifeBarComponent(player, size);
    add(lifeBar);
  }
}
