import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../game/serenety_village_game.dart';
import '../george_component/george_component.dart';

class BeachComponent extends PositionComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<SerenetyVillageGame> {
  BeachComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() {
    debugMode = true;
    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is GeorgeComponent) {
      print('пляж начался');
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
