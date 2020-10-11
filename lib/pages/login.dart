import 'package:dexv2/controllers/auth.dart';
import 'package:dexv2/pages/codeSend.dart';
import 'package:dexv2/styles/Textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _username = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  bool isButtonDisabled = true;

  Future<Widget> login(context){

      if(everythingCool()){
          Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => CodeComfirm(uname: _username.text.trim(),phone : _phone.text.trim())),
                      (Route<dynamic> route) => false,
                    );
      }
  }

  everythingCool(){
    if((this._username.text.trim().length > 3) && (this._phone.text.trim().length == 7)){
      print("true");
      print("--------------------------");
      print(this._username.text.trim().length);
      print(this._phone.text.trim().length);
      print("--------------------------");
      isButtonDisabled = false;
      setState(() {
      });
      return true;
    } else {
      print("false");
      print("--------------------------");
      print(this._username.text.trim().length);
      print(this._phone.text.trim().length);
      print("--------------------------");
      isButtonDisabled = true;
      setState(() {
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            width: (MediaQuery.of(context).size.width / 100) * 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Login With Name and Phone number",
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
                          borderSide: BorderSide(color: Colors.grey[200])
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300])
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Username"

                  ),
                  keyboardType: TextInputType.text,
                  controller: _username,
                  onChanged : (val) {
                      everythingCool();
                  }
                ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    maxLength: 7,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[200])
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300])
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Phone"

                  ),
                  keyboardType: TextInputType.phone,
                  controller: _phone,
                  onChanged : (val) {
                      everythingCool();
                  }
                ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    onPressed: () {
                      login(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                      color: isButtonDisabled ? Colors.grey : Colors.deepOrange ,
                      borderRadius: BorderRadius.circular(5)
                      ),
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 50,
                      child: Center(
                          child: Text(
                        "Login",
                        style: TextStyle(fontSize: 30, color: Colors.white,),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
