import 'dart:ui';

import 'package:LocAll/marketplace/repository/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:LocAll/user/repository/firebase_auth_service.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email = "";
  String name = "";
  String phone = "";
  String uuid = "";
  String region = "";
  List _regions = [];

  handleRegion(String value) async {
    this.setState(() {
      region = value;
    });
  }

  @override
  void initState() {
    super.initState();

    initFetch() async {
      var _r = await Regions().getRegions();
      var _temregions = [];
      _temregions.add({"name": "Todas las regiones", "code": ""});
      _r.value.forEach((e, i) {
        _temregions.add(i);
      });
      this.setState(() {
        _regions = _temregions;
      });
    }

    initFetch();

    FirebaseAuth.instance
      ..currentUser().then((value) => {
            if (value != null)
              {
                this.setState(() {
                  email = value.email;
                  uuid = value.uid;
                }),
                FirebaseDatabase.instance
                    .reference()
                    .child("users")
                    .child(value.uid)
                    .once()
                    .then((DataSnapshot val) => {
                          print(val.value['name']),
                          this.setState(() {
                            name = val.value['name'];
                            phone = val.value["phone"];
                            region = val.value["region"];
                          })
                        })
              }
            else
              {
                this.setState(() {
                  email = "Invitado";
                })
              }
          });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 80.0,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(20.0),
                child:
                    Text(email, style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                textAlign: TextAlign.center,
                onChanged: (newValue) => this.setState(() {
                  name = newValue.toString();
                }),
                decoration: InputDecoration(
                  hintText: name,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                textAlign: TextAlign.center,
                onChanged: (newValue) => this.setState(() {
                  phone = newValue.toString();
                }),
                decoration: InputDecoration(
                  hintText: phone,
                ),
              ),
            ),
            DropdownButton(
              hint: Text(
                "Región",
              ),
              style: TextStyle(
                color: Colors.black,
              ),
              elevation: 16,
              value: region,
              onChanged: (String value) => handleRegion(value),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              items: _regions
                  .map(
                    (e) => new DropdownMenuItem(
                      child: Text(e['name'].toString()),
                      value: e["code"].toString(),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(
              height: 40.0,
            ),
            RaisedButton(
              onPressed: () async => {
                if (await Auth().updateProfile(
                    uuid: uuid, name: name, phone: phone, region: region))
                  {Navigator.pushNamed(context, '/home')}
              },
              child: Text("Guardar"),
            ),
            RaisedButton(
              onPressed: () => Auth().signOut(context),
              child: Text("Cerrar sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
