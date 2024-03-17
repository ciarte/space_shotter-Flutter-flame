import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:space_shutter/flame_game/components/player_component/player.dart';

Color selectBarColor(double currentWidth, double maxWidth) {
  if (currentWidth <= maxWidth / 3) {
    return const Color(0xFFEA0101);
  } else if (currentWidth <= maxWidth / 2.5) {
    return Colors.red.shade800;
  } else if (currentWidth <= maxWidth / 1.5) {
    return Colors.orange.shade800;
  } else {
    return Colors.green;
  }
}

class LifeBarComponent extends PositionComponent {
  late Player player;
  final Vector2 sizes;

  late SpriteComponent lifeComponent1;
  LifeBarComponent(this.player, this.sizes)
      : super(position: Vector2(sizes.x - 32, sizes.y - 250));

  @override
  Future<void> onLoad() async {
    final sprite1 = await Sprite.load('heart.png');

    lifeComponent1 = SpriteComponent(
      sprite: sprite1,
      size: Vector2.all(28),
    );
  }

  @override
  Future<void> render(Canvas canvas) async {
    // Calcular el ancho de la barra de vida basado en la vida actual del jugador
    const double maxWidth = 200; // Ancho máximo de la barra de vida
    final double currentWidth =
        maxWidth * (player.life / 10); // Calcular el ancho actual

    const RRect rect = RRect.fromLTRBXY(0, 10, 28, maxWidth, 15, 15);
    // final Rect life = Rect.fromLTWH(0, maxWidth - currentWidth, 28, 150);

    final RRect life =
        RRect.fromLTRBXY(0, maxWidth - currentWidth, 28, maxWidth, 10, 10);

    canvas.drawRRect(
        rect,
        Paint()
          ..color = const Color.fromARGB(255, 224, 208, 26).withOpacity(0.3));

    final Rect rect1 =
        Rect.fromLTRB(sizes.x - 30, sizes.y - 80, sizes.x - 10, sizes.y - 250);
    final Rect life1 = Rect.fromLTRB(
        sizes.x - 30, sizes.y - 80, sizes.x - 10, sizes.y - 50 - currentWidth);
    canvas.drawRect(
        rect1,
        Paint()
          ..color = const Color.fromARGB(255, 224, 208, 26).withOpacity(0.3));

// Seleccionar el color de la barra de vida
    final Color barColor = selectBarColor(currentWidth, maxWidth);

    // Dibujar la barra de vida
    canvas.drawRRect(life, Paint()..color = barColor);
    canvas.drawRect(life1, Paint()..color = barColor);
    // lifeComponent1.position = Vector2(230, 100);

    lifeComponent1.render(canvas);
  }

  @override
  void update(double dt) {}
}
