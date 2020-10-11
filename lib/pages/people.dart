import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPeople extends StatefulWidget {
  @override
  _MyPeopleState createState() => _MyPeopleState();
}

class _MyPeopleState extends State<MyPeople> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
    () => 'Data Loaded',
  );

  Future _future() async {
    User user = auth.currentUser;
    // if (await docExist(user.uid)) {
    //   // che
    // } else {
    //   return "Database doesnt exist ${user.uid}";
    // }

    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users/${user.uid}/people')
        // .where("type", isEqualTo: 'normal')
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents;
  }

  // Future<bool> docExist(String uid) async {
  //   final QuerySnapshot result = await FirebaseFirestore.instance
  //       .collection('users/')
  //       .where('uid', isEqualTo: uid)
  //       .limit(1)
  //       .get();
  //   final List<DocumentSnapshot> documents = result.docs;
  //   return documents.length == 1;
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Contacts")),
      floatingActionButton: FloatingActionButton(
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
                          child: Container(
                            width: 100,
                            color: Colors.amberAccent,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.directions_walk, size: 30),
                                  Text("Smart address",
                                      style: TextStyle(fontSize: 10))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 100,
                            color: Colors.amber,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.directions_car, size: 30),
                                  Text(
                                    "Normal address",
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
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
      ),
      body: FutureBuilder<dynamic>(
        future: _future(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            var ss = snapshot.data as List<QueryDocumentSnapshot>;
            if (ss.length == 0) { //if no addresses were found
                return Center(child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text("No Contact Addresses yet. Use the button below to add new addresses"),
                ),);              
            }
            return ListView.builder(
                // itemExtent: 80.0,
                itemCount: ss.length,
                itemBuilder: (context, index) {
                  return Card(ss[index],context);
                  // return Text(ss[index].get("uid"),style: TextStyle(fontSize:20),);
                });
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
              children: children,
            ),
          );
        },
      ),
    );
  }

  Loading() {
    return Column(children: <Widget>[
      SizedBox(
        child: CircularProgressIndicator(),
        width: 60,
        height: 60,
      ),
      const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text('Awaiting result...'),
      )
    ]);
  }

  Card(QueryDocumentSnapshot data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 5,
        // height: 50,
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.get("name"),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
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
                                      child:
                                          SizedBox.expand(
                                            child:
                                             Column(
                                            children: <Widget>[
                                                    Padding(
                                                  padding: const EdgeInsets.only(top: 15,left: 15,right: 10,bottom: 5),
                                                  child: Column(
                                                    children: <Widget>[
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("Name",style:TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:FontWeight.w500,
                                                            color: Colors.black87
                                                      ),),
                                                        ),
                                                        Divider(),
                                                  ],),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(child: Padding(
                                                      padding: const EdgeInsets.only(left:15.0,top:5),
                                                      child: Text(data.get("name"), style:TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:FontWeight.bold,
                                                          color: Colors.black87,
                                                          
                                                      ),),
                                                    ),),
                                                  ],
                                                ), 
                                                Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("Description",style:TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:FontWeight.w500,
                                                            color: Colors.black87
                                                      ),),
                                                        ),
                                                        Divider(),
                                                  ],),
                                                ),
                                                 Row(
                                                  children: <Widget>[
                                                    Expanded(child: Padding(
                                                      padding: const EdgeInsets.only(left:15.0,top:5),
                                                      child: Text(data.get("description"), 
                                                      style:TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:FontWeight.w800,
                                                          color: Colors.black87
                                                      ),
                                                      overflow: TextOverflow.clip,
                                                      ),
                                                    ),),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("Options",style:TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:FontWeight.w500,
                                                            color: Colors.black87
                                                      ),),
                                                        ),
                                                        Divider(),
                                                  ],),
                                                ),
                                                 Row(
                                                  children: <Widget>[
                                                    Expanded(child: Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: FlatButton(
                                                        onPressed: () {  },
                                                        child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.deepOrange,
                                                          borderRadius:BorderRadius.circular(5)
                                                        ),
                                                          width: 100,
                                                          height: 50,
                                                          child:Center(child: Icon(Icons.delete, color: Colors.white,))
                                                        ),
                                                      )
                                                    ),),
                                                    Expanded(child: Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: FlatButton(
                                                        onPressed: () {},
                                                        child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.deepOrange,
                                                          borderRadius:BorderRadius.circular(5)
                                                        ),
                                                          width: 100,
                                                          height: 50,
                                                          child:Center(child: Icon(Icons.share,color: Colors.white,),),
                                                        ),
                                                      )
                                                    ),),
                                                  ],
                                                ),                                         
                                            ],
                                          )),
                                      margin: EdgeInsets.only(
                                          bottom: 50, left: 12, right: 12),
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
                            color: Colors.white,
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
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
}
