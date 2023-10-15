import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/widgets.dart';
import 'package:infiniteadventure/floor.dart';
import 'package:infiniteadventure/person.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(GameWidget(
      game: EndlessAdventure(),
      loadingBuilder: (context) {
        return Text("carregando");
      }));
}

class EndlessAdventure extends FlameGame with TapCallbacks, HasCollisionDetection{
  //late Person _person;
 
  

  @override
  FutureOr<void> onLoad() async {
    final person = EmberPlayer(
      position: Vector2(100, 620),
      //position: Vector2(10, (size.y / 2) - 20),
      size: Vector2.all(40),
      onTap: (emberPlayer) {
        emberPlayer.add(
          MoveEffect.to(
            Vector2(size.x - 40, (size.y / 2) - 20),
            EffectController(
              duration: 5,
              reverseDuration: 5,
              repeatCount: 1,
              curve: Curves.easeOut,
            ),
          ),
        
    );
      },
    );

    final images = [
      loadParallaxImage("bg2.jpeg", repeat: ImageRepeat.repeat),
      
    ];

    final layers = images.map((image) async => ParallaxLayer(
          await image,
          velocityMultiplier: Vector2((images.indexOf(image) + 1) * 2.0, 0),
        ));
    final parallaxComponent = ParallaxComponent(
        parallax:
            Parallax(await Future.wait(layers), baseVelocity: Vector2(50, 0)));
    //ADD
    add(parallaxComponent);
    // tc = TextComponent(
    //   text:
    // )
    // _person = Person();
    // add(_person);
    add(person);
    add(Floor());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onTapUp(TapUpEvent event) {
    print('tocou no jogo');
    //_person.jump();
    
  }

  
}
