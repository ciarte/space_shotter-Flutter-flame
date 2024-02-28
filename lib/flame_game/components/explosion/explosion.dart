import 'package:flame/components.dart';
import 'package:space_shutter/flame_game/space_shooter_game.dart';

class Explosion extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame> {
  Explosion({super.position})
      : super(
            anchor: Anchor.center, size: Vector2.all(75), removeOnFinish: true);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
        'explosion.png',
        SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2.all(32),
            loop: false));
  }
}
