import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../game/serenety_village_game.dart';
import '../george_component/george_component.dart';

class FriendComponent extends PositionComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<SerenetyVillageGame> {
  final String name;

  FriendComponent({required this.name}) {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    debugMode = true;
    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is GeorgeComponent) {
      String dialogMessage;
      if (gameRef.state.piesCount > 0) {
        dialogMessage = '$name: Thanks for a pie!';
        gameRef.state.decreasePies();
        gameRef.state.increaseFriends();
      } else {
        dialogMessage = '$name: Can you find a pie?';
      }
      gameRef.dialogMessage = dialogMessage;
      gameRef.showDialog = true;
      final bool isLevelFinished = gameRef.state.isMaxFriensNumberReached;
      if (isLevelFinished) {
        gameRef.sceneNumber++;
        gameRef.newScene();
      }
      gameRef.refreshWidget();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
