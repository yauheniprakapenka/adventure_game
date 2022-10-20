class QuestModel {
  final String task;
  final QuestType questType;
  final String? imagePath;

  const QuestModel({
    required this.task,
    this.imagePath,
    required this.questType,
  });

  factory QuestModel.finished() {
    return const QuestModel(task: '', questType: QuestType.finished);
  }
}

enum QuestType {
  finished,
  findBearToy,
  returnBearToyToNinjaBoy,
}
