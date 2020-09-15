import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:LocAll/marketplace/repository/firebase_database.dart';
import 'package:LocAll/my_flutter_app_icons.dart';
import 'package:LocAll/marketplace/repository/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetail extends StatefulWidget {
  final String id, name, desc, instagram, address, phone, was;
  final bool onDiscount;
  final List<dynamic> photos;
  ProductDetail(
      {this.id,
      this.name,
      this.desc,
      this.photos,
      this.instagram,
      this.address,
      this.phone,
      this.onDiscount,
      this.was});
  @override
  _ProductDetailState createState() => _ProductDetailState(
      id: id,
      name: name,
      desc: desc,
      photos: photos,
      instagram: instagram,
      address: address,
      phone: phone,
      onDiscount: onDiscount,
      was: was);
}

class _ProductDetailState extends State<ProductDetail> {
  final String id, name, desc, instagram, address, phone, was;
  final bool onDiscount;
  final List<dynamic> photos;
  bool isFavorite = true;
  bool auth = false;
  String email = '';
  String comment;
  List<dynamic> comments = [];

  _ProductDetailState({
    this.id,
    this.name,
    this.desc,
    this.photos,
    this.instagram,
    this.address,
    this.phone,
    this.onDiscount,
    this.was,
  });

  @override
  void initState() {
    initFetch() async {
      await FirebaseAuth.instance.currentUser().then((value) {
        if (value != null) {
          this.setState(() {
            email = value.email;
            auth = true;
          });
        } else {
          auth = false;
        }
      });
      if (auth == true) {
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
    }

    listenerActive() async {
      var _c = [];
      FirebaseDatabase.instance
          .reference()
          .child('brands')
          .child(id)
          .child("comments")
          .onChildAdded
          .listen((event) {
        _c.add(Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.snapshot.value["email"],
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(event.snapshot.value["text"]),
            ],
          ),
        ));
        this.setState(() {
          comments = _c;
        });
      });
    }

    initFetch();
    listenerActive();

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
              padding: EdgeInsets.all(10.0),
              child: this.onDiscount == true ? Text(this.email) : null,
            ),
            Container(
              color: Colors.black12,
              child: ExpansionTile(
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
                        InkWell(
                          onTap: () => launch(
                              "https://www.instagram.com/" + this.instagram),
                          child: Text(
                            this.instagram,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
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
                          address.length >= 20
                              ? address.substring(0, 20) + "..."
                              : address,
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
                        InkWell(
                          onTap: () => launch("tel:" + this.phone.toString()),
                          child: Text(
                            this.phone.toString(),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
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
                            MyFlutterApp.whatsapp,
                          ),
                        ),
                        InkWell(
                          onTap: () => launch(
                              "https://api.whatsapp.com/send?phone=57" +
                                  this.phone.toString()),
                          child: Text(
                            this.was.toString(),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              child: ExpansionTile(
                title: Text(
                  "Comentarios",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                children: [
                  Column(
                    children: [
                      auth
                          ? RaisedButton(
                              color: Colors.blue,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                    height: 150.0,
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          decoration: InputDecoration(
                                            hintText: "Comentario",
                                          ),
                                          onChanged: (value) =>
                                              this.setState(() {
                                            comment = value;
                                          }),
                                        ),
                                        Spacer(),
                                        RaisedButton(
                                          onPressed: () {
                                            Brands().addComment(comment, id);
                                            Navigator.of(context).pop();
                                          },
                                          color: Colors.blue,
                                          child: Text(
                                            "Enviar",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Añadir comentario",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Container(),
                      ...comments,
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: auth
          ? isFavorite
              ? FloatingActionButton(
                  onPressed: () => handleAddFavorite(),
                  child: Icon(Icons.favorite),
                )
              : FloatingActionButton(
                  onPressed: () => handleRemoveFavorite(),
                  child: Icon(Icons.close),
                )
          : null,
    );
  }
}
