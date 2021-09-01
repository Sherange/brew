import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:brew_crew/models/user_data.dart';
import 'package:brew_crew/services/database_service.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "4"];

  //form values
  String? _currentName;
  String? _currentSugar;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user?.uid).userData,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data as UserData;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Update your brew settings',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textDecoration.copyWith(hintText: "Name"),
                  validator: (val) => val!.isEmpty ? "Enter name" : null,
                  onChanged: (val) => {setState(() => _currentName = val)},
                ),
                SizedBox(
                  height: 20,
                ),
                //drop down
                DropdownButtonFormField(
                    value: userData.sugar,
                    decoration: textDecoration,
                    onChanged: (val) {
                      setState(() => _currentSugar = val.toString());
                    },
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text(
                          "$sugar Sugar",
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList()),
                //slider
                SizedBox(
                  height: 20,
                ),
                Slider(
                  value: _currentStrength != null
                      ? _currentStrength!.toDouble()
                      : userData.strength!.toDouble(),
                  activeColor: Colors.brown[
                      _currentStrength != null ? _currentStrength! : 100],
                  inactiveColor: Colors.brown[100],
                  onChanged: (val) {
                    setState(() {
                      _currentStrength = val.round();
                    });
                  },
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                ),

                SizedBox(
                  height: 20,
                ),
                //button
                ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.brown[400])),
                    onPressed: () {
                      print(_currentName);
                      print(_currentStrength);
                      print(_currentSugar);
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
