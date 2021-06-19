

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maak/providers/language_provider.dart';


import 'package:provider/provider.dart';
import 'package:flutter_button/flutter_button.dart';


import 'package:maak/providers/setting_provider.dart';
import 'package:maak/screens/help.dart';
import 'package:maak/screens/privacy_policy.dart';
import 'package:maak/screens/questions.dart';
import 'package:maak/screens/support.dart';
import 'package:provider/single_child_widget.dart';
import 'package:settings_ui/settings_ui.dart';
import 'about_application.dart';
import 'send_feedback.dart';



class Setting extends StatelessWidget {
   Setting({Key? key}) : super(key: key);
  static const routeName = '/setting';
  @override
  Widget build(BuildContext context) {
     var activeProvider=  Provider.of<SettingProvider>(context, listen: true);
     var inactiveProvider=  Provider.of<SettingProvider>(context, listen: false);
     var lan = Provider.of<LanguageProvider>(context, listen: true);
     var lanChange = Provider.of<LanguageProvider>(context, listen: false);
     SettingsTile switchTile(title,icon,value,call){
    return  SettingsTile.switchTile(
        title: title,
        leading: Icon(icon),
        switchValue:value,

        onToggle: (bool value) {
        call();
        },

      );
    }

     SettingsTile settingsTile(title,icon,routeName){
       return  SettingsTile(
         title: title,
         leading: Icon(icon),

        onPressed: (BuildContext context){
           Navigator.pushNamed(context, routeName);
        },

       );
     }

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
       child: Scaffold(
      appBar: AppBar(title: Text('Settings'),

      automaticallyImplyLeading: true,
        centerTitle: true,

       actions: [

         DropdownButton(underline: SizedBox(),
             iconSize: 30,
             icon: Icon(Icons.language,),
             items: <DropdownMenuItem<int>>[ DropdownMenuItem(
               value: 0,
               child:
               Text('English',
                 style: TextStyle(fontSize: 20),
               ),
             ),
               DropdownMenuItem(
                 value: 1,
                 child:
                 Text('Arabic',
                   style: TextStyle(fontSize: 20),
                 ),
               ),


             ],
             onChanged: (val){
              if(val == 0){
                lanChange.changeLan(true);
              }
              else {
                lanChange.changeLan(false);
              }

             }

         ),
         SizedBox(width: 20,),
       ],


      ),
      body:
            Container(child:
            SettingsList(
              backgroundColor: Theme.of(context).accentColor,
              sections: [
                SettingsSection(

                  tiles: [

                    switchTile(lan.getTexts('permission'),Icons.perm_device_information,activeProvider.permission,inactiveProvider.per),
                    switchTile('Push Notifications',Icons.notifications,activeProvider.pushNotifications,inactiveProvider.pushNot),
                    switchTile('Location Services',Icons.electrical_services_rounded,activeProvider.locationServices,inactiveProvider.LocServ),


              SettingsTile.switchTile(
                title:'ThemeMode',
                leading:Icon(Icons.dark_mode),
                switchValue:activeProvider.themeMode,

                onToggle: (bool value) {
                  inactiveProvider.themeModeChange();
                },

              )
                  ],

                ),

                SettingsSection(
                  title: 'Help',
                  tiles: [
                    settingsTile('Help', Icons.help,Help.routeName ),
                    settingsTile('About Application', Icons.more,AboutApplication.routeName ),
                    settingsTile('Send Feedback', Icons.feedback,SendFeedback.routeName ),
                    settingsTile('Support', Icons.support,Support.routeName ),
                    settingsTile('Frequently Asked Questions', Icons.question_answer,Questions.routeName ),
                    settingsTile('privacy Policy', Icons.policy,PrivacyPolicy.routeName ),
                  ],
                ),
                SettingsSection(
                  title: 'Logout',
                  tiles: [
                    SettingsTile(
                      titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      onPressed: (BuildContext ctx){},
                        leading: Icon(Icons.logout),
                        title: 'Sign Out')
                  ],
                ),

              ],
            )
              ,)

    ));
  }
}
