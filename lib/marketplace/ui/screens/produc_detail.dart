import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/marketplace/repository/firebase_database.dart';
import 'package:marketplace/my_flutter_app_icons.dart';

class ProductDetail extends StatefulWidget {
  final String id, name, desc, instagram, address;
  final int phone;
  final List<dynamic> photos;
  ProductDetail(
      {this.id,
      this.name,
      this.desc,
      this.photos,
      this.instagram,
      this.address,
      this.phone});
  @override
  _ProductDetailState createState() => _ProductDetailState(
      id: id,
      name: name,
      desc: desc,
      photos: photos,
      instagram: instagram,
      address: address,
      phone: phone);
}

class _ProductDetailState extends State<ProductDetail> {
  final String id, name, desc, instagram, address;
  final int phone;
  final List<dynamic> photos;
  bool isFavorite = true;
  _ProductDetailState({
    this.id,
    this.name,
    this.desc,
    this.photos,
    this.instagram,
    this.address,
    this.phone,
  });

  @override
  void initState() {
    initFetch() async {
      var _favorites = await Brands().getFavorites();
      if (_favorites.value != null) {
        _favorites.value.forEach((i, e) {
          if (e == id) {
            this.setState(() {
              isFavorite = false;
            });
          }
        });
      }
    }

    initFetch();

    super.initState();
  }

  handleAddFavorite() {
    FirebaseAuth.instance.currentUser().then((value) {
      Brands().addToFavorite(value.uid, id);
      this.setState(() {
        isFavorite = !isFavorite;
      });
    });
  }

  handleRemoveFavorite() {
    Brands().removeToFavorite(id);
    this.setState(() {
      isFavorite = !isFavorite;
    });
    Navigator.popAndPushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detalles"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.width,
                viewportFraction: 1.0,
              ),
              items: photos.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Hero(
                          tag: 'taghero$id',
                          child: Image.network(i),
                        ));
                  },
                );
              }).toList(),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(desc.length >= 150 ? desc.substring(0, 150) : desc)
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  "Contacto",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      fontSize: 20.0),
                ),
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(
                            MyFlutterApp.instagram_filled,
                          ),
                        ),
                        Text(
                          this.instagram,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.home_filled,
                          ),
                        ),
                        Text(
                          this.address,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.phone,
                          ),
                        ),
                        Text(
                          this.phone.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isFavorite
          ? FloatingActionButton(
              onPressed: () => handleAddFavorite(),
              child: Icon(Icons.favorite),
            )
          : FloatingActionButton(
              onPressed: () => handleRemoveFavorite(),
              child: Icon(Icons.close),
            ),
    );
  }
}
