import 'package:flame/components.dart';
import 'package:infiniteadventure/main.dart';

class Background extends SpriteComponent with HasGameRef<EndlessAdventure> {
  @override
  onLoad() async {
    // TODO: implement onLoad
    super.onLoad();

    sprite = await gameRef.loadSprite("bg2.jpeg");
    size = gameRef.size;
  }
}
