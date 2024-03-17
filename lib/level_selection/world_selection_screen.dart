import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:space_shutter/level_selection/levels.dart';
import 'package:space_shutter/player_progress/player_progress.dart';
import 'package:space_shutter/style/style.dart';

class WorldSelectionScreen extends StatelessWidget {
  const WorldSelectionScreen({
    super.key,
    required this.world,
  });

  final GameWorld world;
  static const _gap = SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    // final playerProgress = context.watch<PlayerProgress>();
    // final blocked = playerProgress.worlds.length >= world.number - 1;
    final blocked = world.number > 1;
    return Column(
      children: [
        IconButton(
          icon: ColorFiltered(
            colorFilter: ColorFilter.mode(
              blocked
                  ?
                  // Si el mundo está desbloqueado, no aplicar filtro
                  Colors.transparent
                  // Si no está desbloqueado, aplicar filtro de opacidad
                  : Colors.black45.withOpacity(0.5),
              BlendMode.srcATop,
            ),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/worlds/${world.number}/${world.number}_01.png',
                  scale: 0.6,
                ),
                blocked
                    ? const SizedBox()
                    : const Positioned(
                        top: 20,
                        child: Icon(Icons.block,
                            size: 80, color: Color.fromARGB(255, 255, 26, 26)))
              ],
            ),
          ),
          onPressed: () {
            // if (playerProgress.worlds.length >= world.number - 1) {
            context.go('/worlds/${world.number}');
            // } else {
            //   // Manejar el caso en el que el mundo no está desbloqueado
            //   return;
            // }
          },
        ),
        _gap,
        Text(
          world.name,
          style: TextStyle(
            fontSize: 18,
            color: palette.text.color,
          ),
        )
      ],
    );
  }
}
