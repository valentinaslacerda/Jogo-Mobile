import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:infiniteadventure/main.dart';

class AnimatedEnemy extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  late ShapeHitbox hitbox;

  AnimatedEnemy(Vector2 position, Vector2 size)
      : super(
          position: position,
          size: size,
          animation: null,
        );
  Vector2 velocity = Vector2(-150, 0);

  @override
  FutureOr<void> onLoad() async {
    hitbox = CircleHitbox(radius: size.x / 3)
      ..paint = debugPaint
      ..renderShape = false;

    add(hitbox);
    final image = await Flame.images.load('slime.png');
    final spriteAnimation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: 9,
        textureSize: Vector2.all(80),
        stepTime: 0.24,
      ),
    );

    animation = spriteAnimation;
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is SpriteAnimationComponent) {
      hitbox.renderShape = false;
      EndlessAdventure game = EndlessAdventure();
      (gameRef as EndlessAdventure).isGameOver = true;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (position.x < 0) {
      Random random = Random();
      position.y = random.nextInt(160) + 600;

      position.x = 400;
    }
  }
}
