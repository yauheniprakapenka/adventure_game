import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import '../characters/friend_component.dart';
import '../george_game.dart';

Future<void> loadFriends(TiledComponent homeMap, GeorgeGame game) async {
  const String friendsTiledObjectGroupName = 'friends';
  final ObjectGroup? friendsObjectGroup = homeMap.tileMap.getLayer<ObjectGroup>(
    friendsTiledObjectGroupName,
  );
  for (final friendBox in friendsObjectGroup!.objects) {
    game.maxFriends++;

    final friend = FriendComponent(name: friendBox.name)
      ..position = Vector2(friendBox.x, friendBox.y)
      ..width = friendBox.width
      ..height = friendBox.height;

    game.componentList.add(friend);
  }
}
