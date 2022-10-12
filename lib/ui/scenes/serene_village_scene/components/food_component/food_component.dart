import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../game/serenety_village_game.dart';

class FoodComponent extends SpriteComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<SerenetyVillageGame> {
  final String name;

  FoodComponent({required this.name}) {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    debugMode = true;
    await super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    gameRef.state.increasePies();
    gameRef.refreshWidget();
    gameRef.audioController.playPickUpItem();
    removeFromParent();
    super.onCollision(intersectionPoints, other);
  }
}
