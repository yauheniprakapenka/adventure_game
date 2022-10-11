import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core_ui/design/app_text_style.dart';
import '../design/serenety_village_colors.dart';
import '../game/serenety_village_game.dart';

class DialogWidget extends StatelessWidget {
  final SerenetyVillageGame game;
  const DialogWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return game.showDialog
        ? Container(
            padding: const EdgeInsets.all(8),
            color: SerenetyVillageColors.overlayBackground,
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  game.dialogMessage,
                  textStyle: AppTextStyle.h3,
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              isRepeatingAnimation: false,
              onFinished: () {
                game.showDialog = false;
                game.refreshWidget();
              },
            ),
          )
        : const SizedBox();
  }
}
