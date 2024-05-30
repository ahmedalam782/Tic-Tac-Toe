import 'package:audioplayers/audioplayers.dart';

class SoundService {
  final String sound;

  SoundService({
    required this.sound,
  });

  playSound() {
    final player = AudioPlayer();
    player.play(AssetSource(sound));
  }
}
