import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:snake/pages/check_page.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo, textTheme: TextTheme(headline1: TextStyle(color: Colors.white))),
      home: CheckPage(),
    );
  }
}
