import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:reminderapp/routes/routes_name.dart';
import 'package:reminderapp/ui/model_bottomsheet.dart';
import 'package:reminderapp/ui/navigation.dart';
import 'package:reminderapp/utilis/themechange.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  
  String currentDate = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());
  String onlyDate = DateFormat('MMM d,').format(DateTime.now());

  DateTime? highlightedDay;
int weeksDifference = 0;
int weeksdays=0;

  @override
  void initState() {
    super.initState();
    _Calculatestoreddays();
    _loadHighlightedDay();
    camparedate();
    _startPedometer();
    _requestPermissions();
  }

  Future<void> _Calculatestoreddays() async {

    final prefss = await SharedPreferences.getInstance();
    String? caldate= prefss.getString('selected_date');

    if(caldate !=null){
      DateTime storedate= DateTime.parse(caldate);
      DateTime currentDate=DateTime.now();
      int differencedate= currentDate.difference(storedate).inDays;

      setState(() {
        weeksDifference=(differencedate/7).floor();
      });
    }
  }

  Future<void> _setstoreddate()async{

    final prefestwo = await SharedPreferences.getInstance();
DateTime currentDate=DateTime.now();
    await prefestwo.setString('selected_date', currentDate.toIso8601String());
  }
  
  
  
  
  
  Future<void> _loadHighlightedDay() async {
  final prefs = await SharedPreferences.getInstance();
  final savedDate = prefs.getString('selected_date');
  final cycleDuration = prefs.getInt('period_duration'); // Get the saved duration from SharedPreferences

  if (cycleDuration == null) {
   
    return;
  }

  if (savedDate != null) {
    setState(() {
      DateTime selectedDay = DateTime.parse(savedDate);
      highlightedDay = selectedDay.add(Duration(days: cycleDuration)); // Use the retrieved periodDuration

      int daysDifference = highlightedDay!.difference(selectedDay).inDays;

      double weeks = daysDifference / 7;
      weeksdays = weeks.toInt();
    });
  }
}

int result=0;

void camparedate(){

  DateTime now=DateTime.now();
  DateTime valentinedays=DateTime(now.year,2,14);

  if(now.isAfter(valentinedays)){
     valentinedays = DateTime(now.year + 1, 2, 14);
    setState(() {
     result = valentinedays.difference(now).inDays;
    });
  }

}
  
 

  Future<void> _savePeriodDuration(int duration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cycle_duration', duration);
  }
    int _step = 0;
     int _resetStepCount = 0;
     int _initialStepCount = 0;

  Stream<StepCount>? _stepCountStream;
  

  

  Future<void> _requestPermissions() async {
    PermissionStatus status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      _startPedometer();
    } else {
      // Handle permission denied case
    }
  }

  void _startPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream!.listen(_onStepCount).onError(_onStepCountError);
  }

  void _onStepCount(StepCount event) {
    setState(() {
      _step = event.steps;
    });
  }

  void _onStepCountError(error) {
    print('Error: $error');
  }
 void _resetStepCounter() {
    setState(() {
      _initialStepCount = _step;
    });
  }
  int get _displayedSteps => _step - _initialStepCount;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.notifications_outlined, size: 34),
        title: Text(
          currentDate,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right:10 ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/image/color2(1).png"),
                 const SizedBox(width: 3,),
                const Text("Current Date",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                const SizedBox(width: 20,),
                 Image.asset("assets/image/color2(2).png"),
                 
       const SizedBox(width: 3,),
                const Text("Periode Duration",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: themeProvider.isDarkMode? Colors.white:Colors.black,
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Now Fullicular phase"),
                          Text(
                            highlightedDay != null
                                ? DateFormat('d MMMM').format(highlightedDay!)
                                : 'no  date is stored',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 29, 141, 233),
                              fontSize: 16,
                            ),
                          ),
                      
                        ],
                      )
                    ,
                    Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: Image.asset("assets/image/flower.png"),
                    ),
                    ],
                  ),
                      const SizedBox(height: 12),
                          Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, RoutesName.nextpage);
                                },
                                child: const SizedBox(
                                  height: 30,
                                  width: 230,
                                  child: Text(
                                    "Tap to see next period start date",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Column(
                                children: [
                                 
                                  Text(
                                    "Now",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 29, 141, 233),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                       
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: themeProvider.isDarkMode? Colors.white:Colors.black,
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Next Periode start"),
                          Text(
                            highlightedDay != null
                                ? DateFormat('d MMMM').format(highlightedDay!)
                                : 'no date is not stored',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 29, 141, 233),
                              fontSize: 16,
                            ),
                          ),]),
                           Padding(
                             padding: const EdgeInsets.only(right: 15.0),
                             child: Image.asset(
                                          "assets/image/water.png",
                                          width: 50,
                                          height: 50,
                                        ),
                           ),
                    ]),
                     const SizedBox(height: 12),
                          Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, RoutesName.nextpage);
                                },
                                child: const SizedBox(
                                  height: 30,
                                  width: 190,
                                  child: Text(
                                    "Your last period lasted 5 days",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 1),
                              Column(
                                children: [
                                 
                                 Text(
                                     weeksdays.toString(),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 29, 141, 233),
                                    ),
                                  ),
                                   const Text(
                                 "weeks remaning",
                                                                         style: TextStyle(
                                  color: Color.fromARGB(255, 29, 141, 233),fontSize: 11,
                                                                         ),
                                   ),
                                ],
                              ),
                            ],
                          ),
                        
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: themeProvider.isDarkMode? Colors.white:Colors.black,
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Valentine days"),
                          Text(
                           "2025. 2. 14",
                            style: TextStyle(
                              color: Color.fromARGB(255, 29, 141, 233),
                              fontSize: 16,
                            ),
                          ),
                        ]),
 Padding(
   padding: const EdgeInsets.only(right: 10.0),
   child: Image.asset("assets/image/heart.png"),
 ),
                    ]),
                     const SizedBox(height: 12),
                          Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 30,
                                width: 200,
                                child: Text(
                                  "Tap to view your calendar",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Column(
                                children: [
                                 
                                   Row(
                                    children: [
                                       const Text(
                                        "In",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 29, 141, 233),fontSize: 10,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        result.toString(),
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 29, 141, 233),fontSize: 14,
                                        ),
                                      ),
                                       SizedBox(width: 5,),
                                       const Text(
                                        "days",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 29, 141, 233),fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                 
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 08.0, horizontal: 15),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: themeProvider.isDarkMode? Colors.white:Colors.black,
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           TextButton(
                           onPressed: _resetStepCounter,
                           child: const Text("Pedometer",style: TextStyle(color: Colors.black),),
                          ),
                         Row(
                           children: [
                             Text(
                                           ' Steps :',
                                            style: const TextStyle(
                                             fontSize: 14,
                                            ),
                                          ),
                                            Text(
                                           _displayedSteps.toString(),
                                            style: const TextStyle(
                                              color: Color.fromARGB(255, 29, 141, 233),fontSize: 16,
                                            ),
                                          ),
                           ],
                         ),
                        ]),
                         Padding(
                           padding: const EdgeInsets.only(right: 15.0),
                           child: Image.asset("assets/image/foot.png"),
                         ),
                    ]),
                         const SizedBox(height: 12),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 30,
                                width: 210,
                                child: Text(
                                  "Synced to Google Fit",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              SizedBox(width: 1),
                              Column(
                                children: [
                                 
                                  SizedBox(
                                    width: 80,
                                    
                                    child: Text(
                                      _displayedSteps>2000  ?   "you completed  goals":"you need more steps",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 29, 141, 233),fontSize: 10
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        
                ],
              ),
            ),
          ),
           const MODELBOOTOMSHEET(),
        ],
      ),
      bottomNavigationBar: const BottomNaviscreen(),
    );
  }
}



