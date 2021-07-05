import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_string/random_string.dart';

import 'gameOverTextIndexes.dart';

enum SnakeDirection { DOWN, UP, LEFT, RIGHT }
enum KeyboardType { physicalKey, isKeyPressed, logicalKey }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _numbersOfTotalSquares = 900;
  int _foodIndex;
  int _speed = 250;

  List<int> _snakePositionIndexes = [];
  List<int> _barrierPositionIndexes = [];

  SnakeDirection _currentSnakeDirection;

  KeyboardType _keyboardType = KeyboardType.isKeyPressed;

  FocusNode focusNode = FocusNode();

  Timer _timer;

  bool _snakeIsRed = false;
  bool _gameOver = false;
  bool _gameStarted = false;

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
    _foodIndex = null;
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
    _barrierPositionIndexes.add(_barrierIndex);
    if (_snakePositionIndexes.contains(_barrierIndex)) {
      _createRandomBarrier();
    }
  }

  void _movement() {
    _timer = Timer.periodic(Duration(milliseconds: 300), (Timer timer) async {
      switch (_currentSnakeDirection) {
        case SnakeDirection.DOWN:
          if (_snakePositionIndexes.last > 870) {
            _snakePositionIndexes.add(_snakePositionIndexes.last + 30 - 900);
          } else {
            _snakePositionIndexes.add(_snakePositionIndexes.last + 30);
          }
          break;

        case SnakeDirection.UP:
          if (_snakePositionIndexes.last < 30) {
            _snakePositionIndexes.add(_snakePositionIndexes.last - 30 + 900);
          } else {
            _snakePositionIndexes.add(_snakePositionIndexes.last - 30);
          }
          break;

        case SnakeDirection.LEFT:
          if (_snakePositionIndexes.last % 30 == 0) {
            _snakePositionIndexes.add(_snakePositionIndexes.last - 1 + 30);
          } else {
            _snakePositionIndexes.add(_snakePositionIndexes.last - 1);
          }
          break;

        case SnakeDirection.RIGHT:
          if ((_snakePositionIndexes.last + 1) % 30 == 0) {
            _snakePositionIndexes.add(_snakePositionIndexes.last + 1 - 30);
          } else {
            _snakePositionIndexes.add(_snakePositionIndexes.last + 1);
          }
          break;
      }
      if (_isFoodEaten()) {
        _createRandomFood();
        _createRandomBarrier();
        _speed--;
        _timer.cancel();
        _movement();
      } else {
        _snakePositionIndexes.removeAt(0);
      }
      if (_isGameOver()) {
        _timer.cancel();
        _snakeIsRed = true;
        int _length = _snakePositionIndexes.length;
        int _speed = (2000 / _length).round();
        for (var i = 0; i < _length; i++) {
          await Future.delayed(Duration(milliseconds: _speed));
          _snakePositionIndexes.removeAt(0);
          setState(() {});
        }
        _gameOver = true;
      }
      setState(() {});
    });
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

  @override
  void initState() {
    super.initState();
    _createSnakeAtRandomPosition();
    _createRandomFood();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
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
                    ElevatedButton(
                      onPressed: () {
                        if (_keyboardType == KeyboardType.isKeyPressed) {
                          _keyboardType = KeyboardType.logicalKey;
                        } else if (_keyboardType == KeyboardType.logicalKey) {
                          _keyboardType = KeyboardType.physicalKey;
                        } else if (_keyboardType == KeyboardType.physicalKey) {
                          _keyboardType = KeyboardType.isKeyPressed;
                        }
                        setState(() {});
                      },
                      child: Text(_keyboardType.toString()),
                      style: ButtonStyle(),
                    ),
                    Text(
                      'Skor : ${_snakePositionIndexes.length - 4}\nHız : $_speed',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          RawKeyboardListener(
            autofocus: true,
            focusNode: focusNode,
            onKey: (RawKeyEvent event) {
              if (_keyboardType == KeyboardType.isKeyPressed) {
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
              } else if (_keyboardType == KeyboardType.logicalKey) {
                if (event.data.logicalKey == LogicalKeyboardKey.arrowDown) {
                  if (_currentSnakeDirection != SnakeDirection.UP) {
                    _currentSnakeDirection = SnakeDirection.DOWN;
                  }
                }
                if (event.data.logicalKey == LogicalKeyboardKey.arrowLeft) {
                  if (_currentSnakeDirection != SnakeDirection.RIGHT) {
                    _currentSnakeDirection = SnakeDirection.LEFT;
                  }
                }
                if (event.data.logicalKey == LogicalKeyboardKey.arrowRight) {
                  if (_currentSnakeDirection != SnakeDirection.LEFT) {
                    _currentSnakeDirection = SnakeDirection.RIGHT;
                  }
                }
                if (event.data.logicalKey == LogicalKeyboardKey.arrowUp) {
                  if (_currentSnakeDirection != SnakeDirection.DOWN) {
                    _currentSnakeDirection = SnakeDirection.UP;
                  }
                }
                if (event.data.logicalKey == LogicalKeyboardKey.keyS) {
                  if (_currentSnakeDirection != SnakeDirection.UP) {
                    _currentSnakeDirection = SnakeDirection.DOWN;
                  }
                }
                if (event.data.logicalKey == LogicalKeyboardKey.keyA) {
                  if (_currentSnakeDirection != SnakeDirection.RIGHT) {
                    _currentSnakeDirection = SnakeDirection.LEFT;
                  }
                }
                if (event.data.logicalKey == LogicalKeyboardKey.keyD) {
                  if (_currentSnakeDirection != SnakeDirection.LEFT) {
                    _currentSnakeDirection = SnakeDirection.RIGHT;
                  }
                }
                if (event.data.logicalKey == LogicalKeyboardKey.keyW) {
                  if (_currentSnakeDirection != SnakeDirection.DOWN) {
                    _currentSnakeDirection = SnakeDirection.UP;
                  }
                }
              } else if (_keyboardType == KeyboardType.physicalKey) {
                if (event.data.physicalKey == PhysicalKeyboardKey.keyS) {
                  if (_currentSnakeDirection != SnakeDirection.UP) {
                    _currentSnakeDirection = SnakeDirection.DOWN;
                  }
                }
                if (event.data.physicalKey == PhysicalKeyboardKey.keyA) {
                  if (_currentSnakeDirection != SnakeDirection.RIGHT) {
                    _currentSnakeDirection = SnakeDirection.LEFT;
                  }
                }
                if (event.data.physicalKey == PhysicalKeyboardKey.keyD) {
                  if (_currentSnakeDirection != SnakeDirection.LEFT) {
                    _currentSnakeDirection = SnakeDirection.RIGHT;
                  }
                }
                if (event.data.physicalKey == PhysicalKeyboardKey.keyW) {
                  if (_currentSnakeDirection != SnakeDirection.DOWN) {
                    _currentSnakeDirection = SnakeDirection.UP;
                  }
                }

                if (event.data.physicalKey == PhysicalKeyboardKey.arrowDown) {
                  if (_currentSnakeDirection != SnakeDirection.UP) {
                    _currentSnakeDirection = SnakeDirection.DOWN;
                  }
                }
                if (event.data.physicalKey == PhysicalKeyboardKey.arrowLeft) {
                  if (_currentSnakeDirection != SnakeDirection.RIGHT) {
                    _currentSnakeDirection = SnakeDirection.LEFT;
                  }
                }
                if (event.data.physicalKey == PhysicalKeyboardKey.arrowRight) {
                  if (_currentSnakeDirection != SnakeDirection.LEFT) {
                    _currentSnakeDirection = SnakeDirection.RIGHT;
                  }
                }
                if (event.data.physicalKey == PhysicalKeyboardKey.arrowUp) {
                  if (_currentSnakeDirection != SnakeDirection.DOWN) {
                    _currentSnakeDirection = SnakeDirection.UP;
                  }
                }
              }
            },
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (_currentSnakeDirection != SnakeDirection.UP && details.delta.dy > 0) {
                  _currentSnakeDirection = SnakeDirection.DOWN;
                } else if (_currentSnakeDirection != SnakeDirection.DOWN && details.delta.dy < 0) {
                  _currentSnakeDirection = SnakeDirection.UP;
                }
              },
              onHorizontalDragUpdate: (details) {
                if (_currentSnakeDirection != SnakeDirection.LEFT && details.delta.dx > 0) {
                  _currentSnakeDirection = SnakeDirection.RIGHT;
                } else if (_currentSnakeDirection != SnakeDirection.RIGHT && details.delta.dx < 0) {
                  _currentSnakeDirection = SnakeDirection.LEFT;
                }
              },
              child: Container(
                height: 600,
                width: 600,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _numbersOfTotalSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 30),
                  itemBuilder: (context, index) {
                    if (_gameOver) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(
                              color: gameOverTextIndexes.contains(index) ? Colors.white : Colors.grey[900], borderRadius: BorderRadius.circular(4)),
                        ),
                      );
                    }
                    if (index == _foodIndex) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(4)),
                        ),
                      );
                    }
                    if (_barrierPositionIndexes.contains(index)) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(4)),
                        ),
                      );
                    }
                    if (_snakePositionIndexes.contains(index)) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(
                              color: _snakeIsRed
                                  ? Colors.red
                                  : index == _snakePositionIndexes.last
                                      ? Colors.pink
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      );
                    } else {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(4)),
                        ),
                      );
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _timer.cancel();
                      },
                      child: Text('Pause'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
