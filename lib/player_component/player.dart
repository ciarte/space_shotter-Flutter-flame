import 'package:flame/components.dart';
import 'package:space_shutter/main.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame> {
  Player() : super(size: Vector2(100, 150), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
        'player.png',
        SpriteAnimationData.sequenced(
            amount: 4, stepTime: 0.5, textureSize: Vector2(32, 48)));

    position = gameRef.size / 2;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}
