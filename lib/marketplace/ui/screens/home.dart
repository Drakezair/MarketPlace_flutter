import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/marketplace/repository/firebase_database.dart';
import 'package:marketplace/marketplace/ui/widgets/card_marketplace.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _brands = [];
  List _brandsKeys = [];
  @override
  void initState() {
    initFetch() async {
      var _b = await Brands().getBrands();
      var tempBrandsArray = [];
      var tempBrandskeyArray = [];
      _b.value.forEach((e, i) {
        tempBrandsArray.add(i);
        tempBrandskeyArray.add(e);
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
    return Scaffold(
      appBar: PreferredSize(child: AppBar(), preferredSize: Size.fromHeight(0)),
      body: SafeArea(
        child: Container(
            color: Color(0xFFf0f0f0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black54),
                    ),
                  ),
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
                            childAspectRatio: 2 / 2.3,
                          ),
                          itemCount: _brands.length,
                          itemBuilder: (context, index) => CardMarketplace(
                            id: _brandsKeys[index],
                            photos: _brands[index]['photos'],
                            name: _brands[index]['name'],
                            desc: _brands[index]['desc'],
                            instagram: _brands[index]['instagram'],
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
        onTap: (value) => print(value),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.access_alarm)),
        ],
      ),
    );
  }
}
