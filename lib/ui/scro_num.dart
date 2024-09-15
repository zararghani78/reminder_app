import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberScroll extends StatelessWidget {
    final int maxNumber;

  const NumberScroll({Key? key, required this.maxNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
       
       
         ListView.builder(
          itemCount: maxNumber,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${index + 1}'),
            );
          },
        ),
      
    );
  }
}



class DATESCROLL extends StatelessWidget {
  final DateTime startDate;
  final int itemCount;

  DATESCROLL({Key? key, required this.startDate, required this.itemCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // Calculate the date for the current index
        DateTime currentDate = startDate.add(Duration(days: index));
        // Format the date to display day name, month, day, and year
        String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(currentDate);

        return ListTile(
          title: Text(formattedDate),
        );
      },
    );
  }
}