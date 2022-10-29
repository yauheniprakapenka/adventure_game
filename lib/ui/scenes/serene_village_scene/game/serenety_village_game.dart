import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:tiled/tiled.dart';

import '../../../../core_ui/movement_state.dart';
import '../../../../core_ui/screen.dart';
import '../components/beach_component/beach_component.dart';
import '../components/beach_component/load_beach_components.dart';
import '../components/bear_component/bear_component.dart';
import '../components/cat_component/cat_component.dart';
import '../components/dialog_component/dialog_component.dart';
import '../components/food_component/load_food_components.dart';
import '../components/friend_component/load_friend_components.dart';
import '../components/george_component/george_component.dart';
import '../components/leaf_component/leaf1_component.dart';
import '../components/leaf_component/leaf2_component.dart';
import '../components/ninja_boy/ninja_boy_component.dart';
import '../components/obstacle_component/load_obstacle_components.dart';
import '../controllers/audio_controller.dart';
import '../controllers/quest_controller.dart';
import '../controllers/state_controller.dart';
import '../tiled_maps/serene_village_tiled_map/serene_village_tiled_map.dart';

const String kOverlayController = 'ButtonController';

class SerenetyVillageGame extends FlameGame with HasCollisionDetection, HasTappables {
  final StateController stateController = StateController();
  final AudioController audioController = AudioController();
  final QuestController questController = QuestController();

  static const double _tileSize = SereneVillageTiledMap.tileSize;

  int georgeMovementState = kIdle;
  int collisionDirection = kNoCollision;
  bool isShowDialog = true;
  String dialogMessage = 'My first message';

  List<Component> components = [];

  late final Size mapSize;
  late final Rect worldBounds;
  late final Rect centralBeachSelection;

  late final NinjaBoyComponent ninjaBoy;

  final Vector2 _georgeInitialPosition = Vector2(400, 250);
  final Vector2 _ningaBoyInitialPosition = Vector2(700, 440);
  final Vector2 _poisonPieInitialPosition = Vector2(700, 240);
  final Vector2 _leaf1InitialPosition = Vector2(510, 390);
  final Vector2 _leaf2InitialPosition = Vector2(760, 620);
  final Vector2 _catInitialPosition = Vector2(1020, 544);

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    const int maxDirections = 4;
    if (georgeMovementState >= maxDirections) {
      georgeMovementState = kIdle;
    } else {
      georgeMovementState++;
    }
    super.onTapDown(pointerId, info);
  }

  @override
  Future<void> onLoad() async {
    audioController.initialize();
    await audioController.playBackground();
    await audioController.pauseBackground();

    final TiledComponent sereneVillageMap = await TiledComponent.load(
      SereneVillageTiledMap.sereneVillageTiledMapPath,
      Vector2.all(_tileSize),
    );
    final TiledMap tiledMap = sereneVillageMap.tileMap.map;
    mapSize = Size(tiledMap.width * _tileSize, tiledMap.height * _tileSize);
    await add(sereneVillageMap);

    await loadFoodComponents(sereneVillageMap, this);
    await loadFriendComponents(sereneVillageMap, this);
    await loadObstacleComponents(homeMap: sereneVillageMap, game: this);

    final List<BeachComponent> beachComponents = await loadBeachComponents(map: sereneVillageMap);
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
    ninjaBoy = NinjaBoyComponent()..position = _ningaBoyInitialPosition;
    final Leaf1Component leaf1 = Leaf1Component()..position = _leaf1InitialPosition;
    final Leaf2Component leaf2 = Leaf2Component()..position = _leaf2InitialPosition;
    final CatComponent cat = CatComponent()..position = _catInitialPosition;
    final BearComponent grape = BearComponent()..position = _poisonPieInitialPosition;

    await add(ninjaBoy);
    await add(george);
    await add(leaf1);
    await add(leaf2);
    await add(cat);
    await add(grape);
    overlays.add(kOverlayController);

    worldBounds = Rect.fromLTRB(kStartXPosition, kStartYPosition, mapSize.width, mapSize.height);
    camera.followComponent(george, worldBounds: worldBounds);

    await super.onLoad();
  }

  void showMessage(String message) {
    dialogMessage = message;
    isShowDialog = true;
    refreshWidget();
  }

  Future<void> showOtherMessage(String message, Vector2 position) async {
    final DialogComponent _dialogComponent = DialogComponent(text: message, position: position)
      ..position =position;
    await add(_dialogComponent);
  }

}
