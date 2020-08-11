import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        color: Color(0xFFbbe1fa),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50.0, bottom: 20.0),
              child: Image(
                image: NetworkImage("https://placeimg.com/500/200/any"),
              ),
            ),
            Form(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.email,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Correo electronico",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.vpn_key,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Contraseña",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    buttonColor: Color(0xFF0f4c75),
                    child: RaisedButton(
                      onPressed: () => Navigator.pushNamed(context, '/home'),
                      textColor: Colors.white,
                      child: Text("Acceder"),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
