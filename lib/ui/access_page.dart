import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminderapp/utilis/themechange.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ACCESSPAGE extends StatefulWidget {
  const ACCESSPAGE({Key? key}) : super(key: key);

  @override
  _ACCESSPAGEState createState() => _ACCESSPAGEState();
}

class _ACCESSPAGEState extends State<ACCESSPAGE> {
  DateTime? _selectedDate;
  int? _daysRemaining;

  Future<DateTime?> _getAccess() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedDate = prefs.getString('selected_date');
   
    if (savedDate != null) {
      return DateTime.parse(savedDate);
    }
    return null;
  }
Future<void> _removeAllData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('selected_date');
  // You can add additional keys to remove here, if any
 await prefs.remove('period_duration');
  // Clear any other stored data related to period information
  setState(() {
    _selectedDate = null;
    _daysRemaining = null; // Clear days remaining when data is removed
  });
}


  @override
  void initState() {
    super.initState();
    _getAccess().then((date) {
      setState(() {
        _selectedDate = date;
        if (_selectedDate != null) {
          _calculateDaysRemaining();
        }
      });
    });
  }

  void _calculateDaysRemaining() {
    if (_selectedDate != null) {
      final today = DateTime.now();
      final difference = _selectedDate!.difference(today).inDays;
      setState(() {
        _daysRemaining = difference;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   final themeProvider = Provider.of<ThemeProvider>(context);
   
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the color of the back arrow icon
        ),
        backgroundColor: const Color.fromARGB(255, 29, 141, 233),
        title: const Text(
          "Your period date",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedDate != null)
              Dismissible(
                key: Key(_selectedDate.toString()),
                onDismissed: (direction) {
                  _removeAllData();
                },
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [

                    
                      
                  const SizedBox(height: 10,),
                      Container(
                        alignment: Alignment.center,
                        width: 280,
                        height: 160,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 29, 141, 233),
                          border: Border.all(width: 1,color:  themeProvider.isDarkMode? Colors.white:Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                        
                          children: [
                            
                             const SizedBox(height: 20),
                            _daysRemaining != null
                                ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        '$_daysRemaining ',
                                        style: const TextStyle(color: Colors.white,fontSize: 25, fontWeight: FontWeight.bold),
                                      ),
                                       const Text(
                                        ' : days Left',
                                        style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                  ],
                                )
                                : Container(),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('MMM dd').format(_selectedDate!),
                                  style: const TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold),
                                ),  const SizedBox(width: 7),
                                 const Text(
                              ": Next periode ",
                              style: TextStyle(color: Colors.white,fontSize: 14,
                              fontWeight: FontWeight.bold),
                            ),
                              ],
                            ),
                           
                           
                            
                          ],
                        ),
                      ),
                  
                    ],
                  ),
                ),
              )
            else
              const Center(
                child: Text('No stored date found.'),
              ),
          ],
        ),
      ),
    );
  }
}
