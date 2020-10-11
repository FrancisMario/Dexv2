import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FuturedContent extends StatefulWidget {
  FuturedContent({Key key}) : super(key: key);

  @override
  _FuturedContentState createState() => _FuturedContentState();
}

class _FuturedContentState extends State<FuturedContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 100,
        color: Colors.redAccent,
        child: Column(
          children: <Widget>[
            Text("Hello",style: TextStyle(fontSize:30),),
            ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Text("Hello"),
              ],
            ),
          ],
        )),
    );
  }
  //  StreamBuilder<Object>(
  //             stream: null,
  //             builder: (context, snapshot) {
  //               return Text("Hello");
  //             }
  //           ),
  Widget Card() {
    return Container(
      width: 200,
      height: 150,
      color: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("ds"),
      ),
    );
  }
}
