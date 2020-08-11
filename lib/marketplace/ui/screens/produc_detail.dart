import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final String id;
  ProductDetail({this.id});
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
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.amber),
                        child: i == 1
                            ? Hero(
                                tag: 'taghero$id',
                                child: Image(
                                  height: 180,
                                  image: NetworkImage(
                                      "https://placeimg.com/500/500/any"),
                                ),
                              )
                            : Text("gokokaf $i "));
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
                      "Nombre de la marca",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
