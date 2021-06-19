import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);
  static const routeName = '/privacy';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Privacy Policy')),
    );
  }
}
