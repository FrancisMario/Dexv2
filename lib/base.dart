import 'package:dexv2/address.dart';
import 'package:dexv2/notifications.dart';
import 'package:dexv2/orders.dart';
import 'package:dexv2/pages/addSmartAddress.dart';
import 'package:dexv2/pages/category.dart';
import 'package:dexv2/pages/marketView.dart';
import 'package:dexv2/pages/myaddress.dart';
import 'package:dexv2/pages/normalAddress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Base extends StatefulWidget {
  Base({Key key}) : super(key: key);
  @override
  _Base createState() => _Base();
}

class _Base extends State<Base> {
   static const TextStyle optionStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    // TabController controller = new TabController(length: 3, vsync: this);
    // TickerProvider  dd ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: true,
            flexibleSpace: TabBar(
              tabs: [
                Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Tab(icon: Icon(Icons.my_location),text: "Orders",),
                ),
                Padding(
                  padding: const  EdgeInsets.only(top:10.0),
                  child: Tab(icon: Icon(Icons.history),text: "Market",),
                ),
                Padding(
                  padding: const  EdgeInsets.only(top:10.0),
                  child: Tab(icon: Icon(Icons.history),text: "Addresses",),
                ),
                Padding(
                  padding: const  EdgeInsets.only(top:10.0),
                  child: Tab(icon: Icon(Icons.history),text: "notifications",),
                ),
              ],
            ),
            ),
  
          body: TabBarView(
            // controller : controller,
            physics: ClampingScrollPhysics(),
            children: [
                Orders(),
                // MarketView(),
                Category(),
                // Address(),
                Address(),
                Notifications(),
                // MyAddress(),
                // MarketView(),
                // SmartAddress(),
                // NormalAddress(),
              ],
          ),
        ),
      ),
    );
  }
}


