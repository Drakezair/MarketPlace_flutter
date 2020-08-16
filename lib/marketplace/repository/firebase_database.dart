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

class CategoriesRepo {
  getCategories() async {
    return await FirebaseDatabase.instance
        .reference()
        .child('categories')
        .once()
        .then((DataSnapshot value) {
      return value;
    });
  }
}
