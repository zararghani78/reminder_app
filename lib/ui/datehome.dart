import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages



class Dateclass extends StatefulWidget {
  const Dateclass({super.key});

  @override
  State<Dateclass> createState() => _DateclassState();
}

class _DateclassState extends State<Dateclass> {
  String currentDate = DateFormat('d').format(DateTime.now());

  // Function to get the next 7 days
  List<String> getNext7Days() {
    DateTime now = DateTime.now();
    return List.generate(7, (index) {
      DateTime date = now.add(Duration(days: index));
      return DateFormat('d').format(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> next7Days = getNext7Days();

    return Container(
      color: Color.fromARGB(255, 29, 141, 233),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: next7Days.map((day) {
                bool isCurrentDate = day == currentDate;
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isCurrentDate ? const Color.fromARGB(255, 238, 236, 236) : Color.fromARGB(255, 29, 141, 233), // Change background color based on the condition
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    day,
                    style: TextStyle(color: isCurrentDate ?Color.fromARGB(255, 29, 141, 233): Colors.white),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}




class DAYDATE extends StatefulWidget {
  const DAYDATE({super.key});

  @override
  State<DAYDATE> createState() => _DAYDATEState();
}

class _DAYDATEState extends State<DAYDATE> {
  String currentDate = DateFormat('E').format(DateTime.now());

  // Function to get the next 7 days
  List<String> getNext7Days() {
    DateTime now = DateTime.now();
    return List.generate(7, (index) {
      DateTime date = now.add(Duration(days: index));
      return DateFormat('E').format(date)[0]; // Extract the first character
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> next7Days = getNext7Days();

    return Container(
      color: Color.fromARGB(255, 29, 141, 233),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: next7Days.map((day) {
                bool isCurrentDate = day == currentDate;
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isCurrentDate ? const Color.fromARGB(255, 238, 236, 236) : Color.fromARGB(255, 29, 141, 233),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    day,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0
