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
      String message;
      if (gameRef.stateController.piesCount > 0) {
        message = '$name: Thanks for a pie!';
        gameRef.stateController.decreasePies();
        gameRef.stateController.increaseFriends();
      } else {
        message = '$name: Can you find a pie?';
      }
      gameRef.showMessage(message);
      gameRef.refreshWidget();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
