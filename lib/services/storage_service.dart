import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class StorageService {
  final XFile? imageFile;

  StorageService({this.imageFile});

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future uploadFile() async {
    try {
      firebase_storage.Reference ref =
          storage.ref().child('images/${Path.basename(imageFile!.path)}');

      firebase_storage.TaskSnapshot result =
          await ref.putFile(File(imageFile!.path));

      if (result.state.toString() == 'TaskState.success') {
        return await ref.getDownloadURL();
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
