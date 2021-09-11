import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:brew_crew/services/storage_service.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  List<XFile> _image = [];

  final ImagePicker _picker = ImagePicker();

  chooseImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image.add(pickedFile);
      });
    }
  }

  uploadSelectedFiles() async {
    for (var img in _image) {
      dynamic urlPath = await StorageService(imageFile: img).uploadFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Coffe Image'),
        elevation: 0.0,
        backgroundColor: Colors.brown[400],
        actions: [
          IconButton(
              onPressed: () {
                uploadSelectedFiles();
              },
              icon: Icon(Icons.upload)),
        ],
      ),
      body: GridView.builder(
          itemCount: _image.length + 1,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return index == 0
                ? Center(
                    child: IconButton(
                      onPressed: () {
                        chooseImage();
                      },
                      icon: Icon(Icons.add),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(3),
                    child: Image.file(
                      File(
                        _image[index - 1].path,
                      ),
                      fit: BoxFit.cover,
                    ),
                  );
          }),
    );
  }
}
