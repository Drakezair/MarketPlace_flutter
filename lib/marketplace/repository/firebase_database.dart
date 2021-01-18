import 'package:firebase_auth/firebase_auth.dart';
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

  addToFavorite(userId, brandId) async {
    await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(userId)
        .child("favorite_brands")
        .push()
        .set(brandId);
  }

  removeToFavorite(brandId) async {
    var _currentUser = await FirebaseAuth.instance.currentUser();
    await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(_currentUser.uid)
        .child("favorite_brands")
        .once()
        .then((value) {
      value.value.forEach((i, e) {
        if (e == brandId) {
          FirebaseDatabase.instance
              .reference()
              .child('users')
              .child(_currentUser.uid)
              .child("favorite_brands")
              .child(i)
              .remove();
        }
      });
    });
  }

  addComment(text, brandId) async {
    var _currentUser = await FirebaseAuth.instance.currentUser();
    FirebaseDatabase.instance
        .reference()
        .child('brands')
        .child(brandId)
        .child("comments")
        .push()
        .set({"email": _currentUser.email, "text": text});
  }

  getFavorites() async {
    var _currentUser = await FirebaseAuth.instance.currentUser();
    return await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(_currentUser.uid)
        .child('favorite_brands')
        .once()
        .then((value) => value);
  }
}

class Wallpapers {
  getWallpapers() async {
    return await FirebaseDatabase.instance
        .reference()
        .child('wallpapers')
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

class Regions {
  getRegions() async {
    return await FirebaseDatabase.instance
        .reference()
        .child('regiones')
        .once()
        .then((DataSnapshot value) {
      return value;
    });
  }
}
