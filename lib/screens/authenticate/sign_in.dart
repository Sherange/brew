import "package:flutter/material.dart";
import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Sign in to Brew"),
              actions: [
                IconButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.app_registration_rounded),
                ),
              ],
            ),
            backgroundColor: Colors.brown[100],
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textDecoration.copyWith(hintText: "Email"),
                      validator: (val) =>
                          val!.isEmpty ? "Enter an email" : null,
                      onChanged: (val) => {setState(() => email = val)},
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textDecoration.copyWith(hintText: "Password"),
                      obscureText: true,
                      validator: (val) =>
                          val!.isEmpty ? "Enter password" : null,
                      onChanged: (val) => {setState(() => password = val)},
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.brown[400])),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic user = await _auth
                                .signInWithEmailAndPassword(email, password);

                            if (user == null) {
                              setState(() {
                                loading = false;
                                error = "SignIn failed";
                              });
                            }
                          }
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(height: 20.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
