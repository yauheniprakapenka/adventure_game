import 'package:flutter/material.dart';

import '../../core_ui/app_colors.dart';
import '../../core_ui/app_text_style.dart';
import '../george_game.dart';

class PiesScoreWidget extends StatelessWidget {
  const PiesScoreWidget({
    Key? key,
    required this.game,
  }) : super(key: key);

  final GeorgeGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: AppColors.overlayBackground,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/apple_pie2.png'),
          Text(
            'Pies: ${game.pieNumber}',
            style: AppTextStyle.h3,
          ),
        ],
      ),
    );
  }
}
