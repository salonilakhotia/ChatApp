import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Screen/ChatScreen.dart';
import './Screen/Auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.deepPurple,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.deepPurple,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(stream : FirebaseAuth.instance.onAuthStateChanged,
      builder: (context , userSnapshot) {
        if(userSnapshot.hasData){
          return ChatScreen();
        }
        else{
          return Auth();
        }
       }
      ),
    );
  }
}


