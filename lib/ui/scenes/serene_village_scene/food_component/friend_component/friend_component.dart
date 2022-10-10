import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../../../../geogre_game/george_game.dart';
import '../george_component/george_component.dart';

class FriendComponent extends PositionComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<GeorgeGame> {
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
      if (gameRef.pieNumber > 0) {
        dialogMessage = '$name: Thanks for a pie!';
        gameRef.pieNumber--;
        gameRef.friendNumber++;
      } else {
        dialogMessage = '$name: Can you find a pie?';
      }
      gameRef.dialogMessage = dialogMessage;
      gameRef.showDialog = true;
      final bool isLevelFinished = gameRef.maxFriends <= gameRef.friendNumber;
      if (isLevelFinished) {
        gameRef.sceneNumber++;
        gameRef.newScene();
      }
      gameRef.refreshWidget();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
