import 'package:firebase_otp/login_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('This is a new page called MAIN PAGE'),
            FlatButton(
              child: Text('Sign out'),
              onPressed: () async {
                await LoginService().signOut();
              }
            )
          ],
        )
      ),
    );
  }
}