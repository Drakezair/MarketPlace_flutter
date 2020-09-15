import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:LocAll/marketplace/ui/screens/categories.dart';
import 'package:LocAll/marketplace/ui/screens/discounts.dart';
import 'package:LocAll/marketplace/ui/screens/favorites.dart';
import 'package:LocAll/marketplace/ui/screens/home.dart';
import 'package:LocAll/my_flutter_app_icons.dart';
import 'package:LocAll/user/ui/screens/profile.dart';

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int index = 0;
  bool auth = false;

  List<Widget> route = [
    Home(),
    Discount(),
    Categories(),
    Favorites(),
    Profile()
  ];
  List<Widget> buttons = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance
      ..currentUser().then((value) => {
            if (value != null)
              {
                this.setState(() {
                  auth = true;
                  route = [
                    Home(),
                    Discount(),
                    Categories(),
                    Favorites(),
                    Profile()
                  ];
                })
              }
            else
              {
                this.setState(() {
                  auth = false;
                  route = [
                    Home(),
                    Categories(),
                    Profile(),
                  ];
                })
              }
          });
  }

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
          items: auth == true
              ? [
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
                ]
              : [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.grid_view),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                  ),
                ]),
    );
  }
}
