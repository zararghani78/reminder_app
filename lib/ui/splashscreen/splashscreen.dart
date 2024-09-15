import 'package:flutter/material.dart';
import 'package:reminderapp/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 141, 233),
      body: ListView(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: screenSize.height * 0.25, top: screenSize.height * 0.15),
                  child: Image.asset('assets/image/dot.png',  width: screenSize.width * 0.4, height: screenSize.width * 0.4),
                ),
                SizedBox(height: screenSize.height * 0.05),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.splashtwo);
                  },
                  child: Container(
                    width: screenSize.width * 0.3,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Continue", style: TextStyle(fontSize: screenSize.width * 0.04)),
                        Icon(Icons.arrow_forward, color: Colors.black, size: screenSize.width * 0.06),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Splashscreentwo extends StatefulWidget {
  const Splashscreentwo({super.key});

  @override
  State<Splashscreentwo> createState() => _SplashscreentwoState();
}

class _SplashscreentwoState extends State<Splashscreentwo> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/image/text.png", width: screenSize.width * 0.4, height: screenSize.width * 0.4),
                Image.asset("assets/image/download.png", width: screenSize.width * 0.5, height: screenSize.height * 0.35),
                SizedBox(height: screenSize.height * 0.15),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.homescreen);
                  },
                  child: Container(
                    width: screenSize.width * 0.13,
                    height: screenSize.width * 0.13,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 29, 141, 233),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Icon(Icons.arrow_forward, color: Colors.white, size: screenSize.width * 0.07),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
