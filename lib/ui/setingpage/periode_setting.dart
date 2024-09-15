import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PERIODESETTING extends StatefulWidget {
  const PERIODESETTING({super.key});

  @override
  State<PERIODESETTING> createState() => _PERIODESETTINGState();
}

class _PERIODESETTINGState extends State<PERIODESETTING> {
  int storedperiode = 28; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    periodesetting(); // Load stored data when the widget is first created
  }

  Future<void> periodesetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      storedperiode = prefs.getInt('period_duration') ?? 28; // Default to 1 if not set
    });
  }

  Future<void> _updateperiodedata() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('period_duration', storedperiode);
  }

  void increment() {
    setState(() {
      if (storedperiode < 35) {
        storedperiode++;
        _updateperiodedata(); // Update SharedPreferences when the value changes
      }
    });
  }

  void decrement() {
    setState(() {
      if (storedperiode > 23) {
        storedperiode--;
        _updateperiodedata(); // Update SharedPreferences when the value changes
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Periode duration", style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 9, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Cycle Duration", style: TextStyle(fontSize: 14)),
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
                  child: Text(storedperiode.toString(), style: const TextStyle()),
                ),
                const SizedBox(width: 3),
                Container(
                  width: 70,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Text("Days", style: TextStyle(fontSize: 16)),
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
                    child: const Text("+", style: TextStyle(fontSize: 40, color: Colors.black)),
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
                    child: const Text("-", style: TextStyle(fontSize: 50, color: Colors.black)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            const Text("Cycle usually lasts between 23-35 days"),
            const SizedBox(height: 17),
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
            const SizedBox(height: 13),
            Container(
              height: 1,
              color: Colors.grey,
            ),
           
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
