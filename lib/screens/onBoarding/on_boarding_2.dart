import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:provider/provider.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage("assets/images/back.jpg"),
              fit: BoxFit.cover,

          ),

      ),
      child:
      Center(
        child: Container(
          alignment: Alignment.center,
          width:  MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.4,
          color: Theme.of(context).accentColor.withOpacity(0.5),
          padding:
          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${lan.getTexts('home_medical_services')}",

                style: Theme.of(context).textTheme.headline5,
                softWrap: true,

                overflow: TextOverflow.fade,
              ),

              Text(
                  "${lan.getTexts('detail_services')}",

                style: Theme.of(context).textTheme.headline6,
                softWrap: true,
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
