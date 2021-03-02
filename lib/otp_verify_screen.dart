import 'package:firebase_otp/home_screen.dart';
import 'package:firebase_otp/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class OtpVerify extends StatefulWidget {
  final String verificationId;

  const OtpVerify({Key key, this.verificationId}) : super(key: key);
  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('OTP Verify'),
      ),
      body:  Builder(
        builder: (ctx) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Text'),
              Text('Text'),
              Text('Text'),
              PinEntryTextField(
                showFieldAsBox: true,
                fields: 6,
                onSubmit: (value) => code = value,
              ),
              FlatButton(
                color: Colors.blue,
                child: Text(
                  'Verify'
                ),
                onPressed: (){
                  LoginService().signInWithPhoneNumber(code, widget.verificationId).then((value){
                    if(value == false){
                      Scaffold.of(ctx).showSnackBar(SnackBar(
                        content: const Text('OTP failed'),
                        duration: const Duration(seconds: 1),
                      ));
                    }else{
                      print('true');
                      Phoenix.rebirth(context);
                    }
                  });
                },
              )
            ],
          );
        },
      ),
    );
  }
}