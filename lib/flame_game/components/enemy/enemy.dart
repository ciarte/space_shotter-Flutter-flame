import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_shutter/flame_game/components/bullets/bullet.dart';
import 'package:space_shutter/flame_game/components/explosion/explosion.dart';
import 'package:space_shutter/flame_game/space_shooter_game.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame>, CollisionCallbacks {
  static const enemySize = 40.0;
  late int count;
  Enemy({super.position})
      : super(size: Vector2.all(enemySize), anchor: Anchor.center) {
    count = 0;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await game.loadSpriteAnimation(
        'enemy.png',
        SpriteAnimationData.sequenced(
            amount: 4, stepTime: 0.2, textureSize: Vector2.all(16)));

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * 250;

    if (position.y > game.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      // count += 1;
      gameRef.scoreNotifier.value += count + 1;
      print(count);
      other.removeFromParent();
      removeFromParent();
      game.add(Explosion(position: position));
    }
  }
}
