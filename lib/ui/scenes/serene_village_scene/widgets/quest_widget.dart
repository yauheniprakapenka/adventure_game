import 'package:flutter/material.dart';

import '../../../../core_ui/design/app_sizes.dart';
import '../../../../core_ui/design/app_text_style.dart';
import '../design/serenety_village_colors.dart';
import '../models/quest_model.dart';

class QuestWidget extends StatelessWidget {
  final QuestModel taskModel;

  const QuestWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    final String? imagePath = taskModel.imagePath;
    return Container(
      padding: const EdgeInsets.all(8),
      color: SerenetyVillageColors.overlayBackground,
      child: Row(
        children: [
          imagePath == null ? const SizedBox() : Image.asset(imagePath, width: AppSizes.icon),
          const SizedBox(width: 6),
          Text(taskModel.task, style: AppTextStyle.h3),
          const SizedBox(width: 6),
        ],
      ),
    );
  }
}
