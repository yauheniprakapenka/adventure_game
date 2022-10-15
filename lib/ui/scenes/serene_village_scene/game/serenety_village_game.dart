import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiled/tiled.dart';

import '../../../../core_ui/app_tiled_components.dart';
import '../../../../core_ui/movement_direction.dart';
import '../../../../core_ui/screen.dart';
import '../components/beach_component/load_beach_components.dart';
import '../components/food_component/load_food_components.dart';
import '../components/friend_component/load_friend_components.dart';
import '../components/george_component/george_component.dart';
import '../components/ninja_boy/ninja_boy_component.dart';
import '../components/obstacle_component/load_obstacle_components.dart';
import '../controllers/serenety_village_audio_controller.dart';
import '../controllers/serenety_village_state_controller.dart';
import '../tiled_maps/serene_village_tiled_map/serene_village_tiled_map.dart';

const String kOverlayController = 'ButtonController';

class SerenetyVillageGame extends FlameGame with TapDetector, HasCollisionDetection {
  final SerenetyVillageStateController stateController = SerenetyVillageStateController();
  final SerenetyVillageAudioController audioController = SerenetyVillageAudioController();

  late GeorgeComponent _george;
  static const double _tileSize = SereneVillageTiledMap.tileSize;
  int georgeDirection = kIdleIndex;
  int collisionDirection = kNoCollision;
  late double mapWidth;
  late double mapHeight;
  int sceneNumber = 1;
  bool isShowDialog = true;
  String dialogMessage = 'My first message';
  late TiledComponent homeMap;
  List<Component> components = [];

  late final Rect worldBounds;

  final Vector2 _georgeStartPosition = Vector2(250, 540);
  final Vector2 _ningaBoyStartPosition = Vector2(700, 440);

  void showMessage(String message) {
    dialogMessage = message;
    isShowDialog = true;
    refreshWidget();
  }

  @override
  Future<void> onLoad() async {
    audioController.initialize();
    await audioController.playBackground();
    await audioController.pauseBackground();

    homeMap = await TiledComponent.load(
      SereneVillageTiledMap.sereneVillageTiledMapPath,
      Vector2.all(_tileSize),
    );

    final TiledMap tiledMap = homeMap.tileMap.map;
    mapWidth = tiledMap.width * _tileSize;
    mapHeight = tiledMap.height * _tileSize;
    worldBounds = Rect.fromLTRB(kStartXPosition, kStartYPosition, mapWidth, mapHeight);

    await add(homeMap);
    await loadFoodComponents(homeMap, this);
    await loadFriendComponents(homeMap, this);
    await loadObstacleComponents(homeMap: homeMap, game: this);
    await loadBeachComponents(homeMap: homeMap, game: this);

    components.forEach((component) async {
      await add(component);
    });

    final NinjaBoyComponent ninjaBoy = NinjaBoyComponent()..position = _ningaBoyStartPosition;
    await add(ninjaBoy);
    _george = GeorgeComponent()..position = _georgeStartPosition;
    await add(_george);

    camera.followComponent(_george, worldBounds: worldBounds);
    overlays.add(kOverlayController);
    await super.onLoad();
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
    remove(homeMap);
    removeAll(components);
    components.clear();
    isShowDialog = false;
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
