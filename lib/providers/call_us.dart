import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:maak/models/call_us.dart';
import 'package:http/http.dart' as http;
class CallUsProvider with ChangeNotifier {



   Future<void> sendCall(CallUs callUs) async {
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
   }
}