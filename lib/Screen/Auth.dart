import'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../Widget/auth_form.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    void _submitAuthForm(
      String email,
      String username,
      String password,
      File image,
      bool isLogin,
      BuildContext ctx,
    ) async {
      AuthResult authResult;
      try{
        setState(() {
          _isLoading = true;
        });
        if(isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(email: email, password:password,);
        }
        else{
          authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password,);
        }

        //image upload
        final ref = FirebaseStorage.instance.ref().child('user_image').child(authResult.user.uid + '.jpg');

        await ref.putFile(image).onComplete;

        final url = await ref.getDownloadURL();//dont have to use firebaseStorage to use image

        await Firestore.instance.collection('users').document(authResult.user.uid).setData({
          'username' : username,
          'email ': email,
          'image_url' : url,
        }); 
      } 
      on PlatformException catch (error) {
        var message = 'An error occured';
        if(error.message != null){
          message = error.message;
        }

        Scaffold.of(ctx).showSnackBar(
          SnackBar( 
            content : Text(message),
            backgroundColor: Theme.of(ctx).errorColor, 
            ),
          );
          setState(() {
            _isLoading = false;
            });
        } catch (error){
           setState(() {
            _isLoading = false;
            });
          print(error);
        }
      }
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: AuthForm(_submitAuthForm , _isLoading),
    );
  }
}