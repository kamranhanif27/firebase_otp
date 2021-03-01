import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_otp/otp_verify_screen.dart';
import 'package:flutter/material.dart';

class LoginService{

 final FirebaseAuth auth = FirebaseAuth.instance; 

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
 Future signOut(){
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
   return true;
  } catch (e){
    print(e.toString());
    return false;
  }
}

}
