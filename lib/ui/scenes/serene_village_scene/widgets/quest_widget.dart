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
    return Container(
      padding: const EdgeInsets.all(8),
      color: SerenetyVillageColors.overlayBackground,
      child: Row(
        children: [
          Image.asset(taskModel.imagePath, width: AppSizes.icon),
          const SizedBox(width: 6),
          Text(taskModel.task, style: AppTextStyle.h3),
          const SizedBox(width: 6),
          Icon(
            taskModel.isCompleted ? Icons.check_box_outlined : Icons.check_box_outline_blank,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
