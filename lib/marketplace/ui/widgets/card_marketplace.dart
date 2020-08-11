import 'package:flutter/material.dart';
import 'package:marketplace/marketplace/ui/screens/produc_detail.dart';

class CardMarketplace extends StatelessWidget {
  final String id;
  CardMarketplace({this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetail(
            id: id,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: "taghero$id",
              child: Image(
                height: MediaQuery.of(context).size.width / 2,
                image: NetworkImage("https://placeimg.com/500/500/any"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
