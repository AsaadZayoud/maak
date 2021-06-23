import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/models/profile.dart';
import 'package:maak/providers/auth_provider.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:maak/providers/profile_provider.dart';
import 'package:maak/providers/utils.dart';
import 'package:provider/provider.dart';

class createAccount extends StatefulWidget {
  const createAccount({Key? key}) : super(key: key);

  @override
  _createAccountState createState() => _createAccountState();
}

class _createAccountState extends State<createAccount> {
  @override
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String fullName = '';
  String idCard = '';
  String number = '';
  String number1 = '';
  FocusNode? filed1;
  FocusNode? filed2;
  FocusNode? filed3;
  FocusNode? filed4;
  Map<String, dynamic> loc = {'lat': '', 'long': '', 'address': ''};
  bool checkedValue = false;
  @override
  void initState() {
    super.initState();
    filed1 = FocusNode();
    filed2 = FocusNode();
    filed3 = FocusNode();
    filed4 = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    filed1!.dispose();
    filed2!.dispose();
    filed3!.dispose();
    filed4!.dispose();
  }

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
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.height * 0.07),
                    Container(
                      child: SvgPicture.asset(
                        'assets/svg/apple.svg',
                      ),
                    ),
                    SizedBox(height: SizeConfig.height * 0.04),
                    Text(
                      'Create account',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: SizeConfig.height * 0.04),
                    Text(
                      'Create an account with us using your phone',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                    SizedBox(height: SizeConfig.height * 0.04),
                    TextFormField(
                      autofocus: true,
                      focusNode: filed1,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        hintText: "Full Name",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* ${lan.getTexts('required')}";
                        } else
                          return null;
                      },
                      onFieldSubmitted: (val) {
                        filed2!.requestFocus();

                        this.idCard = val;
                      },
                      onSaved: (val) => this.idCard = val!,
                    ),
                    SizedBox(
                      height: SizeConfig.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          width: SizeConfig.width * 0.2,
                          child: TextFormField(
                            focusNode: filed2,
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
                            onChanged: (val) => this.number1 = val,
                            onFieldSubmitted: (val) {
                              filed3!.requestFocus();
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(),
                          width: SizeConfig.width * 0.68,
                          child: TextFormField(
                            focusNode: filed3,
                            autofocus: true,
                            keyboardType: TextInputType.phone,
                            decoration: new InputDecoration(
                              hintText: "Number",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* ${lan.getTexts('required')}";
                              } else
                                return null;
                            },
                            onFieldSubmitted: (val) {
                              filed4!.requestFocus();
                            },
                            onChanged: (val) => this.number = val,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.height * 0.04,
                    ),
                    TextFormField(
                      focusNode: filed4,
                      keyboardType: TextInputType.phone,
                      decoration: new InputDecoration(
                        hintText: "Enter Gov Issued ID No.",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* ${lan.getTexts('required')}";
                        } else
                          return null;
                      },
                      onFieldSubmitted: (val) {
                        filed4!.unfocus();
                      },
                      onSaved: (val) => this.fullName = val!,
                    ),
                    SizedBox(
                      height: SizeConfig.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: checkedValue,
                          onChanged: (bool? value) {
                            setState(() {
                              checkedValue = value!;
                            });
                          },
                        ),
                        Text(
                          "I agree with our ",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        GestureDetector(
                          onTap: () {
                            Utils.mainNavigatorKey.currentState!
                                .pushReplacementNamed('/otp');
                          },
                          child: Text(
                            "Terms",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Text(' and'),
                        GestureDetector(
                          onTap: () {
                            Utils.mainNavigatorKey.currentState!
                                .pushReplacementNamed('/otp');
                          },
                          child: Text(
                            " Conditions",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
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
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                           onPressed:checkedValue ?  () {
                          if (_formKey.currentState!.validate() ) {
                            Provider.of<ProfileProvider>(context, listen: false)
                                .setProfile(
                                    Profile(name: '', phone: 0, idCard: ''))
                                .then((value) {
                              _showToast(context, "${lan.getTexts('Thx_reg')}");
                              Provider.of<AuthProvider>(context, listen: false)
                                  .SetAuth(true);

                              Utils.mainNavigatorKey.currentState!
                                  .pushReplacementNamed('/tabScreen');
                            }).onError((error, stackTrace) {
                              _showToast(
                                  context, "${lan.getTexts('plz_again')}");
                            });
                          } else {
                            print("Not Validated");
                          }
                        } : null,
                        child: Text("Verify Phone & Create an Account"),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ? ",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        GestureDetector(
                          onTap: () {
                            Utils.NavigatorKey.currentState!
                                .pushReplacementNamed('/otp');
                          },
                          child: Text(
                            "Login",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
