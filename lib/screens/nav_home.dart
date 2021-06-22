import 'package:flutter/material.dart';
import 'package:maak/models/service.dart';
import 'package:maak/providers/service_provider.dart';
import 'package:maak/providers/utils.dart';
import 'package:maak/screens/home.dart';
import 'package:maak/screens/login/otp.dart';
import 'package:maak/screens/tab_screen.dart';
import 'package:maak/widgets/ads_list.dart';
import 'package:maak/widgets/category_list.dart';
import 'package:maak/widgets/service_widget.dart';
import 'package:provider/provider.dart';

import 'calendar.dart';
import 'login/login.dart';
import 'login/otp_code.dart';

// ignore: must_be_immutable
class NavHome extends StatelessWidget {
  static const routeName = '/navHome';

  Widget build(BuildContext context) {
    return Navigator(
      key: Utils.mainNavigatorKey,
      initialRoute: '/tabScreen',
      onGenerateRoute: (RouteSettings settings) {
        Widget page;
        switch (settings.name) {

          case '/tabScreen':
            page = TabScreen();
            break;
          case '/home':
            page = Home();
            break;


          default:
            page = Container();
            break;
        }
        return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation animation, _) => page,
            transitionDuration: const Duration(seconds: 0));
      },
    );
  }
}
