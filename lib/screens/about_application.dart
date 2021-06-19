import 'package:flutter/material.dart';

class AboutApplication extends StatelessWidget {
  const AboutApplication({Key? key}) : super(key: key);
  static const routeName = '/about';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('About Application')),
    );
  }
}
