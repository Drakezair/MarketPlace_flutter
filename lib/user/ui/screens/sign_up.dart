import 'package:LocAll/marketplace/repository/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:LocAll/user/repository/firebase_auth_service.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email, password, name, phone, address;
  List _regions = [];
  String region;
  handleSubmit() async {
    if (await Auth().signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        phone: phone,
        region: region)) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      // TODO
    }
  }

  @override
  void initState() {
    // TODO: implement initState
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
    super.initState();
  }

  handleRegion(String value) async {
    this.setState(() {
      region = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black12,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(
                        MediaQuery.of(context).size.width / 2, 100.0),
                    bottomRight: Radius.elliptical(
                        MediaQuery.of(context).size.width / 2, 100.0),
                  ),
                  // gradient: LinearGradient(
                  //   begin: Alignment.bottomCenter,
                  //   colors: [
                  //     Color(0xFF0f4c75),
                  //     Color(0xFF3282b8),
                  //   ],
                  // ),
                  color: Colors.black),
            ),
            Container(
              margin: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/Logo_Locall.png',
                    height: 100.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    padding: EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Registrate',
                            style: TextStyle(fontSize: 30.0),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Nombre Completo",
                              suffixIcon: Icon(Icons.account_circle),
                            ),
                            onChanged: (newValue) => this.setState(() {
                              name = newValue.toString();
                            }),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Teléfono",
                              suffixIcon: Icon(Icons.phone),
                            ),
                            onChanged: (newValue) => this.setState(() {
                              phone = newValue.toString();
                            }),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Correo electrónico",
                              suffixIcon: Icon(Icons.email),
                            ),
                            onChanged: (newValue) => this.setState(() {
                              email = newValue.toString();
                            }),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Contraseña",
                              suffixIcon: Icon(Icons.vpn_key),
                            ),
                            onChanged: (newValue) => this.setState(() {
                              password = newValue.toString();
                            }),
                          ),
                          SizedBox(
                            height: 30.0,
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
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            buttonColor: Color(0xFF3282b8),
                            child: RaisedButton(
                              onPressed: () => handleSubmit(),
                              child: Text(
                                "Acceder",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "¿Ya tienes una cuenta?",
                        style: TextStyle(
                          color: Color(0xFF3282b8),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
