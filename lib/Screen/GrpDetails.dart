// import 'dart:html';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './GrpBubble.dart';

class GrpDetails extends StatelessWidget {

                   

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: new Text('Members Details'),),
      body : FutureBuilder(
          future : FirebaseAuth.instance.currentUser(),
          builder: (context, futureSnapshot) { 
            if(futureSnapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            return StreamBuilder(
              stream: Firestore.instance.collection('users').snapshots(),
              builder : (context, userSnapshot){
                if(userSnapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),
                  );
                }
              final userDocs = userSnapshot.data.documents;
        
              return ListView.builder(
                itemCount: userDocs.length,
                itemBuilder: (context, index) =>    GrpBubble(
                userDocs[index]['username'],
                userDocs[index]['email '],//space is essencial after email as it is defined in firebase with this name
                userDocs[index]['image_url'],
                futureSnapshot.data.email,
                ),
               );
              }
           );
            }
            ),
    );
  }
}
