import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:infiniteadventure/main.dart';

class Person extends SpriteAnimationComponent with TapCallbacks, HasGameRef<EndlessAdventure>, HasCollisionDetection, CollisionCallbacks{
  double vx = 0;
  double vy = 0;
  double ax = 0;
  double ay = 600;

  int score = 0;

  late SpriteSheet normalSheet, jumpSheet;

  late SpriteAnimation normalAnimation, jumpAnimation;


  @override
  void onLoad() async{
    position = gameRef.size / 2;
    size = Vector2(64.0, 64.0);
    anchor = Anchor.center;

    normalSheet = SpriteSheet(
      image: await gameRef.images.load('fall.jpeg'),
      srcSize: Vector2.all(32)
    );
    jumpSheet = SpriteSheet(
      image: await gameRef.images.load('jump.jpeg'),
      srcSize: Vector2.all(32.0)
    );

    normalAnimation = normalSheet.createAnimation(
      row: 0, stepTime: 0.2, from: 0, to: 0, loop: true 
    );
    jumpAnimation = jumpSheet.createAnimation(row: 0, stepTime: 0.2, from: 0, to: 7, loop: false );

    animation = normalAnimation;

    super.onLoad();
  } 

  @override
  void onTapUp(TapUpEvent event) async{
    scale = Vector2(1, -2);
    animation = jumpAnimation;
    print('tocou no boneco');
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    scale = Vector2(1.5, 1.5);
  }

  void jump(){
    vy = -400;
  }

  @override
  void update(double dt) {
    super.update(dt);

    vy += ay * dt;

    if(position.y - 40 >= gameRef.size.y){
      ay = 0;
      vy = 0;

      removeFromParent();
    }
    position.x += vx * dt;
    position.y += vy * dt;
    
  }



}