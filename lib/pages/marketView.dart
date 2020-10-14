import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexv2/pages/detailedShopView.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class MarketView extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final String categoryImage;
  

  MarketView(
      {Key key,
      this.categoryId ,
      this.categoryName ,
      this.categoryImage })
      : super(key: key);

  @override
  _MarketViewState createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {
  Future _future = null;
  Location location = new Location();
  

  @override
  void initState() {
    super.initState();
    _future = future();
  }

  @override
  Widget build(BuildContext context) {
    // location.getLocation()
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
            return scaffold([
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text(
                      "No shops added to this category yet. Check back later."),
                ),
              )
            ]);
          }
          print(snapshot.data);

          return body(docs);
          // return Text("Success ${docs.length} ${docs[0].get("name")} ${docs[1].get("name")}");
          //  return Text("Jasasa + ${snapshot.data[0]}");
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return 
        
        Center(
          // child: body(list),
          child:
          //  Text("Loading"),
         CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))
        );
      },
    );
  }

  Future future() {
    // print(FirebaseFirestore.instance.collection("products").snapshots().toList());
    print("ds");
    return FirebaseFirestore.instance
        .collection("markets")
        .where("category", isEqualTo: widget.categoryId)
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
    return scaffold(boxes);
  }

  Widget scaffold(data) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text(widget.categoryName),
            expandedHeight: MediaQuery.of(context).size.height / 4.5,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              // title: Text("Title"),
              background: Image.network(
                widget.categoryImage
                //TODO
                ,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(data))
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
            height: MediaQuery.of(context).size.height / 2,
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
    QueryDocumentSnapshot dataa = data;
    String address = "Loading Address";
    GeoPoint geolocation = dataa.get("location");


    final coordinates = new Coordinates(geolocation.latitude, geolocation.longitude);

     Geocoder.local.findAddressesFromCoordinates(coordinates).then((value) {
      address = value.first.featureName;
      print(value.first.featureName);
      setState(() {});
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return DetailedEntityView(ent_des: dataa.get("description"), ent_id: dataa.id ,ent_img: dataa.get("image"),ent_name: dataa.get("name"),)
;
          }));
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          height: MediaQuery.of(context).size.height / 4,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
          ),
          child: Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      child: Image.network(
                    "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
                    fit: BoxFit.cover,
                  )),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          dataa.get("name"),
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          dataa.get("description"),
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Icon(Icons.location_searching),
                            Text(address),
                            // Text(dataa.get("location")),
                          ],
                        ),
                      ),
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
