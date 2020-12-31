
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexv2/pages/myaddress.dart';
import 'package:dexv2/pages/people.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// This Widget is the main application widget.
class Address extends StatefulWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  FirebaseAuth auth = FirebaseAuth.instance;
    
  Future<String> _calculation = Future<String>.delayed(Duration(seconds: 2),() => 'Data Loaded',);
  
 
  Widget build(BuildContext context) {
    return Scaffold(
      // style: Theme.of(context).textTheme.headline2,
      // textAlign: TextAlign.center,
      // floatingActionButton: Add(),
      body: Column(
        children: [
          Card(title:"My Addresses", description: "Addresses That belong to you.",route: MyAddress()),
          // Card(title:"People",description: "Addresses That belong to your contacts.", route: MyPeople())
        ],
      )
      );
  }

  Add(){
   return FlatButton(onPressed: null, 
    child: Container(
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.width / 5,
      decoration: BoxDecoration(
      color: Colors.orange,
        borderRadius:BorderRadius.circular(MediaQuery.of(context).size.width / 2.5)
      ),
      child: Center(child: Icon(Icons.add)),
    ),);
  }

  Card({String title, String description,Widget route})  {
    return GestureDetector(
      onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                           return route;
                           }
                    ),
                    );
      },
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.height / 5,
            // height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.grey,blurRadius: 10, offset: Offset(2, 2) ),
            ],
            ),
            child:Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(title, style: TextStyle(
                          fontSize: 20,
                          fontWeight:FontWeight.w900,
                          color: Colors.red
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align( alignment: Alignment.centerRight ,child: Icon(Icons.info,size: 30,color: Colors.red,)),
                      )
                    ),
                  ],
                ),
                  Row(
                      children: <Widget>[
                         Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(description, style: TextStyle(
                          fontSize: 16,
                          fontWeight:FontWeight.w500,
                          color: Colors.black38
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }



}
