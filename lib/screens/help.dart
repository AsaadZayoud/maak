import 'package:flutter/material.dart';
class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);
  static const routeName = '/help';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('help'))
    );
  }
}
