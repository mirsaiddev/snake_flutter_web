import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(1.5),
        decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
