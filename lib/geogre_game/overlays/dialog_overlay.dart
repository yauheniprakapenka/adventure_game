import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../core_ui/app_colors.dart';
import '../../core_ui/app_text_style.dart';
import '../george_game.dart';

class DialogOverlay extends StatelessWidget {
  final GeorgeGame game;
  const DialogOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return game.showDialog
        ? Container(
            padding: EdgeInsets.all(8),
            color: AppColors.overlayBackground,
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
