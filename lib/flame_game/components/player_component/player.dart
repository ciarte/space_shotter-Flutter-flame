import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_shutter/flame_game/components/bullets/bullet.dart';
import 'package:space_shutter/flame_game/components/enemy/enemy.dart';
import 'package:space_shutter/flame_game/components/explosion/explosion.dart';

import 'package:space_shutter/flame_game/space_shooter_game.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame>, CollisionCallbacks {
  Vector2 _moveDirection = Vector2.zero();
  final double _speed = 250;
  late final SpawnComponent _bulletSpawner;
  late int life;

  Player() : super(size: Vector2(80, 120), anchor: Anchor.center) {
    life = 3;
  }
  @override
  void update(double dt) {
    super.update(dt);
    position += _moveDirection.normalized() * _speed * dt;

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

    _bulletSpawner = SpawnComponent(
      period: 0.2,
      selfPositioning: true,
      factory: (index) {
        return Bullet(position: position + Vector2(0, -height / 2));
      },
      autoStart: false,
    );
    game.add(_bulletSpawner);

    animation = await game.loadSpriteAnimation(
        'player.png',
        SpriteAnimationData.sequenced(
            amount: 4, stepTime: 0.2, textureSize: Vector2(32, 48)));

    position = gameRef.size / 2;
    add(RectangleHitbox());
  }

  void move(Vector2 delta) {
    _moveDirection = delta;
    // position.add(delta);
  }

  void startShooting() {
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
  }

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

      gameRef.playerLifeNotifier.value = life;
      // print(life);
      other.removeFromParent();
      game.add(Explosion(position: position));
    }
  }
}
