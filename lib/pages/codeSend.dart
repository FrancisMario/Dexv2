import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexv2/base.dart';
import 'package:dexv2/controllers/auth.dart';
import 'package:dexv2/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodeComfirm extends StatefulWidget {
  final String phone;
  final String uname;
  CodeComfirm({Key key, this.phone, this.uname}) : super(key: key);

  @override
  _CodeComfirmState createState() => _CodeComfirmState();
}

class _CodeComfirmState extends State<CodeComfirm> {
  TextEditingController _code = new TextEditingController();
  var verificationId = null;
  FirebaseAuth auth;
  bool buttonEnabled = false;
  bool textfieldEnabled = false;

  @override
  Widget build(BuildContext context) {
    auth = FirebaseAuth.instance;

    login(widget.phone.trim());
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Code"),
      ),
      body: Container(
          child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Enter Comfirmation Code ",
              style: TextStyle(fontSize: 30),
              overflow: TextOverflow.clip,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey[200]),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    hintStyle:
                        TextStyle(textBaseline: TextBaseline.ideographic),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Code"),
                maxLength: 6,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: _code,
                enabled: textfieldEnabled,
                onChanged: (val) {
                  val.length == 6
                      ? buttonEnabled = true
                      : buttonEnabled = false;
                  setState(() {});
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: () {
                if (this.verificationId != null) {
                  print("----------------------verificationId");
                  print(this.verificationId);
                  print("----------------------");
                  manual(this.verificationId, _code.text.trim());
                  buttonEnabled = false;
                }
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    color: buttonEnabled ? Colors.deepOrange : Colors.grey,
                    borderRadius: BorderRadius.circular(5)),
                width: MediaQuery.of(context).size.width / 1.4,
                height: 50,
                child: Center(
                  // child: Text("Confirm",style: TextStyle(fontSize: 30,color: Colors.white,),)
                  child: buttonEnabled
                      ? Text("Confirm",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ))
                      : new CircularProgressIndicator(
                          value: null,
                          strokeWidth: 7.0,
                        ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  login(phone) async {
    await auth.verifyPhoneNumber(
        phoneNumber: "+220" + phone,
        timeout: Duration(seconds: 5),
        verificationCompleted: (_credential) {
          signIn(_credential);
        },
        verificationFailed: (verificationFailed) {
          print("verificationFailed))))======================");
          print(verificationFailed);
          dialog();
        },
        codeSent: (s, d) {
          print("code sent ");
          print("v id " + s);
          print("resent token- $d");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // setting the global @param verification to a value and enabling the confirm button if the autocode detection fails
          this.verificationId = verificationId;
          this.textfieldEnabled = true;
          setState(() {});
        });
  }

  manual(verificationId, smsCode) {
    var _credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    signIn(_credential);
  }

  signIn(PhoneAuthCredential _credential) {
    auth.signInWithCredential(_credential).then((result) {
      // result.user.displayName.replaceAll(null, widget.uname.trim());
      // result.additionalUserInfo.
      // profile.addAll({"name": ""});

  User user = auth.currentUser;
  user.updateProfile(
      displayName:widget.uname,
    );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Base()),
        (Route<dynamic> route) => false,
      );
    }).catchError((e) {
      print("------------------------------------------");
      print(e);
      dialog();
    });
  }

  dialog() {
    //show dialog to take input from the user
    var _codeController = new TextEditingController();
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              title: Text("Verification Failed"),
              content: Icon(Icons.error_outline,size: 40,color: Colors.red,),
              actions: <Widget>[
                FlatButton(
                  child: Text("Done"),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (Route<dynamic> route) => false,
                    );
                  },
                )
              ],
            ));
  }

}
