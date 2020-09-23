import 'package:flutter/material.dart';
import 'package:LocAll/marketplace/ui/screens/category.dart';

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
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Category(
            id: id,
            name: name,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Hero(
                tag: "taghero$id",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    height: MediaQuery.of(context).size.width / 2.5,
                    image: NetworkImage(photo),
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                name,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
