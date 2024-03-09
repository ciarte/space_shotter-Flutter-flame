import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:space_shutter/flame_game/game_screen.dart';

import 'package:space_shutter/level_selection/levels.dart';

import 'package:space_shutter/level_selection/world_screen.dart';
import 'package:space_shutter/main_menu/main_menu_screen.dart';

import 'level_selection/level_selection_screen.dart';

final goRouter = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) =>
          const MainMenuScreen(key: Key('main menu screen'))),
  GoRoute(
    path: '/play',
    builder: (context, state) => const WorldScreen(),
  ),
  GoRoute(
      path: '/worlds/:world',
      builder: (context, state) {
        final worldNumber = int.parse(state.pathParameters['world']!);
        final world = gameLevels[worldNumber - 1];
        return LevelSelectionScreen(
          worlds: world,
        );
      }),
  GoRoute(
      path: '/levels/:world/:level',
      builder: (context, state) {
        final worldNumber = int.parse(state.pathParameters['world']!);
        final levelNumber = int.parse(state.pathParameters['level']!);
        final level = gameLevels[worldNumber - 1].levels[levelNumber - 1];
        return GameScreen(world: gameLevels[worldNumber - 1], level: level);
      }),
]);
