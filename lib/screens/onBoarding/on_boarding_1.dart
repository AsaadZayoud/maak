import 'package:maak/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage("assets/images/Cover.jpg"),
          fit: BoxFit.cover,

        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.center,
            width: 300,
            color: Theme.of(context).accentColor.withOpacity(0.5),
            padding:
            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Text(
              "${lan.getTexts('Maak')}",
              style: Theme.of(context).textTheme.headline6,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
          Container(
            width: 350,
            color: Theme.of(context).accentColor.withOpacity(0.5),
            padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Text(
                  "${lan.getTexts('choose_your_language')}",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${lan.getTexts('lan_ar')}",
                        style: Theme.of(context).textTheme.headline6),
                    Switch(
                      value: lan.isEn,
                      onChanged: (newValue) {
                        Provider.of<LanguageProvider>(context,
                            listen: false)
                            .changeLan(newValue);
                      },
                    ),
                    Text("${lan.getTexts('lan_en')}" , style: Theme.of(context).textTheme.headline6),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
