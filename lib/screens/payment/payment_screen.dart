import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/providers/appointmen_provider.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:maak/providers/payment.dart';
import 'package:maak/screens/payment/input_formatters.dart';
import 'package:maak/screens/payment/payment_card.dart';
import 'package:provider/provider.dart';



class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var numberController = new TextEditingController();
  var _paymentCard = PaymentCard();
  var _autoValidateMode = AutovalidateMode.disabled;
  FocusNode? filed1;
  FocusNode? filed2;
  FocusNode? filed3;
  FocusNode? filed4;
  FocusNode? filed5;
  @override
  void initState() {
    // TODO: implement initState
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);
    filed1 = FocusNode();
    filed2 = FocusNode();
    filed3 = FocusNode();
    filed4 = FocusNode();
    filed5 = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    print('ssd');
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    filed1!.dispose();
    filed2!.dispose();
    filed3!.dispose();
    filed4!.dispose();
    filed5!.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  String getCleanedNumber(String text) {
    RegExp regExp = new RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }


  CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(new RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.Master;
    } else if (input.startsWith(new RegExp(r'[4]'))) {
      cardType = CardType.Visa;
    } else if (input
        .startsWith(new RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = CardType.Verve;
    } else if (input.startsWith(new RegExp(r'((34)|(37))'))) {
      cardType = CardType.AmericanExpress;
    } else if (input.startsWith(new RegExp(r'((6[45])|(6011))'))) {
      cardType = CardType.Discover;
    } else if (input
        .startsWith(new RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      cardType = CardType.DinersClub;
    } else if (input.startsWith(new RegExp(r'(352[89]|35[3-8][0-9])'))) {
      cardType = CardType.Jcb;
    } else if (input.length <= 8) {
      cardType = CardType.Others;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }



  void _getCardTypeFrmNumber() {
    String input = getCleanedNumber(numberController.text);
    CardType cardType = getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCard.type = cardType;
    });
  }


  Future<void> _showInSnackBar(String value) async {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(value),
      duration: new Duration(seconds: 3),
    ));
  }
  void _validateInputs() async{
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode =
            AutovalidateMode.always; // Start validating on every change.
      });
      _showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      print(_paymentCard.toString());
    bool isDef =await Provider.of<paymentProvider>(context, listen: false).PaymentNow(_paymentCard);
    if(isDef){
      Provider.of<appointmenProvider>(context,
          listen: false)
          .setAppointment();
    }
    print(isDef);
      // Encrypt and send send payment details to payment gateway
      _showInSnackBar('Thank you for using our service');

    // Utils.NavigatorKey.currentState!.pushNamed('/categoriesScreen');
    }
  }



  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
     String? validateCVV(String? value) {
      if (value == null || value.isEmpty) {

        return "${lan.getTexts('field_is_required')}";
      }

      if (value.length < 3 || value.length > 4) {
        return "CVV is invalid";
      }
      return null;
    }

     String? validateDate(String? value) {
      if (value == null || value.isEmpty) {
        return "${lan.getTexts('field_is_required')}";
      }

      int year;
      int month;
      // The value contains a forward slash if the month and year has been
      // entered.
      if (value.contains(new RegExp(r'(/)'))) {
        var split = value.split(new RegExp(r'(/)'));
        // The value before the slash is the month while the value to right of
        // it is the year.
        month = int.parse(split[0]);
        year = int.parse(split[1]);
      } else {
        // Only the month was entered
        month = int.parse(value.substring(0, (value.length)));
        year = -1; // Lets use an invalid year intentionally
      }

      if ((month < 1) || (month > 12)) {
        // A valid month is between 1 (January) and 12 (December)
        return 'Expiry month is invalid';
      }
      int convertYearTo4Digits(int year) {
        if (year < 100 && year >= 0) {
          var now = DateTime.now();
          String currentYear = now.year.toString();
          String prefix = currentYear.substring(0, currentYear.length - 2);
          year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
        }
        return year;
      }

      var fourDigitsYear = convertYearTo4Digits(year);
      if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
        // We are assuming a valid should be between 1 and 2099.
        // Note that, it's valid doesn't mean that it has not expired.
        return 'Expiry year is invalid';
      }

      bool hasYearPassed(int year) {
        int fourDigitsYear = convertYearTo4Digits(year);
        var now = DateTime.now();
        // The year has passed if the year we are currently is more than card's
        // year
        return fourDigitsYear < now.year;
      }

      bool hasMonthPassed(int year, int month) {
        var now = DateTime.now();
        // The month has passed if:
        // 1. The year is in the past. In that case, we just assume that the month
        // has passed
        // 2. Card's month (plus another month) is more than current month.
        return hasYearPassed(year) ||
            convertYearTo4Digits(year) == now.year && (month < now.month + 1);
      }


      bool isNotExpired(int year, int month) {
        // It has not expired if both the year and date has not passed
        return !hasYearPassed(year) && !hasMonthPassed(year, month);
      }


      bool hasDateExpired(int month, int year) {
        return isNotExpired(year, month);
      }

      if (!hasDateExpired(month, year)) {
        return "Card has expired";
      }
      return null;
    }





     List<int> getExpiryDate(String value) {
      var split = value.split(new RegExp(r'(/)'));
      return [int.parse(split[0]), int.parse(split[1])];
    }






     Widget? getCardIcon(CardType? cardType) {
      String img = "";
      Icon? icon;
      switch (cardType) {
        case CardType.Master:
          img = 'mastercard.png';
          break;
        case CardType.Visa:
          img = 'visa.png';
          break;
        case CardType.Verve:
          img = 'verve.png';
          break;
        case CardType.AmericanExpress:
          img = 'american_express.png';
          break;
        case CardType.Discover:
          img = 'discover.png';
          break;
        case CardType.DinersClub:
          img = 'dinners_club.png';
          break;
        case CardType.Jcb:
          img = 'jcb.png';
          break;
        case CardType.Others:
          icon = new Icon(
            Icons.credit_card,
            size: 40.0,
            color: Colors.grey[600],
          );
          break;
        default:
          icon = new Icon(
            Icons.warning,
            size: 40.0,
            color: Colors.grey[600],
          );
          break;
      }
      Widget? widget;
      if (img.isNotEmpty) {
        widget = new Image.asset(
          'assets/images/pay/$img',
          width: 40.0,
        );
      } else {
        widget = icon;
      }
      return widget;
    }

    /// With the card number with Luhn Algorithm
    /// https://en.wikipedia.org/wiki/Luhn_algorithm
     String? validateCardNum(String? input) {
      if (input == null || input.isEmpty) {
        return "${lan.getTexts('field_is_required')}";
      }

      input = getCleanedNumber(input);

      if (input.length < 8) {
        return  "${lan.getTexts('card_is_invalid')}";
      }

      int sum = 0;
      int length = input.length;
      for (var i = 0; i < length; i++) {
        // get digits in reverse order
        int digit = int.parse(input[length - i - 1]);

        // every 2nd number multiply with 2
        if (i % 2 == 1) {
          digit *= 2;
        }
        sum += digit > 9 ? (digit - 9) : digit;
      }

      if (sum % 10 == 0) {
        return null;
      }

      return "${lan.getTexts('card_is_invalid')}";
    }









var prov =Provider.of<appointmenProvider>(context, listen: false);

    var SizeConfig = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.height * 0.08),
              Text(
                "${lan.getTexts('add_payment_det')}",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: SizeConfig.height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: SizeConfig.height * 0.1,
                    width: SizeConfig.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.green,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/card.svg',
                          ),
                          Text("${lan.getTexts('credit_card')}",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    height: SizeConfig.height * 0.1,
                    width: SizeConfig.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/Apple_icon.svg',
                          ),
                          Text(
                            "${lan.getTexts('apple_pay')}",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.height * 0.04),
              Text(
                "${lan.getTexts('card_number')}",

             style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: SizeConfig.height * 0.02),
              TextFormField(
textDirection: TextDirection.ltr,
                 focusNode: filed1,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  new LengthLimitingTextInputFormatter(19),
                  new CardNumberInputFormatter()
                ],
                controller: numberController,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  filled: true,
                  // icon: CardUtils.getCardIcon(_paymentCard.type),
                  labelText: "${lan.getTexts('number')}",
                  suffixIcon:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: getCardIcon(_paymentCard.type),
                  )
                ),
                onFieldSubmitted: (val){
                  filed2!.requestFocus();
                },
                onSaved: (String? value) {
                  print('onSaved = $value');
                  print('Num controller has = ${numberController.text}');
                  _paymentCard.number = getCleanedNumber(value!);
                },
                validator: validateCardNum,
              ),
              SizedBox(height: SizeConfig.height * 0.04),
              Text(
                "${lan.getTexts('cardholder_name')}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: SizeConfig.height * 0.02),
              new TextFormField(
                focusNode: filed2,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),

                  filled: true,
                  // icon: CardUtils.getCardIcon(_paymentCard.type),

                  labelText: "${lan.getTexts('name')}",
                ),
                onFieldSubmitted: (val){
                   filed3!.requestFocus();
                },
                onSaved: (String? value) {

                  _paymentCard.name = value;
                },
                keyboardType: TextInputType.text,
                validator: (String? value) =>
                    value!.isEmpty ? "${lan.getTexts('field_is_required')}" : null,
              ),
              SizedBox(height: SizeConfig.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${lan.getTexts('expiry_date')}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: SizeConfig.height * 0.01),
                      Container(
                        decoration: BoxDecoration(),
                        width: SizeConfig.width * 0.4,
                        child: TextFormField(
                          focusNode: filed3,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            new LengthLimitingTextInputFormatter(4),
                            new CardMonthInputFormatter()
                          ],
                          onFieldSubmitted: (val){
                            filed4!.requestFocus();
                          },
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            hintText: 'MM/YY',
                            labelText:"${lan.getTexts('expiry_date')}",
                          ),
                          validator:validateDate,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            List<int> expiryDate =
                                getExpiryDate(value!);
                            _paymentCard.month = expiryDate[0];
                            _paymentCard.year = expiryDate[1];
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CVV / CVC",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: SizeConfig.height * 0.01),
                      Container(
                        decoration: BoxDecoration(),
                        width: SizeConfig.width * 0.4,
                        child: TextFormField(
                          focusNode: filed4,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            new LengthLimitingTextInputFormatter(4),
                          ],
                          onFieldSubmitted: (val){
                            filed5!.requestFocus();
                          },
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            hintText: "${lan.getTexts('number_behind')}",
                            labelText: 'CVV',
                          ),
                          validator: validateCVV,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            _paymentCard.cvv = int.parse(value!);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: SizeConfig.height * 0.03),
        Align(alignment: Alignment.center,

          child: ElevatedButton(
                onPressed: _validateInputs,
                child: new Text(
                  "${lan.getTexts('request_service')}",
                  style: const TextStyle(fontSize: 17.0),
                ),
              ),
        ),

              SizedBox(height: SizeConfig.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
