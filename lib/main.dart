import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';
import 'package:space_shutter/app_life_cicle/app_lifecycle.dart';
import 'package:space_shutter/player_progress/player_data.dart';

import 'package:space_shutter/player_progress/player_progress.dart';
import 'package:space_shutter/router.dart';
import 'package:space_shutter/settings/settings.dart';
import 'package:space_shutter/style/style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlameAudio.bgm.initialize();
  await Flame.device.fullScreen();
  runApp(const MyGame());
}

class MyGame extends StatelessWidget {
  const MyGame({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
        child: MultiProvider(
            providers: [
          Provider(create: (context) => Palette()),
          ChangeNotifierProvider(
              create: (context) => PlayerData.fromMap(PlayerData.defaultData)),
          Provider(create: (context) => SettingsController()),
          // Audio
          // ProxyProvider2<SettingsController, AppLifecycleStateNotifier,
          //     AudioController>(
          //   //empieza la musica desde el inicio de la app
          //   lazy: false,
          //   create: (context) => AudioController(),
          //   update: (context, settings, lifecycleNotifier, audio) {
          //     audio!.attachDependencies(lifecycleNotifier, settings);
          //     return audio;
          //   },
          //   dispose: (context, audio) => audio.dispose(),
          // )
        ],
            child: Builder(builder: (context) {
              final palette = context.watch<Palette>();

              return MaterialApp.router(
                theme: flutterNesTheme().copyWith(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: palette.seed.color,
                    background: palette.backgroundLevelSelection.color,
                  ),
                  textTheme: GoogleFonts.pressStart2pTextTheme().apply(
                    fontFamily: 'Press Start 2P',
                    bodyColor: palette.text.color,
                    displayColor: palette.text2.color,
                  ),
                ),
                debugShowCheckedModeBanner: false,
                routeInformationProvider: goRouter.routeInformationProvider,
                routeInformationParser: goRouter.routeInformationParser,
                routerDelegate: goRouter.routerDelegate,
              );
            })));
  }
}
