import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminderapp/routes/routes_name.dart';
import 'package:reminderapp/utilis/themechange.dart';

class BottomNaviscreen extends StatefulWidget {
  const BottomNaviscreen({super.key});

  @override
  State<BottomNaviscreen> createState() => _BottomNaviscreenState();
}

enum SelectedTab { home, calendar, settings }

class _BottomNaviscreenState extends State<BottomNaviscreen> {
  SelectedTab? selectedTab;

  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 50,
      color: themeProvider.isDarkMode? Colors.white:Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                selectedTab = SelectedTab.home;
              });
              Navigator.pushNamed(context, RoutesName.homescreen);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selectedTab == SelectedTab.home
                    ? Colors.white
                    : Color.fromARGB(255, 29, 141, 233),
              ),
              child: Icon(
                Icons.home,
                size: 32,
                color: selectedTab == SelectedTab.home
                    ? Color.fromARGB(255, 29, 141, 233)
                    : Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedTab = SelectedTab.calendar;
              });
              Navigator.pushNamed(context, RoutesName.calenderscreen);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selectedTab == SelectedTab.calendar
                    ? Colors.white
                    : Color.fromARGB(255, 29, 141, 233),
              ),
              child: Icon(
                Icons.lock_clock,
                size: 32,
                color: selectedTab == SelectedTab.calendar
                    ? Color.fromARGB(255, 29, 141, 233)
                    : Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedTab = SelectedTab.settings;
              });
              Navigator.pushNamed(context, RoutesName.settingscreen);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selectedTab == SelectedTab.settings
                    ? Colors.white
                    : Color.fromARGB(255, 29, 141, 233),
              ),
              child: Icon(
                Icons.settings,
                size: 32,
                color: selectedTab == SelectedTab.settings
                    ? Color.fromARGB(255, 29, 141, 233)
                    : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
