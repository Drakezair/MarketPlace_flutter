import 'package:flutter/material.dart';
import 'package:marketplace/marketplace/ui/screens/produc_detail.dart';

class CardMarketplace extends StatelessWidget {
  final String id, name, desc, instagram, address, phone;
  bool onDiscount;

  final List<dynamic> photos;
  CardMarketplace({
    this.id,
    this.photos,
    this.name,
    this.desc,
    this.instagram,
    this.address,
    this.phone,
    this.onDiscount,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetail(
            id: id,
            name: name,
            desc: desc,
            photos: photos,
            instagram: instagram,
            address: address,
            phone: phone,
            onDiscount: onDiscount,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: "taghero$id",
              child: Image(
                height: MediaQuery.of(context).size.width / 2.03,
                image: NetworkImage(photos[0]),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
