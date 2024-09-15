import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminderapp/routes/routes_name.dart';
import 'package:reminderapp/ui/setingpage/pages2/home_setting.dart';
import 'package:reminderapp/ui/setingpage/pages2/profle_scren.dart';
import 'package:reminderapp/utilis/themechange.dart';
import 'package:shared_preferences/shared_preferences.dart';




class VerticalNavigationScreen extends StatefulWidget {
  @override
  _VerticalNavigationScreenState createState() =>
      _VerticalNavigationScreenState();
}

class _VerticalNavigationScreenState extends State<VerticalNavigationScreen> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loadSelectedIndex();
  }

  Future<void> _loadSelectedIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('selected_index') ?? 0;
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  Future<void> _saveSelectedIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('selected_index', index);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
    _saveSelectedIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());
    return Scaffold(
       appBar: AppBar(
         leading: const Icon(Icons.notifications_outlined,size: 34,),
  title: Text(currentDate,style: const TextStyle(fontSize: 16),),
 
      ),
      body: Row(
        children: [
          NavigationMenu(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                _saveSelectedIndex(index);
              },
              children: [
                Page1(),
                PROFILESCREEN(),
                Page3(),
                Page4(),
                Page5(),
                Page6(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationMenu extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  NavigationMenu({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          color:Color.fromARGB(255, 29, 141, 233),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10)
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: NavigationItem(
                text: 'Home',
                index: 0,
                selectedIndex: selectedIndex,
                onTap: onItemTapped,
              ),
            ),
            NavigationItem(
              text: 'Profile',
              index: 1,
              selectedIndex: selectedIndex,
              onTap: onItemTapped,
            ),
           
            NavigationItem(
              text: 'Setting',
              index: 3,
              selectedIndex: selectedIndex,
              onTap: onItemTapped,
            ),
           
           
          ],
        ),
      ),
    );
  }
}

class NavigationItem extends StatelessWidget {
  final String text;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  NavigationItem({
    required this.text,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(index),
      child: Padding(
     padding: EdgeInsets.only(top: 20,left: 20),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
             color: selectedIndex == index ? Colors.white : Color.fromARGB(255, 29, 141, 233),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15)
              
            )
          ),
          padding: EdgeInsets.all(10),
         
          child: Text(
            text,
            style: TextStyle(
              color: selectedIndex == index ?  Color.fromARGB(255, 29, 141, 233): Colors.white,
              fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}


class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Settings Page'));
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final themeProvider=Provider.of<ThemeProvider>(context);
    return Center(child:   Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: themeProvider.isDarkMode? Colors.white:Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_circle),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.periodesetting);
                          },
                          child: Text("Cycle Setting"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: themeProvider.isDarkMode? Colors.white:Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_circle),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.cyclesetting);
                          },
                          child: Text("Periode Setting"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                   Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color:themeProvider.isDarkMode? Colors.white:Colors.black),
              ),
              child: SwitchListTile(
                title: SizedBox( width:150, child: Text( themeProvider.isDarkMode ?'Dark Mode':'Light Mode',style: TextStyle(fontSize: 11),)),
                value: themeProvider.isDarkMode,
                onChanged: (bool value) {
                  themeProvider.toggleTheme();
                },
              ),
            ),
        ],
      ),
    ));
  }
}

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page 5'));
  }
}

class Page6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page 6'));
  }
}
