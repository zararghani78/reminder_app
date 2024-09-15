
import 'package:flutter/material.dart';
import 'package:reminderapp/routes/routes_name.dart';
import 'package:reminderapp/ui/about_page.dart';
import 'package:reminderapp/ui/access_page.dart';
import 'package:reminderapp/ui/calenderscreen.dart';
import 'package:reminderapp/ui/home_screen.dart';
import 'package:reminderapp/ui/nextdate_page.dart';
import 'package:reminderapp/ui/setingpage/cycle_setting.dart';
import 'package:reminderapp/ui/setingpage/periode_setting.dart';
import 'package:reminderapp/ui/setingpage/setting_ui.dart';
import 'package:reminderapp/ui/setingpage/termofservices.dart';
import 'package:reminderapp/ui/splashscreen/splashscreen.dart';

class RouteLinks {



  static Route<dynamic> generateroutes(RouteSettings settings){

switch (settings.name){
  case RoutesName.splashscreen:
  return MaterialPageRoute(builder: (BuildContext context)=> const SplashScreen());
 case RoutesName.splashtwo:
  return MaterialPageRoute(builder: (BuildContext context)=> const Splashscreentwo());

case RoutesName.homescreen:
  return MaterialPageRoute(builder: (BuildContext context)=> const HomeScreen ());

case RoutesName.calenderscreen:
  return MaterialPageRoute(builder: (BuildContext context)=> const Calenderscreen ());

case RoutesName.settingscreen:
  return MaterialPageRoute(builder: (BuildContext context)=>  VerticalNavigationScreen());

case RoutesName.aboutpage:
  return MaterialPageRoute(builder: (BuildContext context)=>  ABOUTPAGE());

case RoutesName.getpage:
  return MaterialPageRoute(builder: (BuildContext context)=> ACCESSPAGE ());
case RoutesName.nextpage:
  return MaterialPageRoute(builder: (BuildContext context)=> NEXTPERIODE ());

  case RoutesName.termsofservices:
  return MaterialPageRoute(builder: (BuildContext context)=> TERMSOFSERVICES ());
   case RoutesName.periodesetting:
  return MaterialPageRoute(builder: (BuildContext context)=> PERIODESETTING());
   case RoutesName.cyclesetting:
  return MaterialPageRoute(builder: (BuildContext context)=> CycleSetting());


  default:
      return MaterialPageRoute(builder: (_) {
        return Scaffold(
          body: Center(
            child: Text("No route defined for ${settings.name}"),
          ),
        );
      });
}

  }


}