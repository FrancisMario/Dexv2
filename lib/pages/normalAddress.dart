import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NormalAddress extends StatefulWidget {
  NormalAddress({Key key}) : super(key: key);

  @override
  _NormalAddressState createState() => _NormalAddressState();

  var body;
}

class _NormalAddressState extends State<NormalAddress> {
  List<String> _places = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  final _addressDescriptionController = TextEditingController();
  final _addressLocationController = TextEditingController();
  final _addressNameController = TextEditingController();

  initState() {
    getPlaces();
    _places.forEach((value) => {
      print("value"),
      print(value)
    });
    super.initState();
  }

  getPlaces() async{
    await FirebaseFirestore.instance.collection('places').get().then((value) => {
      value.docs.forEach((doc)=>{
        _places.add(doc.get("name").toString())
      })
    });
  }

  showMessage(String massage) async {
    await showDialog(
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

  _saveNormalAddress(String name, String description, String location) async {
    User user = auth.currentUser;

    var result = await FirebaseFirestore.instance
        .collection('users/${user.uid}/address')
        .add({
          "name": _addressNameController.value.text,
          "description": _addressDescriptionController.value.text,
          "location": _addressLocationController.value.text,
          "type": "normal"
        })
        .then((value) => (value) => {Navigator.of(context).pop()})
        .catchError((onError) => {print("error $onError")});
  }

  String _pickupLocation = "";
  // List<String> _places = ["aa", "ddd"];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("Normal Address")),
        body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 10,
                child: Text(
                  "Normal Addresses are alot less acurate than smart address. They require a detailed description of the location.",
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 10),
              Text("Select Location",style: TextStyle(fontSize: 30)),
              Divider(),
              SizedBox(height: 10),
              DropdownButton<String>(
                  // value: _places[0],
                  value: "Kanifing",
                  hint: Text("Pickup Location"),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 42,
                  underline: SizedBox(),
                  onChanged: (String newValue) {
                    setState(() {
                      _pickupLocation = newValue;
                    });
                    print("dropdown value: ");
                  },
                  items: _places.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
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
              new TextFormField(
                maxLines: 7,
                controller: _addressLocationController,
                decoration: new InputDecoration(
                  // labelText: "Describe the Location.",
                  hintText: "eg. West-Coast-Region Serekunda Bamboo",
                  hintStyle: TextStyle(wordSpacing: 1000, fontSize: 20),
                  fillColor: Color.fromRGBO(62, 62, 62, 1),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return "this camnnot be empty";
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
                      _addressDescriptionController.value.text != "" &&
                      _addressLocationController.value.text != "") {
                    if (await _saveNormalAddress(
                        _addressNameController.value.text.trim(),
                        _addressDescriptionController.value.text.trim(),
                        _addressDescriptionController.value.text)) {
                      Navigator.pop(context, widget.body);
                    }
                  } else {
                    showMessage("You must fill all fields");
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
