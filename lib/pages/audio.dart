/**
 * Author: Mario Francis Gomez
 * Description: Audio class for the voice messaging functionality.
 * version:0.0.0 
 */

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sound/flutter_sound_player.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
/**
 * 
*/

class Audio extends StatefulWidget {
  final String audio_id;
  final String user_id;
  final bool   upload_action;
  final bool   direction;
  Audio({Key key, this.audio_id, this.user_id, this.upload_action, this.direction}) : super(key: key);

  @override
  _AudioState createState() => _AudioState();
}
// class Audio {
  class _AudioState extends State<Audio> {
  

  bool playing = false;
  bool downloading = false;
  bool fileIsonDevice = false;
  bool download_failed = false;
  bool uploading = false;
  double download_level = 0.0; // for download progression loader
  double upload_level = 0.0; // for upload progression loader
  double  play_level = 0.0; // for play progression loader
  FlutterSoundPlayer flutterSoundPlayer;
  Future<StorageReference> getDownloadURL() async {
    // final StorageReference storageReference =
    return await FirebaseStorage()
        .ref()
        .child("voice/${widget.audio_id}")
        .getDownloadURL();
  }

   Future<void> init() async {
    flutterSoundPlayer = await new FlutterSoundPlayer().initialize();
  }

  checkFileExists() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    if (await io.File('${appDocDir.absolute}/voice/${widget.audio_id}').exists()) {
      return true;
    }
    return false;
  }

  @override
  initState(){
    if (widget.upload_action) {
      this.fileIsonDevice = true;
      uploadFile();
    }

  }



  Future<bool> uploadFile() async {
    uploadingState(state: true);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File file = File('${appDocDir.absolute}/voice/${widget.audio_id}');
    Uint8List buffer = (await file.readAsBytesSync()).buffer.asUint8List();
    final StorageReference storageReference =
        FirebaseStorage().ref().child("voice/${widget.user_id}");

    final StorageUploadTask uploadTask = storageReference.putData(buffer);

    final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
      // You can use this to notify yourself or your user in any kind of way.
      // For example: you could use the uploadTask.events stream in a StreamBuilder instead
      // to show your user what the current status is. In that case, you would not need to cancel any
      // subscription as StreamBuilder handles this automatically.

      // Here, every StorageTaskEvent concerning the upload is printed to the logs.
      print('EVENT ${event.type}');

      print('EVENT ${event.snapshot.totalByteCount}');
      print('EVENT ${event.snapshot.bytesTransferred}');
      this.upload_level =
          ((event.snapshot.totalByteCount / event.snapshot.bytesTransferred) *
                  100) /
              100; // update progress bar
      // TODO SetSTate
    });
  }
  Future<bool> downloadFile() async {
    uploadingState(state: true);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File file = File('${appDocDir.absolute}/voice/${widget.audio_id}');
    Uint8List buffer = (await file.readAsBytesSync()).buffer.asUint8List();
    final StorageReference storageReference =
        FirebaseStorage().ref().child("voice/${widget.user_id}");

    final StorageUploadTask uploadTask = storageReference.putData(buffer);

    final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
      // You can use this to notify yourself or your user in any kind of way.
      // For example: you could use the uploadTask.events stream in a StreamBuilder instead
      // to show your user what the current status is. In that case, you would not need to cancel any
      // subscription as StreamBuilder handles this automatically.

      // Here, every StorageTaskEvent concerning the upload is printed to the logs.
      print('EVENT ${event.type}');

      print('EVENT ${event.snapshot.totalByteCount}');
      print('EVENT ${event.snapshot.bytesTransferred}');
      this.upload_level =
          ((event.snapshot.totalByteCount / event.snapshot.bytesTransferred) *
                  100) /
              100; // update progress bar
      // TODO SetSTate
    });
  }

  uploadingState({bool state = false}) {
    if (state) {
      uploading = true;
    } else {
      uploading = false;
    }
  }

  playState({bool state = false}) {
    if (state) {
      playing = true;
    } else {
      playing = false;
    }
  }

  download_state({bool state = false}) {
    if (state) {
      downloading = true;
    } else {
      downloading = false;
    }
  }
  play_state({bool state = false}) {
    if (state) {
      playing = true;
    } else {
      playing = false;
    }
  }

  get file async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.absolute}/${widget.audio_id}');
    if (fileIsonDevice) {
      return downloadToFile;
    } else {
      if (await downloadFile()) {}
    }
  }

  Widget loader() {
    switch (this.fileIsonDevice) {
      case true:
        return Text("1:00");
        break;
      case false:
        if (uploading) {
          return CircularProgressIndicator(
            strokeWidth: 5,
            backgroundColor: Colors.grey.withOpacity(0.5),
            valueColor: new AlwaysStoppedAnimation<Color>(
                download_failed ? Colors.white24 : Colors.redAccent),
            value: upload_level,
          );
        } else if (downloading) {
          return CircularProgressIndicator(
            strokeWidth: 5,
            backgroundColor: Colors.grey.withOpacity(0.5),
            valueColor: new AlwaysStoppedAnimation<Color>(
                download_failed ? Colors.white24 : Colors.redAccent),
            // value: upload_level,
          );
        }
        break;
      case false: 
        Text("dd");
        break;
      default:
    }
  }
  @override
  Widget build(BuildContext context) {
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
        alignment: widget.direction ? Alignment.topLeft : Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              // height: MediaQuery.of(context).size.height / 6.5,
              height: 75,
              decoration: BoxDecoration(
                color: widget.direction ? Colors.white : Colors.red,
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
                        padding: const EdgeInsets.all(8.0), child: loader()),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                        value: play_level,
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
                          color: widget.direction ? Colors.red : Colors.white,
                        )),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}