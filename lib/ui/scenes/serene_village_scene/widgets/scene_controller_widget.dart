import 'package:flutter/material.dart';

import '../game/serenety_village_game.dart';
import 'audio_buttons.dart';
import 'dialog_widget.dart';
import 'friend_counter_widget.dart';
import 'pie_counter_widget.dart';
import 'quest_widget.dart';

class SceneControllerWidget extends StatelessWidget {
  final SerenetyVillageGame game;

  const SceneControllerWidget({
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AudioButtons(game: game),
              QuestWidget(
                taskModel: game.questController.getCurrentQuest,
              ),
            ],
          ),
          Row(
            children: [
              PieCounterWidget(game: game),
              FriendCounterWidget(game: game),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DialogWidget(game: game),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
