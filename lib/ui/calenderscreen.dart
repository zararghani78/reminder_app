import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminderapp/ui/datehome.dart'; // Ensure the correct import path
import 'package:reminderapp/ui/navigation.dart';
import 'package:reminderapp/ui/saveddata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Calenderscreen extends StatefulWidget {
  final int? periodDuration;

  const Calenderscreen({super.key,  this.periodDuration});

  @override
  State<Calenderscreen> createState() => _CalenderscreenState();
}

class _CalenderscreenState extends State<Calenderscreen> {
  String currentDate = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());
  String onlyDate = DateFormat('MMM d,').format(DateTime.now());
   DateTime? highlightedDay;

  @override
  void initState() {
    super.initState();
    _loadHighlightedDay();
  }

  Future<void> _loadHighlightedDay() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString('selected_date');
    final periodDuration = prefs.getInt('period_duration'); // Fetching period duration from SharedPreferences
    
    if (savedDate != null) {
      setState(() {
        DateTime selectedDay = DateTime.parse(savedDate);
        highlightedDay = selectedDay.add(Duration(days: periodDuration ?? widget.periodDuration ?? 25));
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.notifications_outlined, size: 34),
        title: Text(currentDate, style: const TextStyle(fontSize: 16)),
      ),
      body: ListView(
        children: [
          Container(
            height: 120,
            color: Color.fromARGB(255, 29, 141, 233),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Your Next Period Starts on",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                const SizedBox(height: 10),
                Container(
                  width: 160,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Text(
                    highlightedDay != null
                        ? DateFormat('d MMMM').format(highlightedDay!)
                        : 'no date is stored',
                    style: const TextStyle(
                       color:  Color.fromARGB(255, 29, 141, 233),fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 1),
          const DAYDATE(),
          const SizedBox(height: 8),
          MONTHCALENDER(highlightedDay: highlightedDay),
        ],
      ),
      bottomNavigationBar: const BottomNaviscreen(),
    );
  }
}
