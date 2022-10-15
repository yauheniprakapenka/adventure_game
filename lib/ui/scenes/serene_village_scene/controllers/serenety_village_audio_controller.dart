import 'dart:async';

import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';

class SerenetyVillageAudioController {
  static const String _background = 'betterdays.mp3';
  static const String _pickUpItem = 'audio/click2.mp3';

  void initialize() {
    FlameAudio.bgm.initialize();
  }

  bool isBackgroundPlaying() {
    return FlameAudio.bgm.isPlaying;
  }

  Future<void> playBackground() async {
    await FlameAudio.bgm.play(_background);
  }

  Future<void> pauseBackground() async {
    await FlameAudio.bgm.pause();
  }

  Future<void>  resumeBackground() async {
    await FlameAudio.bgm.resume();
  }

  Future<void> stopBackground() async {
    await FlameAudio.bgm.stop();
  }

  Future<void> playPickUpItem() async {
    final AudioPool sound = await AudioPool.create(_pickUpItem, maxPlayers: 8);
    unawaited(sound.start());
  }
}
