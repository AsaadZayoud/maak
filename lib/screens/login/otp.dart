import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:maak/providers/utils.dart';
import 'package:provider/provider.dart';

class OtpForm extends StatefulWidget {
  static const routeName = '/otp';
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String phone = '';
  bool isSend = false;
  FocusNode? pin1FocusNode;
  @override
  void initState() {
    // TODO: implement initState
    pin1FocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    pin1FocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    void _showToast(BuildContext context, String _text) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text(_text),
        ),
      );
    }

    var SizeConfig = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Padding(

              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.height * 0.05),
                  Container(
                    child: SvgPicture.asset(
                      'assets/svg/apple.svg',
                    ),
                  ),
                  SizedBox(height: SizeConfig.height * 0.03),
                  Text(
                    "${lan.getTexts('login')}",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: SizeConfig.height * 0.05),
                  Text(
                    "${lan.getTexts('login_det')}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: SizeConfig.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(),
                        width: SizeConfig.width * 0.16,
                        child: TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.phone,
                          decoration: new InputDecoration(

                            hintText: "+1",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* ${lan.getTexts('required')}";
                            } else
                              return null;
                          },
                          onChanged: (val) => this.phone = val,
                          onFieldSubmitted: (val) {
                            pin1FocusNode!.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        width: SizeConfig.width * 0.65,
                        child: TextFormField(
                          focusNode: pin1FocusNode,
                          autofocus: true,
                          keyboardType: TextInputType.phone,
                          decoration: new InputDecoration(

                            hintText:  "${lan.getTexts('number')}",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* ${lan.getTexts('required')}";
                            } else
                              return null;
                          },
                          onFieldSubmitted: (val) {
                            pin1FocusNode!.unfocus();
                          },
                          onChanged: (val) => this.phone = val,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.height * 0.05,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.08),
                    child: ElevatedButton(
                      onPressed: () {
                        Utils.NavigatorKey.currentState!
                            .pushReplacementNamed('/otpcode');
                        setState(() {
                          isSend = false;
                        });
                      },
                      child: Text("${lan.getTexts('login')}"),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
