import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_shutter/flame_game/components/bullets/bullet.dart';
import 'package:space_shutter/flame_game/components/explosion/explosion.dart';
import 'package:space_shutter/flame_game/space_shooter_game.dart';

class Enemy extends SpriteComponent
    with HasGameRef<SpaceShooterGame>, CollisionCallbacks {
  final Vector2 _srcSize;
  final Vector2 _srcPosition;
  static const enemySize = 55.0;
  late int count;

  Enemy.easy({super.position})
      : _srcSize = Vector2(84, 72),
        _srcPosition = Vector2.zero(),
        super(size: Vector2.all(enemySize), anchor: Anchor.center, angle: pi) {
    count = 0;
  }

  Enemy.medium({super.position})
      : _srcSize = Vector2(84, 72),
        _srcPosition = Vector2(92, 0),
        super(size: Vector2.all(enemySize), anchor: Anchor.center, angle: pi) {
    count = 0;
  }
  Enemy.hard({super.position})
      : _srcSize = Vector2(84, 72),
        _srcPosition = Vector2(204, 0),
        super(size: Vector2.all(enemySize), anchor: Anchor.center, angle: pi) {
    count = 0;
  }
  Enemy.legend({super.position})
      : _srcSize = Vector2(84, 72),
        _srcPosition = Vector2(306, 0),
        super(size: Vector2.all(enemySize), anchor: Anchor.center, angle: pi) {
    count = 0;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load(
      'shipsry8.png',
      srcSize: _srcSize,
      srcPosition: _srcPosition,
    );
    // animation = await game.loadSpriteAnimation(
    //     'enemy.png',
    //     SpriteAnimationData.sequenced(
    //         amount: 4, stepTime: 0.2, textureSize: Vector2.all(16)));

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
