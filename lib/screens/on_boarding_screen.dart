import 'package:flutter/material.dart';
import 'package:maak/screens/nav/nav.dart';
import 'package:maak/screens/nav/nav_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import 'onBoarding/on_boarding_1.dart';
import 'onBoarding/on_boarding_2.dart';
import 'onBoarding/on_boarding_3.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = '/on_boarding';
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).accentColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [OnBoarding1(), OnBoarding2(), OnBoarding3()],
            onPageChanged: (val) {
              setState(() {
                _currentIndex = val;
              });
            },
          ),
          Indicator(_currentIndex),
          Align(
            alignment: Alignment(0, 0.85),
            child: Container(
             
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                
                style: ElevatedButton.styleFrom(
                  padding: lan.isEn ? EdgeInsets.all(7) : EdgeInsets.all(0),
                  primary: primaryColor.withOpacity(0.8),
                ),
                child: Text(
                  "${lan.getTexts('start')}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.of(context).pushReplacementNamed(NavHome.routeName);

                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  prefs.setBool('watched', true);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int index;

  Indicator(this.index);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(context, 0),
          buildContainer(context, 1),
          buildContainer(context, 2),
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext ctx, int i) {
    return index == i
        ? Icon(Icons.star, color: Theme.of(ctx).primaryColor)
        : Container(
            margin: EdgeInsets.all(4),
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: Theme.of(ctx).accentColor,
              shape: BoxShape.circle,
            ),
          );
  }
}
