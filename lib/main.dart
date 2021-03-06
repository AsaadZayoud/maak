import 'package:flutter/material.dart';
import 'package:maak/providers/appointmen_provider.dart';
import 'package:maak/providers/auth_provider.dart';
import 'package:maak/providers/call_us.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:maak/providers/payment.dart';
import 'package:maak/providers/profile_provider.dart';
import 'package:maak/providers/setting_provider.dart';
import 'package:maak/screens/login/otp.dart';
import 'package:maak/screens/nav/nav_home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maak/screens/on_boarding_screen.dart';
import 'package:maak/screens/profile_screen.dart';
import 'package:maak/screens/tab_screen.dart';
import 'package:provider/provider.dart';
import 'providers/service_provider.dart';
import 'screens/nav/nav.dart';


import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool setBegin =false;

if( prefs.getBool('watched') == null){

}
else{

  setBegin = prefs.getBool('watched')!;

}
  print(setBegin);
  Widget homeScreen = setBegin ? NavHome() : OnBoardingScreen();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ServiceProvider>(
        create: (context) => ServiceProvider(),
      ),
      ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
      ),
      ChangeNotifierProvider<LanguageProvider>(
        create: (context) => LanguageProvider(),
      ),
      ChangeNotifierProvider<SettingProvider>(
        create: (context) => SettingProvider(),
      ),
      ChangeNotifierProvider<CallUsProvider>(
        create: (context) => CallUsProvider(),
      ),
      ChangeNotifierProvider<ProfileProvider>(
        create: (context) => ProfileProvider(),
      ),
      ChangeNotifierProvider<appointmenProvider>(
        create: (context) => appointmenProvider(),
      ),
      ChangeNotifierProvider<paymentProvider>(
        create: (context) => paymentProvider(),
      ),

    ],
    child: MyApp(homeScreen),
  ));
}

class MyApp extends StatelessWidget {
  final Widget homeScreen;
  MyApp(this.homeScreen);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    lan.getLan();
    var tm = Provider.of<SettingProvider>(context, listen: true).tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: tm,
      darkTheme: ThemeData(
        fontFamily:  lan.isEn ? 'Exo' : 'FrutigerLTArabic',
          brightness: Brightness.dark,
          primaryColor: Colors.black54,
          accentColor: Colors.black54

          /* dark theme settings */
          ),
      theme: ThemeData(

             fontFamily:  lan.isEn ? 'Exo' : 'FrutigerLTArabic',


          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Colors.green,

          accentColor: Colors.blue),

      localizationsDelegates: [

        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('ar', ''), // Arabic
      ],
      initialRoute: '/', // d


 //     navigatorKey: Utils.mainNavigatorKey,
      routes: {
        '/' : (ctx) => homeScreen,
        OtpForm.routeName: (ctx) => OtpForm(),
        NavHome.routeName: (ctx) => NavHome(),
        Nav.routeName: (ctx) => Nav(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        OnBoardingScreen.routeName: (ctx) => OnBoardingScreen(),
        TabScreen.routeName: (ctx) => TabScreen(),

      },

      // home: ListItem()
    );
  }
}
