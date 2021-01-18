import 'package:flutter/material.dart';
import 'package:LocAll/marketplace/ui/screens/produc_detail.dart';

class CardDiscount extends StatelessWidget {
  final String id, name, desc, instagram, address, phone, was;
  bool onDiscount;

  final List<dynamic> photos;
  CardDiscount(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: "taghero$id",
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    height: MediaQuery.of(context).size.width / 3,
                    image: NetworkImage(photos[0]),
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(10.0),
                width: 200.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        name.length > 25 ? name.substring(0, 25) + '...' : name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      desc.length > 90 ? desc.substring(0, 90) + '...' : desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
