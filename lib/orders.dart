import 'package:dexv2/pages/customorder.dart';
import 'package:dexv2/pages/trackorders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Orders extends StatefulWidget {
  Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User user = auth.currentUser;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text(user.displayName),
            expandedHeight: MediaQuery.of(context).size.height / 3,
            floating: false,
            pinned: true,
            elevation: 10,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              // title: Text("Title"),
              background: Image.network(
                "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg" // TODO:
                ,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(delegate: new SliverChildListDelegate(_buildList(50))),
        ],
      ),
    );
  }

  List _buildList(int count) {
    List<Widget> listItems = List();

    listItems.add(
      box("Custom Orders", "Make custom delivery Orders ", CustomOrder()),
    );
    listItems.add(
      box("Track Orders", "Track your ongoing orders", TrackOrders()),
    );

    return listItems;
  }

  Widget box(String title, String des, Widget route) {
    return new Padding(
      padding: new EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return route;
          }));
        },
        child: new Container(
          decoration: BoxDecoration(
              color: Colors.indigoAccent,
              gradient: LinearGradient(
          begin: Alignment.topLeft,
          end:
              Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
          colors: [
            const Color(0xffef709b),
            const Color(0xfffa9372)
          ], // red to yellow
          // tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          width: MediaQuery.of(context).size.width / 1.2,
          height: MediaQuery.of(context).size.height / 4,
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              child: Divider(
                thickness: 2,
                color: Colors.black38,
              ),
            ),
            Text(
              des,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ]),
        ),
      ),
    );
  }
}
