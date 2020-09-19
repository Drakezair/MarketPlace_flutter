import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:LocAll/marketplace/repository/firebase_database.dart';
import 'package:LocAll/marketplace/ui/widgets/card_marketplace.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _brands = [];
  List _wallpapers = [];
  @override
  void initState() {
    super.initState();

    initFetch() async {
      var _b = await Brands().getBrands();
      var _w = await Wallpapers().getWallpapers();
      var tempBrandsArray = [];
      var tempWallpapers = [];
      _w.value.forEach((e, i) {
        tempWallpapers.add(i["photo"]);
      });
      _b.value.forEach((e, i) {
        if (!i['onDiscount']) {
          tempBrandsArray.add({...i, 'id': e});
        }
      });
      this.setState(() {
        _brands = tempBrandsArray..shuffle();
        _wallpapers = tempWallpapers;
      });
    }

    initFetch();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: Color(0xFFf0f0f0),
          child: Column(
            children: <Widget>[
              // Container(
              //   padding: EdgeInsets.all(10.0),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     border: Border(
              //       bottom: BorderSide(width: 1.0, color: Colors.black54),
              //     ),
              //   ),
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       prefixIcon: Icon(Icons.search),
              //       hintText: "Busca una marca",
              //       contentPadding: EdgeInsets.only(top: 0, bottom: 0),
              //       fillColor: Colors.white,
              //       filled: true,
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(10.0),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 139.0,
                          viewportFraction: 1.0,
                          autoPlay: true,
                        ),
                        items: _wallpapers.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(color: Colors.black),
                                child: Image.network(i),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 7.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 2 / 2.3,
                        ),
                        itemCount: _brands.length,
                        itemBuilder: (context, index) => CardMarketplace(
                          id: _brands[index]["id"],
                          photos: _brands[index]['photos'],
                          name: _brands[index]['name'],
                          desc: _brands[index]['desc'],
                          instagram: _brands[index]['instagram'],
                          address: _brands[index]['address'],
                          phone: _brands[index]['phone'],
                          onDiscount: _brands[index]['onDiscount'],
                          was: _brands[index]['was'],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
