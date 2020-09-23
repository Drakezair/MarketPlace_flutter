import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:LocAll/marketplace/repository/firebase_database.dart';
import 'package:LocAll/marketplace/ui/widgets/card_category.dart';
import 'package:LocAll/marketplace/ui/widgets/card_marketplace.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List _categories = [];
  List _categoriesKeys = [];
  @override
  void initState() {
    super.initState();

    initFetch() async {
      var _b = await CategoriesRepo().getCategories();
      var tempcategoriesArray = [];
      var tempcategorieskeyArray = [];
      _b.value.forEach((e, i) {
        tempcategoriesArray.add(i);
        tempcategorieskeyArray.add(e);
      });
      this.setState(() {
        _categories = tempcategoriesArray;
        _categoriesKeys = tempcategorieskeyArray;
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
                      padding: EdgeInsets.all(10.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 7.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 2 / 2.3,
                        ),
                        itemCount: _categories.length,
                        itemBuilder: (context, index) => CardCategory(
                          id: _categoriesKeys[index],
                          name: _categories[index]['name'],
                          photo: _categories[index]["photo"],
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
