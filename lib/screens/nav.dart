import 'package:flutter/material.dart';
import 'package:maak/models/service.dart';
import 'package:maak/providers/service_provider.dart';
import 'package:maak/providers/utils.dart';
import 'package:maak/screens/home.dart';
import 'package:maak/screens/map.dart';
import 'package:maak/screens/search.dart';
import 'package:maak/screens/tab_screen.dart';
import 'package:maak/widgets/ads_list.dart';
import 'package:maak/widgets/category_list.dart';
import 'package:maak/widgets/service_widget.dart';
import 'package:provider/provider.dart';

import 'calendar.dart';

class Nav extends StatelessWidget {
  static const routeName = '/nav';

  Widget build(BuildContext context) {
    return Navigator(
      key: Utils.NavigatorKey,
      initialRoute: '/home',
      onGenerateRoute: (RouteSettings settings) {
        Widget page;
        switch (settings.name) {
          case '/home':
            page = Home();
            break;
          case '/tabScreen':
            page = TabScreen();
            break;
          case '/search':
            page = Search();
            break;
          case '/calendar':
            page = Calendar();
            break;
          case '/map':
            page = Maploc();
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
