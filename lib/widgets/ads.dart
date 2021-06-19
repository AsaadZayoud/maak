import 'package:flutter/material.dart';



// ignore: must_be_immutable
class Ads extends StatelessWidget {
  static const routeName = '/category';

  String svg='';
  Color color = Colors.green;
  String text = '';



  @override
  Widget build(BuildContext context) {

    return Container(
              height:MediaQuery.of(context).size.height*0.18,
              width:  MediaQuery.of(context).size.width*0.3,
              decoration:  BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(
                    Radius.circular(15.0)
                ),
              ),





    );
  }
}
