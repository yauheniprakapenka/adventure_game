import 'package:flutter/material.dart';

import '../../core_ui/app_colors.dart';
import '../../core_ui/app_text_style.dart';
import '../george_game.dart';

class FriendScoreOverlay extends StatelessWidget {
  const FriendScoreOverlay({Key? key, required this.game}) : super(key: key);

  final GeorgeGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: AppColors.overlayBackground,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/face.png'),
          Text(
            'Friends: ${game.friendNumber}',
            style: AppTextStyle.h3,
          ),
        ],
      ),
    );
  }
}
