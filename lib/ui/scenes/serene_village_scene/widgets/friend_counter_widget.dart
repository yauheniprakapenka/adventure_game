import 'package:flutter/material.dart';

import '../../../../core_ui/design/app_text_style.dart';
import '../design/serenety_village_colors.dart';
import '../design/serenety_village_images.dart';
import '../game/serenety_village_game.dart';

class FriendCounterWidget extends StatelessWidget {
  const FriendCounterWidget({super.key, required this.game});

  final SerenetyVillageGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: SerenetyVillageColors.overlayBackground,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(SerenetyVillageImages.face),
          Text(
            'Friends: ${game.state.friendsCount}',
            style: AppTextStyle.h3,
          ),
        ],
      ),
    );
  }
}
