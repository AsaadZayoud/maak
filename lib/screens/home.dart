import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/models/service.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:maak/providers/service_provider.dart';
import 'package:maak/providers/utils.dart';
import 'package:maak/screens/nav/nav.dart';
import 'package:maak/screens/profile_screen.dart';
import 'package:maak/widgets/ads_list.dart';
import 'package:maak/widgets/category_list.dart';
import 'package:maak/widgets/service_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _SerState createState() => _SerState();
}

class _SerState extends State<Home> {
  late Future<List<Service>> _futureAvailable;


  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
      elevation: 0,
      leading: Align(
        alignment: Alignment.topCenter
        ,
        child: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset(
              'assets/svg/drawer.svg',
              height: 15,
              width: 34,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      title:      Align(
        alignment:lan.isEn ?  Alignment.bottomRight : Alignment.bottomLeft,
        child: GestureDetector(
          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
          child: CircleAvatar(
            radius: 18,
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.png',
              ),
            ),
          ),
        ),
      ) ,


    ),
        body: Nav()
      ),
    );
  }
}
