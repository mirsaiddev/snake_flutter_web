/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:snake/controllers/game_controller.dart';
import 'package:snake/pages/snake.dart';
import 'package:snake/widgets/squares.dart';

enum SnakeDirection { DOWN, UP, LEFT, RIGHT }
enum GestureActionType { HORIZONTAL, VERTICAL }

class SnakeGetx extends StatelessWidget {
  final int _numbersOfTotalSquares = 900;
  final FocusNode _focusNode = FocusNode();

  final _gameController = Get.put(GameController());

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
                        onPressed: () {},
                        child: Text('Start'),
                        style: ButtonStyle(),
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      Text(
                        'Skor : 4\nHız : 4',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            RawKeyboardListener(
              autofocus: true,
              focusNode: _focusNode,
              onKey: (RawKeyEvent event) {},
              child: GestureDetector(
                child: Container(
                  height: 600,
                  width: 600,
                  child: GetBuilder<GameController>(
                    init: GameController(),
                    builder: (value) => GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _numbersOfTotalSquares,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 30),
                      itemBuilder: (context, index) {
                        if (_gameController.snakePositionIndexes.contains(index)) {
                          return SnakeSquare(snakePositionIndexes: _gameController.snakePositionIndexes.toList(), index: index);
                        }
                        return Background();
                      },
                    ),
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
                        onPressed: () {},
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
        ));
  }
}
*/