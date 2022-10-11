import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../../../../core_ui/movement_direction.dart';
import '../../game/serenety_village_game.dart';
import '../george_component/george_component.dart';

class ObstacleComponent extends PositionComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<SerenetyVillageGame> {
  ObstacleComponent() {
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
      gameRef.collisionDirection = gameRef.georgeDirection;
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is GeorgeComponent) {
      gameRef.collisionDirection = kNoCollision;
    }
    super.onCollisionEnd(other);
  }
}
