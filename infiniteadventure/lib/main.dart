import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/widgets.dart';
import 'package:infiniteadventure/person.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(GameWidget(
    game: EndlessAdventure(),
    loadingBuilder: (context) {
      return Text("carregando");
    
    } 
      
  ));
}


class EndlessAdventure extends FlameGame with TapCallbacks{

  late Person _person;
  //late Platform _platform;

  @override
  FutureOr<void> onLoad() async{
    // TODO: implement onLoad

    final images = [
      loadParallaxImage("bg2.jpg", repeat: ImageRepeat.repeat),
      //loadParallaxImage("")


    ];

    final layers = images.map((image) async => ParallaxLayer(
      await image,
      velocityMultiplier: Vector2((images.indexOf(image) + 1) * 2.0, 0),

    ));
    final parallaxComponent = ParallaxComponent(
      parallax: Parallax(
        await Future.wait(layers),
        baseVelocity: Vector2(50,0)
      )
    );
    //ADD
    add(parallaxComponent);
    // tc = TextComponent(
    //   text: 
    // )
    _person = Person();
    add(_person);

    return super.onLoad();

  }

  @override
  void update(double dt){
    super.update(dt);

    
  }

  @override
  void onTapUp(TapUpEvent event) {
    print('tocou no jogo');
    _person.jump();
  }

}