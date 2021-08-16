import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:provider/provider.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({Key? key}) : super(key: key);

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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).accentColor.withOpacity(0.5),
          ),
          alignment: Alignment.center,
          width:  MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.7,

          padding:
          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: ListView(
            children: [
              Text(
                "${lan.getTexts('description')}",

                style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
                softWrap: true,

                overflow: TextOverflow.fade,
              ),

              Text("* ${lan.getTexts('on_boarding3_1')}",  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                softWrap: true,

                overflow: TextOverflow.fade,),
              Text("* ${lan.getTexts('on_boarding3_2')}",  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                softWrap: true,

                overflow: TextOverflow.fade,),
              Text("* ${lan.getTexts('on_boarding3_3')}",  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                softWrap: true,

                overflow: TextOverflow.fade,),


            ],
          ),
        ),
      ),
    );
  }
}
