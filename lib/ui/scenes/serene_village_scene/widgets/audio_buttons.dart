import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../design/serenety_village_colors.dart';

class AudioButtons extends StatelessWidget {
  const AudioButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: SerenetyVillageColors.overlayBackground,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: FlameAudio.bgm.pause,
            icon: const Icon(
              Icons.pause,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: FlameAudio.bgm.resume,
            icon: const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
