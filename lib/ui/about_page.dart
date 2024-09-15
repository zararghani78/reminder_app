import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminderapp/utilis/themechange.dart';

class ABOUTPAGE extends StatefulWidget {
  const ABOUTPAGE({super.key});

  @override
  State<ABOUTPAGE> createState() => _ABOUTPAGEState();
}

class _ABOUTPAGEState extends State<ABOUTPAGE> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
  
    return Scaffold(
      
appBar: AppBar(
  backgroundColor: Color.fromARGB(255, 29, 141, 233),
  title: const Text("About "),
)
      ,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            
            decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border:Border.all(
            width: 2,
            color:   themeProvider.isDarkMode? Colors.white:Colors.black,
          )
            ),
                      child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0,left: 14,right: 14),
                  child: 
                  Expanded(
                    child: Container(
                      child: Text("Period tracking: Users can input their period start and end dates, cycle length, and any symptoms they experience. The app then calculates future period predictions and fertile windows based on this data.Symptom tracking: Users can log symptoms such as cramps, mood changes, and headaches to identify patterns and better understand their menstrual health.Fertility tracking: Some period apps include features for tracking ovulation and fertility, which can be helpful for those trying to conceive or avoid pregnancy.Health insights: Many period apps offer educational content about menstruation, reproductive health, and contraception. Some also provide insights into how lifestyle factors like diet, exercise, and stress can affect menstrual cycles.Personalization: Users can often customize the app based on their individual preferences and health goals, such as setting reminders for taking birth control pills or scheduling regular gynecological exams.Privacy and data security: Period apps typically prioritize user privacy and data security, especially regarding sensitive health information. Users can usually choose whether to share their data and with whom.Overall, period apps can empower individuals to take control of their menstrual health, gain insights into their cycles, and make informed decisions about their reproductive well-being.",textAlign: TextAlign.justify,),
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}