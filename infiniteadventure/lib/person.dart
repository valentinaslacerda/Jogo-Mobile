import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:infiniteadventure/main.dart';

class EmberPlayer extends SpriteAnimationComponent
    with TapCallbacks, CollisionCallbacks {
  late ShapeHitbox hitbox;
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
    hitbox = RectangleHitbox()
      ..paint = debugPaint
      ..renderShape = true;
    add(hitbox);
    animation = SpriteAnimation.fromFrameData(
      await Flame.images.load('player.png'),
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2.all(24),
        stepTime: 0.24,
      ),
    );

    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is SpriteAnimationComponent) {
      hitbox.renderShape = false;
    }
  }

  @override
  void update(double dt) {
    position += velocity * dt;
    super.update(dt);
  }

  @override
  void onTapUp([TapUpEvent? event]) => _onTap?.call(this);
}
