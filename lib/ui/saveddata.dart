import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class MONTHCALENDER extends StatefulWidget {
  final DateTime? highlightedDay;

  const MONTHCALENDER({Key? key, this.highlightedDay}) : super(key: key);

  @override
  _MONTHCALENDERState createState() => _MONTHCALENDERState();
}

class _MONTHCALENDERState extends State<MONTHCALENDER> {
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _highlightedDay;
  DateTime? _savedDate;

  @override
  void initState() {
    super.initState();
    _loadSelectedDate();
    _highlightedDay = widget.highlightedDay; // Use the passed parameter
  }

  Future<void> _loadSelectedDate() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedDate = prefs.getString('selected_date');
    if (savedDate != null) {
      setState(() {
        _savedDate = DateTime.parse(savedDate);
        _highlightedDay = DateTime.parse(savedDate);
      });
    }
  }

  Future<void> _saveSelectedDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selected_date', date.toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime(2020),
          lastDay: DateTime(2030),
          focusedDay: _focusedDay,
          calendarFormat: calendarFormat,
          daysOfWeekVisible: false,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          rowHeight: 40,
          calendarBuilders: CalendarBuilders(
            outsideBuilder: (context, day, focusedDay) {
              return Container(); // Hides the outside month days
            },
            defaultBuilder: (context, day, focusedDay) {
              if (isSameDay(day, _savedDate)) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  margin: const EdgeInsets.all(6.0),
                  width: 30,
                  height: 30,
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: const TextStyle().copyWith(color: Colors.white),
                    ),
                  ),
                );
              } else if (_savedDate != null &&
                  day.isAfter(_savedDate!.subtract(Duration(days: 5))) &&
                  day.isBefore(_savedDate!)) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  margin: const EdgeInsets.all(6.0),
                  width: 30,
                  height: 30,
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: const TextStyle().copyWith(color: Colors.white),
                    ),
                  ),
                );
              }
              return Center(
                child: Text('${day.day}'),
              );
            },
          ),
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
          ),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _highlightedDay = selectedDay.add(Duration(days: 25));
              _focusedDay = focusedDay;
              _savedDate = selectedDay;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.all(9),
          child: Container(
            alignment: Alignment.center,
            width: 300,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 29, 141, 233),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, size: 25, color: Colors.white),
                    onPressed: () {
                      if (_selectedDay != null) {
                        setState(() {
                          _focusedDay = _selectedDay!;
                          _highlightedDay = _selectedDay!.add(Duration(days: 25));
                          _savedDate = _selectedDay!;
                        });
                        _saveSelectedDate(_selectedDay!);
                      }
                    },
                  ),
                ),
                if (_selectedDay != null)
                  const Text(
                    "Add new events",
                    style: TextStyle(color: Color.fromARGB(255, 29, 141, 233),),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
