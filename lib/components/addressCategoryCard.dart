import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class OrdersCard extends StatefulWidget {
  final String title;
  final String description;
  OrdersCard({Key key, this.title, this.description}) : super(key: key);

  @override
  _OrdersCardState createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 10,
        width: MediaQuery.of(context).size.width / 1.3,
        decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(3)
        ),
        child: Column(
          children: <Widget>[
            Text(widget.title),
            Divider(),
            Text(
              widget.description,
              overflow: TextOverflow.clip,
            )
          ],
        ),  
      ),
    );
  }
}
