import 'package:flutter/material.dart';


class Siralama extends StatelessWidget {
  const Siralama({
    Key key,
    @required List scoresList,
  })  : _scoresList = scoresList,
        super(key: key);

  final List _scoresList;

  @override
  Widget build(BuildContext context) { 
    return Column(
      children: [
        Spacer(),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Sıra', style: TextStyle(color: Colors.white,fontSize: 16)),
                SizedBox(height: 6),
                Text('1', style: TextStyle(color: Colors.white)),
                Text('2', style: TextStyle(color: Colors.white)),
                Text('3', style: TextStyle(color: Colors.white)),
                Text('4', style: TextStyle(color: Colors.white)),
                Text('5', style: TextStyle(color: Colors.white)),
                Text('6', style: TextStyle(color: Colors.white)),
                Text('7', style: TextStyle(color: Colors.white)),
                Text('8', style: TextStyle(color: Colors.white)),
                Text('9', style: TextStyle(color: Colors.white)),
                Text('10', style: TextStyle(color: Colors.white)),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Adı', style: TextStyle(color: Colors.white,fontSize: 16)),
                SizedBox(height: 6),
                Text('${_scoresList[0]['name']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[1]['name']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[2]['name']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[3]['name']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[4]['name']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[5]['name']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[6]['name']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[7]['name']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[8]['name']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[9]['name']}', style: TextStyle(color: Colors.white)),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Skor', style: TextStyle(color: Colors.white,fontSize: 16)),
                SizedBox(height: 10),
                 Text('${_scoresList[0]['score']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[1]['score']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[2]['score']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[3]['score']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[4]['score']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[5]['score']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[6]['score']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[7]['score']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[8]['score']}', style: TextStyle(color: Colors.white)),
                Text('${_scoresList[9]['score']}', style: TextStyle(color: Colors.white)),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ],
        )

            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ListView.builder(
                controller: _controller,
                itemBuilder: (context, index) {
                  var _score = _scoresList[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${index + 1}', style: TextStyle(color: Colors.white)),
                      Spacer(),
                      Text('${_score['name']}', style: TextStyle(color: Colors.white)),
                      Spacer(),
                      Text(_score['score'].toString(), style: TextStyle(color: Colors.white)),
                    ],
                  );
                },
                itemCount: _scoresList.length,
              ),
            ),*/
            ),
        Spacer(),
      ],
    );
  }
}