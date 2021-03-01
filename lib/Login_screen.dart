import 'package:firebase_otp/login_service.dart';
import 'package:firebase_otp/otp_verify_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String number;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Insert your telephone number'),
          TextField(
            keyboardType: TextInputType.phone,
            onChanged: (value) => number = value,
          ),
          Text('You will receive a SMS code'),
          FlatButton(
            color: Colors.blue,
            child: Text('Continue'),
            onPressed: (){
              LoginService().loginUser(number, context);
            },
          )
        ],
      ),
    );
  }
}