import 'package:flame/game.dart';
import 'package:flame/input.dart';

import './components/player.dart';
import './components/enemy_creator.dart';

class SpaceShooterGame extends FlameGame with PanDetector, HasCollidables {
  late PlayerComponent player;
  int score = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(player = PlayerComponent());
    add(EnemyCreator());
  }

  @override
  void onPanStart(info) {
    player.beginFire();
  }

  @override
  void onPanEnd(info) {
    player.stopFire();
  }

  @override
  void onPanCancel() {
    player.stopFire();
  }

  @override
  void onPanUpdate(info) {
    player.move(info.delta.game.x, info.delta.game.y);
  }

  void increaseScore() {
    score++;
  }

  void playerTakeHit() {
    player.takeHit();
    score = 0;
  }
}
