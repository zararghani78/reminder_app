import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CycleSetting extends StatefulWidget {
  const CycleSetting({super.key});

  @override
  State<CycleSetting> createState() => _CycleSettingState();
}

class _CycleSettingState extends State<CycleSetting> {
  int storeddays=4 ; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    cyclesetting(); // Load stored data when the widget is first created
  }

Future<void> cyclesetting() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    storeddays = prefs.getInt('cycle_duration') ?? 4; // Default to 28 if not set
  });
}

  Future<void> _updateperiodedata() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('cycle_duration', storeddays); // Store as integer
}

  void increment() {
    setState(() {
      if (storeddays < 7) {
        storeddays++;
        _updateperiodedata(); // Update SharedPreferences when the value changes
      }
    });
  }

  void decrement() {
    setState(() {
      if (storeddays > 4) {
        storeddays--;
        _updateperiodedata(); // Update SharedPreferences when the value changes
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Periode duration"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Periode Duration",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(
                    '$storeddays',
                    style: const TextStyle(),
                  ),
                ),
                const SizedBox(width: 3),
                Container(
                  width: 70,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Text(
                    "Days",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 40),
                Container(
                  alignment: Alignment.center,
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: increment,
                    child: const Text(
                      "+",
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 3),
                Container(
                  width: 70,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: decrement,
                    child: const Text(
                      "-",
                      style: TextStyle(fontSize: 50, color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            const Text("Periode usually lasts between 4-7 days"),
            const SizedBox(height: 13),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 220,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  onPressed: _updateperiodedata,
                  child: const Text("Set", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
