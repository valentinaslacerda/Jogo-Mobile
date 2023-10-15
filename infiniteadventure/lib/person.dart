import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:infiniteadventure/main.dart';

// class Person extends SpriteAnimationComponent with TapCallbacks, HasGameRef<EndlessAdventure>, HasCollisionDetection, CollisionCallbacks{
//   double vx = 0;
//   double vy = 0;
//   double ax = 0;
//   double ay = 300;
//   ShapeHitbox hb = RectangleHitbox();
//   int score = 0;

//   late SpriteSheet runSheet, jumpSheet;

//   late SpriteAnimation runAnimation, jumpAnimation;

//   @override
//   void onLoad() async{
//     add(hb);

//     position = gameRef.size / 2;
//     size = Vector2(50.0, 50.0);
//     anchor = Anchor.center;

//     runSheet = SpriteSheet(
//       image: await gameRef.images.load('run.jpeg'),
//       srcSize: Vector2(21.25, 19.0)
//     );
//     jumpSheet = SpriteSheet(
//       image: await gameRef.images.load('jump.jpeg'),
//       srcSize: Vector2(22.5, 22)
//     );

//     runAnimation = runSheet.createAnimation(
//       row: 0, stepTime: 0.2, from: 0, to: 4, loop: true
//     );
//     jumpAnimation = jumpSheet.createAnimation(
//       row: 0, stepTime: 0.2, from: 0, to: 7, loop: false
//     );

//     animation = runAnimation;

//     super.onLoad();
//   }

//   @override
//   void onTapUp(TapUpEvent event) async{
//     //scale = Vector2(1, 2);
//     print('tocou no boneco');
//   }

//   @override
//   void onTapDown(TapDownEvent event) {
//     super.onTapDown(event);
//     //scale = Vector2(1.5, 1.5);
//     animation = runAnimation;
//   }

//   void jump(){
//     vy = -300;
//     animation = jumpAnimation;

//   }

//   @override
//   void update(double dt) {
//     super.update(dt);

//     vy += ay * dt;

//     if(position.y - 40 >= gameRef.size.y){
//       ay = 0;
//       vy = 0;

//       removeFromParent();
//     }
//     position.x += vx * dt;
//     position.y += vy * dt;

//     if(hb.isColliding){
//       print("AQUIIIIIIIIIIII");
//     }

//   }

//   @override
//   void onCollision(Set<Vector2> intersectionPoints, PositionComponent other){
//     super.onCollision(intersectionPoints, other);
//     print("Passou dentro");
//     animation = jumpAnimation;
//   }

// }

class EmberPlayer extends SpriteAnimationComponent with TapCallbacks {
  EmberPlayer({
    required super.position,
    required super.size,
    void Function(EmberPlayer player)? onTap,
  })  : _onTap = onTap,
        super();

  Vector2 velocity = Vector2(0, 0);
  final void Function(EmberPlayer player)? _onTap;

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      await Flame.images.load('run.jpeg'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    position += velocity * dt;
    super.update(dt);
  }

  @override
  void onTapUp([TapUpEvent? event]) => _onTap?.call(this);
}
