import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexv2/pages/addSmartAddress.dart';
import 'package:dexv2/pages/checkout.dart';
// import 'package:dexv2/pages/normalAddress.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class MyAddress extends StatefulWidget {
  final Map originalcart;
  final Map resturantStats;
  const MyAddress({Key key, this.originalcart, this.resturantStats})
      : super(key: key);
  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var _pickupLocation = null;
  var _price = 0;
  List<dynamic> _places = [];
  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
    () => 'Data Loaded',
  );

  @override
  void initState() {
    super.initState();
  }

  _future() {
    User user = auth.currentUser;
    return FirebaseFirestore.instance
        .collection('users/${user.uid}/address')
        .snapshots();
  }

  Widget build(BuildContext context) {
    fetchPlaces();
    return Scaffold(
        appBar: AppBar(title: Text("My Addresses")),
        floatingActionButton:
            // widget.originalcart !== null ?
            FloatingActionButton(
          onPressed: () {
            showGeneralDialog(
              barrierLabel: "Label",
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: Duration(milliseconds: 700),
              context: context,
              pageBuilder: (context, anim1, anim2) {
                return Align(
                  alignment: Alignment.bottomRight,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Container(
                      height: 200,
                      width: 100,
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return SmartAddress();
                                  }),
                                );
                              },
                              child: Container(
                                width: 100,
                                color: Colors.white,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.directions_walk, size: 30),
                                      Text("Smart address",
                                          style: TextStyle(fontSize: 10))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       Navigator.of(context).push(
                          //         MaterialPageRoute(
                          //             builder: (BuildContext context) {
                          //           return NormalAddress();
                          //         }),
                          //       );
                          //     },
                          //     child: Container(
                          //       width: 100,
                          //       color: Colors.red,
                          //       child: Center(
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.center,
                          //           children: <Widget>[
                          //             Icon(
                          //               Icons.directions_car,
                          //               size: 30,
                          //               color: Colors.white,
                          //             ),
                          //             Text(
                          //               "Normal address",
                          //               style: TextStyle(
                          //                   fontSize: 10, color: Colors.white),
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
                    ),
                  ),
                );
              },
              transitionBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                      .animate(anim1),
                  child: child,
                );
              },
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.width / 5,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width / 2.5)),
            child: Center(child: Icon(Icons.add)),
          ),
        )
        // : Text("")
        ,
        body: StreamBuilder<dynamic>(
          stream: _future(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              var aa = snapshot.data as QuerySnapshot;
              var ss = aa.docs;
              if (ss.length == 0) {
                //if no addresses were found
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Text(
                        ""),
                        // "No Contact Addresses yet. Use the button below to add new addresses"),
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.only(bottom: 80),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    // itemExtent: 80.0,
                    itemCount: ss.length,
                    itemBuilder: (context, index) {
                      // return Card(ss[index], context);
                      return Text("",);
                    }),
              );
              // print(ss.data());
              //  return Text("Jasasa + ${snapshot.data[0]}");
            } else if (snapshot.hasError) {
              return Error(snapshot.error);
            } else {
              return Loading();
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // children: children,
                // children: children,
              ),
            );
          },
        ),
        bottomSheet: widget.originalcart != null
            ? Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 4,
                color: Colors.red[900],
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        _selectLocation(context);

                        // getAddress();
                      },
                      child: widget.originalcart != null
                          ? Container(
                              height: MediaQuery.of(context).size.width / 4,
                              color: Colors.red,
                              child: Center(
                                child: Text(
                                  "Deliver Here",
                                  // "Deliver To Current Location",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ),
                            )
                          : Text("oij"),
                    )),
                  ],
                ),
              )
            : Text(""));
  }

  Loading() {
    return Center(
      child: Column(children: <Widget>[
        SizedBox(
          child: CircularProgressIndicator(),
          width: 60,
          height: 60,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Awaiting result...'),
        )
      ]),
    );
  }

  Card(QueryDocumentSnapshot data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        // height: MediaQuery.of(context).size.height / 5,
        // height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(
            //   color: Colors.white
            // ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurRadius: 10, offset: Offset(2, 2)),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      data.get("name"),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.red),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            // dialog();
                            showGeneralDialog(
                              barrierLabel: "Label",
                              barrierDismissible: true,
                              barrierColor: Colors.black.withOpacity(0.5),
                              transitionDuration: Duration(milliseconds: 700),
                              context: context,
                              pageBuilder: (context, anim1, anim2) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Container(
                                      height: 350,
                                      child: SizedBox.expand(
                                          child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15,
                                                left: 15,
                                                right: 10,
                                                bottom: 5),
                                            child: Column(
                                              children: <Widget>[
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Name",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                                Divider(),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0, top: 5),
                                                  child: Text(
                                                    data.get("name"),
                                                    style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              children: <Widget>[
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Description",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Divider(),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0, top: 5),
                                                  child: Text(
                                                    data.get("description"),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.black),
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              children: <Widget>[
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Options",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                                Divider(),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: FlatButton(
                                                      onPressed: () {},
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .deepOrange,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          width: 100,
                                                          height: 50,
                                                          child: Center(
                                                              child: Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                          ))),
                                                    )),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: FlatButton(
                                                      onPressed: () {},
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .deepOrange,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        width: 100,
                                                        height: 50,
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.share,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                      margin: EdgeInsets.only(
                                          bottom: 20, left: 12, right: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              transitionBuilder:
                                  (context, anim1, anim2, child) {
                                return SlideTransition(
                                  position: Tween(
                                          begin: Offset(0, 1),
                                          end: Offset(0, 0))
                                      .animate(anim1),
                                  child: child,
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.info,
                            size: 35,
                            color: Colors.grey,
                          ))),
                )),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.get("description"),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black38),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            widget.originalcart != null ? selectButton(data) : Text(""),
          ],
        ),
      ),
    );
  }

  Widget selectButton(data) {
    data.get("description");
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: () {
                setAddress(data);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                color: Colors.green,
                width: 150,
                height: 50,
                child: Center(
                  child: Text(
                    "Select",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Error(err) {
    return <Widget>[
      Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text('Error: ${err}'),
      )
    ];
  }

  Success(data) {
    return <Widget>[
      Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text('Result: ${data}'),
      )
    ];
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

// sets the delivery address to one of the clients addresses
  setAddress(QueryDocumentSnapshot data) {
    var address;
    User user = auth.currentUser;
    if (data.get("type") == "normal") {
      address = {
        "description": data.get("description"),
        "location": data.get("location"),
        "type": data.get("type"),
      };
    } else {
      address = {
        "description": data.get("description"),
        "geopoint": data.get("location"),
        "type": data.get("type"),
      };
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Checkout(
          originalcart: widget.originalcart,
          resturantStats: widget.resturantStats,
          client: {
            "id": user.uid,
            "address": address,
          },
        );
      }),
    );
  }

// sets the delivery address to the clients current location
  getAddress() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        showMessage("Error", "You must enable Location on your phone.");
        getAddress();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        showMessage(
            "Error", "You must grant us permission to access your location");
        getAddress();
      }
    }

    _locationData = await location.getLocation();

    print(_locationData.latitude);
    print(_locationData.longitude);

    _proceedToCheckout({
      "latitude": _locationData.latitude,
      "longitude": _locationData.longitude
    });
  }

  // for determining price because reverse geocoding from coordinate is not working for now.
  _selectLocation(context) async {
    await fetchPlaces();
    showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              title: new Text("Select Current Location"),
              content: new Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    // width: 250,
                    // height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      // color: Colors.blueAccent,
                      // border: Border(
                      //   top: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
                      //   left: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
                      //   right: BorderSide(width: 2.0, color: Color(0xFFFF7F7F7F)),
                      //   bottom: BorderSide(width: 2.0, color: Color(0xFFFF7F7F7F)),
                      // ),
                    ),
                    child: DropdownButton<String>(
                        // value: _pickupLocation,
                        dropdownColor: Colors.grey,
                        elevation: 10,
                        hint: Text(
                          _pickupLocation == null
                              ? "Pickup Location"
                              : _pickupLocation,
                        ),
                        icon: Icon(Icons.add),
                        iconSize: 38,
                        underline: SizedBox(),
                        onChanged: (dynamic newValue) {
                          print("dropdown value: $newValue");
                          setPrice(newValue);
                          setState(() {
                          _pickupLocation = newValue;
                          });
                          refresh();
                          // Navigator.of(context).pop();
                        },
                        items: _places
                            .map<DropdownMenuItem<String>>((dynamic value) {
                          // print(value["price"] + "=>" + value["price"]);
                          return DropdownMenuItem<String>(
                            value: value["name"],
                            child: Text(value["name"],style: TextStyle(
                              fontSize:15,
                            )),
                          );
                        }).toList()),
                  ),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Enter'),
                  onPressed: () {
                    print("pickup location  :" + _pickupLocation);
                    if (!(_pickupLocation == null)) {
                      print("pickup location  :" + _pickupLocation);
                      getAddress();
                      Navigator.of(context).pop();
                    } else {}
                  },
                )
              ],
            ));
  }

  fetchPlaces() {
    print("hello");
    // var string = await http.get('http://192.168.100.6:3000/locations/');
    // var string = await http.get('http://admin.dexgambia.com/locations/');
    var string = http
        .get('http://192.168.100.6:3000/locations/')
        .then((value) => {this._places = jsonDecode(value.body)});
    this._places.forEach((element) {
      print(element["name"]);
    });
    // print(this._places);
    // List<Map> response = jsonDecode(string.body);
    // await response.forEach((element) {
    // this._places = element["name"];
    //  });
  }

  setPrice(String name) {
    // var element = _places.singleWhere((element) => element[name]);
    // this._price = element["price"];
  }
     // Am ashamed of this code right here
    refresh() {
      Navigator.of(context).pop();
      _selectLocation(context);
    }
  _proceedToCheckout(address) async {
    User user = auth.currentUser;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Checkout(
          originalcart: widget.originalcart,
          resturantStats: widget.resturantStats,
          client: {
            "id": user.uid,
            "address": address,
            "location": _pickupLocation,
            "price": _price
          },
        );
      }),
    );
 

    // Checkout(
    //   originalcart: widget.originalcart,
    //   resturantStats: widget.resturantStats,
    //   client: {
    //     "id": user.uid,
    //     "address": address,
    //   },
    // );

    // User user = auth.currentUser;
    // print("user id : ${user.uid}");
    // var result = FirebaseFirestore.instance
    //     .collection('users/${user.uid}/address')
    //     .add({
    //       "content": {
    //         "cart": widget.originalcart,
    //         "resturant": widget.originalcart,
    //         "client": {
    //           "id": user.uid,
    //           "location": {
    //             "": "",
    //             "": "",
    //           },
    //         }
    //       },
    //     })
    //     .then((value) => {Navigator.of(context).pop()})
    //     .catchError((onError) => {print("error $onError")});
  }
}
