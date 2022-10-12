import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiled/tiled.dart';

import '../../../../core_ui/app_tiled_components.dart';
import '../../../../core_ui/movement_direction.dart';
import '../../../../core_ui/screen.dart';
import '../controllers/serenety_village_audio_controller.dart';
import '../components/food_component/load_food_components.dart';
import '../components/friend_component/load_friend_components.dart';
import '../components/george_component/george_component.dart';
import '../components/obstacle_component/load_obstacle_components.dart';

import '../controllers/serenety_village_state_controller.dart';
import '../tiled_maps/serene_village_tiled_map/serene_village_tiled_map.dart';

const String kOverlayController = 'ButtonController';

class SerenetyVillageGame extends FlameGame with TapDetector, HasCollisionDetection {
  final SerenetyVillageStateController state = SerenetyVillageStateController();
  final SerenetyVillageAudioController audioController = SerenetyVillageAudioController();

  late GeorgeComponent _george;
  static const double _tileSize = SereneVillageTiledMap.tileSize;
  String dialogMessage = 'My first message';
  int georgeDirection = kIdleIndex;
  int collisionDirection = kNoCollision;
  late double mapWidth;
  late double mapHeight;
  int sceneNumber = 1;
  bool showDialog = true;
  // late AudioPool click2;
  late TiledComponent homeMap;
  List<Component> components = [];

  late final Rect worldBounds;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    audioController.initialize();
    audioController.playBackground();

    homeMap = await TiledComponent.load(
        SereneVillageTiledMap.sereneVillageTiledMapPath, Vector2.all(_tileSize));

    final TiledMap tiledMap = homeMap.tileMap.map;
    mapWidth = tiledMap.width * _tileSize;
    mapHeight = tiledMap.height * _tileSize;
    worldBounds = Rect.fromLTRB(kStartXPosition, kStartYPosition, mapWidth, mapHeight);

    await add(homeMap);
    await loadFoodComponents(homeMap, this);
    await loadFriendComponents(homeMap, this);
    await loadObstacleComponents(homeMap, this);

    components.forEach((component) async {
      await add(component);
    });

    _george = GeorgeComponent()
      ..position = Vector2(250, 540)
      ..anchor = Anchor.center;

    await add(_george);

    camera.followComponent(_george, worldBounds: worldBounds);

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
    _george = GeorgeComponent()..position = Vector2(300, 528);

    if (sceneNumber == 2) {
      print('moving to map 2');
    }

    homeMap = await TiledComponent.load(AppTiledComponents.office, Vector2.all(_tileSize));
    await add(homeMap);

    mapWidth = homeMap.tileMap.map.width * _tileSize;
    mapHeight = homeMap.tileMap.map.height * _tileSize;

    await add(_george);
    camera.followComponent(_george, worldBounds: worldBounds);
  }
}
