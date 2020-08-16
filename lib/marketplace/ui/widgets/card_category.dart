import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  final String id, name, photo;
  CardCategory({
    this.id,
    this.photo,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => null,
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
                image: NetworkImage(photo),
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