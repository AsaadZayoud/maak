import 'package:flutter/material.dart';
import 'package:maak/providers/utils.dart';

class OtpForm extends StatefulWidget {
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  String phone = '';
  bool isSend = false;
  List numbers = [];
  String numVal = '';

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode?.dispose();
    pin3FocusNode?.dispose();
    pin4FocusNode?.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
      numbers.add(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    Row buildTimer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("This code will expired in "),
          TweenAnimationBuilder(
            tween: Tween(begin: 30.0, end: 0.0),
            duration: Duration(seconds: 30),
            builder: (_, value, child) => Text(
              "00:${value.toString().substring(0, 2)}",
              //  style: TextStyle(color: Colors),
            ),
            onEnd: () {
              setState(() {
                isSend = false;
              });
            },
          ),
        ],
      );
    }

    void _showToast(BuildContext context, String _text) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text(_text),
        ),
      );
    }

    OutlineInputBorder outlineInputBorder() {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.black87),
      );
    }

    final otpInputDecoration = InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 15),
      border: outlineInputBorder(),
      focusedBorder: outlineInputBorder(),
      enabledBorder: outlineInputBorder(),
    );

    var SizeConfig = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.height * 0.05),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  hintText: "Phone",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "* Required";
                  } else
                    return null;
                },
                onChanged: (val) => this.phone = val,
              ),
              SizedBox(
                height: SizeConfig.height * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  if (phone == '') {
                    _showToast(context, 'Please Insert Number');
                  } else {
                    setState(() {
                      isSend = true;
                    });
                  }
                },
                child: Text('Send Code'),
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    elevation: 5,
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.6,
                        MediaQuery.of(context).size.height * 0.05)),
              ),
              SizedBox(
                height: SizeConfig.height * 0.05,
              ),
              isSend
                  ? Text(
                      "OTP Verification",
                    )
                  : Container(),
              SizedBox(
                height: SizeConfig.height * 0.02,
              ),
              isSend ? Text("We sent your code to $phone") : Container(),
              SizedBox(height: SizeConfig.height * 0.02),
              isSend ? buildTimer() : Container(),
              SizedBox(
                height: SizeConfig.height * 0.05,
              ),
              isSend
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 60,
                          child: TextFormField(
                            obscureText: true,
                            style: TextStyle(fontSize: 24),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: otpInputDecoration,
                            onChanged: (value) {
                              nextField(value, pin2FocusNode!);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          child: TextFormField(
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
                        SizedBox(
                          width: 60,
                          child: TextFormField(
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
                        SizedBox(
                          width: 60,
                          child: TextFormField(
                            focusNode: pin4FocusNode,
                            obscureText: true,
                            style: TextStyle(fontSize: 24),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: otpInputDecoration,
                            onChanged: (value) {
                              if (value.length == 1) {
                                pin4FocusNode!.unfocus();
                                numbers.forEach((element) {
                                  numVal = '$numVal$element';
                                });
                                numVal = '$numVal$value';

                                numbers = [];

                                if(int.parse(numVal) == 1234 ){
                                  Utils.NavigatorKey.currentState!
                                      .pushReplacementNamed('/Body');
                                  numVal= '';
                                }
                                else {

                                  _showToast(context,'Wrong Number');
                                  numVal= '';
                                }
                                // Then you need to check is the code is correct or not
                              }
                            },
                            onFieldSubmitted: (val) {},
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
