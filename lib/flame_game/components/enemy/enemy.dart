import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:space_shutter/flame_game/components/bullets/bullet.dart';
import 'package:space_shutter/flame_game/components/explosion/explosion.dart';
import 'package:space_shutter/flame_game/space_shooter_game.dart';

class Enemy extends SpriteComponent
    with HasGameRef<SpaceShooterGame>, CollisionCallbacks {
  final Vector2 _srcSize;
  final Vector2 _srcPosition;
  static const enemySize = 55.0;
  late int count;

  final int speed;

//types of enemies
  Enemy.easy({
    super.position,
  })  : _srcSize = Vector2(92, 72),
        _srcPosition = Vector2.zero(),
        speed = 0,
        super(size: Vector2.all(enemySize), anchor: Anchor.center, angle: pi) {
    count = 0;
  }
  Enemy.medium({super.position})
      : _srcSize = Vector2(94, 72),
        _srcPosition = Vector2(92, 0),
        speed = 2,
        super(size: Vector2.all(enemySize), anchor: Anchor.center, angle: pi) {
    count = 0;
  }
  Enemy.hard({super.position})
      : _srcSize = Vector2(84, 72),
        _srcPosition = Vector2(204, 0),
        speed = 3,
        super(size: Vector2.all(enemySize), anchor: Anchor.center, angle: pi) {
    count = 0;
  }
  Enemy.legend({
    super.position,
  })  : _srcSize = Vector2(86, 72),
        _srcPosition = Vector2(306, 0),
        speed = 5,
        super(size: Vector2.all(enemySize), anchor: Anchor.center, angle: pi) {
    count = 0;
  }

  /// Generates a random obstacle of type [ObstacleType].
  factory Enemy.random(
      {Vector2? position,
      Random? random,
      bool canSpawnTall = true,
      required int speed}) {
    final values = canSpawnTall
        ? const [
            EnemyType.easy,
            EnemyType.medium,
            EnemyType.hard,
            EnemyType.legend
          ]
        : const [EnemyType.easy, EnemyType.medium];
    final obstacleType = values.random(random);
    switch (obstacleType) {
      case EnemyType.easy:
        return Enemy.easy(position: position);
      case EnemyType.medium:
        return Enemy.medium(position: position);
      case EnemyType.hard:
        return Enemy.hard(position: position);
      case EnemyType.legend:
        return Enemy.legend(position: position);
    }
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

    position.y += dt * 250 + speed;

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

      other.removeFromParent();
      removeFromParent();
      game.add(Explosion(position: position));
    }
  }
}

enum EnemyType { easy, medium, hard, legend }
