import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:LocAll/marketplace/repository/firebase_database.dart';
import 'package:LocAll/marketplace/ui/widgets/card_marketplace.dart';

class Category extends StatefulWidget {
  String id, name;
  Category({this.id, this.name});
  @override
  _CategoryState createState() => _CategoryState(id: id, name: name);
}

class _CategoryState extends State<Category> {
  List _brands = [];
  List _brandsKeys = [];
  String name, id;
  List _regions = [];
  String region, email, uuid;

  _CategoryState({this.id, this.name});

  @override
  void initState() {
    initFetch() async {
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
              else
                {
                  this.setState(() {
                    email = "Invitado";
                  })
                }
            });
      var _b = await Brands().getBrands();
      var tempBrandsArray = [];
      var _r = await Regions().getRegions();
      var _temregions = [];
      _temregions.add({"name": "Todas las regiones", "code": ""});
      _r.value.forEach((e, i) {
        _temregions.add(i);
      });
      _b.value.forEach((e, i) {
        if (i["category"] == id) {
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
        if (!i['onDiscount'] && i["category"] == id) {
          tempBrandsArray.add({...i, 'id': e});
        }
      });
      this.setState(() {
        _brands = tempBrandsArray..shuffle();
        region = value;
      });
    } else {
      _b.value.forEach((e, i) {
        if (i['region'] == value && i["category"] == id) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SafeArea(
        child: Container(
            color: Color(0xFFf0f0f0),
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
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
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
      ),
    );
  }
}
