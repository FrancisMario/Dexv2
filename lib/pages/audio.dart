// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class Audio extends StatefulWidget {
//   Audio({Key key}) : super(key: key);

//   @override
//   _AudioState createState() => _AudioState();
// }

// class _AudioState extends State<Audio> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:path_provider/path_provider.dart';

/**  
 * 
*/

class Audio {
  final String audio_id;
  final String user_id;
  firebase_storage.FirebaseStorage storage;
  Audio({this.user_id, this.audio_id}) {
    storage = firebase_storage.FirebaseStorage.instance;
  }

Future<void> uploadExample() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String filePath = '${appDocDir.absolute}/voice';
}
  Future<void> downloadFileExample() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  File downloadToFile = File('${appDocDir.absolute}/download-logo.png');

  try {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .writeToFile(downloadToFile);
  } on firebase_core.FirebaseException catch (e) {
    // e.g, e.code == 'canceled'
  }
}

Widget build(BuildContext context , bool direction){
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
        alignment: direction ? Alignment.topLeft : Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              // height: MediaQuery.of(context).size.height / 6.5,
              height: 75,
              decoration: BoxDecoration(
                color: direction ? Colors.white : Colors.red,
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
                          color: direction ? Colors.red : Colors.white,
                        )),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
