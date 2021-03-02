import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_otp/otp_verify_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

class LoginService{

 final FirebaseAuth auth = FirebaseAuth.instance; 

 Future<bool> addToSP(String telNumber, String deviceId) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setString('tel', telNumber);
   prefs.setString('device', deviceId);
   return true;
 }

 Future readFromSP() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   if(prefs.containsKey('tel') && prefs.containsKey('device')) {
     Map _map = {
     'tel': prefs.getString('tel'),
     'device': prefs.getString('device')
    };
    return _map;
   }
   return null; 
 }

 Future<String> _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) { // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }
}

  //create user object based on FireBaseUser

 User _userFromFirebaseUser(User user){
  return user != null ? user : null;
 }


 verificationCompleted(AuthCredential credential) async{
   UserCredential result = await auth.signInWithCredential(credential);
   User user  = result.user;
   return _userFromFirebaseUser(user);
 }
 verificationFailed(FirebaseAuthException exception) {
   print('$exception');
 }
 
  phoneCodeAutoRetrievalTimeout(String timeout){
    print('asdf');
  }
 

 // define _auth.verifyPhoneNumber() here
 // ignore: missing_return
 Future loginUser (String number, BuildContext context) async{
  try {
    await auth.verifyPhoneNumber(
        phoneNumber: number,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: (String verificationId, [int forceResendingToken]) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerify(verificationId: verificationId)
            )
          );
        }, 
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout
    );
  } catch (e) {
    print("Failed to Verify Phone Number: $e");
  }
 }
 Future signOut()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.remove("tel");
   await prefs.remove("device");
   return auth.signOut();
 }

 Future signInWithPhoneNumber(String smsCode, String verificationId) async {
  try{ 
    final AuthCredential credential = PhoneAuthProvider.credential(
    verificationId: verificationId,
    smsCode: smsCode,
   );
   UserCredential result = await auth.signInWithCredential(credential);
   User user= result.user;
   _userFromFirebaseUser(user);
   await addToSP(user.phoneNumber, await _getId());
   return true;
  } catch (e){
    print(e.toString());
    return false;
  }
}

}
