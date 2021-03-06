import 'package:flutter/material.dart';
import 'package:LocAll/user/repository/firebase_auth_service.dart';

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  String email, password;
  handleSubmit() async {
    if (await Auth().recoverPassword(email: email)) {
      _showMyDialog();
    } else {
      // TODO
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Revisa tu correo'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/auth/sign_in");
              },
            ),
          ],
        );
      },
    );
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
                  //   end: Alignment.topCenter,
                  //   colors: [
                  //     Color(0xFF00bcd4),
                  //     Color(0xFFb2ebf2),
                  //   ],
                  // ),
                  color: Colors.black),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 50.0, left: 30.0, right: 30.0, bottom: 30.0),
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
                            'Recuperar contraseña',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.0,
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
                            height: 10.0,
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
                      onTap: () =>
                          Navigator.pushNamed(context, '/auth/sign_in'),
                      child: Text(
                        "Iniciar sesion",
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
