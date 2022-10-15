import 'package:flutter/material.dart';

import '../../../../core_ui/design/app_text_style.dart';
import '../design/serenety_village_colors.dart';
import '../game/serenety_village_game.dart';

class PieCounterWidget extends StatelessWidget {
  const PieCounterWidget({
    Key? key,
    required this.game,
  }) : super(key: key);

  final SerenetyVillageGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: SerenetyVillageColors.overlayBackground,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/serenety_village/apple_pie.png'),
          Text(
            'Pies: ${game.stateController.piesCount}',
            style: AppTextStyle.h3,
          ),
        ],
      ),
    );
  }
}
