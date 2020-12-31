import 'package:dexv2/address.dart';
// import 'package:dexv2/notifications.dart';
import 'package:dexv2/orders.dart';
// import 'package:dexv2/pages/addSmartAddress.dart';
// import 'package:dexv2/pages/category.dart';
// import 'package:dexv2/pages/checkout.dart';
// import 'package:dexv2/pages/detailedShopView.dart';
import 'package:dexv2/pages/marketView.dart';
import 'package:dexv2/pages/message.dart';
// import 'package:dexv2/pages/message.dart';
// import 'package:dexv2/pages/myaddress.dart';
// import 'package:dexv2/pages/normalAddress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Base extends StatefulWidget {
  final bool order_placed;
  Base({Key key, this.order_placed = false}) : super(key: key);
  @override
  _Base createState() => _Base();
}

class _Base extends State<Base> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  // TabController controller = new TabController(length: 3, vsync: this);
  // TickerProvider  dd ;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: size.height * 0.12,
              automaticallyImplyLeading: true,
              flexibleSpace: TabBar(
                tabs: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Tab(
                        icon: SvgPicture.asset(
                          "assets/icons/food-delivery.svg",
                          width: size.width * 0.05,
                          height: size.height * 0.05,
                          color: Colors.white,
                        ),
                        text: "Delivery"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Tab(
                      icon: SvgPicture.asset(
                        "assets/icons/burger.svg",
                        width: size.width * 0.05,
                        height: size.height * 0.05,
                        color: Colors.white,
                      ),
                      text: "DEx Eats",
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 20.0),
                  //   child: Tab(
                  //     icon: SvgPicture.asset(
                  //       "assets/icons/location.svg",
                  //       width: size.width * 0.05,
                  //       height: size.height * 0.05,
                  //       color: Colors.white,
                  //     ),
                  //     text: "Addresses",
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 20.0),
                  //   child: Tab(
                  //     icon: SvgPicture.asset(
                  //       "assets/icons/messaging.svg",
                  //       width: size.width * 0.05,
                  //       height: size.height * 0.05,
                  //       color: Colors.white,
                  //     ),
                  //     text: "messaging",
                  //   ),
                  // ),
                ],
              ),
            ),
            body: TabBarView(
              // controller : controller,
              physics: ClampingScrollPhysics(),
              children: [
                Orders(order_placed: widget.order_placed),
                MarketView(),
                // Address(),
                // Address(),
                // Message()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
