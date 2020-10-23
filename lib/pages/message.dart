import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Message extends StatefulWidget {
  Message({Key key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  var fade = false;
  var visible = false;

//   Widget glow(){
     
//   return AnimatedOpacity(
//   // If the widget is visible, animate to 0.0 (invisible).
//   // If the widget is hidden, animate to 1.0 (fully visible).
//   opacity: _visible ? 1.0 : 0.0,
//   duration: Duration(milliseconds: 500),
//   // The green box must be a child of the AnimatedOpacity widget.
//   child: Container(
//     width: 200.0,
//     height: 200.0,
//     color: Colors.green,
//   ),
// );
//   }
  @override
  Widget build(BuildContext context) {
    // glow(0);
    return Scaffold(
        bottomSheet: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.black26,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "0:00",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.send,
                             size: 40,
                             color : Colors.white
                             ),
                          Text(
                            "Send",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Icon(
                            Icons.mic,
                             size: 40,
                             color : Colors.red.withOpacity(0.3),                             
                             ), 
                          Text(
                            "Record",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 75),
          child: ListView(physics: BouncingScrollPhysics(), children: <Widget>[
            // Card(incoming: false),
            Card(incoming: false),
            Card(incoming: false),
            Card(incoming: true),
            Card(incoming: false),
            Card(incoming: true),
          ]),
        ));
  }

  Card({bool incoming}) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (BuildContext context) {
        //     return route;
        //   }),
        // );
        // firebase_storage.FirebaseStorage storage =
        //   firebase_storage.FirebaseStorage.instance.re;

      },
      child: Align(
        alignment: incoming ? Alignment.topLeft : Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              // height: MediaQuery.of(context).size.height / 6.5,
              height: 75,
              decoration: BoxDecoration(
                color: incoming ? Colors.white : Colors.red,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 10, offset: Offset(2, 2)),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        backgroundColor: Colors.grey.withOpacity(0.5),
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white24),
                        value: 0.4,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                        value: 0.3,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.play_circle_filled,
                          size: 40,
                          color: incoming ? Colors.red : Colors.white,
                        )),
                  ),
                ],
              )),
        ),
      ),
    );
  }

}
