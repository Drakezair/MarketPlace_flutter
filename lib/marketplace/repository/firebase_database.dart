import 'package:firebase_database/firebase_database.dart';

class Brands {
  getBrands() async {
    return await FirebaseDatabase.instance
        .reference()
        .child('brands')
        .once()
        .then((DataSnapshot value) {
      return value;
    });
  }
}
