import "package:flutter/material.dart";
import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Register to Brew"),
        actions: [
          IconButton(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.login_rounded),
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
                validator: (val) => val!.isEmpty ? "Enter an email" : null,
                onChanged: (val) => {setState(() => email = val)},
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textDecoration.copyWith(hintText: "Password"),
                obscureText: true,
                validator: (val) =>
                    val!.length < 6 ? "Enter password 6+ chars long" : null,
                onChanged: (val) => {setState(() => password = val)},
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.brown[400])),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic newUser = await _auth
                          .registerWithEmailAndPassword(email, password);

                      if (newUser == null) {
                        setState(() {
                          error = "Registration failed";
                        });
                      }
                      print(newUser);
                    }
                  },
                  child: Text(
                    "Register",
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
