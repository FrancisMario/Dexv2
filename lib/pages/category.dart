import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Category extends StatefulWidget {
  Category({Key key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
    List<Widget> list = [];
    Future _future = null;

    @override
  void initState() {
    super.initState();
    _future = future();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: _future, // a previously-obtained Future<String> or null
        builder: (BuildContext context,snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            var ss = snapshot.data as List<QueryDocumentSnapshot>;
            if (ss.length == 0) {
              //if no addresses were found
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text(
                      "No Contact Addresses yet. Use the button below to add new addresses"),
                ),
              );
            }
            return Text("Success");
            // print(ss.data());
            //  return Text("Jasasa + ${snapshot.data[0]}");
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } 
          return Center(
            // child: body(list),
            child: body([
              Text("m"),
            ]),
          
          );
        },
      );

  }
  

  Future future() {
    FirebaseFirestore.instance.collection("products").get().then((value) => {
       value.docs.forEach((element) {
               setState(() {
               list.add(box(element));
               });
               print(element.get("name")); 
               print(element.id);
               print(list.length.toString());
            })
     });

  }
  Widget body(dataa) {
     return  Scaffold(
      body: CustomScrollView(
        // physics: BouncingScrollPhysics(),
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
        SliverList(delegate:  SliverChildListDelegate(dataa))
        ],
      ),
    );
  }



  Widget box(data) {
      return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                           return Text("");
                           }));
                   },
                
                  child: Container(
                    width: 200 ,
                    height: 100 ,
                    color:Colors.blueGrey,
                    child: Row(
                      children: [
                        Expanded(flex:1,child: Container(child:Text(""),)),
                        
                        Expanded(flex:2,
                        child: Column(
                          children:[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(data.get("name")),),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("data sdf sd fsd pf dfuh u u  hafu9sd 9syf a9asdf9 shdf9h"),),
                          ],
                         )
                        ),
                      ],
                    ),
                  )
                
                );
}
}