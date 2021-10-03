import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_string/random_string.dart';
import 'package:snake/services/firestore_service.dart';
import 'package:snake/widgets/background.dart';
import 'package:snake/widgets/siralama.dart';
import 'package:snake/widgets/squares.dart';
import 'dart:math';

enum SnakeDirection { DOWN, UP, LEFT, RIGHT }
enum GestureActionType { HORIZONTAL, VERTICAL }

class Snake extends StatefulWidget {
  @override
  _SnakeState createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  int _numbersOfTotalSquares = 900;
  int _foodIndex;
  int _speed = 200;
  int _score = 4;

  List<int> _snakePositionIndexes = [];
  List<int> _barrierPositionIndexes = [];
  List<dynamic> _scoresList = [];

  SnakeDirection _currentSnakeDirection;

  FocusNode _focusNode = FocusNode();

  Timer _timer;

  bool _gameStarted = false;
  bool _scoresListGet = false;

  Future<void> _gameOver() async {
    _timer.cancel();
    int _length = _snakePositionIndexes.length;
    int _speed;
    if (_length < 6) {
      _speed = 100;
    } else if (_length < 10 && 5 < _length) {
      _speed = 50;
    } else if (10 < _length) {
      _speed = 20;
    }
    for (int i = 0; i < _length - 1; i++) {
      await Future.delayed(Duration(milliseconds: _speed));
      _snakePositionIndexes.removeAt(0);
      setState(() {});
    }
    // ignore: unnecessary_statements
    !_scoresListGet ? await _getScoresList() : () {};
    if (_isHighScore()) {
      await _highScore();
    }
    _restart();
  }

  Future<void> _highScore() async {
    await FirestoreService().siralamayaGir(_score);
  }

  Future<void> _getScoresList() async {
    _scoresList = await FirestoreService().getScoresList();
    _scoresListGet = true;
    setState(() {});
  }

  void _startGame() {
    _movement();
    _gameStarted = true;
  }

  void _createSnakeAtRandomPosition() {
    int _randomDirection = randomBetween(0, 3);

    _currentSnakeDirection = SnakeDirection.values[_randomDirection];

    _snakePositionIndexes = [];

    switch (_currentSnakeDirection) {
      case SnakeDirection.DOWN:
        int _verticalPosition = randomBetween(7, 15);
        int _horizontalPosition = randomBetween(4, 27);
        int _randomForFirstSquareOfSnake = _verticalPosition * 30 + _horizontalPosition;

        for (var i = 0; i < 4; i++) {
          _snakePositionIndexes.add(_randomForFirstSquareOfSnake - i * 30);
        }

        _snakePositionIndexes.sort((a, b) => a.compareTo(b));
        break;

      case SnakeDirection.UP:
        int _verticalPosition = randomBetween(15, 23);
        int _horizontalPosition = randomBetween(4, 27);
        int _randomForFirstSquareOfSnake = _verticalPosition * 30 + _horizontalPosition;

        for (var i = 0; i < 4; i++) {
          _snakePositionIndexes.add(_randomForFirstSquareOfSnake + i * 30);
        }

        _snakePositionIndexes.sort((a, b) => b.compareTo(a));
        break;

      case SnakeDirection.LEFT:
        int _verticalPosition = randomBetween(4, 27);
        int _horizontalPosition = randomBetween(15, 23);
        int _randomForFirstSquareOfSnake = _verticalPosition * 30 + _horizontalPosition;

        for (var i = 0; i < 4; i++) {
          _snakePositionIndexes.add(_randomForFirstSquareOfSnake + i);
        }

        _snakePositionIndexes.sort((a, b) => b.compareTo(a));
        break;

      case SnakeDirection.RIGHT:
        int _verticalPosition = randomBetween(4, 27);
        int _horizontalPosition = randomBetween(7, 15);
        int _randomForFirstSquareOfSnake = _verticalPosition * 30 + _horizontalPosition;

        for (var i = 0; i < 4; i++) {
          _snakePositionIndexes.add(_randomForFirstSquareOfSnake - i);
        }

        _snakePositionIndexes.sort((a, b) => a.compareTo(b));
        break;
    }
    setState(() {});
  }

  void _createRandomFood() {
    _foodIndex = 0;
    int _verticalPosition = randomBetween(4, 26);
    int _horizontalPosition = randomBetween(4, 26);

    _foodIndex = _verticalPosition * 30 + _horizontalPosition;
    if (_snakePositionIndexes.contains(_foodIndex)) {
      _createRandomFood();
    }
  }

  void _createRandomBarrier() {
    int _verticalPosition = randomBetween(4, 26);
    int _horizontalPosition = randomBetween(4, 26);
    int _barrierIndex = _verticalPosition * 30 + _horizontalPosition;
    _barrierIndexCheck(_barrierIndex);
    setState(() {});
  }

  void _barrierIndexCheck(int _newBarrierIndex) {
    bool _isOk = true;
    if (_newBarrierIndex == _foodIndex ||
        _snakePositionIndexes.contains(_newBarrierIndex) ||
        _snakePositionIndexes.last == _newBarrierIndex ||
        _barrierPositionIndexes.contains(_newBarrierIndex)) {
      _isOk = false;
    }
    switch (_currentSnakeDirection) {
      case SnakeDirection.DOWN:
        if (_newBarrierIndex == _snakePositionIndexes.last + 30 || _newBarrierIndex == _snakePositionIndexes.last + 60) {
          _isOk = false;
        }
        break;

      case SnakeDirection.UP:
        if (_newBarrierIndex == _snakePositionIndexes.last - 30 || _newBarrierIndex == _snakePositionIndexes.last - 60) {
          _isOk = false;
        }
        break;

      case SnakeDirection.LEFT:
        if (_newBarrierIndex == _snakePositionIndexes.last - 1 || _newBarrierIndex == _snakePositionIndexes.last - 2) {
          _isOk = false;
        }
        break;

      case SnakeDirection.RIGHT:
        if (_newBarrierIndex == _snakePositionIndexes.last + 1 || _newBarrierIndex == _snakePositionIndexes.last + 2) {
          _isOk = false;
        }
        break;
    }

    if (_isOk) {
      _barrierPositionIndexes.add(_newBarrierIndex);
    } else {
      _createRandomBarrier();
    }
  }

  void _movement() {
    _timer = Timer.periodic(Duration(milliseconds: 300), (Timer timer) async {
      switch (_currentSnakeDirection) {
        case SnakeDirection.DOWN:
          if (_snakePositionIndexes.last > 870) {
            _gameOver();
          } else {
            _snakePositionIndexes.add(_snakePositionIndexes.last + 30);
          }
          break;

        case SnakeDirection.UP:
          if (_snakePositionIndexes.last < 30) {
            _gameOver();
          } else {
            _snakePositionIndexes.add(_snakePositionIndexes.last - 30);
          }
          break;

        case SnakeDirection.LEFT:
          if (_snakePositionIndexes.last % 30 == 0) {
            _gameOver();
          } else {
            _snakePositionIndexes.add(_snakePositionIndexes.last - 1);
          }
          break;

        case SnakeDirection.RIGHT:
          if ((_snakePositionIndexes.last + 1) % 30 == 0) {
            _gameOver();
          } else {
            _snakePositionIndexes.add(_snakePositionIndexes.last + 1);
          }
          break;
      }
      if (_isFoodEaten()) {
        _foodIsEaten();
      } else {
        _snakePositionIndexes.removeAt(0);
      }
      if (_isGameOver()) {
        _gameOver();
      }
      setState(() {});
    });
  }

  void _foodIsEaten() {
    _createRandomFood();
    _createRandomBarrier();
    _createRandomBarrier();
    _speed = _speed - 2;
    _score++;
    _timer.cancel();
    _movement();
  }

  void _restart() {
    _speed = 200;
    _snakePositionIndexes = [];
    _barrierPositionIndexes = [];
    _focusNode = FocusNode();
    _gameStarted = false;
    _score = 4;
    _createSnakeAtRandomPosition();
    _createRandomFood();
    _getScoresList();
  }

  void _keyboardActions(RawKeyEvent event) {
    if (event.isKeyPressed(LogicalKeyboardKey.keyS)) {
      if (_currentSnakeDirection != SnakeDirection.UP) {
        _currentSnakeDirection = SnakeDirection.DOWN;
      }
    }
    if (event.isKeyPressed(LogicalKeyboardKey.keyA)) {
      if (_currentSnakeDirection != SnakeDirection.RIGHT) {
        _currentSnakeDirection = SnakeDirection.LEFT;
      }
    }
    if (event.isKeyPressed(LogicalKeyboardKey.keyD)) {
      if (_currentSnakeDirection != SnakeDirection.LEFT) {
        _currentSnakeDirection = SnakeDirection.RIGHT;
      }
    }
    if (event.isKeyPressed(LogicalKeyboardKey.keyW)) {
      if (_currentSnakeDirection != SnakeDirection.DOWN) {
        _currentSnakeDirection = SnakeDirection.UP;
      }
    }

    if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
      if (_currentSnakeDirection != SnakeDirection.UP) {
        _currentSnakeDirection = SnakeDirection.DOWN;
      }
    }
    if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
      if (_currentSnakeDirection != SnakeDirection.RIGHT) {
        _currentSnakeDirection = SnakeDirection.LEFT;
      }
    }
    if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
      if (_currentSnakeDirection != SnakeDirection.LEFT) {
        _currentSnakeDirection = SnakeDirection.RIGHT;
      }
    }
    if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      if (_currentSnakeDirection != SnakeDirection.DOWN) {
        _currentSnakeDirection = SnakeDirection.UP;
      }
    }
  }

  void _gestureActions(DragUpdateDetails details, GestureActionType actionType) {
    switch (actionType) {
      case GestureActionType.HORIZONTAL:
        if (_currentSnakeDirection != SnakeDirection.LEFT && details.delta.dx > 0) {
          _currentSnakeDirection = SnakeDirection.RIGHT;
        } else if (_currentSnakeDirection != SnakeDirection.RIGHT && details.delta.dx < 0) {
          _currentSnakeDirection = SnakeDirection.LEFT;
        }
        break;

      case GestureActionType.VERTICAL:
        if (_currentSnakeDirection != SnakeDirection.UP && details.delta.dy > 0) {
          _currentSnakeDirection = SnakeDirection.DOWN;
        } else if (_currentSnakeDirection != SnakeDirection.DOWN && details.delta.dy < 0) {
          _currentSnakeDirection = SnakeDirection.UP;
        }
        break;
    }
  }

  bool _isFoodEaten() {
    if (_snakePositionIndexes.last == _foodIndex) {
      return true;
    }
    return false;
  }

  bool _isGameOver() {
    if (_snakePositionIndexes.any((element) => _barrierPositionIndexes.contains(element))) {
      return true;
    }
    for (var i = 0; i < _snakePositionIndexes.length; i++) {
      int _count = 0;
      for (var j = 0; j < _snakePositionIndexes.length; j++) {
        if (_snakePositionIndexes[i] == _snakePositionIndexes[j]) {
          _count += 1;
        }
        if (_count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  bool _isHighScore() {
    if (_scoresList != null && _scoresList.length != 0) {
      List<int> _newScores = _scoresList.map((e) => e['score']).toList().cast<int>();
      if (_score > _newScores.reduce(min)) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _createSnakeAtRandomPosition();
    _createRandomFood();
    _getScoresList();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Container(
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _movement();
                        _gameStarted = true;
                      },
                      child: Text('Start'),
                      style: ButtonStyle(),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    Text(
                      'Skor : $_score\nHız : $_speed',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          RawKeyboardListener(
            focusNode: _focusNode,
            onKey: (RawKeyEvent event) {
              if (event != null && !_gameStarted) {
                _startGame();
              }
              _keyboardActions(event);
            },
            child: GestureDetector(
              onTap: () {
                if (!_gameStarted) {
                  _startGame();
                }
              },
              onVerticalDragUpdate: (details) {
                _gestureActions(details, GestureActionType.VERTICAL);
              },
              onHorizontalDragUpdate: (details) {
                _gestureActions(details, GestureActionType.HORIZONTAL);
              },
              child: Container(
                height: 600,
                width: 600,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _numbersOfTotalSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 30),
                  itemBuilder: (context, index) {
                    if (index == _foodIndex) {
                      return Food();
                    }
                    if (_barrierPositionIndexes.contains(index)) {
                      return Barrier();
                    }
                    if (_snakePositionIndexes.contains(index)) {
                      return SnakeSquare(snakePositionIndexes: _snakePositionIndexes, index: index);
                    } else {
                      return Background();
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                height: 600,
                child: _scoresListGet ? Siralama(scoresList: _scoresList) : SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
