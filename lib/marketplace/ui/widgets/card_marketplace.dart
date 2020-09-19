import 'package:flutter/material.dart';
import 'package:LocAll/marketplace/ui/screens/produc_detail.dart';

class CardMarketplace extends StatelessWidget {
  final String id, name, desc, instagram, address, phone, was;
  bool onDiscount;

  final List<dynamic> photos;
  CardMarketplace(
      {this.id,
      this.photos,
      this.name,
      this.desc,
      this.instagram,
      this.address,
      this.phone,
      this.onDiscount,
      this.was});

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
            was: was,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: "taghero$id",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  height: MediaQuery.of(context).size.width / 2.5,
                  image: NetworkImage(photos[0]),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0, top: 8.0),
              child: Text(
                name.length > 11 ? name.substring(0, 11) + '...' : name,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
