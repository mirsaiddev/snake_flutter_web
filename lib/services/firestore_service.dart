import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreService {
  Future<String> isimIleGiris(String _kaydedilecekIsim, BuildContext _context) async {
    DocumentSnapshot _users = await FirebaseFirestore.instance.collection('users').doc('list').get();
    DocumentReference _usersDocumentReference = FirebaseFirestore.instance.collection('users').doc('list');

    Map<String, dynamic> _data = _users.data() as Map<String, dynamic>;
    List _names = _data['names'];
    bool _check = _names.contains(_kaydedilecekIsim);
    if (!_check) {
      _names.add(_kaydedilecekIsim);
      await _usersDocumentReference.update({'names': _names});
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('name', _kaydedilecekIsim);
      return 'success';
    } else {
      return 'user_exists';
    }
  }

  Future<List> getScoresList() async {
    DocumentSnapshot _scores = await FirebaseFirestore.instance.collection('high-scores').doc('list').get();
    Map<String, dynamic> _data = _scores.data() as Map<String, dynamic>;
    List<dynamic> _scoresList = _data['scores'];
    return _scoresList;
  }

  Future<void> siralamayaGir(int score) async {
    DocumentSnapshot _scores = await FirebaseFirestore.instance.collection('high-scores').doc('list').get();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _isim = _prefs.getString('name');

    Map<String, dynamic> _data = _scores.data() as Map<String, dynamic>;

    List<dynamic> _scoresList = _data['scores'];

    if (_scoresList.isEmpty || _scoresList.length == 0 || _scoresList == null) {
      _scoresList = [];
      _scoresList.add({'name': _isim, 'score': score});
      FirebaseFirestore.instance.collection('high-scores').doc('list').update({'siralama': _scoresList});
    } else {
      _scoresList.add({'name': _isim, 'score': score});
      _scoresList.sort((a, b) {
        var elementa = a['score'];

        var elementb = b['score'];

        return elementb.compareTo(elementa);
      });
      if (_scoresList.length > 10) {
        int _deger = _scoresList.length - 10;
        for (var i = 0; i < _deger; i++) {
          _scoresList.removeLast();
        }
      }
      FirebaseFirestore.instance.collection('high-scores').doc('list').update({'scores': _scoresList});
    }
  }
}
