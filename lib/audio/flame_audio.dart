import 'package:flame_audio/flame_audio.dart';

class AudioGame {
  void musicTheme() {
    FlameAudio.bgm.play('theme_song.mp3', volume: 0.2);
  }

  void onButtonPress() {
    FlameAudio.play('click4.mp3');
    print('boton click');
  }

  void onFire() {
    FlameAudio.play('Fire4.mp3');
    print('fire');
  }
}
