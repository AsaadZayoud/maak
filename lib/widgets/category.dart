import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


// ignore: must_be_immutable
class Category extends StatelessWidget {
  static const routeName = '/category';

  String svg = '';
  Color color = Colors.green;
  String text = '';
  // Category({required String text,required String svg , required Color color , required details }) ;


  @override
  Widget build(BuildContext context) {

      return ListTile(
            leading: Container(child: SvgPicture.asset(
              'assets/svg/Vector_Art_1.svg',


            )

              ,),
              title: Text('Doctors Service'),
              subtitle: Text('Doctors Available To Book'),
              tileColor: Colors.grey,
        shape:RoundedRectangleBorder(borderRadius: new BorderRadius.all(new Radius.circular(10))) ,
            );


  }
}
