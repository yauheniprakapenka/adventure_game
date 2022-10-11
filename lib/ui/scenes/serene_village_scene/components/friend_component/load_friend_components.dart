import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import '../../game/serenety_village_game.dart';
import '../../tiled_maps/serene_village_tiled_map/serene_village_tiled_map.dart';
import 'friend_component.dart';

Future<void> loadFriendComponents(TiledComponent homeMap, SerenetyVillageGame game) async {
  final ObjectGroup? friendsObjectGroup = homeMap.tileMap.getLayer<ObjectGroup>(
    SereneVillageTiledMap.friendsGroupName,
  );
  if (friendsObjectGroup != null) {
    for (final object in friendsObjectGroup.objects) {
      game.maxFriends++;
      final FriendComponent friendComponent = FriendComponent(name: object.name)
        ..position = Vector2(object.x, object.y)
        ..width = object.width
        ..height = object.height;
      game.components.add(friendComponent);
    }
  }
}
