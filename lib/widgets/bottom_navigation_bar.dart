
import 'package:flutter/material.dart';
import 'package:maak/models/call_us.dart';
import 'package:maak/screens/callus.dart';

class bottomNavigationBar extends StatelessWidget {
  const bottomNavigationBar({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {



    return BottomAppBar(
      elevation: 8,


      color:Theme.of(context).accentColor ,
      child: Row(

        children: [
          SizedBox(width: 20,),
          IconButton(icon: Icon(Icons.call), onPressed: () {
            Navigator.of(context).pushNamed(CallUsScreen.routeName);
          },color:Theme.of(context).bottomAppBarColor ,),
          IconButton(icon: Icon(Icons.task), onPressed: () {},color:Theme.of(context).bottomAppBarColor),
          Spacer(),
          IconButton(icon: Icon(Icons.menu_open_sharp), onPressed: () {},color:Theme.of(context).bottomAppBarColor),
          IconButton(icon: Icon(Icons.account_balance_wallet_rounded), onPressed: () {},color:Theme.of(context).bottomAppBarColor),
          SizedBox(width: 20,)
        ],
      ),
    );
  }
}
