import 'dart:io';
import 'package:brew_crew/services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:brew_crew/services/storage_service.dart';
import 'package:brew_crew/shared/progress.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  bool uploading = false;
  double progressVal = 0;
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Coffe Image'),
        elevation: 0.0,
        backgroundColor: Colors.brown[400],
        actions: [
          IconButton(
              onPressed: () async {
                int i = 1;
                //set uploading true
                setState(() {
                  uploading = true;
                });
                //upload file
                for (var img in _image) {
                  setState(() {
                    progressVal = i / _image.length;
                  });
                  dynamic urlPath =
                      await StorageService(imageFile: img).uploadFile();
                  //save image path in images collection
                  ImageService(uid: user?.uid).saveUserImage(urlPath);
                  i++;
                }
                // navigate back
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.upload)),
        ],
      ),
      body: Stack(children: [
        GridView.builder(
            itemCount: _image.length + 1,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {
              return index == 0
                  ? Center(
                      child: IconButton(
                        onPressed: () => !uploading ? chooseImage() : null,
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
        uploading ? Progress(progressVal: progressVal) : SizedBox()
      ]),
    );
  }
}
