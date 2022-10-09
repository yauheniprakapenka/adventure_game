import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';

import '../core_ui/design/app_images.dart';

class TalkingScene extends FlameGame {
  TextPaint dialogTextPaint = TextPaint();
  int dialogLevel = 0;
  late final Timer timer;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final SpriteComponent back = SpriteComponent()
      ..sprite = await loadSprite(AppImages.background)
      ..size = Vector2(size[0], size[1] - 190);
    await add(back);

    timer = Timer(
      2,
      repeat: true,
      onTick: () {
        dialogLevel++;
      },
    );
    // timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    switch (dialogLevel) {
      case 0:
        dialogTextPaint.render(canvas, 'Hello', Vector2(100, 100));
        break;
      case 1:
        dialogTextPaint.render(canvas, 'World', Vector2(100, 100));
        break;
      case 2:
        dialogTextPaint.render(canvas, 'Tokio', Vector2(100, 100));
        break;
      case 3:
        dialogTextPaint.render(canvas, 'Cat', Vector2(100, 100));
        break;
    }
  }
}
