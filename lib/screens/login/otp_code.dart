import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/providers/auth_provider.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:maak/providers/utils.dart';
import 'package:provider/provider.dart';

import 'creat_account.dart';

class OtbCode extends StatefulWidget {
  const OtbCode({Key? key}) : super(key: key);

  @override
  _OtbCodeState createState() => _OtbCodeState();
}

class _OtbCodeState extends State<OtbCode> {
  FocusNode? pin1FocusNode;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;
  TextEditingController editText1 = TextEditingController();
  TextEditingController editText2 = TextEditingController();
  TextEditingController editText3 = TextEditingController();
  TextEditingController editText4 = TextEditingController();
  TextEditingController editText5 = TextEditingController();
  TextEditingController editText6 = TextEditingController();
  String phone = '';
  bool isSend = false;
  List numbers = [];
  String numVal = '';

  @override
  void initState() {
    super.initState();
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin1FocusNode?.dispose();
    pin2FocusNode?.dispose();
    pin3FocusNode?.dispose();
    pin4FocusNode?.dispose();
    pin5FocusNode?.dispose();
    pin6FocusNode?.dispose();
    editText1.dispose();
    editText2.dispose();
    editText3.dispose();
    editText4.dispose();
    editText5.dispose();
    editText6.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
      numbers.add(value);
    }
  }

  void _showToast(BuildContext context, String _text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(_text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var SizeConfig = MediaQuery.of(context).size;
    OutlineInputBorder outlineInputBorder() {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey.shade200),
      );
    }

    final otpInputDecoration = InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 15),
      border: outlineInputBorder(),
      focusedBorder: outlineInputBorder(),
      enabledBorder: outlineInputBorder(),
    );

    Row buildTimer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${lan.getTexts('code_exp')}"),
          TweenAnimationBuilder(
            tween: Tween(begin: 30.0, end: 0.0),
            duration: Duration(seconds: 30),
            builder: (_, value, child) => Text(
              "00:${value.toString().substring(0, 2)}",
              //  style: TextStyle(color: Colors),
            ),
            onEnd: () {
              setState(() {
                isSend = true;
              });
            },
          ),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    child: SvgPicture.asset(
                      'assets/svg/apple.svg',
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.height * 0.05,
                  ),
                  Text(
                    "${lan.getTexts('otp_ver')}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: SizeConfig.height * 0.02,
                  ),
                  Text("${lan.getTexts('we_sent')} $phone"),
                  SizedBox(height: SizeConfig.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(11)),
                        width: SizeConfig.width * 0.12,
                        child: TextFormField(
                          controller: editText1,
                          autofocus: true,
                          focusNode: pin1FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            border: outlineInputBorder(),
                            focusedBorder: outlineInputBorder(),
                            enabledBorder: outlineInputBorder(),
                          ),
                          onChanged: (value) {
                            nextField(value, pin2FocusNode!);
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(11)),
                        width: SizeConfig.width * 0.12,
                        child: TextFormField(
                          controller: editText2,
                          focusNode: pin2FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) =>
                              nextField(value, pin3FocusNode!),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(11)),
                        width: SizeConfig.width * 0.12,
                        child: TextFormField(
                          controller: editText3,
                          focusNode: pin3FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) =>
                              nextField(value, pin4FocusNode!),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(11)),
                        width: SizeConfig.width * 0.12,
                        child: TextFormField(
                          controller: editText4,
                          focusNode: pin4FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            nextField(value, pin5FocusNode!);
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(11)),
                        width: SizeConfig.width * 0.12,
                        child: TextFormField(
                          controller: editText5,
                          autofocus: true,
                          focusNode: pin5FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            nextField(value, pin6FocusNode!);
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(11)),
                        width: SizeConfig.width * 0.12,
                        child: TextFormField(
                          controller: editText6,
                          focusNode: pin6FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            if (value.length == 1) {
                              pin6FocusNode!.unfocus();
                              numbers.forEach((element) {
                                numVal = '$numVal$element';
                              });
                              numVal = '$numVal$value';

                              numbers = [];

                              if (int.parse(numVal) == 123456) {

                                Utils.NavigatorKey.currentState!
                                    .pushReplacement(MaterialPageRoute(builder: (contex) => createAccount()));
                                numVal = '';
                              } else {
                                _showToast(
                                    context, "${lan.getTexts('wrong_number')}");
                                numVal = '';
                                editText1.clear();
                                editText2.clear();
                                editText3.clear();
                                editText4.clear();
                                editText5.clear();
                                editText6.clear();
                              }
                              // Then you need to check is the code is correct or not
                            }
                          },
                          onFieldSubmitted: (val) {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.height * 0.04,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.08),
                    child: ElevatedButton(
                      onPressed: () {
                        Utils.mainNavigatorKey.currentState!
                            .pushNamed('/otpcode');
                        setState(() {
                          isSend = false;
                        });
                      },
                      child: Text("${lan.getTexts('re_send')}"),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${lan.getTexts('dont_otp')}"),
                      GestureDetector(
                          onTap: () {},
                          child: Text(
                            "${lan.getTexts('re_send')}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
