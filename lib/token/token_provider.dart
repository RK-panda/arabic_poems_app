import 'package:flutter/material.dart';
import 'package:poems_arabic/token/token_class.dart';

// class TokenProvider with ChangeNotifier {
//   late Token tokenn;

//   Token get token => tokenn;

//   set token(Token token) {
//     tokenn = token;
//     notifyListeners();
//   }
// }

class TokenProvider with ChangeNotifier {
  Token? _token;

  Token? get token => _token;

  set token(Token? token) {
    _token = token;
    notifyListeners();
  }

  void logOut() {
    _token = null;
    notifyListeners();
  }
}
