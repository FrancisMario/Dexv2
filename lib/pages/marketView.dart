import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MarketView extends StatefulWidget {
  MarketView({Key key}) : super(key: key);

  @override
  _MarketViewState createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {
  @override
  Widget build(BuildContext context) {
    List m = [];
    m.add("value");
    m.add("value");
    m.add("value");
    return Scaffold(
        // appBar: AppBar(title: Text("Market")),
        body: Container(
          child: Column(
            children: <Widget>[
            Container(
                width: 200,
                height: 100,
                color: Colors.redAccent,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Hello",
                      style: TextStyle(fontSize: 30),
                    ),
                    Divider(),
                    // ListView.builder(
                    //   itemCount: m.length,
                    //   itemBuilder: (context, index){
                    //     print("returning $index");
                    //       return Text("mm");
                    //   }
                    // ),
                  ],
                )),
          ]),
        ),);
  }
}
