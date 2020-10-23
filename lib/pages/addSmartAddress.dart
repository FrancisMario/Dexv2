import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class SmartAddress extends StatefulWidget {
  SmartAddress({Key key}) : super(key: key);

  @override
  _SmartAddressState createState() => _SmartAddressState();
}

class _SmartAddressState extends State<SmartAddress> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _addressNameController = TextEditingController();
  final _addressDescriptionController = TextEditingController();

  _saveSmartAddress() async {
   
   Location location = new Location();

   await  print(location.getLocation());
    // Navigator.of(context).pop();
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

    await _future(_locationData);
  }
  _future(_locationData) async {
    User user = auth.currentUser;
    print("user id : ${user.uid}");
    var result =   FirebaseFirestore.instance
        .collection('users/${user.uid}/address')
        .add({
            "name": _addressNameController.value.text, 
            "description": _addressDescriptionController.value.text,
            "location":[
              _locationData.latitude,
              _locationData.longitude
            ] ,
            "type":"smart"
        }).then(
          (value) => {
            Navigator.of(context).pop()
          } 
          ).catchError(
            (onError) => {print("error $onError")}
            );
        
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("Smart Address")),
        body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 10,
                child: Text(
                  "Smart  Addresses are very acurate, they enable us to quicky locate you. However, you have to be physicaly at the address to add it.",
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 10),
              new TextFormField(
                maxLength: 10,
                controller: _addressNameController,
                decoration: new InputDecoration(
                  labelText: "Give this address a name.",
                  fillColor: Color.fromRGBO(62, 62, 62, 1),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return "phone cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 10),
              new TextFormField(
                maxLines: 3,
                controller: _addressDescriptionController,
                decoration: new InputDecoration(
                  labelText: "Add some descriptions will ya?",
                  fillColor: Color.fromRGBO(62, 62, 62, 1),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return "phone cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.multiline,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 10),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () async {
                  if (_addressNameController.value.text != "" &&
                      _addressDescriptionController.value.text != "") {
                    print("hello");
                    // await _saveSmartAddress();
                    await getAddress();
                    // await getAddress();
                    // await _initCurrentLocation();
                    showMessage("Success","Address was succesfully added");
                    print("done");
                    Navigator.of(context).pop();
                  } else {
                    showMessage("Error","You must fill all fields");
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  child: Center(
                    child: Text(
                      "SAVE",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
