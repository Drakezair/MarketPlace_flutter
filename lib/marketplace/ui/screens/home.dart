import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/marketplace/ui/widgets/card_marketplace.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: AppBar(), preferredSize: Size.fromHeight(0)),
      body: SafeArea(
        child: Container(
            color: Color(0xFFf0f0f0),
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.black38,
                  padding: EdgeInsets.only(
                      right: 20.0, left: 20.0, top: 20.0, bottom: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Busca una marca",
                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 150.0,
                            viewportFraction: 1.0,
                          ),
                          items: [1, 2, 3, 4, 5].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration:
                                        BoxDecoration(color: Colors.amber),
                                    child: Text(
                                      'text $i',
                                      style: TextStyle(fontSize: 16.0),
                                    ));
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 7.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio:
                                MediaQuery.of(context).size.height / 780,
                          ),
                          itemCount: 10,
                          itemBuilder: (context, index) => CardMarketplace(
                            id: index.toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.access_alarm)),
        ],
      ),
    );
  }
}
