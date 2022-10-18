import 'package:flutter/material.dart';

import '../../../../core_ui/design/app_sizes.dart';
import '../design/serenety_village_colors.dart';
import '../game/serenety_village_game.dart';

class AudioButtons extends StatelessWidget {
  final SerenetyVillageGame game;

  const AudioButtons({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    final bool isBackgroundPlaying = game.audioController.isBackgroundPlaying();
    return Container(
      color: SerenetyVillageColors.overlayBackground,
      child: IconButton(
        iconSize: AppSizes.icon,
        constraints: const BoxConstraints(),
        onPressed: () {
          isBackgroundPlaying
              ? game.audioController.pauseBackground()
              : game.audioController.resumeBackground();
          game.refreshWidget();
        },
        icon: Icon(
          isBackgroundPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }
}
