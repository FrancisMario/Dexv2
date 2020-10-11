import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class OrdersCard extends StatefulWidget {
  OrdersCard({Key key}) : super(key: key);

  @override
  _OrdersCardState createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: MediaQuery.of(context).size.width / 2.5,
        decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(3)
        ),
        child: Column(
          children: <Widget>[
            Text("Custom Order"),
            Divider(),
            Text(
              "Make oder for custom deliveries",
              overflow: TextOverflow.clip,
            )
          ],
        ),
      ),
    );
  }
}
