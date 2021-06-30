
import 'package:flutter/foundation.dart';
import 'package:maak/screens/payment/payment_card.dart';

class paymentProvider with ChangeNotifier{
  PaymentCard paymentCard = PaymentCard();



 bool PaymentNow(PaymentCard _paymentCard){
     print('provider ${_paymentCard}');
   return true;
  }
}