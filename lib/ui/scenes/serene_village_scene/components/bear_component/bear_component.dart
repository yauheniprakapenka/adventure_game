import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../design/serenety_village_images.dart';
import '../../game/serenety_village_game.dart';
import '../george_component/george_component.dart';

class BearComponent extends SpriteComponent
    with HasGameRef<SerenetyVillageGame>, CollisionCallbacks {
  static final Vector2 _size = Vector2(160.0, 182.0);
  static const double _sizeMultiplier = 0.17;

  BearComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(SerenetyVillageImages.bearFlamePath, srcSize: _size);
    size = _size * _sizeMultiplier;
    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is GeorgeComponent) {
      removeFromParent();
      gameRef.stateController.setBearToy();
      gameRef.questController.completeCurrentQuest();
      gameRef.refreshWidget();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
