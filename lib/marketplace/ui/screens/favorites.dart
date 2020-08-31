import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:LocAll/marketplace/repository/firebase_database.dart';
import 'package:LocAll/marketplace/ui/widgets/card_marketplace.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List _brands = [];
  List _brandsKeys = [];
  bool isNotEmpty = false;
  @override
  void initState() {
    initFetch() async {
      var _b = await Brands().getBrands();
      var _favorites = await Brands().getFavorites();
      var _tempFav = [];
      if (_favorites.value != null) {
        _favorites.value.forEach((e, i) {
          _tempFav.add(i);
        });
        var tempBrandsArray = [];
        var tempBrandskeyArray = [];
        _b.value.forEach((e, i) {
          if (_tempFav.contains(e)) {
            tempBrandsArray.add(i);
            tempBrandskeyArray.add(e);
          }
        });

        this.setState(() {
          _brands = tempBrandsArray;
          _brandsKeys = tempBrandskeyArray;
          isNotEmpty = true;
        });
      }
    }

    initFetch();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isNotEmpty
        ? SafeArea(
            child: Container(
                color: Color(0xFFf0f0f0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
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
                                childAspectRatio: 2 / 2.3,
                              ),
                              itemCount: _brands.length,
                              itemBuilder: (context, index) => CardMarketplace(
                                id: _brandsKeys[index],
                                photos: _brands[index]['photos'],
                                name: _brands[index]['name'],
                                desc: _brands[index]['desc'],
                                instagram: _brands[index]['instagram'],
                                address: _brands[index]['address'],
                                phone: _brands[index]['phone'],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          )
        : SafeArea(
            child: Center(
              child: Text("Aun no has agragado ninguna marca a favoritos."),
            ),
          );
  }
}
