import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew item;
  const BrewTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[item.strength ?? 0],
          ),
          title: Text(item.name ?? ""),
          subtitle:
              Text(item.sugar != null ? "Takes ${item.sugar} sugar(s)'" : ""),
        ),
      ),
    );
  }
}
