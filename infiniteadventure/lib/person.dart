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
  double ay = 300;
  
  int score = 0;

  late SpriteSheet normalSheet, jumpSheet;

  late SpriteAnimation normalAnimation, jumpAnimation;


  @override
  void onLoad() async{
    position = gameRef.size / 2;
    size = Vector2(50.0, 50.0);
    anchor = Anchor.center;

    normalSheet = SpriteSheet(
      image: await gameRef.images.load('fall.jpeg'),
      //image: await gameRef.images.load('idle.png'),
      srcSize: Vector2(12.0, 19.0)
    );
    jumpSheet = SpriteSheet(
      image: await gameRef.images.load('jump.jpeg'),
      srcSize: Vector2(22.5, 22)
    );

    normalAnimation = normalSheet.createAnimation(
      //row: 0, stepTime: 0.2, from: 0, to: 0, loop: true
      row: 0, stepTime: 0.2, from: 0, to: 1, loop: true
    );
    jumpAnimation = jumpSheet.createAnimation(
      row: 0, stepTime: 0.2, from: 0, to: 7, loop: false 
    );

    animation = normalAnimation;

    super.onLoad();
  } 

  @override
  void onTapUp(TapUpEvent event) async{
    scale = Vector2(1, 2);
    //animation = jumpAnimation;
    print('tocou no boneco');
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    scale = Vector2(1.5, 1.5);
    animation = normalAnimation;
  }

  void jump(){
    vy = -300;
    animation = jumpAnimation;

    
    
  }

  @override
  void update(double dt) {
    super.update(dt);

    vy += ay * dt;
    if(position.y >= 500){
      ay = 0;
      vy = 0;
    }

    //print(gameRef.size.y);
    print(position.y);

    // if(position.y - 40 >= gameRef.size.y){
    //   ay = 0;
    //   vy = 0;

    //   removeFromParent();
    // }
    position.x += vx * dt;
    position.y += vy * dt;
    
  }



}