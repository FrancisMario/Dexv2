import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  // final inputcart;
  // final List<Map> cart = widget.inputcart;
  final Map originalcart;
  final Map resturantStats;
  Checkout({Key key, this.originalcart, this.resturantStats}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  // var mutablecart = widget.originalcart;
  List<Widget> builder() {
    List<Widget> children = [];
    widget.originalcart.forEach((key, value) {
      children.add(item(key));
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    // widget.originalcart.elementAt(1);
    // widget.originalcart.
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 4),
        child: widget.originalcart != null
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                // itemCount: widget.cart.length,
                itemCount: (widget.originalcart.length),
                itemBuilder: (context, index) {
                  print(widget.originalcart.keys.elementAt(index));
                  return item(widget.originalcart.keys.elementAt(index));
                })
            : Center(child: Text("No Orders in cart")),
      ),
      bottomSheet: Container(
        // margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 4,
        color: Colors.teal,
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  height: MediaQuery.of(context).size.width / 4,
                  color: Colors.black12,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "DEx Service : D",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              Text(
                                "${dexService()}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "Order Cost : D",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              Text(
                                "${orderCost()}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "Total : D",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              Text(
                                "${total()}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      )),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.width / 4,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      "CheckOut",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  int dexService(){
    return 100;
  }
  int orderCost(){
    int response = 0;
       widget.originalcart.forEach((key, value) {
         response += value["price"] * value["quantity"];
      });
      return response;
  }
  int total(){

    return dexService() + orderCost();
  }

  void incrementItemCount(id) {
    widget.originalcart[id]["quantity"]++;
    print(widget.originalcart[id]["quantity"]);
    setState(() {});
  }

  void decrementItemCount(id) {
    if (widget.originalcart[id]["quantity"] > 0) {
      widget.originalcart[id]["quantity"]--;
      print(widget.originalcart[id]["quantity"]);
      setState(() {});
    }
  }

  Widget item(id) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 5.2,
        decoration: BoxDecoration(
          color: Colors.white30,
          border: Border.all(color: Colors.black38),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.height / 5.2,
                  child: Image.network(
                    "${widget.originalcart[id]["image"]}",
                    fit: BoxFit.fill,
                  ),
                )),
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                // Name
                                "${id}",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black87),
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 7),
                            child: Icon(Icons.close),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          child: Text(
                            // Price
                            "D${widget.originalcart[id]["price"]}",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            decrementItemCount(id);
                          },
                          child: Container(
                            color: Colors.redAccent,
                            child: Icon(Icons.remove,
                                size: 35, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            // Quantity
                            "${widget.originalcart[id]["quantity"]}",
                            style:
                                TextStyle(fontSize: 25, color: Colors.black87),
                          ),
                        ),
                        Container(
                          color: Colors.greenAccent,
                          child: GestureDetector(
                              onTap: () {
                                incrementItemCount(id);
                              },
                              child: Icon(Icons.add,
                                  size: 35, color: Colors.white)),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      color: Colors.red,
                      width: 100,
                      child: Row(children: []),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
