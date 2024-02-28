import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorldSelectionScreen extends StatelessWidget {
  const WorldSelectionScreen({
    super.key,
    required this.world,
  });

  final world;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'assets/images/worlds/${(world.number.toString())}/${(world.number.toString())}_01.png',
        scale: .5,
      ),
      onPressed: () {
        context.go('/level/${world.number}');
      },
    );
  }
}
