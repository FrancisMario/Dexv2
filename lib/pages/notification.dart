import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Notificate extends StatefulWidget {
  Notificate({Key key}) : super(key: key);

  @override
  _NotificateState createState() => _NotificateState();
}

class _NotificateState extends State<Notificate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //  child: Text("notification"),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 270,
            height: 70,
            decoration: BoxDecoration(color: Colors.amber),
            child: Row(
              children: [
                Expanded(
                  child: Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                          child: Divider(),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                          child: Text("1:34"),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.send),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.play_circle_filled),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
