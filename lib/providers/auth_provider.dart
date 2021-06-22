import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier{
bool _isAuth = false;

bool get isAuth => _isAuth;


set isAuth(bool value) {
    _isAuth = value;
  }

  void SetAuth(bool auth){
    isAuth = auth;
  notifyListeners();
}
}