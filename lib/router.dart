import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:space_shutter/flame_game/game_screen.dart';

import 'package:space_shutter/level_selection/levels.dart';

import 'package:space_shutter/level_selection/screen.dart';
import 'package:space_shutter/main_menu/main_menu_screen.dart';

final goRouter = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) =>
          const MainMenuScreen(key: Key('main menu screen'))),
  GoRoute(
    path: '/play',
    builder: (context, state) => const Screen(),
  ),
  GoRoute(
      path: '/level/:world',
      builder: (context, state) {
        final levelNumber = int.parse(state.pathParameters['world']!);
        final level = gameLevels[levelNumber - 1];
        return GameScreen(levels: level);
      }),
]);
