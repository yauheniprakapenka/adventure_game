import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
// import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../george_game.dart';
import 'audio_overlay.dart';
import 'dialog_overlay.dart';
import 'friends_score_overlay.dart';
import 'pies_score_widget.dart';

const String kOverlayController = 'ButtonController';

class OverlayController extends StatelessWidget {
  final GeorgeGame game;

  const OverlayController({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AudioOverlay(),
          Row(
            children: [
              PiesScoreWidget(game: game),
              FriendScoreOverlay(game: game),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DialogOverlay(game: game),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
