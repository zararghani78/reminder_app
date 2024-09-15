
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminderapp/routes/routes_name.dart';
import 'package:reminderapp/utilis/themechange.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: EdgeInsets.all(9.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 10, right: 10, bottom: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: themeProvider.isDarkMode? Colors.white:Colors.black),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.message_outlined),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.termsofservices);
                    },
                    child: Text("Term of Services"),
                  ),
                ],
              ),
            ),
       
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: themeProvider.isDarkMode? Colors.white:Colors.black),
              ),
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.notification);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.alarm),
                    SizedBox(width: 7),
                    Text("Reminder"),
                  ],
                ),
              ),
            ),
          
          
           
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.aboutpage);
              },
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: themeProvider.isDarkMode? Colors.white:Colors.black),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.stop_outlined),
                    SizedBox(width: 7),
                    Text("About"),
                  ],
                ),
              ),
            ),
          
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.getpage);
              },
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color:themeProvider.isDarkMode? Colors.white:Colors.black),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.storage),
                    SizedBox(width: 7),
                    Text("Access your data"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
           
          ],
        ),
      ),
    );
  }
}
