import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Floor extends PositionComponent with CollisionCallbacks{
  late ShapeHitbox hitbox;

  Floor()
    :super(
      position: Vector2(200, 620),
      size: Vector2.all(50),
      anchor: Anchor.center
    );

  @override
  FutureOr<void> onLoad() async{
    hitbox = RectangleHitbox()
      ..paint = debugPaint
      ..renderShape = true;
    add(hitbox);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    
    if(other is SpriteAnimationComponent){
     hitbox.renderShape = false;
      print("AQUIII");
    }
  }

 
}