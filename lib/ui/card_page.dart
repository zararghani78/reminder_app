import 'package:flutter/material.dart';
import 'package:reminderapp/ui/calenderscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CARDPAGE extends StatefulWidget {
  const CARDPAGE({Key? key}) : super(key: key);

  @override
  State<CARDPAGE> createState() => _CARDPAGEState();
}

class _CARDPAGEState extends State<CARDPAGE> {
  int? periodDuration;
  TextEditingController periodDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkFirstTimeOpen();
  }

  Future<void> _savePeriodDuration(int duration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('period_duration', duration);
    await prefs.setBool('is_first_time', false);
    setState(() {
      periodDuration = duration;
    });
  }

  Future<void> _checkFirstTimeOpen() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('is_first_time') ?? true;
    if (isFirstTime) {
      _showPeriodDurationDialog();
    } else {
      // Check if period duration is stored, if not show dialog
      final int? storedDuration = prefs.getInt('period_duration');
      if (storedDuration == null) {
        _showPeriodDurationDialog();
      } else {
        setState(() {
          periodDuration = storedDuration;
        });
      }
    }
  }

  Future<void> _showPeriodDurationDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
     
        return AlertDialog(
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Set your period days",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: periodDateController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Enter days",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog without setting duration
                      },
                      child: const Text("Skip"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        int duration = int.tryParse(periodDateController.text) ?? 25;
                        _savePeriodDuration(duration);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Calenderscreen(periodDuration: duration),
                          ),
                        );
                      },
                      child: const Text("Set Days"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(

     
    );
  }
}



class NumberList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),

          ),
          child: Row(
            children: [
              ListTile(
                title: Text(' ${index + 1}'),

                
              ),
              Text("Days"),
            ],
          ),
        );
      },
    );
  }
}

