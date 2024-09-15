import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DATESCROLL extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final Function(DateTime) onDateSelected;

  const DATESCROLL({
    required this.startDate,
    required this.endDate,
    required this.onDateSelected,
  });

  @override
  _DATESCROLLState createState() => _DATESCROLLState();
}

class _DATESCROLLState extends State<DATESCROLL> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _saveSelectedDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_date', date.toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: CupertinoDatePicker(
        initialDateTime: selectedDate,
        onDateTimeChanged: (DateTime newTime) {
          setState(() {
            selectedDate = newTime;
          });
          widget.onDateSelected(newTime);
          _saveSelectedDate(newTime);
        },
        use24hFormat: true,
        mode: CupertinoDatePickerMode.date,
      ),
    );
  }
}
