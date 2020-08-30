import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/marketplace/ui/screens/categories.dart';
import 'package:marketplace/marketplace/ui/screens/discounts.dart';
import 'package:marketplace/marketplace/ui/screens/favorites.dart';
import 'package:marketplace/marketplace/ui/screens/home.dart';
import 'package:marketplace/my_flutter_app_icons.dart';
import 'package:marketplace/user/ui/screens/profile.dart';

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int index = 0;

  List<Widget> route = [
    Home(),
    Discount(),
    Categories(),
    Favorites(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: AppBar(), preferredSize: Size.fromHeight(0)),
      body: route[index],
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: index,
        onTap: (value) {
          this.setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.percentage),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
