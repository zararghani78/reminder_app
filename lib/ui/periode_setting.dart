import 'package:flutter/material.dart';

import 'calenderscreen.dart'; // Ensure you have the correct import path

class PERIODESETTING extends StatefulWidget {
  const PERIODESETTING({Key? key}) : super(key: key);

  @override
  _PERIODESETTINGState createState() => _PERIODESETTINGState();
}

class _PERIODESETTINGState extends State<PERIODESETTING> {
  TextEditingController periodedateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the color of the back arrow icon
        ),
        backgroundColor: const Color.fromARGB(255, 29, 141, 233),
        title: const Text(
          "Your period days",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    width: 280,
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 29, 141, 233),
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Set your period days",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: periodedateController,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              label: Text(
                                "set your period days",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Calenderscreen(
                                  periodDuration: int.tryParse(periodedateController.text) ?? 25,
                                ),
                              ),
                            );
                          },
                          child: const Text("Set Days"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
