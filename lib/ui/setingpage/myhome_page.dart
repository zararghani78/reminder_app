import 'package:flutter/material.dart';
import 'package:reminderapp/routes/routes_name.dart';

class MYhOMEPAGE extends StatefulWidget {
  const MYhOMEPAGE({super.key});

  @override
  State<MYhOMEPAGE> createState() => _MYhOMEPAGEState();
}

class _MYhOMEPAGEState extends State<MYhOMEPAGE> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(padding: EdgeInsets.all(10),
        
        child: Container(
          width: 130,
          height: 59,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 2,
              color: Colors.black
            )
          ),
          child: Row(
            children: [
              Icon(Icons.message_outlined),
              InkWell(
                
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.termsofservices);
                },
                child: Text("Terms of dervices"))
            ],
          ),
        ),
        
        )
      ],
    );
  }
}