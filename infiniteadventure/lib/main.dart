import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/widgets.dart';
import 'package:infiniteadventure/animateEnemy.dart';
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

class EndlessAdventure extends FlameGame
    with TapCallbacks, HasCollisionDetection {
  //late Person _person;
  final List<AnimatedEnemy> enemies = [];
  bool isGameOver = false;
  double score = 1;
  int velocityScore = 2;
  late TextComponent textScore;
  final scoreStyle = TextPaint(
    style: TextStyle(
      fontSize: 32.0,
      color: BasicPalette.white.color,
    ),
  );

  @override
  FutureOr<void> onLoad() async {
    final person = EmberPlayer(
      position: Vector2(100, 620),
      size: Vector2.all(90),
      onTap: (emberPlayer) {
        emberPlayer.add(
          MoveEffect.to(
            Vector2(size.x - 300, (size.y / 2) - 10),
            EffectController(
              duration: 1,
              reverseDuration: 0.5,
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

    add(person);
    Random random = Random();
    final enemy = AnimatedEnemy(Vector2(600, 640), Vector2.all(60));
    enemy.velocity = Vector2(-200, 0);
    enemies.add(enemy);
    add(enemy);
    textScore = TextComponent(
      text: score.floor().toString(),
      textRenderer: scoreStyle,
      anchor: Anchor.topCenter,
      position: Vector2(size.x / 2, 40),
    );
    add(textScore);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!isGameOver) {
      super.update(dt);
      if (score >= 100) {
        for (final enemy in enemies) {
          enemy.position += enemy.velocity * dt;
        }
        textScore.text = "Score: " + score.floor().toString();
        score += velocityScore * dt;
      }
      for (final enemy in enemies) {
        enemy.position += Vector2(-165, 0) * dt;
      }
      textScore.text = "Score: " + score.floor().toString();
      score += 3 * dt;
    } else {
      textScore.text = "Game over: " + score.floor().toString();
      for (final enemy in enemies) {
        enemy.position += Vector2(-250, 0) * dt;
      }

      //isGameOver = false;
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    print('tocou no jogo');
    //_person.jump();
  }
}
