import 'dart:io';
import 'package:chatApp/Screen/image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
   AuthForm(this.submitFn, this.isLoading);
   final bool isLoading;
    final void Function (
      String email,
      String username,
      String password,
      File image,
      bool isLogin,
      BuildContext ctx,
    ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
   final isValid = _formKey.currentState.validate();
   FocusScope.of(context).unfocus();

    if(_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please pick image"), backgroundColor: Theme.of(context).errorColor,),);
      return;
    }

   if(isValid){
     _formKey.currentState.save();
   widget.submitFn(
     _userEmail.trim(),
     _userName.trim(),
     _userPassword.trim(),
     _userImageFile,
     _isLogin,
     context,
   );
   }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if(!_isLogin)
                      UserImagePicker(_pickedImage),
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if(value.isEmpty || !value.contains('@')){
                          return 'Please enter a valid email!!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      onSaved: (value) { _userEmail = value; },
                    ),
                    if(!_isLogin) 
                      TextFormField(
                        key: ValueKey('username'),
                        decoration : InputDecoration(
                          labelText: 'Username',
                        ),
                        
                        onSaved: (value) { _userName = value; },
                      ),
                      
                      TextFormField(
                      key: ValueKey('password'),
                      keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if(value.length < 6 || value.isEmpty){
                            return 'Passsword must be at least 6 character';
                          }
                          return null;
                        },
                        decoration : InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        
                        onSaved: (value) { _userPassword = value; },
                      ),
                    
                    SizedBox(height : 12),
                    if(widget.isLoading) CircularProgressIndicator(),
                    if(!widget.isLoading)
                      RaisedButton(child :  Text( _isLogin ? 'Login' : 'SignUp'), onPressed: _trySubmit,),
                    if(!widget.isLoading)
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        textColor: Theme.of(context).primaryColor,
                        child: Text( _isLogin ? 'Create new account' : 'Already a member') ,)
                    ],)
              ),
            ),
          ),
        ),
      );
  }
}