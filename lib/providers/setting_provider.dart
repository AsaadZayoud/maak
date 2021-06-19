import 'package:flutter/material.dart';
class SettingProvider with ChangeNotifier{
  var tm = ThemeMode.light;
 bool permission = false;
 bool pushNotifications = false;
 bool locationServices = false;
 bool themeMode =  false;

  void per() {
   this.permission = !this.permission;
   notifyListeners();
 }
 void pushNot() {
   this.pushNotifications = !this.pushNotifications;
   notifyListeners();
 }
 void LocServ() {
   this.locationServices = !this.locationServices;
   notifyListeners();
 }


 void themeModeChange()  {
   themeMode= !themeMode;
   notifyListeners();
   if (tm == ThemeMode.dark){
     tm = ThemeMode.light;
     notifyListeners();
   }
   else
     {
       tm = ThemeMode.dark;
       notifyListeners();

     }



 }


}


