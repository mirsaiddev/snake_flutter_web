import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:snake/pages/snake.dart';

class GameController extends GetxController {
  var snakePositionIndexes = [].obs;
  SnakeDirection currentSnakeDirection;

  @override
  void onInit() {
    super.onInit();
    _createSnakeAtRandomPosition();
  }

  void _createSnakeAtRandomPosition() {
    int _randomDirection = randomBetween(0, 3);

    currentSnakeDirection = SnakeDirection.values[_randomDirection];

    snakePositionIndexes.value = [];

    switch (currentSnakeDirection) {
      case SnakeDirection.DOWN:
        int _verticalPosition = randomBetween(7, 15);
        int _horizontalPosition = randomBetween(4, 27);
        int _randomForFirstSquareOfSnake = _verticalPosition * 30 + _horizontalPosition;

        for (var i = 0; i < 4; i++) {
          snakePositionIndexes.add(_randomForFirstSquareOfSnake - i * 30);
        }

        snakePositionIndexes.sort((a, b) => a.compareTo(b));
        break;

      case SnakeDirection.UP:
        int _verticalPosition = randomBetween(15, 23);
        int _horizontalPosition = randomBetween(4, 27);
        int _randomForFirstSquareOfSnake = _verticalPosition * 30 + _horizontalPosition;

        for (var i = 0; i < 4; i++) {
          snakePositionIndexes.add(_randomForFirstSquareOfSnake + i * 30);
        }

        snakePositionIndexes.sort((a, b) => b.compareTo(a));
        break;

      case SnakeDirection.LEFT:
        int _verticalPosition = randomBetween(4, 27);
        int _horizontalPosition = randomBetween(15, 23);
        int _randomForFirstSquareOfSnake = _verticalPosition * 30 + _horizontalPosition;

        for (var i = 0; i < 4; i++) {
          snakePositionIndexes.add(_randomForFirstSquareOfSnake + i);
        }

        snakePositionIndexes.sort((a, b) => b.compareTo(a));
        break;

      case SnakeDirection.RIGHT:
        int _verticalPosition = randomBetween(4, 27);
        int _horizontalPosition = randomBetween(7, 15);
        int _randomForFirstSquareOfSnake = _verticalPosition * 30 + _horizontalPosition;

        for (var i = 0; i < 4; i++) {
          snakePositionIndexes.add(_randomForFirstSquareOfSnake - i);
        }

        snakePositionIndexes.sort((a, b) => a.compareTo(b));
        break;
    }
  }
}
