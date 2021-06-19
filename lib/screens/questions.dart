import 'package:flutter/material.dart';

class Questions extends StatelessWidget {
  const Questions({Key? key}) : super(key: key);
  static const routeName = '/questions';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Questions')),
    );
  }
}
