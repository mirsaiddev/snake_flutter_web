import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:snake/pages/snake.dart';
import 'package:snake/services/firestore_service.dart';

class NicknamePage extends StatefulWidget {
  const NicknamePage({Key key}) : super(key: key);

  @override
  _NicknamePageState createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  final RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  Future<void> _isimKontrol() async {
    _buttonController.start();
    if (_controller.text == null || _controller.text.characters.length == 0) {
      _buttonController.stop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ad-soyad giriniz',
          ),
        ),
      );
    } else {
      String _state = await FirestoreService().isimIleGiris(_controller.text.trim(), context);
      if (_state == 'success') {
        _buttonController.success();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Snake()), (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Bu kullanıcı adı zaten mevcut',
            ),
          ),
        );
        _buttonController.error();
        _buttonController.reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Skorunuzu sıralama sisteminde görebilmek için lütfen ad-soyadınızı giriniz.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 25),
            Container(
              width: 300,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  controller: _controller,
                  validator: (text) {
                    if (text.characters.length > 17) {
                      return 'Girilen ad-soyad çok uzun';
                    }
                    if (text.characters.length < 3) {
                      return 'Girilen ad-soyad çok kısa';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                    labelText: 'Ad-Soyad Giriniz',
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            RoundedLoadingButton(
                child: Text('Devam', style: TextStyle(color: Colors.white)),
                color: Colors.indigo,
                width: 300,
                controller: _buttonController,
                onPressed: _isimKontrol),
          ],
        ),
      ),
    );
  }
}
