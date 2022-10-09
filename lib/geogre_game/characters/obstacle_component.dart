import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../george_game.dart';
import '../../ui/scenes/serene_village_scene/characters/george/george_component.dart';

class ObstacleComponent extends PositionComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<GeorgeGame> {
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
    super.onCollisionStart(intersectionPoints, other);
    print('On obstacle collision start');

    if (other is GeorgeComponent) {
      gameRef.collisionDirection = gameRef.georgeDirection;
      print('collision with obstacle in direction: ${gameRef.collisionDirection}');
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is GeorgeComponent) {
      gameRef.collisionDirection = kNoCollision;
    }
    super.onCollisionEnd(other);
  }
}
