import 'package:LocAll/marketplace/ui/widgets/card_discount.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  List _regions = [];
  String region, email, uuid;
  @override
  void initState() {
    FirebaseAuth.instance
      ..currentUser().then((value) => {
            if (value != null)
              {
                this.setState(() {
                  email = value.email;
                  uuid = value.uid;
                }),
                FirebaseDatabase.instance
                    .reference()
                    .child("users")
                    .child(value.uid)
                    .once()
                    .then((DataSnapshot val) => {
                          print(val.value['name']),
                          handleRegion(val.value["region"]),
                          this.setState(() {
                            region = val.value["region"];
                          })
                        })
              }
          });
    initFetch() async {
      var _b = await Brands().getBrands();
      var tempBrandsArray = [];
      var _r = await Regions().getRegions();
      var _temregions = [];
      _temregions.add({"name": "Todas las regiones", "code": ""});
      _r.value.forEach((e, i) {
        _temregions.add(i);
      });
      _b.value.forEach((e, i) {
        if (i['onDiscount']) {
          tempBrandsArray.add({...i, 'id': e});
        }
      });
      this.setState(() {
        _brands = tempBrandsArray..shuffle();
        _regions = _temregions;
      });
    }

    initFetch();

    super.initState();
  }

  handleRegion(String value) async {
    var _b = await Brands().getBrands();
    var tempBrandsArray = [];

    print(value);

    if (value == "") {
      _b.value.forEach((e, i) {
        if (!i['onDiscount']) {
          tempBrandsArray.add({...i, 'id': e});
        }
      });
      this.setState(() {
        _brands = tempBrandsArray..shuffle();
        region = value;
      });
    } else {
      _b.value.forEach((e, i) {
        if (i['region'] == value) {
          tempBrandsArray.add({...i, 'id': e});
        }
      });
      this.setState(() {
        _brands = tempBrandsArray..shuffle();
        region = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: Color(0xFFf0f0f0),
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                  ),
                  child: DropdownButton(
                    dropdownColor: Colors.black,
                    hint: Text(
                      "Región",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                    elevation: 16,
                    value: region,
                    onChanged: (String value) => handleRegion(value),
                    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                    items: _regions
                        .map(
                          (e) => new DropdownMenuItem(
                            child: Text(e['name'].toString()),
                            value: e["code"].toString(),
                          ),
                        )
                        .toList(),
                  )),
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
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Descuentos",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),

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
                          crossAxisCount: 1,
                          mainAxisSpacing: 7.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 2 / 0.8,
                        ),
                        itemCount: _brands.length,
                        itemBuilder: (context, index) => CardDiscount(
                          id: _brands[index]['id'],
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
