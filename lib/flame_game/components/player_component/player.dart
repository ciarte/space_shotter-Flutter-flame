import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_shutter/audio/flame_audio.dart';

import 'package:space_shutter/flame_game/components/bullets/bullet.dart';
import 'package:space_shutter/flame_game/components/enemy/enemy.dart';
import 'package:space_shutter/flame_game/components/explosion/explosion.dart';

import 'package:space_shutter/flame_game/space_shooter_game.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame>, CollisionCallbacks {
  // Vector2 _moveDirection = Vector2.zero();
  final double _speed = 280;
  // late final SpawnComponent _bulletSpawner;
  late int life;

  final JoystickComponent joystick;
  final void Function({int amount}) addScore;
  final VoidCallback resetScore;
  AudioGame audioGame = AudioGame();

  Player(this.joystick, {required this.addScore, required this.resetScore})
      : super(size: Vector2(80, 120), anchor: Anchor.center) {
    life = 10;
  }

  @override
  void update(double dt) {
    super.update(dt);
    // position += _moveDirection.normalized() * _speed * dt;
    if (joystick.direction != JoystickDirection.idle) {
      position.add(joystick.relativeDelta * _speed * dt);
      //si se mueve en todas direcciones
      // angle = joystick.delta.screenAngle();
    }

    //player no sale de la pantalla y tiene limite
    var clampedY =
        position.y.clamp(300 - size.y / 2, game.canvasSize.y - size.y / 2);
    double clampedX =
        position.x.clamp(size.x / 2, game.canvasSize.x - size.x / 2);
    position = Vector2(clampedX, clampedY);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
        'player.png',
        SpriteAnimationData.sequenced(
            amount: 4, stepTime: 0.2, textureSize: Vector2(32, 48)));

    position = gameRef.size / 2;
    add(RectangleHitbox());
  }

  void move(Vector2 delta) {
    // _moveDirection = delta;
    // position.add(delta);
  }

  void startShooting() {
    Bullet bullet = Bullet(position: position + Vector2(0, -height / 2));

    game.add(bullet);

    audioGame.onFire();
  }

  // void stopShooting() {
  //   // _bulletSpawner.timer.stop();
  //   // _bulletSpawner.timer.stop();
  // }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    // if (_life < 0) {
    //   removeFromParent();
    //   print("GAME OVER");
    // }

    if (other is Enemy) {
      life -= 1;
      gameRef.scoreNotifier.value += 1;
      gameRef.playerLifeNotifier.value = life;
      // print(life);

      game.add(Explosion(position: position));
      other.removeFromParent();
    }
  }
}
