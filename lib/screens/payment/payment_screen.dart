import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/screens/payment/input_formatters.dart';
import 'package:maak/screens/payment/payment_card.dart';

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
    var SizeConfig = MediaQuery.of(context).size;
    return Container(

      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.height * 0.08),
        Text("Add Payment Details",style: Theme.of(context).textTheme.headline6,),
        SizedBox(height: SizeConfig.height * 0.04),
        Row(

          children: [
            Container(

              height:SizeConfig.height*0.1 ,
              width: SizeConfig.width*0.4,
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(28),color: Colors.green,

              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    SvgPicture.asset(
                      'assets/svg/card.svg',
                    ),
                    Text(
                      ' Credit Card',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height:SizeConfig.height*0.1 ,
              width: SizeConfig.width*0.4,
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(28),color: Colors.grey.withOpacity(0.2),),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/Apple_icon.svg',
                    ),
                    Text(
                      ' Apple Pay',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold,color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
        SizedBox(height: SizeConfig.height * 0.04),

        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            'Card number',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
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

            border: const UnderlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),)
            ),
            filled: true,
           // icon: CardUtils.getCardIcon(_paymentCard.type),
            hintText: 'What number is written on card?',
            labelText: 'Number',
          ),
          onSaved: (String? value) {
            print('onSaved = $value');
            print('Num controller has = ${numberController.text}');
            _paymentCard.number = CardUtils.getCleanedNumber(value!);
          },
          validator: CardUtils.validateCardNum,
        ),
        SizedBox(height: SizeConfig.height * 0.04),
        Text("Cardholder name",style: Theme.of(context).textTheme.bodyText1,),
        SizedBox(height: SizeConfig.height * 0.02),

      ],
    ),
    );
  }
}
