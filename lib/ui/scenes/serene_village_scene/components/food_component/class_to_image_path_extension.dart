import '../../design/serenety_village_images.dart';
import '../../tiled_maps/serene_village_tiled_map/serene_village_tiled_map.dart';

extension ClassToImagePathExtension on String {
  String classToImagePath() {
    if (this == SereneVillageTiledMap.applePieSelectionClass) {
      return SerenetyVillageImages.applePie;
    } else if (this == SereneVillageTiledMap.chokoPieSelectionClass) {
      return SerenetyVillageImages.chokoPie;
    } else {
      return '';
    }
  }
}
