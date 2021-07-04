import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_string/random_string.dart';

enum SnakeDirection { DOWN, UP, LEFT, RIGHT }

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

  List<int> _snakePositionIndexes = [];

  SnakeDirection _currentSnakeDirection;

  FocusNode focusNode = FocusNode();

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

  void _movement() {
    Timer.periodic(Duration(milliseconds: 300), (Timer timer) {
      switch (_currentSnakeDirection) {
        case SnakeDirection.DOWN:
          if (_snakePositionIndexes.last > 870) {
            _snakePositionIndexes.add(_snakePositionIndexes.last + 30 - 900);
          } else {
            _snakePositionIndexes.add(_snakePositionIndexes.last + 30);
          }
          _snakePositionIndexes.removeAt(0);
          break;

        case SnakeDirection.UP:
          if (_snakePositionIndexes.last < 30) {
            _snakePositionIndexes.add(_snakePositionIndexes.last - 30 + 900);
          } else {
            _snakePositionIndexes.add(_snakePositionIndexes.last - 30);
          }
          _snakePositionIndexes.removeAt(0);
          break;

        case SnakeDirection.LEFT:
          if (_snakePositionIndexes.last % 30 == 0) {
            _snakePositionIndexes.add(_snakePositionIndexes.last - 1 + 30);
          } else {
            _snakePositionIndexes.add(_snakePositionIndexes.last - 1);
          }
          _snakePositionIndexes.removeAt(0);
          break;

        case SnakeDirection.RIGHT:
          if ((_snakePositionIndexes.last + 1) % 30 == 0) {
            _snakePositionIndexes.add(_snakePositionIndexes.last + 1 - 30);
          } else {
            _snakePositionIndexes.add(_snakePositionIndexes.last + 1);
          }
          _snakePositionIndexes.removeAt(0);
          break;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _createSnakeAtRandomPosition();
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
                  children: [
                    ElevatedButton(
                      onPressed: _movement,
                      child: Text('Start'),
                      style: ButtonStyle(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          RawKeyboardListener(
            autofocus: true,
            focusNode: focusNode,
            onKey: (RawKeyEvent event) {
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
                    if (_snakePositionIndexes.contains(index)) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(
                              color: index == _snakePositionIndexes.last ? Colors.pink : Colors.white, borderRadius: BorderRadius.circular(4)),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
