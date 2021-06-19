import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/providers/utils.dart';
import 'package:maak/screens/profile_screen.dart';

import 'calendar.dart';
import 'home.dart';
import 'nav.dart';


class TabScreen extends StatefulWidget {
   TabScreen({Key? key}) : super(key: key);
   static const routeName = '/tabScreen';

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with SingleTickerProviderStateMixin  {


  @override
  void initState() {
    // TODO: implement initState

    super.initState();



  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: DefaultTabController(

        initialIndex: 2,

        length: 5,
        child: Scaffold(

         appBar: AppBar(backgroundColor: Theme.of(context).canvasColor,
         elevation: 0,

         leading:
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Builder(
                     builder: (context) =>
                         IconButton(
                           icon: SvgPicture.asset(
                             'assets/svg/drawer.svg',
                             height: 15,
                             width: 34,
                           ),
                           onPressed: () => Scaffold.of(context).openDrawer(),
                         ),
                 ),
                  ),
actions: [
  Padding(
 padding: const EdgeInsets.only(right: 20),
    child: GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );

      }
      ,child: CircleAvatar(
      radius: 18,
      child: ClipOval(
        child: Image.asset(
          'assets/images/profile.png',
        ),
      ),
    ),
    ),
  )
],
  ),
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
          body:
          TabBarView(


            children: [


              Calendar(),
              Container(child: Icon(Icons.directions_transit)),
              Container(child: Nav()),
              Container(child: Icon(Icons.directions_bike)),
              Container(child: Icon(Icons.directions_bike)),

            ],
          ),
          bottomNavigationBar:
          Container(
            color: Theme.of(context).canvasColor,
            child: TabBar(

              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(5.0),
              labelPadding: EdgeInsets.all(5.0),




              indicatorWeight: 4,
onTap: (index){

},

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







                      child:

                         GestureDetector(
                         onTap: (){
                           try {
                             Utils.NavigatorKey.currentState!.popAndPushNamed('/home');
                           }
                           catch(error){
                            

                             Utils.mainNavigatorKey.currentState!.pushReplacementNamed('/tabScreen');

                           }
                         }
                         ,child: Image.asset('assets/images/home_icon_1.png'))),



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
    );





  }


}
