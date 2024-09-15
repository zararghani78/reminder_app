
import 'package:flutter/material.dart';

class PROFILESCREEN extends StatefulWidget {
  const PROFILESCREEN({super.key});

  @override
  State<PROFILESCREEN> createState() => _PROFILESCREENState();
}

class _PROFILESCREENState extends State<PROFILESCREEN> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,

                  spreadRadius: 2,
                  color: Colors.grey.withOpacity(0.3)
                )
              ],
              border: Border.all(width: 1,color:Colors.black )
            ),
      child: Icon(Icons.person,size: 90,),
          ),
       SizedBox(height: 25,),
              Text("Name :     abx"),
      
            
          
        ],
      ),
    );
  }
}