import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiled/tiled.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../../../core_ui/screen.dart';
import '../components/beach_component/beach_component.dart';
import '../components/beach_component/load_beach_components.dart';
import '../components/food_component/load_food_components.dart';
import '../components/friend_component/load_friend_components.dart';
import '../components/george_component/george_component.dart';
import '../components/leaf_component/leaf1_component.dart';
import '../components/leaf_component/leaf2_component.dart';
import '../components/ninja_boy/ninja_boy_component.dart';
import '../components/obstacle_component/load_obstacle_components.dart';
import '../controllers/serenety_village_audio_controller.dart';
import '../controllers/serenety_village_state_controller.dart';
import '../tiled_maps/serene_village_tiled_map/serene_village_tiled_map.dart';

const String kOverlayController = 'ButtonController';

class SerenetyVillageGame extends FlameGame with TapDetector, HasCollisionDetection {
  final SerenetyVillageStateController stateController = SerenetyVillageStateController();
  final SerenetyVillageAudioController audioController = SerenetyVillageAudioController();

  static const double _tileSize = SereneVillageTiledMap.tileSize;
  int georgeDirection = kDirectionIdleIndex;
  int collisionDirection = kNoCollision;
  late final Size mapSize;
  bool isShowDialog = true;
  String dialogMessage = 'My first message';
  late TiledComponent homeMap;
  List<Component> components = [];

  late final Rect worldBounds;

  final Vector2 _georgeInitialPosition = Vector2(250, 540);
  final Vector2 _ningaBoyInitialPosition = Vector2(700, 440);
  final Vector2 _leaf1InitialPosition = Vector2(510, 390);
  final Vector2 _leaf2InitialPosition = Vector2(760, 620);

  late final Rect centralBeachSelection;

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
    mapSize = Size(tiledMap.width * _tileSize, tiledMap.height * _tileSize);
    await add(homeMap);

    await loadFoodComponents(homeMap, this);
    await loadFriendComponents(homeMap, this);
    await loadObstacleComponents(homeMap: homeMap, game: this);

    final List<BeachComponent> beachComponents = await loadBeachComponents(homeMap: homeMap);
    beachComponents.forEach((BeachComponent component) async {
      if (component.objectName == SereneVillageTiledMap.centralBeachSelection) {
        centralBeachSelection = Rect.fromLTWH(
          component.position[0],
          component.position[1],
          component.size[0],
          component.size[1],
        );
        await add(component);
      }
    });

    components.forEach((component) async {
      await add(component);
    });

    final GeorgeComponent george = GeorgeComponent()..position = _georgeInitialPosition;
    final NinjaBoyComponent ninjaBoy = NinjaBoyComponent()..position = _ningaBoyInitialPosition;
    final Leaf1Component leaf1 = Leaf1Component()..position = _leaf1InitialPosition;
    final Leaf2Component leaf2 = Leaf2Component()..position = _leaf2InitialPosition;
    await add(ninjaBoy);
    await add(george);
    await add(leaf1);
    await add(leaf2);
    overlays.add(kOverlayController);

    worldBounds = Rect.fromLTRB(kStartXPosition, kStartYPosition, mapSize.width, mapSize.height);
    camera.followComponent(george, worldBounds: worldBounds);
    await super.onLoad();
  }

  @override
  void onTapUp(TapUpInfo info) {
    const int maxDirections = 4;
    if (georgeDirection >= maxDirections) {
      georgeDirection = kDirectionIdleIndex;
    } else {
      georgeDirection++;
    }
  }
}
