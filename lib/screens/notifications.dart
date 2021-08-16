import 'package:flutter/material.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:maak/providers/profile_provider.dart';
import 'package:provider/provider.dart';


class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var profile = Provider.of<ProfileProvider>(context, listen: false);
    Future<void> refresh() async {
      // await Provider.of<ProfileProvider>(context, listen: false)
      //     .getNotificattion(id);
      setState(() {});
    }

    return RefreshIndicator(
      onRefresh: () => refresh(),
      child: Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false,elevation: 0
            ,centerTitle: true,title: Text('${lan.getTexts('notifications')}',style: TextStyle(color: Colors.black),)
            ,backgroundColor: Theme.of(context).canvasColor,),
          body: Container(
            margin: EdgeInsets.only(top: 20, right: 5, left: 5),
            child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: ()  {

                            }

                          ,
                          child: Card(
                            color: Colors.green,
                            margin: EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(
                                  '${lan.isEn ? 'aasaad' : 'اسعد'}'),
                              leading: Icon(
                                Icons.notifications_active,

                              ),
                              subtitle: Text(
                                  '${lan.isEn ? 'content notification' : 'محنوى الاشعار'}'),

                            ),

                          ),
                        );
                      },
                      itemCount: 5,
                    ),

                ),
),
    )
    );
  }
}
