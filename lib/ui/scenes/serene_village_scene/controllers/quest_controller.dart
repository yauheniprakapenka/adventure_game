import '../design/serenety_village_images.dart';
import '../models/quest_model.dart';

class QuestController {
  final List<QuestModel> _quests = [
    const QuestModel(
      task: 'Find the bear toy',
      imagePath: SerenetyVillageImages.grape,
      questType: QuestType.findBearToy,
    ),
    const QuestModel(
      task: 'Return the bear toy to ninja boy',
      imagePath: SerenetyVillageImages.grape,
      questType: QuestType.returnBearToyToNinjaBoy,
    ),
  ];

  int _currentQuestIndex = 0;

  QuestModel get getCurrentQuest {
    return _currentQuestIndex >= _quests.length
        ? QuestModel.finished()
        : _quests[_currentQuestIndex];
  }

  void completeCurrentQuest() => _currentQuestIndex++;

  bool get isAllQuestsCompleted => _currentQuestIndex > _quests.length;
}
