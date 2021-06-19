import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


// ignore: must_be_immutable
class ServiceWidget extends StatelessWidget {
  static const routeName = '/category';

  String svg = '';
  Color color = Colors.green;
  String title = '';
  String subtitle = '';
  bool isDetails = false;
  bool isAvailable = false;

  ServiceWidget({required this.title,required this.subtitle,required  this.svg , required  this.color, this.isDetails = false,this.isAvailable = false }) ;


  @override
  Widget build(BuildContext context) {

    return
      Container(
          height: 110,

        decoration:BoxDecoration(borderRadius: BorderRadius.all(new Radius.circular(12) ),color: color),
        child: Row(
          children: [
            Flexible(
              child: Center(
                child: ListTile(
                  leading: Container(child: SvgPicture.asset(
                  svg,
                  ),
                  ),
                  title: Text(title),
                  subtitle: Text(subtitle),



                ),
              ),
            ),
            isDetails ? Container(height: 110,width: 30,decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(15)),

              child: Center(child: Text(isAvailable ? 'UPCOMING'   :  'FINISHED',textAlign: TextAlign.center,style: TextStyle(letterSpacing: 100,fontWeight: FontWeight.bold,fontSize: 10) ,)),

            )
            : Container()
          ],
        ),
      );



  }
}
