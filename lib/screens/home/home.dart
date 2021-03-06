import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/services/database_service.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_from.dart';
import 'package:brew_crew/screens/gallery/gallery.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: SettingsForm(),
              ),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew"),
          elevation: 0.0,
          backgroundColor: Colors.brown[400],
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Gallery()),
              ),
              icon: Icon(Icons.photo_outlined),
            ),
            IconButton(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
            ),
            IconButton(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.logout),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
