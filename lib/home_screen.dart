import 'package:firebase_otp/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is a new page called MAIN PAGE'),
            FlatButton(
              child: Text('Sign out'),
              onPressed: () async {
                await LoginService().signOut().then((value){
                  Phoenix.rebirth(context);
                });
              }
            )
          ],
        )
      ),
    );
  }
}