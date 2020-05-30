import 'package:flutter/material.dart';

class MsgBubble extends StatelessWidget {
  MsgBubble(this.msg, this.isMe , this.username , this.userImage ,{this.key});
  final String msg; 
  final bool isMe;
  final String username;
  final String userImage;
  final Key key;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children : <Widget>[
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.brown[500] : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18,),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8, ),
            width: 160,
              child: Column(
                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.black : Colors.white),
                    ),
                    Text(msg, 
                    style: TextStyle(
                      color: isMe ? Colors.black : Colors.white,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    ),
                  ],
                ),
          ),
          ],
        ),
        Positioned(
              top: 0,
              left: isMe ? null : 120,
              right : isMe ? 120 : null,
              child: CircleAvatar(
                backgroundImage: NetworkImage(userImage),
              )),
      ],
    );
  }
}

/*
Padding(
               padding: EdgeInsets.only(
                 left: 10,
               ),
                child: CircleAvatar(
                
               // backgroundImage: NetworkImage(userImage),
                ),
                 ) , */