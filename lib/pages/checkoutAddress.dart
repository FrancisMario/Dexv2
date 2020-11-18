

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexv2/pages/myaddress.dart';
import 'package:dexv2/pages/people.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

/// This Widget is the main application widget.
class CheckOutAddress extends StatefulWidget {
  final Map data;

  const CheckOutAddress({Key key, this.data}) : super(key: key);
  @override
  _CheckOutAddressState createState() => _CheckOutAddressState();
}

class _CheckOutAddressState extends State<CheckOutAddress> {
  FirebaseAuth auth = FirebaseAuth.instance;
    
  // Future<String> _calculation = Future<String>.delayed(Duration(seconds: 2),() => 'Data Loaded',);
  
 
  Widget build(BuildContext context) {
    return Scaffold(
      // style: Theme.of(context).textTheme.headline2,
      // textAlign: TextAlign.center,
      // floatingActionButton: Add(),
      appBar: AppBar(title:Text("Choose an address")),
      body: Column(
        children: [
          UseCurrentLocation(),
          Card(title:"My Addresses", description: "Addresses That belong to you.",route: MyAddress()),
          Card(title:"People",description: "Addresses That belong to your contacts.", route: MyPeople())
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
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10)
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
                          color: Colors.white
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align( alignment: Alignment.centerRight ,child: Icon(Icons.info,size: 30,color: Colors.white,)),
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
                          fontSize: 15,
                          fontWeight:FontWeight.w500,
                          color: Colors.white
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

  Widget UseCurrentLocation()  {
    return GestureDetector(
      onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
          //                  return route;
          //                  }
          //           ),
          //           );
      },
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          // height: MediaQuery.of(context).size.height / 5.7,
          // height: 50,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            // borderRadius: BorderRadius.circular(10)
          ),
          child:Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Text("Use Current Location", style: TextStyle(
                          fontSize: 20,
                          fontWeight:FontWeight.w900,
                          color: Colors.white
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child:Padding(
                  //     padding: const EdgeInsets.all(5.0),
                  //     child: Align( alignment: Alignment.centerRight ,child: Icon(Icons.info,size: 30,color: Colors.white,)),
                  //   )
                  // ),
                ],
              ),
                // Row(
                //     children: <Widget>[
                //        Expanded(
                //     child: Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: Text("Deliver order to this address your are currently at, this uses your gps location to track your exact location.", style: TextStyle(
                //         fontSize: 15,
                //         fontWeight:FontWeight.w500,
                //         color: Colors.white
                //         ),
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ),
                //   ),
                //     ],
                //   ),
            ],
          ),
        ),
      ),
    );
  }

  showMessage(String title, String massage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text(massage),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

getAddress() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        showMessage("Error","You must enable Location on your phone.");
        getAddress();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        showMessage("Error","You must grant us permission to access your location");
        getAddress();
      }
    }

    _locationData = await location.getLocation();
    
    print(_locationData.latitude);
    print(_locationData.longitude);

    await _makeOrder(_locationData);
  }
  _makeOrder(_locationData) async {
    User user = auth.currentUser;
    print("user id : ${user.uid}");
    var result =   FirebaseFirestore.instance
        .collection('users/${user.uid}/address')
        .add({
          "content":{
            "cart":widget.data["orriginalcart"],
            "resturant":widget.data["resturantStats"],
            "client":{
              "id":user.uid,
              "location":{
                "":"",
                "":"",
              },
            }
          },
        }).then(
          (value) => {
             FirebaseFirestore.instance
        .collection('orders/')
        .add({
          "content":{
            "cart":widget.data["orriginalcart"],
            "resturant":widget.data["resturantStats"],
            "client":{
              "id":user.uid,
              "location":{
                "":"",
                "":"",
              },
            }
          },
        }).then(
          (value) => {
            Navigator.of(context).pop()
          } 
          )
          } 
          ).catchError(
            (onError) => {print("error $onError")}
            );
        
  }


}
