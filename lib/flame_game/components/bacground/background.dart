import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/widgets.dart';

class Background extends ParallaxComponent {
  Background({required this.backGround, required this.speed});

  final String backGround;
  final double speed;

  @override
  Future<void> onLoad() async {
    final layers = [
      ParallaxImageData('backgrounds/$backGround'),
      //agregar mas componentes de fondo
    ];

    final velocityMultiplierDelta = Vector2(0, 7);
    final baseVelocity = Vector2(0, -speed * 8);

    parallax = await game.loadParallax(
      layers,
      baseVelocity: baseVelocity,
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: velocityMultiplierDelta,
      filterQuality: FilterQuality.none,
    );
  }
}
