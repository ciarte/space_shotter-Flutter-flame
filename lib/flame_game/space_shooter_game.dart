import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:space_shutter/flame_game/components/enemy/enemy.dart';
import 'package:space_shutter/flame_game/components/player_component/player.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:space_shutter/flame_game/game_screen.dart';

import 'package:space_shutter/level_selection/levels.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, HasCollisionDetection, TapDetector {
  SpaceShooterGame({
    required this.level,
    Random? random,
  }) : _random = random ?? Random();

  late Player player;

  /// The random number generator that is used to spawn periodic components.
  final Random _random;
// joistick elements
  // Offset? _pointerStartPosition;
  // Offset? _pointerCurrentPosition;
  // final double _joystickRadius = 60;
  // final double _deadZoneRadius = 10;

  final GameLevel level;
  late ValueNotifier<int> scoreNotifier;
  late ValueNotifier<int> playerLifeNotifier;
  @override
  Future<void> onLoad() async {
    final sp = await Sprite.load(
      'analog.png',
      srcSize: Vector2(1512, 1512),
      srcPosition: Vector2(0, 24),
    );
    final sp1 = await Sprite.load(
      'joystick2.png',
      srcSize: Vector2.all(524),
      srcPosition: Vector2.all(8),
    );
    scoreNotifier = ValueNotifier(0);
    final scoreText = 'Enemies: ${scoreNotifier.value} / ${level.winScore}';

    final textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontFamily: 'Press Start 2P',
      ),
    );

    final parallax = await loadParallaxComponent([
      ParallaxImageData('fondo1.jpg'),
      // ParallaxImageData('stars.png'),
      // ParallaxImageData('stars.png')
    ],
        baseVelocity: Vector2(0, -8),
        repeat: ImageRepeat.repeat,
        velocityMultiplierDelta: Vector2(0, 7));
    add(parallax);

    overlays.addAll([GameScreen.backButtonKey]);

    final joystick = JoystickComponent(
      knob: SpriteComponent(
        size: Vector2.all(60),
        sprite: sp,
      ),
      background: SpriteComponent(size: Vector2.all(150), sprite: sp1),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    add(joystick);

    final hudButton = HudButtonComponent(
        // size: Vector2.all(12),
        margin: const EdgeInsets.only(right: 20, bottom: 40),
        button: PositionComponent(
          children: [SpriteComponent(sprite: sp, size: Vector2(120, 120))],

          size: Vector2(120, 120), // Tamaño del botón
        ),
        onPressed: () {
          // Función que se ejecutará cuando el botón sea presionado
          print('Botón presionado!');
          player.startShooting();
        },
        onCancelled: () {
          print('Botón suelto!');
          player.stopShooting();
        });

    // final hudButton = HudButtonComponent(
    //     button: PositionComponent(),
    //     // buttonDown: ,
    //     onPressed: () {
    //       player.startShooting();
    //     });

    add(hudButton);
    player = Player(joystick);
    add(player);

    playerLifeNotifier = ValueNotifier<int>(player.life);

    final lifeComponent = TextComponent(
        text: 'Life: ${player.life}',
        position: Vector2(30, size.y - 30),
        textRenderer: textRenderer);

    playerLifeNotifier.addListener(() {
      // print('${playerLifeNotifier.value}');
      lifeComponent.text = 'Life: ${playerLifeNotifier.value}';
      if (playerLifeNotifier.value < 0) {
        pauseEngine();

        overlays.add(GameScreen.looseDialogKey);
      }
    });

    camera.viewport.add(lifeComponent);
    // add(SpawnComponent(
    //     factory: (index) {
    //       // return Enemy.legend(speed: level.number);
    //       // return Enemy.easy();
    //     },
    //     period: 1,
    //     area: Rectangle.fromLTWH(20, 0, size.x - 40, -Enemy.enemySize)));

    add(SpawnComponent(
        factory: (index) => Enemy.random(
            speed: level.number,
            random: _random,
            canSpawnTall: level.canSpawnTall),
        period: 1,
        area: Rectangle.fromLTWH(20, 0, size.x - 40, -Enemy.enemySize)));

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

    camera.viewport.add(scoreComponent);
    // print(playerNotifier.single!.life);
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   if (_pointerStartPosition != null) {
  //     canvas.drawCircle(_pointerStartPosition!, _joystickRadius,
  //         Paint()..color = Colors.grey.withAlpha(100));
  //   }
  //   if (_pointerCurrentPosition != null) {
  //     var delta = _pointerCurrentPosition! - _pointerStartPosition!;

  //     if (delta.distance > _joystickRadius) {
  //       delta = _pointerStartPosition! +
  //           (Vector2(delta.dx, delta.dy).normalized() * _joystickRadius)
  //               .toOffset();
  //     } else {
  //       delta = _pointerCurrentPosition!;
  //     }
  //     canvas.drawCircle(delta, _joystickRadius / 3,
  //         Paint()..color = Colors.white.withAlpha(100));
  //   }
  // }

  // @override
  // void onPanStart(DragStartInfo info) {
  //   _pointerStartPosition =
  //       Offset(info.raw.globalPosition.dx, info.raw.globalPosition.dy);
  //   _pointerCurrentPosition =
  //       Offset(info.raw.globalPosition.dx, info.raw.globalPosition.dy);
  //   // player.startShooting();
  // }

  // @override
  // void onPanUpdate(DragUpdateInfo info) {
  //   _pointerCurrentPosition =
  //       Offset(info.raw.globalPosition.dx, info.raw.globalPosition.dy);
  //   var delta = _pointerCurrentPosition! - _pointerStartPosition!;

  //   if (delta.distance > _deadZoneRadius) {
  //     player.move(info.delta.global);
  //   } else {
  //     player.move(Vector2.zero());
  //   }
  // }

//   @override
//   void onPanEnd(DragEndInfo info) {
//     _pointerStartPosition = null;
//     _pointerCurrentPosition = null;
//     player.move(Vector2.zero());
//     // player.stopShooting();
//   }

  // @override
  // void onTapDown(TapDownInfo info) {
  //   super.onTapDown(info);
  //   print('DISPARO');
  //   player.startShooting();
  // }

  // @override
  // void onTapUp(TapUpInfo info) {
  //   super.onTapUp(info);
  //   print('DEJA DE DISPARO');
  //   player.stopShooting();
  // }
}
