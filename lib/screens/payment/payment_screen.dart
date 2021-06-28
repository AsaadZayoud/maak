import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/providers/language_provider.dart';
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
  var numberController = new TextEditingController();
  var _paymentCard = PaymentCard();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    numberController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  var _card = new PaymentCard();
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var SizeConfig = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(25),
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
                suffixIcon: SvgPicture.asset(
                  'assets/svg/card.svg',
                ),
              ),
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
              decoration: new InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),

                filled: true,
                // icon: CardUtils.getCardIcon(_paymentCard.type),

                labelText: "${lan.getTexts('name')}",
              ),
              onSaved: (String? value) {
                _card.name = value;
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          new LengthLimitingTextInputFormatter(4),
                          new CardMonthInputFormatter()
                        ],
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          new LengthLimitingTextInputFormatter(4),
                        ],
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
              width: SizeConfig.width * 0.8,
              height: SizeConfig.height * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Homs , Syria'),
                  SizedBox(height: SizeConfig.height * 0.01),
                  Text(
                    '33.245 , 45432432',
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            ),
            SizedBox(height: SizeConfig.height * 0.03),
          ],
        ),
      ),
    );
  }
}
