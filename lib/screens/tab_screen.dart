import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/providers/auth_provider.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:maak/providers/utils.dart';
import 'package:maak/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import 'calendar.dart';
import 'home.dart';
import 'nav/nav.dart';

class TabScreen extends StatefulWidget {
  TabScreen({Key? key}) : super(key: key);
  static const routeName = '/tabScreen';

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        initialIndex: 2,
        length: 5,
        child: Directionality(
          textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: Scaffold(

            drawer: Drawer(
              elevation: 5,
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Header',
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Item 1'),
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Item 2'),
                  ),
                  ListTile(
                    leading: Icon(Icons.label),
                    title: Text('Item 3'),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Label',
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Calendar(),
                Container(child: Icon(Icons.directions_transit)),
                Container(child: Nav()),
                Container(child: Icon(Icons.directions_bike)),
                Container(child: Icon(Icons.directions_bike)),
              ],
            ),
            bottomNavigationBar: Container(
              color: Theme.of(context).canvasColor,
              child: TabBar(
                physics: NeverScrollableScrollPhysics(),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.all(5.0),
                labelPadding: EdgeInsets.all(5.0),
                isScrollable: false,
                indicatorWeight: 4,
                onTap: (index) {},
                tabs: [
                  Tab(
                    icon: SvgPicture.asset(
                      'assets/svg/call_1.svg',
                    ),
                  ),
                  Tab(
                    icon: SvgPicture.asset(
                      'assets/svg/appointment_1.svg',
                    ),
                  ),
                  Tab(
                      child: GestureDetector(
                          onTap: () {
                            try {
                              Utils.NavigatorKeyDate.currentState!
                                  .popAndPushNamed('/categoriesScreen');
                            } catch (error) {
                              try{
                                Utils.NavigatorKey.currentState!
                                    .pushReplacementNamed('/navDate');
                              }
                              catch(error){
                                Utils.mainNavigatorKey.currentState!
                                    .pushReplacementNamed('/tabScreen');
                              }
                              }


                          },
                          child: Image.asset('assets/images/home_icon_1.png'))),
                  Tab(
                    icon: SvgPicture.asset(
                      'assets/svg/notifications_1.svg',
                    ),
                  ),
                  Tab(
                    icon: SvgPicture.asset(
                      'assets/svg/settings_1.svg',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
