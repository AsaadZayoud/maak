import 'package:flutter/material.dart';
import 'package:maak/models/profile.dart';
import 'package:maak/providers/profile_provider.dart';
import 'package:maak/screens/login/otp.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String fullName = '';
  String phone = '';
  bool isSend = false;
  String idCard = '';
  FocusNode? filed1;
  FocusNode? filed2;
  FocusNode? filed3;
  Map<String, dynamic> loc = {'lat': '', 'long': '', 'address': ''};

  @override
  void initState() {
    super.initState();
    filed1 = FocusNode();
    filed2 = FocusNode();
    filed3 = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    filed1!.dispose();
    filed2!.dispose();
    filed3!.dispose();
  }

  Widget build(BuildContext context) {
    void _showToast(BuildContext context, String _text) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text(_text),
        ),
      );
    }

    var SizeConfig = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.height * 0.05),
                TextFormField(
                  autofocus: true,
                  focusNode: filed1,
                  keyboardType: TextInputType.phone,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    hintText: "ID Card",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    } else
                      return null;
                  },

                  onFieldSubmitted: (val){
                    filed2!.requestFocus();

                    this.idCard = val;
                  },
                 onSaved: (val) => this.idCard = val!,

                ),
                SizedBox(
                  height: SizeConfig.height * 0.05,
                ),
                TextFormField(
                  focusNode: filed2,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    hintText: "Name",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    } else
                      return null;
                  },
                  onFieldSubmitted: (val){
                    filed3!.requestFocus();
                    this.fullName = val;
                  },

                  onSaved:(val) => this.fullName = val!,


                ),
                SizedBox(
                  height: SizeConfig.height * 0.05,
                ),
                TextFormField(
                  focusNode: filed3,
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
                  onFieldSubmitted: (val){
                    filed3!.unfocus();
                    this.phone = val;
                  },
                  onChanged: (val) => this.phone = val,



                ),
                SizedBox(
                  height: SizeConfig.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    if (phone == '') {
                      _showToast(context, 'Please Insert Number');
                    } else {
                      setState(() {
                        isSend = true;
                      });
                    }
                  },
                  child: Text(
                    'Send Code',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.height * 0.05,
                ),
                Text(
                  "OTP Verification",
                ),
                Text("We sent your code to $phone"),
                isSend ? buildTimer() : Container(),
                OtpForm(),
                GestureDetector(
                  onTap: () {
                    if (phone == '') {
                      _showToast(context, 'Please Insert Number');
                    } else {
                      setState(() {
                        isSend = true;
                      });
                    } // OTP code resend
                  },
                  child: Text(
                    "Resend OTP Code",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.height * 0.02,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                  color: Theme.of(context).accentColor))),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      elevation: MaterialStateProperty.all(7),
                      fixedSize: MaterialStateProperty.all(Size(100, 50))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Validated");
                      Provider.of<ProfileProvider>(context, listen: false)
                          .setProfile(Profile(name: '', phone: 0, idCard: ''))
                          .then(
                            (value) => _showToast(context, 'Thanks for send'),
                          )
                          .onError((error, stackTrace) =>
                              _showToast(context, 'Please try again'));
                    } else {
                      print("Not Validated");
                    }
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
}
