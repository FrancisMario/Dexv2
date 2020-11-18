import 'package:dexv2/pages/message.dart';
import 'package:dexv2/pages/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);
  @override
  _Base createState() => _Base();
}

class _Base extends State<Notifications> {
   static const TextStyle optionStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: true,
            flexibleSpace: TabBar(
              tabs: [
                Padding(
                  padding: const EdgeInsets.only(top:1.0),
                  child: Tab(icon: Icon(Icons.my_location),text: "Notifications",),
                ),
                Padding(
                  padding: const  EdgeInsets.only(top:1.0),
                  child: Tab(icon: Icon(Icons.history),text: "Voice Messages",),
                ),
              ],
            ),
            ),
  
          body: TabBarView(
            children: [
                Notificate(),
                Notificate(),
                // Message(),
              ],
          ),
        ),
      ),
    );
  }
}


