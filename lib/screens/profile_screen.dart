import 'package:flutter/material.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    var lan = Provider.of<LanguageProvider>(context,listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text('${lan.getTexts('profile')}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: deviceSize.height*0.05,),
         Center(child:  Text('${lan.getTexts('name')} : ${lan.isEn ? 'Asaad' : "اسعد"}',style:Theme.of(context).textTheme.headline6 ,)),
          SizedBox(height: deviceSize.height*0.03,),
          Text('${lan.getTexts('age')} : 23',style:Theme.of(context).textTheme.headline6),
          SizedBox(height: deviceSize.height*0.1,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
          SizedBox(height: deviceSize.height*0.1,),
          MaterialButton(shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),onPressed: (){},child:Text('${lan.getTexts('logout')}',
            style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),),elevation: 8,color: Colors.green),
          SizedBox(height: deviceSize.height*0.1,),
          MaterialButton(shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),onPressed: (){},child:Text('${lan.getTexts('delete_account')}  ',
            style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),),elevation: 8,color: Colors.red)


        ],
      ),
    );
  }
}
