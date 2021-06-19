import 'package:flutter/material.dart';

class SendFeedback extends StatelessWidget {
  const SendFeedback({Key? key}) : super(key: key);
  static const routeName = '/feedback';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Send Feedback')),
    );
  }
}
