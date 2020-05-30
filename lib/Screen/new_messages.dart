import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  String enteredMsg = '' ;
  final _controller = new TextEditingController();
  void sendMsg() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'text' : enteredMsg,
      'timeAt' : Timestamp.now(),
      'userId' : user.uid,
      'username' : userData['username'],
      'userImage' : userData['image_url']
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding : EdgeInsets.all(8),
      child: Row(children: <Widget>[
        Expanded(
          child: TextField(
          minLines: 1,
          maxLines: 10,
          controller: _controller,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(labelText: 'Send a messages...'),
          onChanged: (value){
            setState((){
              enteredMsg = value;
            });
          },
          
        ),),
        IconButton(
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.send),
          onPressed: enteredMsg.isEmpty ? null : sendMsg,
        )
      ],)
    );
  }
}