

import 'package:dexv2/base.dart';
import 'package:dexv2/controllers/auth.dart';
import 'package:dexv2/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Checkpoint extends StatefulWidget {
  // FirebaseUser _user;
  Checkpoint({Key key});
  @override
  _CheckpointState createState() => _CheckpointState();
}

class _CheckpointState extends State<Checkpoint> {
  Auth auth;

  @override
  Widget build(BuildContext context) {
    auth = new Auth(context);
    return check() ? Base() : Login();
  }
   
   check()  {
    return  auth.isLoggedIn();
  } 
  
  }

