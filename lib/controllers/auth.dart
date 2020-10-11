import 'package:dexv2/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  FirebaseAuth auth;
  BuildContext context;
  Auth(context) {
    print("initialising Auth");
    auth = FirebaseAuth.instance;
    print("initialised Auth");
    print("contexting");
    this.context = context;
    print("contexed");
  }

  isLoggedIn() {
    var user = auth.currentUser;

    if (user == null) {
      print("user is NOT logged in");
      print(user);
      return false;
    }
    print(user);
    print(user.uid);
    print("user is logged in");
    return true;
  }

  login(phone, data) async {
    await auth.verifyPhoneNumber(
        phoneNumber: "+220" + phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (_credential) {
          signIn(_credential);
        },
        verificationFailed: (verificationFailed) {
          print("verificationFailed))))======================");
          print(verificationFailed);
        },
        codeSent: (s,d){
          
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  signIn(PhoneAuthCredential _credential) {
    auth.signInWithCredential(_credential).then((result) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Base()),
        (Route<dynamic> route) => false,
      );
    }).catchError((e) {
      print(e);
    });
  }
}
