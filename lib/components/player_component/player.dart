import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_shutter/components/bullets/bullet.dart';
import 'package:space_shutter/components/enemy/enemy.dart';
import 'package:space_shutter/components/explosion/explosion.dart';
import 'package:space_shutter/space_shooter_game.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame>, CollisionCallbacks {
  late final SpawnComponent _bulletSpawner;
  late int _life;
  Player() : super(size: Vector2(80, 120), anchor: Anchor.center) {
    _life = 3;
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

  // @override
  // void update(double dt) {
  //   super.update(dt);
  //   // Restringir la posición del jugador dentro de los límites del juego
  //   position.x = position.x.clamp(0, gameRef.size.x - width / 2);
  //   position.y = position.y.clamp(0, gameRef.size.y - height / 2);
  // }

  void move(Vector2 delta) {
    position.add(delta);
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
    if (_life < 0) {
      removeFromParent();
      print("GAME OVER");
    }

    if (other is Enemy) {
      _life -= 1;
      other.removeFromParent();
      game.add(Explosion(position: position));
    }
  }
}
