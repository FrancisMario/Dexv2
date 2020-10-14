import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomOrder extends StatefulWidget {
  CustomOrder({Key key}) : super(key: key);

  @override
  _CustomOrderState createState() => _CustomOrderState();
}

class _CustomOrderState extends State<CustomOrder> {
  TextEditingController _detailed_pickup_address_controller =
      new TextEditingController(); //✅
  TextEditingController _detailed_delivery_address_controller =
      new TextEditingController(); //✅
  TextEditingController _recipient_fullname_controller =
      new TextEditingController(); //✅
  TextEditingController _recipient_phone_controller =
      new TextEditingController(); //✅
  String _pickupLocation = null;
  String _deliveryLocation = null;
  String _pickupDate = null;
  String _pickupTime = null;
  String _deliveryDate = null;
  List<String> _places = ["aa", "ddd", "Serekunda"];
  var dateFormater = new DateFormat('EEE, M/d/yyyy');
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("Add New Order")),
        body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 10,
                child: Text(
                  "Make Custom pickup - delivery orders. We can pickup a package from a location and deliver to another location.",
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  Align(
                    child: Text(
                      "Pickup",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 1.5),
                  Divider()
                ]),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  Align(
                    child: Text("Pickup Location"),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 1),
                  // Divider()
                ]),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: 250,
                  height: 60,
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
                        "Pickup Location",
                      ),
                      icon: Icon(Icons.add),
                      iconSize: 38,
                      underline: SizedBox(),
                      onChanged: (String newValue) {
                        setState(() {
                          _pickupLocation = newValue;
                        });
                        print("dropdown value: ");
                      },
                      items:
                          _places.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()),
                ),
              ),

              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color:
                              _pickupTime != null ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            print("picking date");
                            _pickDate("pickup");
                          },
                          child: Text(_pickupDate != null
                              ? _pickupDate.toString()
                              : "Pick Date"),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 60,
                      // color: Colors.indigoAccent,
                      child: Text(""),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color:
                              _pickupTime != null ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            print("picking time");
                            _pickTime();
                          },
                          child: Text(_pickupTime != null
                              ? _pickupTime.toString()
                              : "Pick Time"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              new TextFormField(
                maxLines: 7,
                controller: _detailed_pickup_address_controller,
                decoration: new InputDecoration(
                  // labelText: "Describe the Location.",
                  hintText:
                      "Address Description eg. West-Coast-Region Serekunda Bamboo",
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
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  Align(
                    child: Text(
                      "Recipient",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 1.5),
                  Divider()
                ]),
              ),
              new TextFormField(
                maxLength: 10,
                controller: _recipient_fullname_controller,
                decoration: new InputDecoration(
                  labelText: "Recipient fullname.",
                  fillColor: Color.fromRGBO(62, 62, 62, 1),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return "recipient name cannot be empty";
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
                maxLength: 10,
                controller: _recipient_phone_controller,
                decoration: new InputDecoration(
                  labelText: "Recipient Phone.",
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
                keyboardType: TextInputType.phone,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 10),

              // Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Column(children: <Widget>[
              //     Align(
              //       child: Text("Recipient"),
              //       alignment: Alignment.centerLeft,
              //     ),
              //     SizedBox(height: 1.5),
              //     Divider()
              //   ]),
              // ),

              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: 250,
                  height: 60,
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
                        "Delivery Location",
                      ),
                      icon: Icon(Icons.add),
                      iconSize: 38,
                      underline: SizedBox(),
                      onChanged: (String newValue) {
                        setState(() {
                          _deliveryLocation = newValue;
                        });
                        print("dropdown value: ");
                      },
                      items:
                          _places.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()),
                ),
              ),

              SizedBox(height: 10),
              new TextFormField(
                maxLines: 7,
                controller: _detailed_delivery_address_controller,
                decoration: new InputDecoration(
                  // labelText: "Describe the Location.",
                  hintText:
                      "Address Description eg. West-Coast-Region Serekunda Bamboo",
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
                  await postOrder();
                  // Navigator.of(context).pop();
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

  postOrder() async {
    // adding order to database
    if (await verify()) {
      User user = auth.currentUser;
      print("user id : ${user.uid}");
      print("level one");
      var result = await FirebaseFirestore.instance
          .collection('users/${user.uid}/orders')
          .add({
            "detailed_pickup_address": _detailed_pickup_address_controller.text,
            "detailed_delivery_address":
                _detailed_delivery_address_controller.text,
            "recipient_fullname": _recipient_fullname_controller.text,
            "recipient_phone": _recipient_phone_controller.text,
            "pickupLocation": _pickupLocation,
            "deliveryLocation": _deliveryLocation,
            "pickupDate": _pickupDate,
            "pickupTime": _pickupTime,
            "type": "custom",
            "status": "submitted"
          })
          .then((value){
                print("level two");
                FirebaseFirestore.instance.collection('custom_orders/').add({
                  "pickup_date": _pickupDate,
                  "pickup_time": _pickupTime,
                  "pickup_location": _pickupLocation,
                  "user_id": user.uid,
                  "status": "submitted",
                }).then((value)  {
                  print("level three");
                   showMessage("Everything Cool", "Apperently, everything was cool");
                  print("level four");
                  
                });
              })
          .catchError((onError) => {print("error $onError")});
    } else {
      showMessage("Nope..!", "Apperently, everything was NOT cool");
    }
  }

  showStatus(state) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              state ? "Success" : "Error",
              style: TextStyle(color: state ? Colors.green : Colors.red),
            ),
            content: Text(state
                ? "Order was successfully placed"
                : "Sorry, we were unable to place the order because of an error. Please check your internet connection and try again."),
          );
        });
  }

  showMessage(title, message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(color: Colors.redAccent),
            ),
            content: Text(message),
          );
        });
  }

  /**
   * Verifying that all the fields have values
   */
  verify() {
    print("checking....");
    if (_detailed_pickup_address_controller.text.isNotEmpty &&
            _detailed_delivery_address_controller.text.isNotEmpty &&
            _recipient_fullname_controller.text.isNotEmpty &&
            _recipient_phone_controller.text.isNotEmpty &&
            _pickupLocation.isNotEmpty &&
            _deliveryLocation.isNotEmpty &&
            _pickupDate.isNotEmpty &&
            _pickupTime.isNotEmpty
        // _deliveryDate != null
        ) {
      print(
          "_detailed_pickup_address_controller.text ${_detailed_pickup_address_controller.text}");
      print(
          "_detailed_delivery_address_controller.text ${_detailed_delivery_address_controller.text}");
      print(
          "_recipient_fullname_controller.text ${_recipient_fullname_controller.text}");
      print(
          "_recipient_phone_controller.text ${_recipient_phone_controller.text}");
      print("_pickupLocation $_pickupLocation");
      print("_deliveryLocation $_deliveryLocation");
      print("_pickupDate $_pickupDate");
      print("_pickupTime $_pickupTime");
      // print("_deliveryDate $_deliveryDate");
      return true;
    }
    print(
        "_detailed_pickup_address_controller.text ${_detailed_pickup_address_controller.text}");
    print(
        "_detailed_delivery_address_controller.text ${_detailed_delivery_address_controller.text}");
    print(
        "_recipient_fullname_controller.text ${_recipient_fullname_controller.text}");
    print(
        "_recipient_phone_controller.text ${_recipient_phone_controller.text}");
    print("_pickupLocation $_pickupLocation");
    print("_deliveryLocation $_deliveryLocation");
    print("_pickupDate $_pickupDate");
    print("_pickupTime $_pickupTime");
    // print("_deliveryDate $_deliveryDate");

    return false;
  }

  _pickDate(String type) async {
    DateTime date = await showDatePicker(
      context: context,
      currentDate: DateTime(DateTime.now().year),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + (DateTime.now().day + 7)),
      initialDate: DateTime(DateTime.now().year),
    );
    if (date != null)
      setState(() {
        if (type == "pickup") {
          _pickupDate = dateFormater.format(date);
          print("_pickupDate");
          print(_pickupDate);
        } else {
          _deliveryDate = dateFormater.format(date);
          print(_deliveryDate);
        }
      });
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (t != null)
      setState(() {
        _pickupTime = t.format(context);
      });
  }
}
