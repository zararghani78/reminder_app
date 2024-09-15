import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminderapp/utilis/themechange.dart';

class TERMSOFSERVICES extends StatefulWidget {
  const TERMSOFSERVICES({super.key});

  @override
  State<TERMSOFSERVICES> createState() => _TERMSOFSERVICESState();
}

class _TERMSOFSERVICESState extends State<TERMSOFSERVICES> {
  @override
  Widget build(BuildContext context) {
       final themeProvider = Provider.of<ThemeProvider>(context);
   
    return Scaffold(

      appBar: AppBar(
        title: Text("Terms of services"),
      ),
      body: Padding(padding: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: themeProvider.isDarkMode? Colors.white:Colors.black,
          )
        ),
        child: ListView(
          children: const [
            Text("Introduction",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("Welcome to [App Name]. By using our app, you agree to comply with and be bound by the following Terms of Service.",textAlign:TextAlign.justify,),
           SizedBox(height: 10,),
             Text("Acceptance of Terms",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("By accessing or using the app, you agree to be bound by these terms. We reserve the right to update these terms at any time.",textAlign:TextAlign.justify,),
             SizedBox(height: 10,),
             Text("User Eligibility",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("You must be at least 18 years old to use this app. By using the app, you represent and warrant that you have the right, authority, and capacity to enter into this agreement.",textAlign:TextAlign.justify,),
            SizedBox(height: 10,),
             Text("Account Registration",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("You agree to provide accurate and complete information when creating an account. You are responsible for maintaining the confidentiality of your account information.",textAlign:TextAlign.justify,),
            SizedBox(height: 10,),
             Text("Privacy Policy",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("We value your privacy. Please review our Privacy Policy to understand how we collect, use, and protect your information.",textAlign:TextAlign.justify,),
            SizedBox(height: 10,),
             Text("User Conduct",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("You agree not to use the app for any unlawful or prohibited activities. You will not misuse the app or its content.",textAlign:TextAlign.justify,),
          ],
        ),
      ),
      
      ),
    );
  }
}