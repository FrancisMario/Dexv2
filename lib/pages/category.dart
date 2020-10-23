import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexv2/pages/detailedShopView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Category extends StatefulWidget {
  Category({Key key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Future _future = null;

  @override
  void initState() {
    super.initState();
    _future = future();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      // future: _future, // a previously-obtained Future<String> or null
      future: future(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // List<Widget> children;

        if (snapshot.hasData) {
          var ss = snapshot.data as QuerySnapshot;

          var docs = ss.docs;
          if (docs.length == 0) {
            //if no addresses were found
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text(
                    "No Contact Addresses yet. Use the button below to add new addresses"),
              ),
            );
          }
          print(snapshot.data);

          return body(docs);
          return Text(
              "Success ${docs.length} ${docs[0].get("name")} ${docs[1].get("name")}");
          //  return Text("Jasasa + ${snapshot.data[0]}");
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
          // child: body(list),
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))
        );
      },
    );
  }

  Future future() {
    // print(FirebaseFirestore.instance.collection("products").snapshots().toList());
    print("ds");
    return FirebaseFirestore.instance.collection("category")
    // .where(field)
    .get();
    // return  FirebaseFirestore.instance.collection("products").snapshots().toList();
    // .then((value) => {
    //    value.docs.forEach((element) {
    //            list.add(box(element));
    //            setState(() {
    //            });
    //            print(element.get("name"));
    //            print(element.id);
    //            print(list.length.toString());
    //         })
    //  });
  }

  Widget body(dataa) {
    List<QueryDocumentSnapshot> docs = dataa;
    List<Widget> boxes = [];

    docs.forEach((element) {
      boxes.add(anotherBox(element));
    });
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Categories"),
            expandedHeight: MediaQuery.of(context).size.height / 4.5,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              // title: Text("Title"),
              background: Image.network(
                "https://drive.google.com/file/d/10FZATLo0nBsAeC-A1Vo4HaNr96L1h0hR/view?usp=sharing" //TODO
                ,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(boxes))
        ],
      ),
    );
  }

  Widget box(data) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return Text("");
          }));
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 3.5,
            color: Colors.blueGrey,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(""),
                    )),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(data.get("name")),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              "data sdf sd fsd pf dfuh u u  hafu9sd 9syf a9asdf9 shdf9h"),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  Widget anotherBox(data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
            Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return DetailedEntityView(ent_des: data.get("description"), ent_id: data.id ,ent_img: data.get("image"),ent_name: data.get("name"),);
          }));
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.height / 3.5,
          child: Expanded(
            child: Stack(fit: StackFit.expand, children: <Widget>[
              Expanded(
                  child: Image.network(
                "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
                fit: BoxFit.cover,
              )),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black87.withOpacity(0.3),
                    Colors.black54.withOpacity(0.3),
                    Colors.black38.withOpacity(0.3),
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                ),
              ),
              //  Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget>[
              //       Text(data[index]["name"]),
              //       Text(data[index]["id"]),
              //     ],
              //   ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data.get("name"),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2),
                    ),
                    // Text(url+data[index]['image']),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
