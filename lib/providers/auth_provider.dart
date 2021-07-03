import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier{
bool _isAuth = false;

bool get isAuth => _isAuth;


  void SetAuth(bool auth){
    _isAuth = auth;
  notifyListeners();

}


}