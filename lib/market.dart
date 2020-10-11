import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexv2/pages/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  Market({Key key}) : super(key: key);

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Orders"),
            expandedHeight: MediaQuery.of(context).size.height / 4.5,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              // title: Text("Title"),
              background: Image.network(
                "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg" //TODO
                ,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("products").snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Text('PLease Wait')
                  : ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot markets =
                            snapshot.data.documents [index];
                        // return Text(snapshot.data.documents[index]);
                        return _buildList(snapshot.data.documents[index]);
                      },
                    );
            },
          )
        ],
      ),
    );
  }

  Widget _buildList(data) {
    List<Widget> listItems = List();

      for (var item in data) {
        listItems.add(box({"name":"Test","image":"https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg"}));
      }
    // listItems.add(box("Custom Orders", "Make custom delivery Orders ", CustomOrder()),);
    // listItems.add(box("Track Orders", "Track your ongoing orders", CustomOrder()),);
    // listItems.add(box("Track Orders", "Track your ongoing orders", CustomOrder()),);

   return  SliverList(delegate: new SliverChildListDelegate(listItems));

  }


  Widget box(data) {
      return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                           return Category();
                           }));
                   },
                  child: Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children:<Widget>[
                        Expanded( 
                          child: 
                          Image.network( 
                          data["image"],
                          fit: BoxFit.cover,
                          )
                          ),
                        Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.black87.withOpacity(0.3),
                              Colors.black54.withOpacity(0.3),
                              Colors.black38.withOpacity(0.3),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(data['name'],style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2
                            ),),
                            // Text(url+data[index]['image']),
                        ],),
                      ),
                      ]
                    ),
                  ),
                );
}
}
