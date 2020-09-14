import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:LocAll/marketplace/repository/firebase_database.dart';
import 'package:LocAll/marketplace/ui/widgets/card_marketplace.dart';
import 'package:LocAll/my_flutter_app_icons.dart';

class Discount extends StatefulWidget {
  @override
  _DiscountState createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  List _brands = [];
  List _brandsKeys = [];
  @override
  void initState() {
    initFetch() async {
      var _b = await Brands().getBrands();
      var tempBrandsArray = [];
      var tempBrandskeyArray = [];
      _b.value.forEach((e, i) {
        if (i['onDiscount']) {
          tempBrandsArray.add(i);
          tempBrandskeyArray.add(e);
        }
      });
      this.setState(() {
        _brands = tempBrandsArray;
        _brandsKeys = tempBrandskeyArray;
      });
    }

    initFetch();

    super.initState();
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
                      padding: EdgeInsets.only(top: 10.0),
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
                          id: _brandsKeys[index],
                          photos: _brands[index]['photos'],
                          name: _brands[index]['name'],
                          desc: _brands[index]['desc'],
                          instagram: _brands[index]['instagram'],
                          address: _brands[index]['address'],
                          phone: _brands[index]['phone'],
                          onDiscount: _brands[index]['onDiscount'],
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
