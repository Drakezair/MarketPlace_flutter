import 'package:flutter/material.dart';
import 'package:marketplace/user/repository/firebase_auth_service.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email, password, name;

  handleSubmit() async {
    if (await Auth().signUpWithEmailAndPassword(
        email: email, password: password, name: name)) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      // TODO
    }
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
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0f4c75),
                    Color(0xFF3282b8),
                  ],
                ),
              ),
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
