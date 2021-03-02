import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_otp/Login_screen.dart';
import 'package:firebase_otp/home_screen.dart';
import 'package:firebase_otp/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<Object>(
        stream: Stream.fromFuture(LoginService().readFromSP()),
        builder: (context, snapshot) {
          // User user = snapshot.data;
          if(snapshot.data == null){
            return LoginScreen();
          }else{
            return HomeScreen();
          }
        }
      ),
    );
  }
}
