import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexv2/pages/myaddress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailedEntityView extends StatefulWidget {
  final String ent_id;
  final String ent_des;
  final String ent_name;
  final String ent_img;
  final String pickup;

  DetailedEntityView({
    Key key,
    this.ent_id,
    this.ent_des,
    this.ent_name,
    this.ent_img,
    this.pickup,
  }) : super(key: key);
  List<Icon> logo = [Icon(Icons.add)];
  @override
  _DetailedEntityViewState createState() => _DetailedEntityViewState();
}

class _DetailedEntityViewState extends State<DetailedEntityView> {
  Future getData0;
  Map cart = {};
  List productIds = [];
  @override
  void initState() {
    super.initState();
    getData0 = future();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        ///If future is null then API will not be called as soon as the screen
        ///loads. This can be used to make this Future Builder dependent
        ///on a button click.
        /**  Dear future developer of this code...
            *   this can better.
            *   It's your problem now. Deal with it. 
           */
        future: getData0,
        // future: Future.delayed(Duration(seconds: 4)), // Dear future developer of this code... this code can better. It's your problem now. Deal with it.
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {

            ///when the future is null
            case ConnectionState.none:
              return Text(
                'Press the button to fetch data',
                textAlign: TextAlign.center,
              );

            case ConnectionState.active:

            ///when data is being fetched
            case ConnectionState.waiting:
              return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));

            case ConnectionState.done:

              ///task is complete with an error (eg. When you
              ///are offline)
              if (snapshot.hasError) {
                print("snapshot has error");
                print(snapshot.error);
                return Container(
                  child: Text("Snapshot has error"),
                );
              }
              if (snapshot.data == 404) {
                return Material(child: Text("404 Error"));
              }
              return _body(snapshot.data);
          }
        },
      ),
    );
  }

// Body
  Widget _body(data) {
    QuerySnapshot dataa = data;
    print("data");
    print(dataa.docs.length);
    print(data);
    if (data != null) {
      return Container(
        child: Scaffold(
          floatingActionButton: GestureDetector(
            onTap: (() {
              if (productIds.isEmpty) {
                showMessage("Cart is Empty");
              } else {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return MyAddress(
                    resturantStats: {
                      "pickup": widget.pickup,
                      "resturant": widget.ent_id
                    },
                    originalcart: cart
                  );
                }));
              }
            }),
            child: Container(
              // margin: EdgeInsets.only(right:10),
              width: 90,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: Colors.white,
                      onPressed: () {}),
                  Text(
                    " ${productIds.length.toString()}",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    // child: Image.network(widget.ent_img,
                    child: Image.asset(
                      "assets/images/restaurants-jays-burger.png",
                      key: widget.key,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 20.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          iconSize: 30.0,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        // IconButton(icon: Icon(Icons.shopping_basket,color: Colors.pink,semanticLabel:"ds"),iconSize: 30.0, onPressed: () {  },),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.ent_name,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star_half, color: Colors.yellow)
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.ent_des,
                      style: TextStyle(fontSize: 15),
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Divider(
                        thickness: 1.5,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Products",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    // Text("CREATE TABLE `market_tables`.`#entity_ID#` ( `table_id` INT NOT NULL AUTO_INCREMENT , `entity_id` VARCHAR(10) NOT NULL , `entity_name` VARCHAR(20) NOT NULL , `entity_description` TEXT NOT NULL , `entity_image` VARCHAR(100) NOT NULL, `visible` VARCHAR(20) NULL , PRIMARY KEY (`table_id`)) ENGINE = InnoDB",overflow: TextOverflow.clip,),
                  ],
                ),
              ),
              // print(dataa.docs.first.data());
              Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    physics: BouncingScrollPhysics(),
                    children: List.generate(
                      dataa.docs.length,
                      (index) {
                        widget.logo.add(Icon(Icons.add));
                        print("sssssssssssssssssssssssssssss");
                        print(dataa.docs[index].get("name"));
                        return _builder(dataa.docs[index], index);
                      },
                    )),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sorry, there was an error",
                    style: TextStyle(fontSize: 16),
                  ),
                  FlatButton(
                    color: Colors.white,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ]),
          ),
        ),
      );
    }
  }

  // Builder
  Widget _builder(dynamic data, int index) {
    QueryDocumentSnapshot dataa = data;
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
            // margin: EdgeInsets.all(10),
            child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: 175.0,
              width: 175.0,
              child: Image.network(
                dataa.get("image")[0],
                key: widget.key,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            GestureDetector(
              onLongPress: () {
                showDetails(dataa);
              },
              child: Container(
                height: 175.0,
                width: 175.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black87.withOpacity(0.3),
                    Colors.black54.withOpacity(0.3),
                    Colors.black38.withOpacity(0.3),
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                ),
              ),
            ),
            Positioned(
              bottom: 60.0,
              child: Column(
                children: <Widget>[
                  Text(
                    dataa.get("name"),
                    style: TextStyle(
                        //resturant name
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2),
                  ),
                  Text(
                    dataa.get("price").toString(),
                    style: TextStyle(
                        // price
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 48,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: IconButton(
                      icon: widget.logo[index],
                      color: Colors.white,
                      onPressed: () {
                        // Provider.of<AppState>(context, listen: false)
                        //     .cartProducts
                        //     .add(Product.fromJson(data));

                        if (!this.productIds.contains(dataa.id)) {
                          setState(() {
                            widget.logo[index] = Icon(Icons.remove);
                          });

                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              cart.addAll({
                                "${dataa.get("name").toString()}":{
                                  "price":dataa.get("price"),
                                  "image":dataa.get("image")[0],
                                  "quantity":1,
                                },
                              
                              });
                              // cart.addEntries({
                              //   dataa.get("name").toString():
                              //   {
                              //     "price": dataa.get("name"),
                              //     "image":"https://hips.hearstapps.com/hmg-prod/images/delish-190808-baked-drumsticks-0217-landscape-pf-1567089281.jpg",
                              //     "quantity": 1
                              //   }
                              // });

                              this.productIds.add(dataa.id);
                              print('added ' + cart.length.toString());
                              print('added ' + dataa.id);
                            });
                          });
                        } else {
                          setState(() {
                            widget.logo[index] = Icon(Icons.add);
                            print('removed ' + dataa.id);
                          });

                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              cart.remove(dataa.get("name").toString());
                              this.productIds.remove(dataa.id);
                            });
                          });
                        }
                      }),
                )),
          ],
        )),
      ),
    );
  }

  showDetails(QueryDocumentSnapshot data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(""),
            content: Container(
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Text(
                      "Price ",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ]),
                  Row(
                    // description
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        data.get("description"),
                        overflow: TextOverflow.clip,
                      )),
                    ],
                  ),
                  // Container(
                  //   height: 100,
                  //   width: 200,
                  //   child: Image.network(
                  //     "" + data['image_0'],
                  //     key: widget.key,
                  //     fit: BoxFit.cover,
                  //     filterQuality: FilterQuality.low,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: Colors.black45,
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   height: 150,
                  //   width: 200,
                  //   child: Image.network(
                  //     "" + data['image_1'],
                  //     key: widget.key,
                  //     fit: BoxFit.cover,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: Colors.black45,
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   height: 100,
                  //   width: 200,
                  //   child: Image.network(
                  //     "" + data['image_2'],
                  //     key: widget.key,
                  //     fit: BoxFit.cover,
                  //     filterQuality: FilterQuality.low,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: Colors.black45,
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
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

  showMessage(String massage) {
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

  Future future() {
    // print(FirebaseFirestore.instance.collection("products").snapshots().toList());
    print("ds");
    print("markets/${widget.ent_id}/products");
    return FirebaseFirestore.instance
        .collection("markets/${widget.ent_id}/products")
        .get();
  }
}
