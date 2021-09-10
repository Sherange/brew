import 'dart:io';
import 'package:flutter/material.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  List<File> _image = [];

  // chooseIamge() async {
  //   final pickedFile = await
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Coffe Image'),
        elevation: 0.0,
        backgroundColor: Colors.brown[400],
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.upload)),
        ],
      ),
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return index == 0
                ? Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                    ),
                  )
                : Container();
          }),
    );
  }
}
