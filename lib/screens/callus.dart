import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maak/models/call_us.dart';
import 'package:maak/providers/call_us.dart';
import 'package:provider/provider.dart';

class CallUsScreen extends StatefulWidget {
  const CallUsScreen({Key? key}) : super(key: key);
  static const routeName = '/cull_us';
  @override
  _CallUsState createState() => _CallUsState();
}

class _CallUsState extends State<CallUsScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _fullName = '';
  int _phone = 0;
  String _email = '';
  String _massage = '' ;

  void _showToast(BuildContext context,String _text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text(_text),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Call Us'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: Theme.of(context).accentColor,
          child: ListView(padding: EdgeInsets.all(8), children: [
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2)),
            new ListTile(
              leading: const Icon(Icons.person),
              title: new TextFormField(
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
                onSaved:(val) => _fullName=val!,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            new ListTile(
              leading: const Icon(Icons.phone),
              title: new TextFormField(
                keyboardType:TextInputType.phone ,
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
                onSaved:(val) => _fullName=val!,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            new ListTile(
              leading: const Icon(Icons.email),
              title: new TextFormField(
                keyboardType: TextInputType.emailAddress,

                decoration: new InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  hintText: "Email",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "* Required";
                  } else
                    return null;
                },
                onSaved:(val) => _email=val!,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            new ListTile(
              leading: const Icon(Icons.message),
              title: new TextFormField(
                decoration: new InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  hintText: "Message",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "* Required";
                  } else
                    return null;
                },
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: 3,
                onSaved:(val) => _massage=val!,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side:
                              BorderSide(color: Theme.of(context).accentColor))),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  elevation: MaterialStateProperty.all(7),
                  fixedSize: MaterialStateProperty.all(Size(60, 50))),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print("Validated");
                  Provider.of<CallUsProvider>(context, listen: false).sendCall(CallUs(email:_email,fullname: _fullName,message: _massage,phone: _phone )).then((value) =>
                  _showToast(context,'Thanks for send'),
                  ).onError((error, stackTrace) =>
                  _showToast(context, 'Please try again')
                  );
                }else{
                  print("Not Validated");
                }
              },
              child: const Text('Send'),
            ),
          ]),
        ),
      ),
    );
  }
}
