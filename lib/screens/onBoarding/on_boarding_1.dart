import 'package:flutter/cupertino.dart';
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
          image: ExactAssetImage("assets/images/back.jpg"),
          fit: BoxFit.cover,

        ),
      ),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
      height: MediaQuery.of(context).size.height*0.22,
        width: MediaQuery.of(context).size.width*0.9
          ,child: Image.asset("assets/images/logo.png")),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),    color: Theme.of(context).accentColor.withOpacity(0.5),),
            height: MediaQuery.of(context).size.height*0.22,
            width: MediaQuery.of(context).size.width*0.9,

            padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.only(bottom: 130),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${lan.getTexts('choose_your_language')}",
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${lan.getTexts('lan_ar')}",
                        style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white)),
                    Switch(
                      value: lan.isEn,
                      onChanged: (newValue) {
                        Provider.of<LanguageProvider>(context,
                            listen: false)
                            .changeLan(newValue);
                      },
                    ),
                    Text("${lan.getTexts('lan_en')}" , style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white)),

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
