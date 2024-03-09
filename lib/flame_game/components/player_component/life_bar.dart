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

  LifeBarComponent(this.player, this.sizes);

  @override
  void render(Canvas canvas) {
    // Calcular el ancho de la barra de vida basado en la vida actual del jugador
    const double maxWidth = 200; // Ancho máximo de la barra de vida
    final double currentWidth =
        maxWidth * (player.life / 10); // Calcular el ancho actual
    final Rect rect = Rect.fromLTWH(100, sizes.y - 35, 200, 20);
    final Rect life = Rect.fromLTWH(100, sizes.y - 35, currentWidth, 20);
    // Dibujar la barra de vida
    canvas.drawRect(
        rect,
        Paint()
          ..color = const Color.fromARGB(255, 224, 208, 26).withOpacity(0.3));
// Seleccionar el color de la barra de vida
    final Color barColor = selectBarColor(currentWidth, maxWidth);

    // Dibujar la barra de vida
    canvas.drawRect(life, Paint()..color = barColor);
    // canvas.drawRect(
    //     life,
    //     Paint()
    //       ..color = currentWidth <= maxWidth / 1.5
    //           ? Colors.orange.shade800
    //           : currentWidth <= maxWidth / 2.5
    //               ? Colors.redAccent
    //               : Colors.green);
  }

  @override
  void update(double dt) {}
}
