import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:maak/models/call_us.dart';
import 'package:http/http.dart' as http;
import 'package:maak/models/profile.dart';
class ProfileProvider with ChangeNotifier {

  Profile _profile = Profile(name: '',  phone: 0, idCard:  '') ;


  Future<void> setProfile(_profile) async {
    print('thanks');
    //   final url = Uri.parse(
    //       '');
    //
    //   try {
    //     final res = await http.post(url,
    //         body: json.encode({
    //         }));
    //
    //     final responseData = json.decode(res.body);
    //     if (responseData['error'] != null) {
    //       throw HttpException(responseData['error']['message']);
    //     }
    //   } catch (e) {
    //     print('error');
    //     throw e;
    //   }
    _profile;
    notifyListeners();
  }


  Future<void> getProfile(String uid) async {
    print('thanks');
    //   final url = Uri.parse(
    //       '');
    //
    //   try {
    //     final res = await http.post(url,
    //         body: json.encode({
    //         }));
    //
    //     final responseData = json.decode(res.body);
    //     if (responseData['error'] != null) {
    //       throw HttpException(responseData['error']['message']);
    //     }
    //   } catch (e) {
    //     print('error');
    //     throw e;
    //   }
    _profile;
    notifyListeners();
  }
}