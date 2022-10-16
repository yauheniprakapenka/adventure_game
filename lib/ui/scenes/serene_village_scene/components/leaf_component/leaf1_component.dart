import 'package:flame/components.dart';

import '../../game/serenety_village_game.dart';

class Leaf1Component extends SpriteComponent with HasGameRef<SerenetyVillageGame> {
  static const String _spritePath = 'serenety_village/leaf1.png';
  static final Vector2 _size = Vector2(144, 160);
  static const double _sizeMultiplier = 0.12;
  static const double _angleSpeed = 0.008;

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(_spritePath);
    anchor = Anchor.center;
    size = _size * _sizeMultiplier;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    angle += _angleSpeed;
    super.update(dt);
  }
}
