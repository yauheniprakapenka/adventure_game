import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../game/serenety_village_game.dart';
import '../ninja_boy/ninja_boy_component.dart';

class BeachComponent extends PositionComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<SerenetyVillageGame> {
  final String objectName;

  BeachComponent({required this.objectName}) {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() {
    debugMode = true;
    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is NinjaBoyComponent) {
      print('пляж начался');
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
