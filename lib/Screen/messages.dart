import 'package:chatApp/Screen/msgBubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './msgBubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return FutureBuilder(
          future : FirebaseAuth.instance.currentUser(),
          builder: (context, futureSnapshot) { 
            if(futureSnapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            return StreamBuilder(
              stream: Firestore.instance.collection('chat').orderBy('timeAt' , descending: true ).snapshots(),
              builder : (context, chatSnapshot){
                if(chatSnapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),
                  );
                }
              final chatDocs = chatSnapshot.data.documents;
        
              return ListView.builder(
              reverse : true,
              itemCount: chatDocs.length,
              itemBuilder: (context, index) => MsgBubble(
                chatDocs[index]['text'], 
                chatDocs[index]['userId'] == futureSnapshot.data.uid , //check whether it is us or not
                chatDocs[index]['username'],
                chatDocs[index]['userImage'],
                key : ValueKey(chatDocs[index].documentID),//not need but update the key will let us know that every time widget is updated..
                ),
           );
            }
            );
        }
        );
  }
}