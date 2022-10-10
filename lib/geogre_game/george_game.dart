import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiled/tiled.dart';

import '../core_ui/app_audio.dart';
import '../core_ui/app_tiled_components.dart';
import '../core_ui/design/movement_direction.dart';
import '../ui/scenes/serene_village_scene/food_component/george_component/george_component.dart';
import 'loaders/add_baked_goods.dart';
import '../ui/scenes/serene_village_scene/food_component/friend_component/load_friend_components.dart';
import '../ui/scenes/serene_village_scene/food_component/obstacle_component/load_obstacle_components.dart';
import 'overlays/overlay_controller.dart';

const int kNoCollision = -1;

class GeorgeGame extends FlameGame with TapDetector, HasCollisionDetection {
  late GeorgeComponent _george;

  String dialogMessage = 'My first message';

  int georgeDirection = idleIndex;

  /// if collision is -1 that is no collision.
  int collisionDirection = kNoCollision;

  late double mapWidth;
  late double mapHeight;

  static const double _tileSize = 16.0;

  int friendNumber = 0;
  int pieNumber = 0;
  int maxFriends = 0;
  int sceneNumber = 1;

  bool showDialog = true;

  late AudioPool click2;

  late TiledComponent homeMap;

  List<Component> components = [];

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    FlameAudio.bgm.initialize();
    await FlameAudio.bgm.play(AppAudio.background);
    await FlameAudio.bgm.pause();

    click2 = await AudioPool.create(AppAudio.click2, maxPlayers: 8);

    homeMap = await TiledComponent.load(AppTiledComponents.sereneVillage, Vector2.all(_tileSize));

    await add(homeMap);
    await addBakedGoods(homeMap, this);
    await loadFriendComponents(homeMap, this);
    await loadObstacleComponents(homeMap, this);

    components.forEach((component) async {
      await add(component);
    });

    final TiledMap tiledMap = homeMap.tileMap.map;
    mapWidth = tiledMap.width * _tileSize;
    mapHeight = tiledMap.height * _tileSize;

    _george = GeorgeComponent()
      ..position = Vector2(250, 140)
      ..anchor = Anchor.center;

    await add(_george);

    camera.followComponent(
      _george,
      worldBounds: Rect.fromLTRB(
        0,
        0,
        mapWidth,
        mapHeight,
      ),
    );

    overlays.add(kOverlayController);
  }

  @override
  void onTapUp(TapUpInfo info) {
    if (georgeDirection >= 4) {
      georgeDirection = 0;
    } else {
      georgeDirection++;
    }
  }

  void newScene() async {
    print('change to a new scene');

    remove(homeMap);
    removeAll(components);
    components.clear();
    showDialog = false;
    remove(_george);
    _george = GeorgeComponent()..position = Vector2(300, 128);

    if (sceneNumber == 2) {
      print('moving to map 2');
    }

    homeMap = await TiledComponent.load(AppTiledComponents.office, Vector2.all(_tileSize));
    await add(homeMap);

    mapWidth = homeMap.tileMap.map.width * _tileSize;
    mapHeight = homeMap.tileMap.map.height * _tileSize;

    await add(_george);
    camera.followComponent(_george, worldBounds: Rect.fromLTWH(0, 0, mapWidth, mapHeight));
  }
}
