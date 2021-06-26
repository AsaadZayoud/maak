import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/models/service.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:maak/providers/service_provider.dart';
import 'package:maak/providers/utils.dart';
import 'package:maak/screens/home.dart';
import 'package:maak/screens/login/creat_account.dart';
import 'package:maak/screens/map.dart';
import 'package:maak/screens/profile_screen.dart';
import 'package:maak/screens/search.dart';
import 'package:maak/screens/tab_screen.dart';
import 'package:maak/widgets/ads_list.dart';
import 'package:maak/widgets/category_list.dart';
import 'package:maak/widgets/service_widget.dart';
import 'package:provider/provider.dart';

import '../appointmen_screen.dart';
import '../calendar.dart';
import '../categories_screen.dart';
import '../login/otp.dart';
import '../login/otp_code.dart';

class navHomeDate extends StatelessWidget {
  static const routeName = '/nav';

  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Scaffold(


    body: Navigator(
        key: Utils.NavigatorKeyDate,
        initialRoute: '/categoriesScreen',
        onGenerateRoute: (RouteSettings settings) {
          Widget page;
          switch (settings.name) {
            case '/home':
              page = Home();
              break;
            case '/categoriesScreen':
              page = categoriesScreen();
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
            case '/otp':
              page = OtpForm();
              break;
            case '/otpcode':
              page = OtbCode();
              break;
            case '/map':
              page = LocationmapPage();
              break;
            case '/appointmen':
              page = appointmenScreen();
              break;
            case '/account':
              page = createAccount();
              break;
            default:
              page = Container();
              break;
          }
          return PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation animation, _) => page,
              transitionDuration: const Duration(seconds: 0));
        },
      ),
    );
  }
}
