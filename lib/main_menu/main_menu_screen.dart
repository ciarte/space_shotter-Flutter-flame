import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:space_shutter/audio/flame_audio.dart';
// import 'package:space_shutter/audio/audio_controller.dart';
// import 'package:space_shutter/audio/sounds.dart';
import 'package:space_shutter/settings/settings.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:space_shutter/style/style.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  static const _gap = SizedBox(
    height: 20,
  );
  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    // final audioController = context.watch<AudioController>();
    final settingsController = context.watch<SettingsController>();
    AudioGame audioGame = AudioGame();

    final size = MediaQuery.of(context).size;

    // Reproducir música al inicializar la aplicación

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // FlameAudio.bgm.play('theme_song.mp3', volume: 0.2);

      settingsController.audioOn.value ? audioGame.musicTheme() : null;
    });

    return Scaffold(
        backgroundColor: palette.backgroundPlaySession.color,
        body: Stack(children: [
          Image.asset('assets/images/banner1.png',
              filterQuality: FilterQuality.none,
              fit: BoxFit.fitHeight,
              // width: 150,
              height: size.height),
          _gap,
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.3),
            child: Text(
              'Galaxy Defender',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Press Start 2P',
                fontSize: 36,
                color: palette.text2.color,
              ),
            ),
          ),
          _gap,
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.6),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WobblyButton(
                      child: const Text(
                        'Play',
                      ),
                      onPressed: () {
                        // audioController.playSfx(SfxType.buttonTap);
                        audioGame.onButtonPress();
                        context.go('/play');
                      }),
                  _gap,
                  WobblyButton(
                      child: const Text('Settings'),
                      onPressed: () {
                        audioGame.onFire();
                        // audioController.playSfx(SfxType.buttonTap);
                      }
                      //  print('Settings'),
                      ),
                ],
              ),
              _gap,
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ValueListenableBuilder<bool>(
                  valueListenable: settingsController.audioOn,
                  builder: (context, audioOn, child) {
                    return IconButton(
                        onPressed: () {
                          if (FlameAudio.bgm.isPlaying) {
                            settingsController.toggleAudioOn();

                            FlameAudio.bgm.pause();
                          } else {
                            FlameAudio.bgm.resume();
                            settingsController.toggleAudioOn();
                          }
                        },
                        icon: Icon(
                            size: 40,
                            color: palette.text2.color,
                            audioOn ? Icons.volume_up : Icons.volume_off));
                  },
                ),
              ),
              _gap,
              Text(
                'Built with Flame',
                style: TextStyle(
                  fontFamily: 'Press Start 2P',
                  color: palette.text2.color,
                ),
              ),
              _gap,
              Text(
                'by Hukelele studios',
                style: TextStyle(
                  fontFamily: 'Press Start 2P',
                  color: palette.text2.color,
                ),
              ),
            ]),
          )
        ]));
  }
}
