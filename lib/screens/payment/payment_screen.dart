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

import 'my_strings.dart';

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
  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
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
var prov =Provider.of<appointmenProvider>(context, listen: false);
    var lan = Provider.of<LanguageProvider>(context, listen: true);
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
                          Text(
                            "${lan.getTexts('credit_card')}",
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
                  suffixIcon:  CardUtils.getCardIcon(_paymentCard.type)
                ),
                onFieldSubmitted: (val){
                  filed2!.requestFocus();
                },
                onSaved: (String? value) {
                  print('onSaved = $value');
                  print('Num controller has = ${numberController.text}');
                  _paymentCard.number = CardUtils.getCleanedNumber(value!);
                },
                validator: CardUtils.validateCardNum,
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
                    value!.isEmpty ? Strings.fieldReq : null,
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
                          validator: CardUtils.validateDate,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            List<int> expiryDate =
                                CardUtils.getExpiryDate(value!);
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
                          validator: CardUtils.validateCVV,
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
              Text("Add Location",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: SizeConfig.height * 0.03),
              Container(

                decoration: BoxDecoration(

                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(15)),
                width: SizeConfig.width * 0.9,
                height: SizeConfig.height * 0.16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(prov.address),
                    SizedBox(height: SizeConfig.height * 0.01),
                    Text(
                      "${prov.lat} , ${prov.lng}",
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height * 0.03),
        Align(alignment: Alignment.center,

          child: ElevatedButton(
                onPressed: _validateInputs,
                child: new Text(
                  Strings.pay,
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
