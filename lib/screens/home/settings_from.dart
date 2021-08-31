import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

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
  int _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
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
            decoration: textDecoration.copyWith(hintText: "Name"),
            obscureText: true,
            validator: (val) => val!.isEmpty ? "Enter name" : null,
            onChanged: (val) => {setState(() => _currentName = val)},
          ),
          SizedBox(
            height: 20,
          ),
          //drop down
          DropdownButtonFormField(
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
            value: _currentStrength.toDouble(),
            activeColor: Colors.brown[_currentStrength],
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
  }
}
