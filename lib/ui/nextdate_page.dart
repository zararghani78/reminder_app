import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NEXTPERIODE extends StatefulWidget {
  const NEXTPERIODE({Key? key}) : super(key: key);

  @override
  _NEXTPERIODEState createState() => _NEXTPERIODEState();
}

class _NEXTPERIODEState extends State<NEXTPERIODE> {
  
 String currentDatee = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());
  String onlyDatee = DateFormat('MMM d,').format(DateTime.now());
  DateTime? highlightedDay;

  @override
  void initState() {
    super.initState();
    _loadHighlightedDay();
  }

  Future<void> _loadHighlightedDay() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString('selected_date');
    if (savedDate != null) {
      setState(() {
        DateTime selectedDay = DateTime.parse(savedDate);
        highlightedDay = selectedDay.add(Duration(days: 25));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
    color: Colors.white, // Set the color of the back arrow icon
  ),
        backgroundColor: Color.fromARGB(255, 29, 141, 233),
        title: const Text(
          "Your  next periode start",
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
               Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    alignment: Alignment.center,
                    width: 280,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 29, 141, 233),
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Your Next periode started on ",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),
                        Text(
                        highlightedDay != null
                            ? DateFormat('d MMMM').format(highlightedDay!)
                            : 'no date is stored',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                                          ),
                      ],
                    ),
                  ),
                ),
                   
          ],
        ),
      ),
    );
  }
}
