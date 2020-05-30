import 'package:chatApp/Screen/new_messages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './messages.dart';
import './new_messages.dart';
import './GrpDetails.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String selectedValue;
  List <String> optionValues = <String> [ 'Members Details','Logout'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
       appBar: new AppBar(
        title: new Text("DrazzyChitChat"),
        actions: [
          Container(
            
            width: 100,//decoration: BoxDecoration(color  : Colors.black),
            child: DropdownButton(
              isExpanded : true,
              underline: Container(),
              icon : Icon(
                Icons.more_vert,  
                color : Theme.of(context).primaryIconTheme.color,
              ),
              items : optionValues.map((String optionValue) {
               return  DropdownMenuItem<String>(
                  child: Column( 
                    children: <Widget>[
                    Row(
                      children: <Widget>[
                       // Icon(Icons.exit_to_app, size: 20,),
                       // SizedBox(width: 1),
                        Text(optionValue, style: TextStyle(
                          fontSize : 15,
                        ),),
                      ],
                    ),
                    ],
                  ),
                  value  :  optionValue,
                );
              }).toList(),
              onChanged : (itemIdentifier) {
                if(itemIdentifier == 'Members Details'){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GrpDetails()),);
                }
                if(itemIdentifier == 'Logout'){
                  FirebaseAuth.instance.signOut();
                }
              }
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          
          children: <Widget>[
            Expanded(child: Messages(),),
            NewMessages(),
        ],),
      ),     
    );
  }
}