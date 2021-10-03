import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snake/pages/nickname_page.dart';
import 'package:snake/pages/snake.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key key}) : super(key: key);

  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  Future<void> _check() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _name = _prefs.getString('name');
    if (_name == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => NicknamePage()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Snake()));
    }
  }

  @override
  void initState() {
    super.initState();
    _check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
