import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Message extends StatefulWidget {
  Message({Key key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("Message"),
    );
  }
}