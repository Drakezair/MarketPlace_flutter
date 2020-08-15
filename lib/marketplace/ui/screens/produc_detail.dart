import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final String id, name, desc, instagram;
  final List<dynamic> photos;
  ProductDetail({this.id, this.name, this.desc, this.photos, this.instagram});

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
                title: Text("Contacto"),
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          this.instagram,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Icon(Icons.accessible_outlined)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
