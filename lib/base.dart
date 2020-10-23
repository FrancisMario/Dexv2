import 'package:dexv2/address.dart';
import 'package:dexv2/notifications.dart';
import 'package:dexv2/orders.dart';
import 'package:dexv2/pages/addSmartAddress.dart';
import 'package:dexv2/pages/category.dart';
import 'package:dexv2/pages/checkout.dart';
import 'package:dexv2/pages/detailedShopView.dart';
import 'package:dexv2/pages/marketView.dart';
import 'package:dexv2/pages/message.dart';
import 'package:dexv2/pages/myaddress.dart';
import 'package:dexv2/pages/normalAddress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Base extends StatefulWidget {
  final bool order_placed;
  Base({Key key, this.order_placed = null}) : super(key: key);
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
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: size.height * 0.10,
            // automaticallyImplyLeading: true,
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Tab(
                    icon: SvgPicture.asset(
                      "assets/icons/location.svg",
                      width: size.width * 0.05,
                      height: size.height * 0.05,
                      color: Colors.white,
                    ),
                    text: "Addresses",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Tab(
                    icon: SvgPicture.asset(
                      "assets/icons/messaging.svg",
                      width: size.width * 0.05,
                      height: size.height * 0.05,
                      color: Colors.white,
                    ),
                    text: "messaging",
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            // controller : controller,
            physics: ClampingScrollPhysics(),
            children: [
              Orders(order_placed:widget.order_placed),
              // MarketView(),
              // Category(),
              MarketView(),
              // Address(),
              Address(),
              Message()
              // Notifications(),
              // MyAddress(
              //   resturantStats: {
              //     "pickup": 200,
              //     "resturant": "9PjTe3g0DA9LkntzjoaH",
              //   },
              //   originalcart: {
              //     "Pizza": {
              //       "price": 250,
              //       "image":
              //           "https://www.hungryhowies.com/sites/default/files/styles/menu_item_280x175/public/images/menu-items/thumbnails/buildyourownpizza_0.png?itok=fgzFck86",
              //       "quantity": 1
              //     },
              //     "Burger": {
              //       "price": 300,
              //       "image":
              //           "https://media-cdn.tripadvisor.com/media/photo-s/0e/4c/78/29/beef-burget.jpg",
              //       "quantity": 1
              //     },
              //     "Cake": {
              //       "price": 500,
              //       "image":
              //           "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/carrot-cake-8d8dfb5.jpg?quality=90&resize=960,872",
              //       "quantity": 1
              //     },
              //     "Chicken": {
              //       "price": 300,
              //       "image":
              //           "https://hips.hearstapps.com/hmg-prod/images/delish-190808-baked-drumsticks-0217-landscape-pf-1567089281.jpg",
              //       "quantity": 1
              //     },
              //     "Chicken é": {
              //       "price": 500,
              //       "image":
              //           "https://hips.hearstapps.com/hmg-prod/images/delish-190808-baked-drumsticks-0217-landscape-pf-1567089281.jpg",
              //       "quantity": 1
              //     },
              //   },
              // ),
              // MarketView(),
              // DetailedEntityView(ent_des: "hahaha ", ent_id: "9PjTe3g0DA9LkntzjoaH",ent_img: "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",ent_name: "Resturant",)
              // SmartAddress(),
              // NormalAddress(),
            ],
          ),
        ),
      ),
    );
  }
}
