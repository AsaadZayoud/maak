import 'package:flutter/material.dart';
import 'package:maak/models/profile.dart';
import 'package:maak/providers/auth_provider.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:maak/providers/profile_provider.dart';
import 'package:maak/providers/utils.dart';
import 'package:maak/screens/login/otp.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String fullName = '';
  String idCard = '';
  FocusNode? filed1;
  FocusNode? filed2;

  Map<String, dynamic> loc = {'lat': '', 'long': '', 'address': ''};

  @override
  void initState() {
    super.initState();
    filed1 = FocusNode();
    filed2 = FocusNode();

  }

  @override
  void dispose() {
    super.dispose();
    filed1!.dispose();
    filed2!.dispose();

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
      appBar: AppBar(
        title: Center(child: Text("${lan.getTexts('log_det')}")),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Center(
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
                          hintText: "${lan.getTexts('id_card')}",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* ${lan.getTexts('required')}";
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
                          hintText: "${lan.getTexts('name')}",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* ${lan.getTexts('required')}";
                          } else
                            return null;
                        },


                        onSaved:(val) => this.fullName = val!,


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

                            Provider.of<ProfileProvider>(context, listen: false)
                                .setProfile(Profile(name: '', phone: 0, idCard: ''))
                                .then(
                                  (value) {
                                    _showToast(context,"${lan.getTexts('Thx_reg')}" );
                                    Provider.of<AuthProvider>(context, listen: false).SetAuth(true);
                               
                                     Utils.mainNavigatorKey.currentState!.pushReplacementNamed('/tabScreen');
                                  })
                                .onError((error, stackTrace) {
                                    _showToast(context, "${lan.getTexts('plz_again')}");});
                          } else {
                            print("Not Validated");
                          }
                        },
                        child:  Text("${lan.getTexts('login')}"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
