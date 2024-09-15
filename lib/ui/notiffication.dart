
/*import 'package:flutter/material.dart';

class NOTIFICATIONSETTIN extends StatefulWidget {
  const NOTIFICATIONSETTIN({super.key});

  @override
  State<NOTIFICATIONSETTIN> createState() => _NOTIFICATIONSETTINState();
}

class _NOTIFICATIONSETTINState extends State<NOTIFICATIONSETTIN> {
 

 Future<void> checkForNotifications(FlutterLocalNotificationsPlugin notificationsplugin)async{
final prefs=await SharedPreferences.getInstance();
final dateget= prefs.getString('selected_date');

if(dateget!=null){

  final getdate=DateTime.parse(dateget);
  final datenow=DateTime.now();

  final tommrowdate=datenow.add(Duration(days: 1));

  if(getdate.isAfter(datenow) && getdate.isBefore(tommrowdate)){

    await _shownotification(notificationsplugin);
  }
}
 }

 Future<void> _shownotification(FlutterLocalNotificationsPlugin notificationsplugin) async{
// Initialize notification plugin
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Check for notifications
  await checkForNotifications(flutterLocalNotificationsPlugin);

const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('your_channel_id', 'your_channel_name',
          channelDescription: 'your_channel_description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
           const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await notificationsplugin.show(
      0, 'Event Reminder', 'Your event is happening tomorrow!', platformChannelSpecifics,
      payload: 'item x');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Notification page"),
    ),
    body: Container(

      
    ),
    );
      }

*/