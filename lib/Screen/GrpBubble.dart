import 'package:flutter/material.dart';

class GrpBubble extends StatelessWidget {
  GrpBubble(this.username , this.email, this.imageURL , this.currentEmail);
  final String username;
   final String email;
  final String imageURL; 
  final String currentEmail;

  @override
  Widget build(BuildContext context) {
    bool isMe = false;
    if(currentEmail == email){
      isMe =true;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18,),
      margin: EdgeInsets.symmetric(vertical: 14, horizontal: 18, ),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
       ),
      child: Row(
        children: <Widget>[
           Padding(
             padding: const EdgeInsets.only(left: 15,),
             child: CircleAvatar(
                 radius: 50 ,
                 backgroundImage: NetworkImage(imageURL)
               ),
           ),
          Padding(padding: EdgeInsets.all(20),),
          Column(
             children : <Widget>[
             Text(username,
             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,)),
             SizedBox(height: 10,),
             Text(email),
                ]),
        ],
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';

class GrpBubble extends StatelessWidget {
  GrpBubble(this.username , this.email, this.imageURL , this.currentEmail);
  final String username;
   final String email;
  final String imageURL; 
  final String currentEmail;

  @override
  Widget build(BuildContext context) {
    bool isMe = false;
    if(currentEmail == email){
      isMe =true;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18,),
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8, ),
      decoration: BoxDecoration(
          color: isMe ? Colors.grey[500] : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
       ),
      child: Column(
         children : <Widget>[
         CircleAvatar(
           radius: isMe ? 50 :  20,
           backgroundImage: NetworkImage(imageURL)
         ),
         Text(username),
         Text(email),
            ]),
    );
  }
}

 
*/