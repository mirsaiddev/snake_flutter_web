
import 'package:flutter/material.dart';

class SnakeSquare extends StatelessWidget {
  const SnakeSquare({
    Key key,
    @required List<dynamic> snakePositionIndexes,
    @required this.index,
  })  : _snakePositionIndexes = snakePositionIndexes,
        super(key: key);

  final List<dynamic> _snakePositionIndexes;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(1.5),
        decoration: BoxDecoration(color: index == _snakePositionIndexes.last ? Colors.pink : Colors.white, borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}

class Barrier extends StatelessWidget {
  const Barrier({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(1.5),
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}

class Food extends StatelessWidget {
  const Food({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(1.5),
        decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
