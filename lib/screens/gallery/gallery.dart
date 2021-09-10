import 'package:brew_crew/screens/add_image/add_image.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffe Gallery'),
        elevation: 0.0,
        backgroundColor: Colors.brown[400],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.brown[400],
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddImage())),
      ),
    );
  }
}
