import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import '../game.dart';
import 'enemy.dart';

class BulletComponent extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame>, Hitbox, Collidable {
  static const bulletSpeed = -500;

  bool destroyed = false;

  double xDirection;

  BulletComponent(double x, double y, {this.xDirection = 0.0})
      : super(
          position: Vector2(x, y),
          size: Vector2(10, 20),
        ) {
    collidableType = CollidableType.passive;
    addHitbox(HitboxRectangle());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await gameRef.loadSpriteAnimation(
      'bullet.png',
      SpriteAnimationData.sequenced(
        stepTime: 0.2,
        amount: 4,
        textureSize: Vector2(8, 16),
      ),
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is EnemyComponent) {
      destroyed = true;
      other.takeHit();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    y += bulletSpeed * dt;
    if (xDirection != 0) {
      x += bulletSpeed * dt * xDirection;
    }

    shouldRemove = destroyed || toRect().bottom <= 0;
  }
}
